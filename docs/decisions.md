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
