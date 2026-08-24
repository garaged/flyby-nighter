# SPEC-0036: Tester Feedback Workflow

Status: Validation Pending  
Milestone: M8

## Goal

Give first testers a clear, low-friction way to report feedback with enough build context to reproduce issues.

## Scope

- Feedback fields and template.
- What testers should include in bug reports.
- What maintainers should check before accepting a report.
- Relationship to release identity and bundle manifest.
- Explicit privacy and data-minimization guidance.

## Requirements

1. Tester feedback must include release identity.
2. Tester feedback must include platform and input mode.
3. Tester feedback must include route, expected behavior, actual behavior, and reproduction steps when applicable.
4. Feedback guidance must avoid asking testers for private data, logs with secrets, or analytics identifiers.
5. Workflow must remain manual/local in M8; no telemetry, crash-reporting SDK, or automatic upload is added.
6. Feedback workflow must include triage categories for blocker, regression, usability, visual, and polish feedback.

## Implementation

- `docs/implementation/M8-tester-feedback-workflow.md` defines required fields, categories, privacy guidance, and maintainer intake.
- The generated first-tester handoff README includes a tester feedback template.
- `FirstTesterBuildPlan.feedbackCategories` is test-covered.
- The bundle manifest includes feedback categories.

## Acceptance criteria

1. Feedback template is documented.
2. Handoff bundle points testers to the feedback template.
3. Workflow includes triage categories.
4. No telemetry or automatic feedback collection is introduced.

## Validation

Implementation is in place. Manual handoff and feedback workflow validation pending.
