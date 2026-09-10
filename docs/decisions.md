# Architecture decisions

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

## Archive domain records instead of permanently deleting them

User-facing delete endpoints preserve domain records with soft deletes. The
VPAA can review and restore them through the system Archive. Curricula continue
to use their established `archived` status because that status is part of the
curriculum workflow. Security-sensitive token revocation and transient
replacement data are excluded from archival and remain immediate deletions.

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
