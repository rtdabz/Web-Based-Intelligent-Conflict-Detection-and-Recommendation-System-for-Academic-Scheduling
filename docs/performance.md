# Performance Operations

## Production settings

Use `APP_ENV=production`, `APP_DEBUG=false`, and `LOG_LEVEL=warning`. Redis is recommended for concurrent deployments:

```dotenv
QUEUE_CONNECTION=redis
CACHE_STORE=redis
SESSION_DRIVER=redis
PERFORMANCE_LOGGING=true
```

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

For local development, `composer run dev` starts a database queue listener for
`scheduling,default`. If the API and Vite server are started separately, run the
same queue explicitly:

```bash
php artisan queue:work database --queue=scheduling,default --tries=1 --timeout=180
```

Restart that worker after local scheduling code changes, or use the
`composer run dev` listener, which reloads application code for each job.

## Load testing

Measure p50/p95 latency for `/api/initial-data`, `/api/schedules/term/{termId}`, and the queue submission endpoint with realistic schedule counts. Test at least 10, 25, and 50 concurrent users, and monitor PHP worker CPU, memory, MySQL slow queries, Redis queue depth, and failed jobs.
