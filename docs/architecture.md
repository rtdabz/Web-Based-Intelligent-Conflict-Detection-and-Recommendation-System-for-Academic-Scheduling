# System architecture

WICARS is a Laravel API and React/Vite client. Authentication and authorization
are enforced by Laravel Sanctum and Spatie permissions. The client calls the
API through the shared Axios client; role-specific pages should compose shared
tables, forms, and scheduling components rather than duplicate domain logic.

## Scheduling boundary

`SchedulingPolicy` is the canonical source for supported days, modes, statuses,
time-grid conventions, and the constraint catalog. `RuleEngine` validates a
manual or persisted placement. `CspSolver` searches valid placement domains and
must apply the same hard constraints before ranking candidates. `ScheduleQualityEvaluator`
only scores feasible candidates; it must not replace hard validation.

The application services around the solver own workflows:

- `GenerateScheduleService` handles recommendation persistence and application.
- `YearLevelScheduleGenerationService` coordinates year-level generation and diagnostics.
- `SplitScheduleService` handles focused split-session recommendations.
- `ScheduleGenerationPreflightService` checks feasibility before expensive searches.

## Write and approval flow

Schedule writes are validated inside a transaction and serialized with the
term-level scheduling lock. New rows start as `draft`; approval transitions are
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

## Refactoring boundary

Controllers should remain thin adapters. New scheduling behavior belongs in a
focused application service or constraint class, with feature tests covering the
API contract and unit tests covering individual rules and scoring behavior.
