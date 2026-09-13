# System architecture

WICARS is a Laravel API and React/Vite client. Authentication and authorization
are enforced by Laravel Sanctum and Spatie permissions. The client calls the
API through the shared Axios client; role-specific pages should compose shared
tables, forms, and scheduling components rather than duplicate domain logic.

## Capability authorization

Base roles identify organizational positions (`vpaa`, `dean`, `secretary`,
`program_head`, and optional `director`). Scheduling actions are granted as
generic Spatie permissions such as `schedule.create` and
`schedule.assign_instructor`; a job title does not imply every scheduling
action. User-specific grants use the existing `model_has_permissions` table.

Capability names, module metadata, role defaults, presets, and workflow role
constraints are maintained in the backend capability registry
(`backend/config/capabilities.php`). The authenticated user payload and VPAA
access-matrix endpoint expose this registry to the React client, so module
labels and capability rows are not duplicated in frontend code. The API still
enforces every capability and workflow constraint; frontend locks are the
corresponding usability layer.

Resource scope remains data-driven: timetable mutations use
`schedules.department_id` (and `program_id` for Program Heads), while faculty
assignment uses `courses.teaching_department_id` and, where applicable,
`teaching_program_id`. Permission assignments are selected per account through
the VPAA user-management workflow; no department names or subject labels are
hardcoded into authorization defaults.

Secretary and Program Head navigation, scheduling routes, and action controls
are derived from these permissions. UI visibility is only a usability layer;
each API mutation is protected by its exact capability. Secretary, Program
Head, and Director base roles inherit no scheduling permissions, making the
per-user scheduling profile authoritative.

## Scheduling boundary

`SchedulingPolicy` is the canonical source for supported days, modes, statuses,
time-grid conventions, and the constraint catalog. `RuleEngine` validates a
manual or persisted placement. `CspSolver` searches valid placement domains and
must apply the same hard constraints before ranking candidates. `ScheduleQualityEvaluator`
only scores feasible candidates; it must not replace hard validation.

The application services around the solver are currently split between legacy
controller orchestration and the refactoring boundary:

- `GenerateSectionSchedulePlans` is the production section-level application
  adapter. It owns preflight, requirement construction, configuration
  confirmation, and legacy response mapping around `GenerateSchedulePlan`.
- `CommitSchedulePlan` is the refactored persistence boundary. Recommendation
  acceptance and section auto-apply now coordinate recommendation state and
  plan persistence inside one transaction.
- `YearLevelScheduleGenerationService` coordinates year-level generation,
  retries, diagnostics, and aggregate metrics through its compatibility path.
- `SplitScheduleService` handles focused split-session recommendations.
- `ScheduleGenerationPreflightService` checks feasibility before expensive searches.

## Current runtime adoption

The refactoring contracts are adopted incrementally rather than uniformly:

| Capability | Current runtime owner | Refactoring status |
|---|---|---|
| Manual single placement | `RuleEngine` through `ScheduleController` | Legacy path, parity-covered |
| Manual batch placement | `BatchConflictValidator` plus `RuleEngine` | Legacy path, lock and transaction enforced |
| Section preview/recommendation | `GenerateSectionSchedulePlans` through `ScheduleRecommendationController` | Phase 10 adoption complete; `GenerateSchedulePlan` is the decision boundary and legacy response shape is preserved |
| Recommendation acceptance | `CommitSchedulePlan` plus recommendation state transaction | Atomic plan/status/history boundary adopted; non-migrated payloads are rejected |
| Year-level preview | `YearLevelScheduleGenerationService` | Retry diagnostics and metrics adopted; aggregate snapshot/configuration contracts deferred |
| Candidate hard validation | CSP guards, `RuleEngine`, and constraint kernel parity paths | Kernel available; legacy implementations remain active |
| Persistence | Controller paths and `CommitSchedulePlan` | Schedule-plan writes share the lock and transaction boundary |

This table is the authoritative current-state summary. The phase notes below
describe the sequence in which capabilities were introduced, not a claim that
every phase is already the sole production implementation.

## Write and approval flow

Schedule writes are validated inside a transaction and serialized with the
semester-level scheduling lock. New rows start as `draft`; approval transitions are
handled by the approval endpoints, not by ordinary batch plotting updates.
Notifications and cache invalidation happen after a successful commit.

Queued year-level previews return a run identifier and are processed by the
scheduling queue. The synchronous endpoint remains for compatibility and small
interactive requests.

## Ownership rules

`department_id` on a schedule is persisted ownership. A course may have a
different `teaching_department_id`; that affects instructor assignment, not the
authority to edit or delete the owning department's timetable. Existing-row
updates must hydrate identity from the database and ignore client attempts to
change ownership for authorization purposes.

