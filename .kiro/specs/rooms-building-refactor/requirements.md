# Requirements Document

## Introduction

This specification replaces the free-form Room Name attribute with a controlled Building attribute throughout room persistence, backend APIs, validation, seed data, and frontend experiences. The change preserves room identity and all existing scheduling, recommendation, printing, teaching-load, and reporting behavior that depends on rooms.

## Glossary

- **Room_System**: The combined database, Laravel backend, seeders, and React frontend that manage and consume room records.
- **Room_Record**: A persisted room entity identified by a stable database identifier.
- **Building**: The canonical optional location attribute of a Room_Record; when present, the value is one member of the Allowed_Buildings set.
- **Allowed_Buildings**: The closed set `NEE Building`, `Building 1`, `Building 2`, `Building 3`, `Building 4`, `Building 5`, and `Building 6`.
- **Physical_Room**: A Room_Record whose Room_Type is `lecture` or `laboratory`.
- **Nonphysical_Room**: A Room_Record whose Room_Type is `online` or `field`, including the seeded `ONLINE` and `FIELD` records.
- **Room_Code**: The existing unique room number or code represented by the canonical API field `room_code`.
- **Room_Type**: The existing room classification represented by `lecture`, `laboratory`, `online`, or `field`.
- **Room_Status**: The existing availability classification represented by `available` or `not available`.
- **Canonical_API**: The room create, read, update, list, and nested schedule interfaces using snake_case JSON field names.
- **Building_Field**: The canonical API field named `building`.
- **Legacy_Room_Name_Field**: The superseded API and database field named `room_name`.
- **Legacy_Consumer**: An application component or external client that reads or writes Legacy_Room_Name_Field during the compatibility period.
- **Compatibility_Period**: A release-bounded interval during which Legacy_Consumer behavior is supported alongside Building_Field.
- **Migration_Report**: A verifiable record listing migrated Room_Record identifiers, source values, resulting Building values, and unresolved source values.
- **Display_Label**: A human-readable room location rendered as Room_Code followed by Building in parentheses when Building is present.
- **Rule_Engine**: The backend service that validates schedule constraints, including room conflicts and room-type compatibility.
- **CSP_Solver**: The backend service that generates and ranks schedule recommendations.
- **SchedulerPanel**: The frontend schedule editing and visualization interface.
- **Room_Selection**: Any interface that lists or chooses a Room_Record for a schedule.
- **Room_Related_Output**: SchedulerPanel, Print Schedule, Teaching Load, recommendation views, and room-related reports that display or process room information.

## Requirements

### Requirement 1: Canonical Building Data Model

**User Story:** As a scheduling administrator, I want each room associated with a controlled building value, so that room locations are consistent across the system.

#### Acceptance Criteria

1. THE Room_System SHALL represent the room location with Building_Field instead of Legacy_Room_Name_Field.
2. WHEN Building is present on a Room_Record, THE Room_System SHALL store exactly one value from Allowed_Buildings.
3. WHEN a Physical_Room is created or updated through Canonical_API, THE Room_System SHALL require Building_Field.
4. WHEN a Nonphysical_Room is created or updated through Canonical_API, THE Room_System SHALL accept a null Building_Field.
5. THE Room_System SHALL preserve each Room_Record identifier, Room_Code, Room_Type, Room_Status, department association, timestamps, and schedule relationships during the refactor.
6. THE Room_System SHALL preserve the uniqueness constraint for Room_Code.

### Requirement 2: Existing-Data Migration and Rollback

**User Story:** As a system operator, I want existing room data migrated deterministically, so that deployment does not lose room identity or silently invent locations.

#### Acceptance Criteria

1. WHEN the migration encounters a Legacy_Room_Name_Field value that exactly matches an Allowed_Buildings value after trimming surrounding whitespace, THE Room_System SHALL copy the matching Allowed_Buildings value to Building_Field.
2. WHEN the migration encounters an empty or null Legacy_Room_Name_Field value, THE Room_System SHALL derive Building only from an approved Room_Code-to-Building mapping supplied with the release.
3. IF the migration cannot map a Physical_Room to one Allowed_Buildings value, THEN THE Room_System SHALL retain a null Building_Field and add the Room_Record to Migration_Report.
4. IF the migration encounters a nonempty Legacy_Room_Name_Field value outside Allowed_Buildings, THEN THE Room_System SHALL preserve the source value in reversible migration data and add the Room_Record to Migration_Report.
5. WHEN the migration processes a Nonphysical_Room, THE Room_System SHALL preserve a null Building_Field unless an Allowed_Buildings value already exists.
6. WHEN the migration completes, THE Room_System SHALL produce Migration_Report with one outcome for every pre-existing Room_Record.
7. WHEN the migration is rolled back, THE Room_System SHALL restore each pre-migration Legacy_Room_Name_Field value and preserve each Room_Record identifier and relationship.

