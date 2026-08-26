# Project Agent Instructions

## Core Workflow

Follow this sequence:

`UNDERSTAND -> REUSE -> MODIFY -> VERIFY`

Before changing code, identify the relevant entry point, inspect the implementation and its direct dependencies, and reuse existing components, services, APIs, models, utilities, and project conventions.

Keep changes focused on the user's request. Do not rewrite unrelated files, introduce duplicate logic, change working behavior without a reason, or invent database fields, relationships, endpoints, permissions, or enum values.

## Context And File Reading

- Do not read the entire repository automatically.
- Use targeted searches such as `rg` and inspect only files needed for the current task.
- Retain verified context during the task. Do not repeatedly reread unchanged files.
- Reread a file only when it has changed, the task scope has changed, a dependency contract is uncertain, or verification requires the latest contents.
- Treat tool output and previous inspection results as working context unless new evidence makes them stale.
- When a file is large, read the relevant sections first and expand only when necessary.
## Project Documentation

The `docs/` directory is the project's source of truth for stable architecture,
business rules, technical decisions, workflows, and project-specific conventions.

Start documentation discovery from:

`docs/DASHBOARD.md`

Use the Dashboard to identify the relevant documentation area, then read only
the documentation directly related to the current task.

Relevant documentation includes:

- `docs/architecture/` — system architecture, boundaries, services, and ownership.
- `docs/business_rules/` — scheduling and domain rules that must be preserved.
- `docs/coding_standards/` — project-specific implementation conventions.
- `docs/database/` — database schema, relationships, and persistence rules.
- `docs/decisions/` — established architectural and implementation decisions.
- `docs/performance/` — performance, queue, caching, and production requirements.
- `docs/schedule_history_workflow/` — schedule history behavior and workflow.
- `docs/vpaa_activity_log_workflow/` — VPAA activity-log behavior and workflow.

Do not treat documentation as a reason to read the entire `docs/` directory.
Follow targeted reading based on the current task.

If documentation conflicts with the existing implementation, do not silently
choose one. Investigate the relevant code and document the discrepancy before
making a behavioral change.

When a task introduces or changes a stable architecture decision, business rule,
workflow, or project convention, update the appropriate documentation after
the implementation has been verified.

## Existing Functionality

Before creating something new, search for an existing implementation and extend or reuse it. Preserve existing authentication, authorization, validation, error handling, API contracts, database relationships, and user-facing interactions unless the request explicitly changes them.

## Database And API Safety

Inspect models, migrations, routes, controllers, validation, response shapes, and frontend consumers before changing database or API behavior. Maintain compatibility with the existing schema and access-control system. Do not bypass authentication or authorization.

## UI Changes

Preserve the existing design language, responsive behavior, components, spacing, typography, and interactions outside the requested area. Include loading, empty, error, disabled, and success states where relevant.

## Verification

After changes, run the narrowest useful checks first, then broader checks when practical:

1. Syntax and type checks.
2. Relevant unit or feature tests.
3. Affected API or database checks.
4. Build or UI verification for user-facing changes.

Report what was verified and any remaining limitations.

## Scope And Documentation

Prefer minimal, maintainable changes. Document stable project-specific architecture or business rules in project documentation rather than relying on repeated rediscovery. Do not add temporary debugging details to this file.

User instructions always take precedence over these defaults.