Curriculum records and their course placements are institution-level academic
records owned by the VPAA. The Secretary, Dean, and Program Head portals may
read and print curriculum data, but all curriculum mutations are restricted by
the API role middleware to `vpaa`.

## Refactoring boundary

Controllers should remain thin adapters. New scheduling behavior belongs in a
focused application service or constraint class, with feature tests covering the
API contract and unit tests covering individual rules and scoring behavior.

The scheduling-core refactor introduces immutable, schema-versioned contracts
under `App\Services\Scheduling\Domain`. See [[scheduling_core_phase_1]] for the
contract responsibilities and incremental adoption sequence. These contracts do
not replace existing runtime arrays until the owning application-service phase is
migrated and covered by parity tests.

`SchedulingSnapshotRepository` is the database boundary for the refactored core.
It captures normalized semester-wide conflict state and department configuration in a
versioned `SchedulingSnapshot`; see [[scheduling_core_phase_2]]. Rules and solver
code must migrate to this shared snapshot incrementally rather than adding new
database queries inside search or validation loops.

Phase 3 adds a presentation-neutral constraint kernel under
`App\Services\Scheduling\Constraints`; see [[scheduling_core_phase_3]]. The
kernel consumes domain contracts and snapshots only, uses explicit rule
priorities, and performs no database access. Existing validators remain the
runtime authority until later phases replace each path under parity coverage.

Phase 4 adds `ValidateGenerationConfiguration` as the application boundary for
pre-generation configuration checks; see [[scheduling_core_phase_4]]. It captures
one immutable snapshot, separates blocking violations from confirmation warnings,
and returns machine-applicable recommendations. Its later Phase 8 adoption is
limited to section recommendation and preview paths; year-level orchestration
still uses its legacy preflight boundary.

Phase 5 introduces explicit solver ports, immutable variable-domain contracts,
snapshot-backed hard-constraint propagation, result mapping, and legacy/canonical
domain parity reporting; see [[scheduling_core_phase_5]]. `CspSolver` remains the
active search implementation. An opt-in shadow pass can compare its persisted
conflict pruning against the constraint kernel without changing generated output.

Phase 6 adds `GenerateSchedulePlan` as the application-service boundary from a
validated `GenerationConfiguration` to ranked, fingerprinted `SchedulePlan`
contracts; see [[scheduling_core_phase_6]]. It records configuration confirmation,
performs final kernel validation, and distinguishes invalid, room-unresolved, and
room-complete plans. Phase 10 now routes all section recommendation generation,
preview, selection, queued preview execution, and auto-apply through the
`GenerateSectionSchedulePlans` adapter. Order 3 now retains the complete typed
plans and exposes them as an additive `schedule_plans` response field. Each
persisted section recommendation also carries the exact `SchedulePlan` contract
under `_scheduling.schedule_plan`, including its plan ID, fingerprints, rows,
violations, recommendations, scores, and generation metadata. Legacy
`recommendations` rows and acceptance behavior remain unchanged.

Phase 7 adds `CommitSchedulePlan` as the single fresh-snapshot persistence
boundary for final plans; see [[scheduling_core_phase_7]]. It shares the existing
semester advisory lock with batch writes, rejects stale or invalid plans, replaces
only editable rows, persists through Eloquent lifecycle events, and records
aggregate history and audit evidence in the same transaction. It is currently a
tested service boundary; controller and job adoption remains deferred until
recommendation status locking and plan commit can share one transaction.

Phase 8 adds deterministic configuration fingerprints, versioned warning
confirmations, and the `_scheduling` recommendation payload envelope; see
[[scheduling_core_phase_8]]. Section recommendation paths now validate and
confirm configurations before solving while preserving their legacy row and
response contracts. Year-level aggregate versioning and atomic recommendation
acceptance through `CommitSchedulePlan` remain later migration steps.

Phase 9 adds the schema-versioned `SchedulingGenerationMetrics` observability
contract; see [[scheduling_core_phase_9]]. Snapshot capture, section solving,
plan generation, and the complete year-level retry ladder now report query cost,
domain size, pruning, iterations, attempts, elapsed time, retry reasons, and
fallback use. Operational timing and query metadata are excluded from snapshot
fingerprints, and instrumentation does not participate in scheduling decisions.

Order 4 adopts `CommitSchedulePlan` for recommendations that carry the
versioned plan envelope. Acceptance and section auto-apply now revalidate and
persist through the shared lock, snapshot, constraint, history, and audit
boundary. Legacy recommendation rows without a serialized plan are rejected
with an actionable regeneration response.

Order 5 completes the recommendation acceptance migration. Historical
recommendations are converted by `php artisan
scheduling:backfill-recommendation-plans`; migrated records carry the
versioned plan envelope, while records that cannot be safely converted remain
explicitly rejected with a regeneration response. The controller-local legacy
acceptance write path and row-normalization fallback have been removed.

