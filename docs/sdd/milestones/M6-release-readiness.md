# M6: Release Readiness

Status: Accepted  
Milestone: M6

## Goal

Prepare the first-tester build for repeatable release-candidate validation without prematurely adding App Store, TestFlight, notarization, analytics, or crash-reporting automation.

M6 focuses on visible product identity, version/build hygiene, release-candidate checks, and a deterministic acceptance checklist.

## Scope

M6 includes:

- Visible app identity and version/build metadata in presentation surfaces.
- A deterministic release-info model that can be tested without platform dependencies.
- A release-candidate checklist that gates sharing a first-tester build.
- A clear split between development builds, first-tester builds, and future distribution work.
- Verification that release readiness work does not change gameplay rules.

## Non-goals

- No App Store Connect metadata.
- No TestFlight automation.
- No notarization pipeline.
- No analytics SDK.
- No crash-reporting SDK.
- No new route, score, audio, or gameplay content.
- No final icon or marketing-art pass unless explicitly approved later.

## Required specs

M6 is governed by:

- `SPEC-0028-release-identity.md`
- `SPEC-0029-release-candidate-checklist.md`
- `SPEC-0030-distribution-boundaries.md`

## Implementation slices

1. Release identity model and tests.
2. Visible version/build presentation in the app shell or title/help surface.
3. Release-candidate checklist and validation record.
4. Distribution-boundary documentation.
5. Validation and milestone closure.

## Acceptance criteria

A reviewer can:

1. See app name and version/build identity in a tester-visible surface.
2. Confirm release identity is test-covered and does not touch deterministic gameplay rules.
3. Run a release-candidate checklist before sharing a build.
4. Understand what M6 does not ship, especially TestFlight, notarization, analytics, and crash reporting.
5. Run `swift build`, `swift test`, and the iPhone/iPad Simulator build successfully.

## Validation

Pending implementation.
