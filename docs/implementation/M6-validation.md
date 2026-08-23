# M6 Validation

Branch: `m6-release-readiness`  
Status: Implementation complete; automated and manual validation pending

## Scope

M6 validates release readiness for a first-tester development build:

- Tester-visible release identity.
- Version/build/channel presentation.
- Release-candidate checklist.
- Distribution-boundary documentation.
- Confirmation that gameplay rules remain unchanged.

## Implemented

- `ReleaseIdentity` in `FlybyNighterCore`.
- `ReleaseIdentityTests`.
- Playtest title/help release identity presentation.
- Release identity coverage in `PlaytestGuideTests`.
- `docs/implementation/M6-release-candidate-checklist.md`.
- `docs/implementation/M6-distribution-boundaries.md`.
- Validation-pending SDD status for `SPEC-0028`, `SPEC-0029`, and `SPEC-0030`.

## Expected automated validation

```bash
swift build
swift test
```

Mobile build:

```bash
xcodebuild \
  -project Apps/FlybyNighterMobile/FlybyNighterMobile.xcodeproj \
  -scheme FlybyNighterMobile \
  -sdk iphonesimulator \
  -destination 'generic/platform=iOS Simulator' \
  CODE_SIGNING_ALLOWED=NO \
  build
```

## Manual validation matrix

1. Release identity is visible before a playtest.
2. Release identity includes app name, version, build, and channel.
3. A tester can copy the release identity into feedback.
4. The release-candidate checklist can be followed from a clean checkout.
5. The checklist blocks sharing on failure.
6. Distribution boundaries are explicit: no TestFlight/App Store/notarization/telemetry automation in M6.
7. Route selection, scoring, best scores, reset, mute, and help do not regress.

## Completion gate

M6 is complete after:

1. `SPEC-0028`, `SPEC-0029`, and `SPEC-0030` are implemented.
2. Automated validation passes.
3. The manual release-readiness matrix passes.
4. The M6 milestone is marked Completed.
