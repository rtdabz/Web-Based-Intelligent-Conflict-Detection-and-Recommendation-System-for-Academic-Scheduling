## 2026-08-13 - Post-CSP schedule quality evaluation

- Keep Rule Engine and CSP ownership of hard constraints unchanged.
- Rank valid CSP candidates in a separate `ScheduleQualityEvaluator`.
- Use a higher-is-better score composed of resource usage, fair distribution, schedule compactness, and configuration compliance.
- Exclude instructor availability until the faculty-assignment phase.
- Keep the CSP's internal heuristics only for search ordering and candidate diversity; they are not the final timetable selection score.
