# Performance Operations

## Production settings

Use `APP_ENV=production`, `APP_DEBUG=false`, and `LOG_LEVEL=warning`. Redis is recommended for concurrent deployments:

```dotenv
QUEUE_CONNECTION=redis
CACHE_STORE=redis
SESSION_DRIVER=redis
PERFORMANCE_LOGGING=true
```

Keep `BCRYPT_ROUNDS=12` in production. Each round doubles the work, and at 12 a
single `Hash::make`/`Hash::check` measured ~340ms — paid once on login and once
on account creation. Local development may drop to 10 (~85ms) to keep those
flows responsive; do not carry that value into a deployed environment.

## Outbound mail

Account-creation and password-reset notifications implement `ShouldQueue`. A
single SMTP session to Gmail measured ~2.3s just to finish `STARTTLS` and the
second `EHLO`, and roughly 4s through `AUTH`/`DATA`/`QUIT` — which is why the
send must never sit inside the HTTP request. Note that `use Queueable` alone
does not defer anything; the `ShouldQueue` contract is what moves the work to a
worker. A `default` queue worker must be running for these mails to leave the
`jobs` table.

## API caching

The API uses the versioned `ApiCache` groups for read-heavy lookup payloads.
Production should use Redis (`CACHE_STORE=redis`); file/database stores remain
valid for local development and single-node fallback deployments.

`GET /api/initial-data` is cached for 15 seconds using a key scoped by role,
department, program, pagination, and schedule-limit parameters. This endpoint
contains both reference data and active workflow rows, so the short TTL is
intentional. Semesters, rooms, departments, sections, courses, and faculty writes
invalidate the `initial.data` group after persistence. Faculty and course list
endpoints also use scoped five-minute caches, invalidated by their related
mutations and instructor-assignment changes.

### Narrowing an `initial.data` invalidation

A cold `GET /api/initial-data` measured ~550ms against a 600KB payload (~140ms of
SQL, ~310ms of `json_encode`) versus ~9ms warm, so the blast radius of an
invalidation matters. The endpoint's key therefore comes from
`ApiCache::compositeKey()`, which versions it by the group *and* by each
requested section (`initial.data.rooms`, `initial.data.users`, …). A write may
bump only the sections it touched; `?include=schedules` callers then keep their
cached payload. Bumping `initial.data` itself still invalidates everything, and
remains the correct default for any write that cannot be narrowed confidently.

Two rules before narrowing a write path:

- Account for the keys that ship outside `OPTIONAL_SECTIONS`. `has_dean`,
  `scheduling_ready`, `active_semester`, `time_grid`, and the `field_course_*` and
  `resource_slot_limits` entries are in *every* response, including ones that
  request no related section. `POST /api/user` narrows to
  `users`/`faculties`/`departments` for this reason only when the new account is
  not an active dean, because `has_dean` is derived from users.
- Account for data duplicated into a section's nested relations. `schedules`
  embeds columns from `faculty`, so renaming a user through
  `UserFacultyProfileService::sync()` changes the `schedules` payload even though
  no schedule row was written. Account *creation* is exempt: a new faculty
  profile has no meetings yet.

Do not cache mutations, notifications, activity logs, generation-run status, or
solver decisions. Schedule and approval changes must continue to invalidate
affected groups after the transaction commits; the short bootstrap TTL is a
bounded fallback for changes made by another session.

Run `php artisan optimize`, `php artisan config:cache`, `php artisan route:cache`, and `php artisan view:cache` during deployment. Run at least one dedicated queue worker for the `scheduling` queue:

```bash
php artisan queue:work redis --queue=scheduling,default --tries=1 --timeout=180
```

Long-running `queue:work` processes keep loaded PHP classes in memory. After
deploying scheduling, validation, job, or configuration changes, reload them
before accepting new generation runs:

```bash
php artisan queue:restart
```

The process manager must then start a replacement worker. Without this reload,
the HTTP request can validate a new Schedule Setup payload while the queued job
still executes an older solver implementation.

## Asynchronous generation

`POST /api/schedule-recommendations/year-level-preview/queue` returns HTTP `202` and a `run_id`. Poll `GET /api/schedule-recommendations/generation-runs/{runId}` until `status` is `completed` or `failed`. The existing synchronous preview endpoint remains available for compatibility.

If a queued run is not claimed within three minutes, status polling marks it
`failed` with a queue-worker diagnostic. This threshold is below the client
polling deadline so an unavailable `scheduling` worker cannot leave a run
indefinitely reported as active.

For local development, `composer run dev` starts a database queue listener for
`scheduling,default`. If the API and Vite server are started separately, run the
same queue explicitly:

```bash
php artisan queue:work database --queue=scheduling,default --tries=1 --timeout=180
```

Restart that worker after local scheduling code changes, or use the
`composer run dev` listener, which reloads application code for each job.

## Load testing

Measure p50/p95 latency for `/api/initial-data`, `/api/schedules/semester/{semesterId}`, and the queue submission endpoint with realistic schedule counts. Test at least 10, 25, and 50 concurrent users, and monitor PHP worker CPU, memory, MySQL slow queries, Redis queue depth, and failed jobs.

## Scheduling generation metrics

Section and year-level generation responses expose the versioned
`generation_metrics` object documented in [[scheduling_core_phase_9]]. Queued
generation stores the same object inside `schedule_generation_runs.result`.

Track these fields when comparing releases:

- `snapshot_query_count` and `snapshot_elapsed_ms`
- `candidate_count_before`, `candidate_count_after`, and `pruned_by_constraint`
- `iterations`, `solver_attempts`, `search_limit_reached`, and `elapsed_ms`
- `retry_reasons` and `fallback_usage`

Candidate and iteration counts are workload measures, not success criteria. A
larger valid curriculum can legitimately produce a larger domain. Investigate
regressions by comparing the same semester, department, sections, configuration,
seed, and database snapshot.

With `PERFORMANCE_LOGGING=true`, the application emits structured
`scheduling_generation_metrics` events in addition to slow-query warnings.
