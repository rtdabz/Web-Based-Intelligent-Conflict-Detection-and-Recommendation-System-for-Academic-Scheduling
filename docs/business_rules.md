# Business Rules

## Course teaching assignment

**Which college teaches a course.** A course is *owned* by the college whose
curriculum offers it (`courses.department_id`) and may be *taught* by another
(`courses.teaching_department_id`). Only the second is a decision anyone records;
the first follows from the curriculum. With no override recorded, the owner
teaches its own course — `SchedulingPolicy::assignedTeachingDepartmentId()`
resolves that fallback, and the rule engine holds instructor assignment to active
instructors of whichever college the answer names.

**A major is never delegated.** It belongs to the department and program that
offers it, so `PATCH /api/course-teaching-assignments/{course}` refuses one with
422. Only a minor — a GEC or GEE service subject — may be handed to another
college.

**Anyone may record the decision; the list is not shared.** The colleges settle
between themselves who teaches what, so any secretary or program head may record
the override for any delegable course, whichever college owns it. The *listing*
is the opposite: strictly the acting department's own.

**The course list is the department's curriculum, never a global list.** A
department sees a course on this page if and only if its own active curriculum
places that course. Ownership does not put a course on the list, and neither does
teaching it for someone else. Three consequences:

- **Year level comes from `curriculum_course.year_level`, not `courses.year_level`.**
  The stored column is a default; the pivot is the authority. A shared minor sits
  in a different year for every college that offers it, so the stored level is the
  wrong answer for all but one of them. The page's 1st–4th Year tabs are built
  from the pivot.
- **No active curriculum means an empty list.** There is nothing to offer and
  nothing to place. Falling back to ownership was worse than saying so: a college
  that owns no minors of its own would be handed every shared GEC and GEE subject
  in the institution, because a shared minor has `department_id IS NULL`.
- **A course delegated *in* is reported separately.** It belongs to the owner's
  curriculum, so it cannot be placed on this department's year grid. It appears
  under `incoming_cross_department_courses` instead, which is where the college
  answerable for teaching it goes looking.

The same scope drives the Auto-Assign Instructor wizard — see
`InitialDataController` — and the two must agree. A course the wizard will not
offer a department is not a course that department should be delegating.
