# WICARS

**Web-Based Intelligent Conflict Detection and Recommendation System for
Academic Scheduling**

A web system for building class schedules without conflicts. It checks for
clashes between rooms, instructors, and sections, suggests fixes, and sends
schedules through dean and VPAA approval.

## Project Structure

```text
backend/      Laravel API (controllers, models, scheduling engine, database migrations)
wicars-ui/    React + TypeScript frontend (Vite)
docs/         Architecture, business rules, and database notes
docs/reports/ Audit and evaluation reports
scripts/      Helper scripts (load testing)
start-dev.ps1 Starts every development service at once
```

## Requirements

- PHP 8.2+ and Composer
- Node.js 20+ and npm
- MySQL (Laragon or XAMPP)

## Installation

1. **Create the database.** In MySQL, create an empty database named
   `scheduling_db`.

2. **Set up the backend.**

   ```bash
   cd backend
   composer install
   copy .env.example .env
   php artisan key:generate
   ```

   Open `backend/.env` and set the database connection:

   ```ini
   DB_CONNECTION=mysql
   DB_HOST=127.0.0.1
   DB_PORT=3306
   DB_DATABASE=scheduling_db
   DB_USERNAME=root
   DB_PASSWORD=
   ```

   Then create the tables and the default data:

   ```bash
   php artisan migrate --seed
   ```

3. **Set up the frontend.**

   ```bash
   cd wicars-ui
   npm install
   ```

## Running the System

**Easiest way (Windows):** from the project root, run

```powershell
.\start-dev.ps1
```

This starts the API server, the scheduling queue worker, the live-updates
server, and the frontend together. Keep the window open.

> `start-dev.ps1` expects PHP at `C:\xampp\php\php.exe`. If your PHP is
> somewhere else (for example Laragon), edit the `$php` line at the top of the
> script.

**Manual way:** open four terminals.

```bash
# 1. API server
cd backend && php artisan serve

# 2. Scheduling worker (needed for automatic schedule generation)
cd backend && php artisan queue:work database --queue=scheduling,default

# 3. Live updates (optional; without it, pages refresh only when you navigate)
cd backend && php artisan reverb:start

# 4. Frontend
cd wicars-ui && npm run dev
```

Open <http://localhost:5173> in your browser.

## Logging In

The seeder creates one administrator account:

| Username | Password   | Role |
|----------|------------|------|
| `vpaa`   | `password` | VPAA |

Create the other accounts (Dean, Program Head, Secretary) from
**User Management**.

## Basic Workflow

1. **VPAA:** set up departments in **Department Management** and create user
   accounts in **User Management**.
2. **Secretary:** add **Courses**, **Curriculum**, **Rooms**, **Instructors**,
   and **Sections** for the department.
3. **Secretary:** open **Schedule Builder**. Place classes by hand or generate a
   schedule automatically. Conflicts are flagged as you work, and the system
   suggests alternatives.
4. **Secretary:** submit the finished schedule for approval.
5. **Dean:** review it under **Schedule Approval**, then approve it or return
   it with remarks.
6. **VPAA:** give final approval under **Schedule Approval** and view every
   department in the **Master Calendar**.
7. **Anyone with access:** print or export schedules and teaching loads from
   **Reports**. Past versions are kept in **Schedule History**.

## Running Tests

```bash
cd backend && php artisan test
cd wicars-ui && npm test
```
