# WICARS Documentation Dashboard

## System Architecture

- [[architecture]]
- [[database]]
- [[business_rules]]

## Development

- [[coding_standards]]
- [[performance]]

## Architecture & Decisions

- [[decisions]]

## Workflows

- [[schedule_history_workflow]]
- [[vpaa_activity_log_workflow]]

---

## Documentation Rules

> This `docs/` directory is the project's source of truth for
> architecture, business rules, workflows, technical decisions,
> and development conventions.

Before modifying behavior:

1. Check the relevant documentation in `docs/`.
2. Follow existing architecture and business rules.
3. Check `decisions/` for previous architectural decisions.
4. Do not introduce behavior that conflicts with documented rules.
5. Update the relevant documentation when a significant
   architectural or behavioral decision changes.

## Current Documentation Areas

### Architecture
Canonical system boundaries, scheduling services,
authorization ownership, transaction behavior, and
refactoring boundaries.

### Business Rules
Course ownership, teaching-department assignment,
curriculum scope, minor delegation, and instructor
assignment rules.

### Database
Current schema map, relationships, delete behavior,
constraints, indexes, migrations, and persistence rules.

### Coding Standards
Project-specific Laravel/React patterns, naming,
authorization, persistence, testing, and verification
standards derived from the current implementation.

### Decisions
Architectural decisions that should not be changed
without explicitly reconsidering the documented decision.

### Performance
Production configuration, queues, caching,
generation performance, and load-testing expectations.

### Workflows
Detailed workflows for schedule history and VPAA
activity logging.

