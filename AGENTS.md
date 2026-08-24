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
