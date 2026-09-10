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

## Minor course split sessions

The department setting named **Minor Course Split Sessions** is a master switch.
When enabled, schedule generation may split only the minor courses explicitly
selected for each section into two shorter MW or TTh meetings. The selection is
made in the schedule generation modal; course codes such as GEC, GEE, PE, or
other minor labels do not determine eligibility. Major lecture/laboratory
splitting remains a separate configuration and workflow.

When a selected minor split has no complete valid two-meeting placement after
room, time, persisted-schedule, delivery-mode, and capacity constraints are
applied, generation may use a single full-duration meeting for that course.
Split candidates are always searched and ranked first; the single meeting is a
lower-priority, explicitly marked fallback and is used only when it enables a
complete timetable. A successful fallback is reported with the course, section,
and reason so it is distinguishable from a user disabling Split Sessions.
The Minor/GEC split search must retain every valid start-time pair in the
configured split-day patterns. Search ranking may try nearby pairs first, but
candidate truncation must not make Online or a single meeting appear necessary
while a later physical pair remains valid.

Minor-course fallback order is lexicographic:

1. An unconfigured Minor course searches every valid physical single-meeting
   placement before any Online candidate is opened.
2. A configured Minor course searches every valid physical Split Session
   placement first, then every valid physical single-meeting placement.
3. Online is opened only after the applicable physical split and physical
   single-meeting tiers cannot produce a complete timetable.

Room compatibility, section conflicts, persisted and tentative schedules,
capacity, forced-day settings, and delivery-mode constraints remain hard rules
inside every tier.

## Generate Schedule fallback priority

After existing schedules and other hard conflicts prune a course's candidates,
regular physical course generation searches the remaining candidates in this order:

1. Monday-Friday candidates using compatible real rooms.
2. Saturday candidates using compatible real rooms.
3. Sunday candidates only when the existing course/session configuration permits them.
4. Room TBA candidates in the same weekday, Saturday, then Sunday order.

Every candidate in a tier is checked before the next tier is opened. Soft room
compactness, day balancing, and timetable quality scores may rank candidates
inside a tier, but cannot move Saturday or Room TBA ahead of a complete feasible
weekday solution. Explicit Schedule Setup rules remain authoritative, so a
forced Saturday course stays on Saturday.

Online lecture candidates use the same Monday-Saturday search tier. Saturday is
considered while online lecture candidates are explored instead of being withheld
until all weekday online candidates fail. This also applies to the online lecture
block inside a hybrid lecture/laboratory candidate; laboratory-only and
physical-only candidates retain the weekday-first order above.

For a course with both lecture and laboratory hours, the lecture component is
not implicitly Hybrid. When Hybrid is not explicitly selected, compatible
lecture rooms are generated first and the online lecture component is retained
only as a lower-priority fallback after those rooms are unavailable. An
explicit Hybrid selection preserves the online lecture plus physical laboratory
configuration. All online candidates remain subject to the department's
concurrent online-meeting limit, including assignments already chosen earlier
in the same year-level generation.