### Requirement 3: Canonical API Contract and Validation

**User Story:** As an API consumer, I want one canonical building field and predictable validation, so that room integrations use a stable contract.

#### Acceptance Criteria

1. THE Canonical_API SHALL use `building` as the only canonical room-location field in request and response payloads.
2. WHEN Canonical_API returns a room directly or nested within a schedule or recommendation, THE Room_System SHALL include Building_Field with an Allowed_Buildings value or null.
3. WHEN a create request for a Physical_Room omits Building_Field or supplies null, THE Room_System SHALL return a validation error associated with `building`.
4. WHEN an update changes a Room_Record to a Physical_Room while Building_Field is null, THE Room_System SHALL return a validation error associated with `building`.
5. IF a request supplies a non-null Building_Field value outside Allowed_Buildings, THEN THE Room_System SHALL return a validation error associated with `building` and leave the Room_Record unchanged.
6. WHEN a valid partial update omits Building_Field, THE Room_System SHALL preserve the existing Building value.
7. WHEN Canonical_API creates or updates a Room_Record successfully, THE Room_System SHALL return the persisted Building_Field value in the response.
8. THE Room_System SHALL apply identical Allowed_Buildings validation to backend requests and frontend room-management forms.

### Requirement 4: Legacy Consumer Compatibility

**User Story:** As a maintainer of an existing room consumer, I want a bounded compatibility path, so that deployments can transition without an unannounced contract break.

#### Acceptance Criteria

1. WHILE Compatibility_Period is active, THE Room_System SHALL include a read-only Legacy_Room_Name_Field alias equal to Building_Field in room API responses.
2. WHILE Compatibility_Period is active, WHEN a Legacy_Consumer submits Legacy_Room_Name_Field without Building_Field, THE Room_System SHALL validate the submitted value against Allowed_Buildings and process the submitted value as Building_Field.
3. WHILE Compatibility_Period is active, WHEN a request supplies both Building_Field and Legacy_Room_Name_Field with different normalized values, THE Room_System SHALL return a validation error and leave the Room_Record unchanged.
4. WHILE Compatibility_Period is active, WHEN a request supplies both Building_Field and Legacy_Room_Name_Field with equal normalized values, THE Room_System SHALL persist one Building value.
5. WHEN Compatibility_Period ends, THE Room_System SHALL reject Legacy_Room_Name_Field in write requests with a validation error identifying `building` as the replacement field.
6. WHEN Compatibility_Period ends, THE Room_System SHALL omit Legacy_Room_Name_Field from room API responses.

### Requirement 5: Seed Data

**User Story:** As a developer or operator, I want seed data to use controlled building values, so that fresh environments match production validation rules.

#### Acceptance Criteria

1. WHEN room seeders create or update a Physical_Room, THE Room_System SHALL assign one Allowed_Buildings value through Building_Field.
2. WHEN room seeders create or update the `ONLINE` or `FIELD` Nonphysical_Room, THE Room_System SHALL assign a null Building_Field.
3. THE Room_System SHALL preserve seeded Room_Code, Room_Type, Room_Status, and department associations except where a separately approved data correction changes a value.
4. IF seeded data contains a non-null value outside Allowed_Buildings, THEN THE Room_System SHALL terminate seeding with an error identifying the invalid Room_Code and value.
5. WHEN room seeders run more than once, THE Room_System SHALL update the same Room_Record selected by Room_Code without creating a duplicate Room_Record.

### Requirement 6: Room Management User Interface

**User Story:** As a dean or VPAA user, I want to select a predefined building when managing rooms, so that invalid building text cannot be entered.

#### Acceptance Criteria

1. WHEN the room-management form displays a Physical_Room, THE Room_System SHALL render Building as a required selection containing exactly Allowed_Buildings.
2. WHEN the room-management form displays a Nonphysical_Room, THE Room_System SHALL render Building as an optional selection containing Allowed_Buildings and an unassigned option.
3. WHEN a user submits the room-management form, THE Room_System SHALL send Building_Field and omit Legacy_Room_Name_Field from the request.
4. WHEN the room-management table displays a Room_Record, THE Room_System SHALL label the location column `Building` and display the Building value or `—` for null.
5. WHEN a user searches the room-management table, THE Room_System SHALL match Room_Code and Building using case-insensitive text comparison.
6. IF Canonical_API returns a building validation error, THEN THE Room_System SHALL display the error adjacent to the Building selection and retain the submitted form values.
7. THE Room_System SHALL preserve existing role-based room visibility, room-management authorization, department assignment, sorting, pagination, creation, editing, and deletion behavior.

### Requirement 7: Consistent Display Formatting

**User Story:** As a schedule reader, I want rooms displayed consistently, so that room code and building location are unambiguous.

