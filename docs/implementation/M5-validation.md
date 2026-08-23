# M5 Validation

Branch: `m5-playtest-readiness`  
Status: Passed  
Validated: August 23, 2026

## Scope

M5 validates playtest readiness and usability:

- In-game onboarding and controls reference.
- Reset and mute affordances for repeated playtests.
- First-tester packaging and handoff instructions.

## Implementation

M5 delivered:

- `PlaytestGuide` in the SpriteKit adapter layer as the canonical copy model for first-tester help text.
- `PlaytestGuideTests` covering route selection, controls, scoring, best scores, reset, and mute guidance.
- Shared `FlybyNighterScene` title overlay rendering the guide summary before active play.
- In-app explanation of route selection, scoring, route-specific best scores, `--reset-high-scores`, and `--mute-audio`.
- `docs/implementation/M5-first-tester-handoff.md` with macOS, iPhone/iPad, reset, mute, smoke-test, and feedback handoff guidance.

## Automated validation result

Passed:

```bash
swift build
swift test
```

Passed mobile target build:

```bash
xcodebuild \
  -project Apps/FlybyNighterMobile/FlybyNighterMobile.xcodeproj \
  -scheme FlybyNighterMobile \
  -sdk iphonesimulator \
  -destination 'generic/platform=iOS Simulator' \
  CODE_SIGNING_ALLOWED=NO \
  build
```

## Manual validation result

Validated successfully:

1. The title screen explains how to select both routes.
2. The title screen references route-specific best scores.
3. The title screen exposes `--reset-high-scores`.
4. The title screen exposes `--mute-audio`.
5. Result screens still fit and remain readable after the title-overlay changes.
6. A first tester can find and understand controls without source/docs.
7. Route selection remains discoverable on macOS, iPhone, and iPad.
8. Score and best-score explanations are visible and accurate.
9. Reset and mute workflows are deliberate and documented.
10. The first-tester handoff guide provides repeatable macOS and iPhone/iPad build and smoke-test steps.

## Completion gate

M5 is complete:

1. `SPEC-0025`, `SPEC-0026`, and `SPEC-0027` are implemented.
2. Automated validation passed.
3. Manual playtest readiness validation passed.
4. The M5 milestone can be marked Completed.
