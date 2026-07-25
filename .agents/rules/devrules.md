---
trigger: always_on
---

# Frontend-Only Development Rule

## Default Behavior
Unless I explicitly instruct otherwise, treat every request as a **frontend-only** task.

## Requirements
- Modify only the frontend/UI.
- Do NOT modify any backend code, including:
  - APIs
  - Server logic
  - Database
  - Authentication
  - Controllers
  - Services
  - Models
  - Middleware
  - Business logic
  - Configuration files related to the backend

## Backend Usage
- The backend already exists and is considered **read-only**.
- You may use existing backend APIs, endpoints, and data.
- Fetch and display backend data without changing how it is generated or stored.
- Do not create new endpoints or modify existing API contracts.

## Frontend Scope
You may:
- Create and edit UI components.
- Improve layouts and styling.
- Implement responsive designs.
- Add animations and transitions.
- Manage frontend state.
- Display, filter, sort, search, and paginate existing backend data.
- Improve user experience while preserving backend behavior.

## If Backend Changes Are Required
If a requested feature cannot be implemented without backend modifications:
1. Do NOT modify the backend.
2. Explain why backend changes are required.
3. Suggest the required backend changes separately.
4. Wait for my explicit approval before making any backend-related changes.

## Priority
Always preserve backend functionality and compatibility. Assume the backend is production-ready and must not be altered unless I explicitly say:
> "Modify the backend."