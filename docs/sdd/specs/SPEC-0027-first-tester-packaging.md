# SPEC-0027: First Tester Packaging

Status: Validation Pending  
Milestone: M5

## Goal

Document a repeatable path for producing and validating first-tester builds without prematurely introducing App Store release automation.

## Scope

- macOS development build instructions.
- iPhone/iPad simulator and development-device build notes.
- Manual test matrix before sharing a build.
- Evidence template for tester feedback.
- Known limitations and non-release caveats.

## Requirements

1. The guide must identify the supported app shells.
2. The guide must include build and smoke-test commands.
3. The guide must describe how to reset local scores before a fresh test.
4. The guide must define what evidence to collect from a tester.
5. The guide must keep App Store/TestFlight automation out of M5 unless explicitly approved later.

## Implementation

`docs/implementation/M5-first-tester-handoff.md` now defines:

- supported app shells
- clean local validation commands
- macOS reset and quiet-test commands
- Xcode launch-argument guidance for iPhone/iPad
- first-tester smoke matrix
- tester feedback template
- M5 known limitations

## Non-goals

- No notarization pipeline.
- No TestFlight automation.
- No App Store Connect metadata.
- No crash-reporting SDK.
- No analytics SDK.

## Acceptance criteria

1. A maintainer can create a local macOS development build.
2. A maintainer can run the iPhone/iPad target in Simulator or on a development device.
3. A first-tester handoff checklist exists.
4. `swift build`, `swift test`, and the mobile simulator build pass.

## Validation

Implementation is in place. Automated and handoff-guide validation remain before this spec can be marked Implemented.
