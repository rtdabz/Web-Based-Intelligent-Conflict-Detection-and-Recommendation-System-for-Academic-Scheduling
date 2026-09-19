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

## Course-driven Split Session and Hybrid delivery

Split Session is always available from **Step 2 - Setup Courses**. The user
selects the course and the affected sections there; the retired Minor, Major,
and Hybrid department switches do not gate the selection. Eligibility is
calculated from the selected course's units, lecture/laboratory hours, delivery
mode, and section configuration. Course codes and department identity are not
used as a hard-coded eligibility shortcut.

The two Hybrid shapes are distinct:

- **Hybrid Split** is a lecture-only course scheduled as two lecture meetings
  on different days, one Online and one Face-to-Face, each
  `SchedulingPolicy::HYBRID_SPLIT_MEETING_MINUTES` (1.5 hours) long. A course
  qualifies when those two meetings equal its weekly contact time
  (`units × 60`), which today means three units. The Face-to-Face meeting
  uses a lecture room, or a laboratory flagged for lecture use only when the
  course is a lecture-only major; it never falls back to Room TBA.
  Either meeting may be the face-to-face one. When rooms and times leave
  both orders equally good, the order alternates by section and course, so
  sections do not all meet face-to-face on their first day.
- **Integrated Hybrid** (Hybrid Laboratory) is a major with lecture and
  laboratory components, scheduled as two separate sessions on different
  days: an Online lecture and a Face-to-Face laboratory. Each length is the
  user's to set in the course's Configure panel. It starts at the course's
  own: one hour per lecture unit, and three hours per laboratory unit or the
  department's Custom Lab Duration when one is set. Together the two may not
  exceed the course's weekly ceiling (`class_duration`); only their delivery
  is fixed. The two are never merged into one block, even when a meeting
  pattern is supplied.

Integrated is always lecture + laboratory as two sessions; the course's
delivery decides the lecture:

- **Integrated On-site** — both face-to-face: the lecture in a lecture room,
  the laboratory in a laboratory. Sent as an Integrated course
  (`selected_split_session_course_ids`) whose delivery mode is `on-site`
  (`SchedulingPolicy::isIntegratedOnSite`).
- **Integrated Hybrid** — the lecture online, the laboratory face-to-face, as
  above.
- **Regular** is one meeting of the course's units. A lecture + laboratory
  course nobody configured is Regular, because that is what the Generator
  places for it.

### Setup Courses: Default Settings and course selection

Step 2 has **Default Settings** that apply to every course without Configure
settings of its own; a course saved from its Configure panel keeps its own
choices ("Use defaults for all" hands it back to the defaults).

- **Lecture Duration** sets the weekly length of lecture courses and of each
  Integrated lecture; **Laboratory Duration** that of laboratory courses and of
  each Integrated laboratory. Blank keeps each course's own length. A default
  longer than a course may meet a week (`class_duration`), or not whole
  slots per meeting, is skipped for that course, which keeps its own length.
  Field courses and Hybrid Split's fixed meetings are never changed.
- **Allow Friday and Saturday as Paired Days** (`allow_friday_saturday_split`)
  lets a Split Session or Hybrid Split also meet Friday + Saturday, tried
  after MW and TTh.

Every course starts checked. An unchecked course is left out of the run's
`course_ids`, field courses included. The API reads an empty list as "all
courses", so the wizard will not continue or generate with every course
unchecked.

### Field courses

A course is a field course only when the department makes it one: its
record requires the field (`room_type_required = field`), or its code is on
the department's field list (`field_course_settings`). Its name never does:
NSTP, ROTC and CWTS used to be field by keyword, with no way to turn it off.

In Setup Courses the list follows the Preferred Room. Picking a field room
adds the course to the list; No preference or a classroom removes it, and the
course is then scheduled like any other minor. The list is department-wide,
so the change applies to every section and is saved at once, like Required
Day. A lecture-only minor, or a course already on the list, is offered field
rooms beside its classrooms.

Both shapes are selected per course in Step 2. The generator and rule engine
must receive the same per-course configuration and must preserve all existing
room, time, section, capacity, forced-day, persisted-schedule, and delivery-mode
constraints.

