# Architecture decisions

## Master Calendar centers the weekly timeline

The Master Calendar uses the existing Gantt components as its primary workspace.
A compact semester header and meeting count replace the introductory banner and
statistic cards. Search, department, row grouping, overlaps, days, and zoom stay
visible; session type, density, collapse controls, and printing live in View
options. Closing those options preserves their selections.

The meeting count and department legend follow the selected days and filters.
Overlap detection still considers all loaded meetings, including hidden ones.
Fit uses the available chart width and reduces time-label density on narrow
screens; fixed zoom levels remain available for inspecting small blocks.

The VPAA dashboard reuses `MasterGantt`, its layout helpers, department palette,
and schedule detail modal through `DashboardGantt`. Its preview retains the
active-semester and `isVpaaApproved` publication scope, defaults to today's
on-site meetings, and offers Week plus separate On-site, Online, and Field
delivery filters. Field meetings are excluded from On-site. Time settings come
from the existing `/initial-data.time_grid` payload. Overlaps are calculated
across the loaded published semester meetings before display filters; the
2,000-row preview limit remains explicit and is not a campus-wide aggregate.
The dashboard timeline uses a compact title/search/action row instead of a
subtitle and statistic cards. Department, building, and room filters open from
the Filters button and retain their selections when closed; the visible meeting
count remains alongside Today/Week, delivery mode, grouping, and zoom controls.

Schedule cards, hover summaries, and details display the department's uploaded
logo. Both views resolve departments from their already-loaded directory by ID,
keeping logo data out of repeated nested schedule API relations. The shared
department-logo component shows an icon when an upload is absent or fails to load.

## VPAA settings preview drafts before saving

VPAA Settings groups semesters, operating hours, signatories, and activation
history behind in-page section links. The daily-hours bar and printed-signature
preview reflect the form drafts; they do not persist changes. Existing explicit
save actions, validation, and the semester activation confirmation remain the
only paths that apply those settings. The hours preview uses the shared
operating-hours parser and hides the range when the draft is invalid.

## Reports share a searchable directory

The shared Reports page presents Department Schedule and Teaching Load as two
report types above a department-grouped directory. Search matches department and
program names; Available only filters report scopes with a positive printable
count. Availability counts represent PDF scopes, not unique sections or faculty.
The existing reports API remains authoritative for approval and access scope,
and the existing schedule and teaching-load PDF builders produce the documents.
Failed refreshes keep the last loaded directory visible with an inline notice.
Teaching-load PDFs use red text for instructor conflict overrides. Pro bono
entries remain grey even when overridden, and retain the grey pro bono legend.

## One rule catalog, two execution modes

Manual edits and generated schedules use different execution strategies, but
they share `SchedulingPolicy` and the `RuleEngine` constraint definitions. The
CSP solver may use optimized domain pruning, while the final candidate is still
validated through the same hard-rule semantics.

## Queue expensive generation

Year-level preview generation is asynchronous for production workloads because
constraint search can exceed a normal HTTP request budget. The run record is
the durable progress contract; polling is preferred to holding an HTTP worker.

## Preserve compatibility during refactoring

Existing synchronous endpoints and response shapes remain available while new
services and shared UI components are introduced. Refactors must be covered by
the existing feature suite before old paths are removed.

## Normalize schedule approval by submission cycle

`schedule_submissions` and `schedule_submission_sections` are the authoritative
approval workflow records. A submission row owns the revision lineage, actors,
review timestamps, rejection reason, withdrawal state, and override decision;
its section rows define the exact cohort sent through that cycle.

`schedules.status` remains an operational mirror because timetable editing,
generation, faculty assignment, finalization, and conflict checks depend on a
row-level lock state. Approval actor and decision columns must not be added back
to `schedules`. Workflow events remain in `scheduling_audit_logs` and schedule
history, so a second approval-event table would be redundant.

Dean and VPAA queues read submission cycles directly. Notifications are delivery
records and must not be used to reconstruct authoritative workflow state.

## Access follows the role; Manage Access was removed

At the adviser's request, User Management no longer has a per-account Manage
Access matrix. Capabilities come from the role alone: Secretaries and Program
Heads share one schedule-building set (view, create, update, delete, generate,
submit, withdraw, instructor and cross-department assignment, room requests),
Deans keep view and dean approval, and the VPAA keeps every capability.
Cross-department assignment is included because existing secretaries relied on
it. The capability middleware still guards every route, so moving to roles
changed where grants come from, not how they are enforced.

Migration `2026_09_15_000001` re-syncs the roles before deleting per-account
grants, so no account loses access in between. Grants are deleted rather than
kept because nothing could display or revoke them afterwards. The migration
cannot restore them; back up `model_has_permissions` first if they may be needed.

## Archive domain records instead of permanently deleting them

User-facing delete endpoints preserve domain records with soft deletes. The
VPAA can review and restore them through the system Archive. Curricula continue
to use their established `archived` status because that status is part of the
curriculum workflow. Security-sensitive token revocation and transient
replacement data are excluded from archival and remain immediate deletions.

## Clear schedules uses the section checklist

Clear schedules reuses the Done/Finalize checklist with only the open section
initially selected. Choices are scoped to the department and active semester;
empty sections and sections locked for approval or instructor assignment are
disabled. Confirmation rechecks eligibility and sends only selected section IDs
through the existing batch replacement endpoint, which also covers meetings
beyond the loaded preview. Draft, completed, and revision are the backend's
replaceable statuses.

The former clear dialog incorrectly promised Archive restoration. The existing
batch endpoint permanently removes these working rows and records schedule
history; the checklist now describes that behavior. This is an exception to
ordinary domain-record archival, not a change to persistence behavior.

## Task-based interactive guides on the existing tour library

Onboarding stays on react-joyride (`useWorkflowGuide`, `joyrideTour`,
`WorkflowGuideButton`); no second tour library is introduced. Guides are
page-scoped and always start/restart from the existing per-page Help (?)
button — there is no global mission overlay or extra entry button.
`src/onboarding/taskGuide.ts` defines `TourAction` (`click`, `select`,
`input`, `submit`, `toggle`, `navigate`, `complete`), per-action validation,
and `waitForElement` (MutationObserver, never fixed sleeps). Each page
declares its steps with the actions the user must perform; action steps hide
the Next button until the real action is detected, then auto-advance.
Completion is persisted per user per guide (v3 key), and destructive moves
(save, submit, approve) are review-only `complete` steps so a tour can never
force a mutation. Action steps spotlight the exact control (the button, not
the card) via precise selectors and zero-visual-change `data-tour` hooks;
the tooltip tracks moving targets with Floating UI autoUpdate while the
spotlight follows scroll, resize, and target mutations.
