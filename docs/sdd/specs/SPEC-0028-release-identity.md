# SPEC-0028: Release Identity

Status: Implemented  
Milestone: M6

## Goal

Expose a tester-visible app identity and version/build value so feedback can be tied to the exact build under test.

## Scope

- A deterministic release identity model.
- App name, semantic version, build number, and channel.
- Presentation of release identity in the title/help surface or another tester-visible shell surface.
- Tests that protect the identity format.

## Requirements

1. Release identity must be available without importing SpriteKit, AppKit, UIKit, SwiftUI, or AVFoundation.
2. The default app name must be `Flyby Nighter`.
3. The default channel for M6 must be `first-tester`.
4. Version and build strings must be non-empty.
5. Tester-facing presentation must include app name, version, build, and channel.
6. Release identity must not alter deterministic gameplay rules.

## Implementation

- `ReleaseIdentity` lives in `FlybyNighterCore` and imports only Foundation.
- `ReleaseIdentity.firstTester` is `Flyby Nighter v0.6.0 (m6-dev) • first-tester`.
- `ReleaseIdentity.feedbackToken` gives testers a copyable feedback token.
- `PlaytestGuide` renders release identity in the title/help surface.
- `ReleaseIdentityTests` and `PlaytestGuideTests` protect formatting and visibility.

## Non-goals

- No App Store version automation.
- No build-number service.
- No git-SHA injection.
- No localization pass.

## Acceptance results

1. Release identity has automated tests.
2. A tester can see the release identity before or during a playtest.
3. The identity can be copied into tester feedback.
4. `swift test` passes.

## Validation

Implemented and validated on August 23, 2026.

See `docs/implementation/M6-validation.md`.
