# M6 Release Candidate Checklist

Status: Implemented; validation pending  
Milestone: M6

Use this checklist before sharing a first-tester development build.

## Release identity

Record the visible release identity from the title/help surface:

```text
App: Flyby Nighter
Version: 0.6.0
Build: m6-dev
Channel: first-tester
Feedback token: app=Flyby Nighter; version=0.6.0; build=m6-dev; channel=first-tester
```

A build must not be shared if the title/help surface does not show the release identity.

## Clean automated validation

From a clean checkout:

```bash
git fetch origin
git switch m6-release-readiness
git reset --hard origin/m6-release-readiness

swift package clean
swift build
swift test
```

Build the iPhone/iPad target:

```bash
xcodebuild \
  -project Apps/FlybyNighterMobile/FlybyNighterMobile.xcodeproj \
  -scheme FlybyNighterMobile \
  -sdk iphonesimulator \
  -destination 'generic/platform=iOS Simulator' \
  CODE_SIGNING_ALLOWED=NO \
  build
```

A build must not be shared if any automated command fails.

## macOS smoke test

```bash
swift run FlybyNighterApp -- --reset-high-scores
swift run FlybyNighterApp
swift run FlybyNighterApp -- --mute-audio
```

Validate:

1. Title/help surface shows release identity.
2. Title/help surface explains route selection, scoring, best scores, reset, and mute.
3. `1`, `2`, arrows, and side clicks select routes before/after a run.
4. WASD/arrows move during active play.
5. Space fires during active play.
6. Completion and failure screens are readable.
7. Route-specific best scores update and persist.
8. `--reset-high-scores` clears known route bests.
9. `--mute-audio` keeps visual feedback while muting generated tones.

A build must not be shared if any smoke check fails.

## iPhone/iPad smoke test

Use Xcode or the simulator build command above.

Validate on one iPhone simulator/device and one iPad simulator/device:

1. Title/help surface shows release identity and remains readable.
2. Left/right side taps select routes.
3. Center tap starts/replays.
4. Hold-to-fire works.
5. Drag movement works.
6. Route-specific best scores are visible.
7. Pause/resume does not create stuck input or route changes.
8. Result screens remain readable.

A build must not be shared if any smoke check fails.

## Evidence to capture

For each release candidate, record:

- Date.
- Commit SHA.
- Release identity display text.
- Automated validation result.
- macOS smoke result.
- iPhone smoke result.
- iPad smoke result.
- Known issues or blockers.
- Decision: share / do not share.

## Failure handling

If any automated or manual gate fails:

1. Do not share the build.
2. Record the failure in the validation notes.
3. Fix the issue in a follow-up commit.
4. Re-run the full checklist.