Order 6 propagates the captured `SchedulingSnapshot` through the
`SchedulingSolver` port, legacy adapter, and `CspSolver` entry point. The
configuration validator, solver, and shadow constraint propagator can now use
the same snapshot identity and fingerprint without recapturing state. The
application solver port requires a non-null snapshot, making snapshot
propagation explicit at compile time; only the legacy `CspSolver` entry points
retain optional input for compatibility tests and remaining loader migration.
legacy solver's internal course, room, and schedule loaders remain temporarily
behind this input contract and are the next extraction target.

Order 7A makes persisted schedules and forced-day rules snapshot-authoritative
inside `CspSolver` whenever the solver is invoked through the new port. Room
type lookup for persisted rows also uses snapshot metadata. Legacy database
queries remain only for callers that do not provide a snapshot, preserving
compatibility during the remaining loader migration.

Order 8 makes snapshot-aware solver runs consume room records, virtual-room
capacity limits, and department scheduling flags from `SchedulingSnapshot`.
This removes room/resource/settings queries from the snapshot path while
leaving the legacy loader branch for direct non-snapshot callers.

Order 9 makes section, semester, course, and curriculum-period data snapshot-
authoritative for snapshot-aware solver runs. Existing Eloquent model shapes
are hydrated from normalized snapshot records so candidate builders and rule
checks retain their current behavior without issuing those loader queries.

Order 10 is now adopted for production orchestration. Year-level retries use
the `YearLevelSchedulingSolver` port and its `CspYearLevelSchedulingSolverAdapter`;
section generation uses the `SchedulingSolver` port. Both paths pass a complete
`SchedulingSnapshot` before solving.

No-snapshot execution is now explicitly observable through the
`legacy_database_loader` generation-metrics fallback marker and
`usesLegacyDatabaseFallback()`. New application-service paths must pass a
snapshot; the marker is retained only to measure remaining migration work.

Order 10 also adds the `REQUIRE_SCHEDULING_SNAPSHOT` rollout guard. Once all
production callers are confirmed snapshot-aware, enabling this flag makes
direct no-snapshot solver execution fail fast instead of silently selecting a
different database state.

Order 11 completes the production caller migration. No application service
invokes `CspSolver` without a snapshot; direct no-snapshot execution is now
observable through `legacy_database_loader` metrics and blocked by the rollout
guard in production. Compatibility-only low-level tests explicitly disable the
guard in PHPUnit.

Order 12 removes the obsolete `LegacyCspSolverAdapter` name and binds the
application port to `CspSchedulingSolverAdapter`. The remaining legacy loader
branches are retained only inside `CspSolver` for explicit compatibility tests
until the final loader extraction, not as production orchestration paths.

Year-level generation now requires `SchedulingSnapshotRepository` and captures
one aggregate snapshot for its full retry run. Retry and fairness parity tests
exercise the port-backed adapter. The deleted `LegacyCspSolverCompatibilityAdapter`
is no longer part of the application dependency graph; direct low-level solver
tests remain explicit compatibility tests and are not production entry points.

The legacy `GenerateScheduleService` has been removed. It had no runtime,
route, command, or test caller; its `accept()` path called `json_decode` on the
`array`-cast `recommended_schedules` attribute, so it raised a `TypeError` on
entry from the day it was written and could not have had a live consumer; and it
re-derived a section's curriculum from the department's active curriculum, the
fallback `SectionCurriculumResolver` explicitly forbids. Section generation runs
through `GenerateSectionSchedulePlans`, and acceptance through
`CommitSchedulePlan`, which additionally locks the recommendation row, enforces
the department guard, and records an audit entry.

The recommendation portion of this gate now has an explicit migration tool:
`php artisan scheduling:backfill-recommendation-plans`. It reports updated,
skipped, and failed records and never fabricates a plan when required schedule
data is invalid. Phase 10 may remove the acceptance fallback after the command
completes with no failed pending recommendations; the solver-loader fallback
still requires the year-level and legacy callers to be migrated.

## Remaining migration boundary

Phase 10 section-generation adoption and Orders 3-5 plan propagation and
commitment are complete. Historical recommendation payloads are handled by
the backfill command and acceptance is routed through `CommitSchedulePlan`.
The solver's database-loader branch remains only as a low-level compatibility
surface for legacy direct APIs/tests; production generation is snapshot-only.

`GenerateScheduleService` is gone (see above); the legacy response mapping it
shared with `GenerateSectionSchedulePlans` stays until the remaining consumer
contracts are retired. Any future removal of the CSP compatibility loader must
be preceded by migrating the remaining direct low-level tests to a dedicated
test fixture that supplies a `SchedulingSnapshot`.