#### Acceptance Criteria

1. WHEN a Physical_Room has Building, THE Room_System SHALL format Display_Label as `<room_code> (<building>)`.
2. WHEN a Room_Record has a null Building, THE Room_System SHALL format Display_Label as `<room_code>` without empty parentheses or separators.
3. WHEN the `ONLINE` Room_Record is displayed, THE Room_System SHALL display `Online`.
4. WHEN the `FIELD` Room_Record is displayed, THE Room_System SHALL display `Field`.
5. WHEN Room_Related_Output displays a room, THE Room_System SHALL use Display_Label consistently.
6. THE Room_System SHALL replace user-facing labels, placeholders, search hints, and column headings that refer to `Room Name` with Building terminology.

### Requirement 8: Scheduling and Recommendation Preservation

**User Story:** As a scheduler, I want the building refactor to preserve scheduling behavior, so that location metadata does not change conflict detection or recommendations.

#### Acceptance Criteria

1. THE Rule_Engine SHALL continue to identify room conflicts by Room_Record identifier, term, day, and overlapping time.
2. THE Rule_Engine SHALL continue to validate Room_Type compatibility independently of Building.
3. THE CSP_Solver SHALL continue to select rooms using existing Room_Record identifiers, Room_Type, Room_Status, department eligibility, and schedule constraints independently of Building.
4. WHEN Canonical_API accepts a schedule create, update, or batch request, THE Room_System SHALL continue to validate `room_id` against an existing Room_Record.
5. THE Room_System SHALL preserve recommendation generation, ranking, acceptance, and audit behavior except for replacing room-location field consumption and display.
6. THE SchedulerPanel SHALL preserve room drag-and-drop, room selection, conflict feedback, schedule editing, and schedule persistence behavior.
7. THE Room_System SHALL preserve any existing room-capacity behavior and capacity values without deriving capacity from Building.

### Requirement 9: Downstream Outputs and Reports

**User Story:** As an academic stakeholder, I want every schedule and report to use the new building attribute without losing existing information, so that operational outputs remain usable.

#### Acceptance Criteria

1. WHEN Print Schedule renders a Room_Record, THE Room_System SHALL use Display_Label.
2. WHEN Teaching Load renders a Room_Record, THE Room_System SHALL use Display_Label.
3. WHEN a room-related report renders or exports a Room_Record, THE Room_System SHALL include Room_Code and Building and omit Room Name terminology.
4. WHEN a recommendation view renders a Room_Record, THE Room_System SHALL use Display_Label.
5. THE Room_System SHALL preserve existing filtering, grouping, totals, ordering, pagination, print layout, and export structure in Room_Related_Output except for the renamed location attribute and Display_Label.
6. IF a downstream output receives a Room_Record with null Building, THEN THE Room_System SHALL render Room_Code without failing the output.

### Requirement 10: Deployment Verification and Observability

**User Story:** As a system operator, I want deployment checks for the refactor, so that invalid or unresolved room locations are visible before legacy support is removed.

#### Acceptance Criteria

1. WHEN the migration completes, THE Room_System SHALL report the count of Room_Record values mapped, left null, and marked unresolved.
2. IF any Physical_Room has a null Building_Field after migration, THEN THE Room_System SHALL identify each affected Room_Record by identifier and Room_Code in Migration_Report.
3. IF any non-null Building_Field value falls outside Allowed_Buildings, THEN THE Room_System SHALL fail deployment verification and identify each affected Room_Record.
4. WHEN Compatibility_Period is active, THE Room_System SHALL record each accepted write that uses Legacy_Room_Name_Field with the request time and affected Room_Record identifier.
5. WHEN no accepted Legacy_Room_Name_Field writes occur for the approved observation interval, THE Room_System SHALL report readiness to end Compatibility_Period.
6. THE Room_System SHALL provide automated verification for migration outcomes, API serialization, request validation, frontend selection values, Display_Label formatting, Rule_Engine room conflicts, CSP_Solver room selection, and Room_Related_Output rendering.

## Unresolved Product Decisions

1. **Approved migration mapping:** Product owners must provide the authoritative Room_Code-to-Building mapping for existing physical rooms whose `room_name` is blank or contains labels such as `Laboratory 1`, `Library`, or `Online Class`. The migration must report rather than guess unmapped values.
2. **Compatibility duration:** Product owners must define the release count or end date for Compatibility_Period and the observation interval required before removing Legacy_Room_Name_Field.
3. **Nonphysical room policy:** This specification treats Building as nullable for `online` and `field` rooms because Allowed_Buildings contains no virtual or outdoor value. Product owners must confirm this exception.
4. **Capacity source:** The inspected `rooms` schema does not contain a capacity column. Product owners must identify the current capacity source or confirm that “preserve capacity” means no new capacity behavior is introduced by this refactor.
