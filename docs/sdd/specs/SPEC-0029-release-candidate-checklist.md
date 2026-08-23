# SPEC-0029: Release Candidate Checklist

Status: Validation Pending  
Milestone: M6

## Goal

Define a repeatable checklist that must pass before sharing a first-tester build.

## Scope

- Release-candidate validation commands.
- Manual smoke checklist across supported shells.
- Evidence fields a maintainer should capture before handoff.
- Explicit failure-handling guidance when a gate fails.

## Requirements

1. The checklist must include `swift build` and `swift test`.
2. The checklist must include the iPhone/iPad Simulator build.
3. The checklist must include a macOS smoke test.
4. The checklist must include title/help readability, route selection, scoring, best-score, reset, and mute checks.
5. The checklist must capture release identity, date, platform, and tester/build notes.
6. A failed checklist item must block sharing the build.

## Implementation

`docs/implementation/M6-release-candidate-checklist.md` defines:

- release identity evidence fields
- clean checkout commands
- `swift build` and `swift test`
- iPhone/iPad Simulator build command
- macOS smoke checklist
- iPhone/iPad smoke checklist
- evidence fields
- failure-handling steps that block sharing

## Non-goals

- No automatic package signing.
- No TestFlight pipeline.
- No crash-reporting dashboard.
- No automated UI screenshot capture.

## Acceptance criteria

1. The checklist exists in the repository.
2. The checklist maps to the implemented M4 and M5 behavior.
3. The checklist includes evidence fields.
4. The checklist clearly blocks sharing on failure.

## Validation

Implementation is in place. Automated and manual checklist validation remain before this spec can be marked Implemented.
