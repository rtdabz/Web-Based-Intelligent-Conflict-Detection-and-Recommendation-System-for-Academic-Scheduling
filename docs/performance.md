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

## Asynchronous generation

`POST /api/schedule-recommendations/year-level-preview/queue` returns HTTP `202` and a `run_id`. Poll `GET /api/schedule-recommendations/generation-runs/{runId}` until `status` is `completed` or `failed`. The existing synchronous preview endpoint remains available for compatibility.

## Load testing

Measure p50/p95 latency for `/api/initial-data`, `/api/schedules/term/{termId}`, and the queue submission endpoint with realistic schedule counts. Test at least 10, 25, and 50 concurrent users, and monitor PHP worker CPU, memory, MySQL slow queries, Redis queue depth, and failed jobs.