When a selected Split Session has no complete valid two-meeting placement after
room, time, persisted-schedule, delivery-mode, and capacity constraints are
applied, generation must not silently convert it into a single full-duration
meeting. The run returns a recommendation instead. The recommendation may
offer Hybrid Split when vacant 1.5-hour slots can be used, or Regular Meeting
with an explicit On-site or Online choice. Both remain suggestions and require
user action before the configuration changes.
The Minor/GEC split search must retain every valid start-time pair in the
configured split-day patterns. Search ranking may try nearby pairs first, but
candidate truncation must not make Online or a single meeting appear necessary
while a later physical pair remains valid.

Split-course search order is lexicographic:

1. An unconfigured Minor course searches every valid physical single-meeting
   placement before any Online candidate is opened.
2. A configured Minor course searches every valid physical Split Session
   placement. If none can complete the run, generation stops with a
   recommendation; it does not add a single-meeting candidate to the domain.
3. Online is opened only according to the selected delivery mode or an
   explicitly chosen Hybrid Split/Regular Meeting recommendation.

Room compatibility, section conflicts, persisted and tentative schedules,
capacity, forced-day settings, and delivery-mode constraints remain hard rules
inside every tier.

## Step 1 Preferred Days

**Step 1 - Configuration** may limit a year level's run to chosen days
(`allowed_days`, one choice sent on every section). None chosen, or all seven,
means any day. It is a hard limit, not a ranking preference: the generator
places no meeting on a day left out, for a regular class, a Split Session, a
Hybrid Split or an Integrated Hybrid, and no retry strategy widens it.

- A two-meeting class keeps the MW or TTh pair whenever the chosen days allow
  one. When they allow neither, its pairs come from the chosen days instead,
  spaced pairs before back-to-back ones, so any two Preferred Days can hold it.
- Both Hybrid shapes need two different days, so one Preferred Day blocks a
  Hybrid course in the pre-check (`preferred_days_too_few_for_hybrid`). The
  response recommends adding another Preferred Day; a Split Session does not
  fall back to a single meeting.
- A course whose Required Day is not one of the Preferred Days is refused
  before generation, and Step 1 flags it as soon as the days are picked.
- A course whose own day limits (field weekdays, Sunday online-only) leave it
  nothing among the chosen days fails with an error naming the course and the
  Preferred Days.

## Course Configure panel: duration, Required Day, Preferred Room

Each course's **Configure** panel in Step 2 - Setup Courses carries every
course-level generation choice. Step 1 keeps the section-level Preferred
Meetings board and the year level's Preferred Days.

- **Custom Time Duration** changes the weekly length of a single-meeting class
  or of an on-site Split Session (entered per meeting; both meetings stay
  equal). It is sent per section as `duration_minutes_by_course_id`, reaches
  the solver on the course's requirement, and is judged by the year-level
  pre-check at the same length. The server refuses a length the save would
  reject: a single meeting may not exceed the course's weekly ceiling
  (`class_duration`), and a Split Session may not exceed the course's units
  (`minor_split_duration`, which accepts a shorter split and never a longer
  one). Integrated Hybrid's lecture and laboratory are set separately and sent
  as `component_minutes_by_course_id`; each must fit the teaching day and
  together they may not exceed the weekly ceiling. Hybrid Split keeps its
  fixed 1.5 h + 1.5 h.
- **Required Day** (optional) is the department's forced-day rule for the
  course, saved to the scheduling settings and enforced for every section and
  for manual edits. A course with a Required Day meets once, on that day; its
  Split or Hybrid markers are not sent.
- **Preferred Room** (optional) is a ranking preference inside an allocation
  tier: the generator tries that room first and falls back to any other
  compatible room. It never moves a course to Saturday, Room TBA or Online to
  keep the room, and a room that is busy at a given time is simply not chosen
  there. The choice list comes from the department's own rooms
  (`RoomAccessPolicy`), filtered to the type the course's face-to-face meeting
  needs — for Integrated Hybrid, a laboratory. The server refuses a room that
  is not available, not reachable this semester, or of the wrong type, using
  the same test as `room_type_match`. Online and field classes take none.

Duration and room follow the panel's section scope; Required Day always
applies to every section.

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
