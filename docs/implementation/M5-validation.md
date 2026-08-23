# M5 Validation

Branch: `m5-playtest-readiness`  
Status: M5-A implemented; automated validation pending

## Scope

M5 validates playtest readiness and usability:

- In-game onboarding and controls reference.
- Reset and mute affordances for repeated playtests.
- First-tester packaging and handoff instructions.

## M5-A implementation

Added `PlaytestGuide` in the SpriteKit adapter layer as the canonical copy model for first-tester help text.

The guide covers:

- route selection on macOS, iPhone, and iPad
- movement and firing controls
- enemy, gift, completion, and HP score sources
- route-specific best scores
- `--reset-high-scores`
- `--mute-audio`

Added `PlaytestGuideTests` to protect this copy coverage.

The guide is now wired into the shared `FlybyNighterScene` title overlay so a first tester can see route-selection, score, best-score, reset, and mute guidance from inside the app before starting a run.

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

M5-A title-overlay checks:

1. The title screen explains how to select both routes.
2. The title screen references route-specific best scores.
3. The title screen exposes `--reset-high-scores`.
4. The title screen exposes `--mute-audio`.
5. Result screens still fit and remain readable after the title-overlay changes.

Remaining M5 checks before milestone completion:

1. A first tester can find and understand controls without source/docs.
2. Route selection remains discoverable on macOS, iPhone, and iPad.
3. Score and best-score explanations are visible and accurate.
4. Reset and mute workflows are deliberate and documented.
5. A maintainer can create and smoke-test a local macOS development build.
6. A maintainer can create and smoke-test an iPhone/iPad Simulator or development-device build.

## Completion gate

M5 is complete after:

1. `SPEC-0025`, `SPEC-0026`, and `SPEC-0027` are implemented.
2. Automated validation passes.
3. The manual playtest readiness matrix passes.
4. The M5 milestone is marked Completed.
