# M5 Validation

Branch: `m5-playtest-readiness`  
Status: Pending implementation

## Scope

M5 validates playtest readiness and usability:

- In-game onboarding and controls reference.
- Reset and mute affordances for repeated playtests.
- First-tester packaging and handoff instructions.

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

Pending implementation. The final matrix must include:

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
