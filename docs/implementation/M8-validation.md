# M8 Validation

Branch: `m8-first-tester-automation`  
Status: Passed  
Validated: September 1, 2026

## Scope

M8 validates first-tester build automation and handoff:

- Release identity updated to M8.
- First-tester build plan model and tests.
- Root `make` commands.
- Local validation script.
- Local macOS bundle script.
- Bundle manifest and handoff README.
- Tester feedback workflow.
- Confirmation that gameplay rules remain unchanged.

## Implemented

- `FirstTesterBuildPlan` and `FirstTesterCommand` in `FlybyNighterCore`.
- `FirstTesterBuildPlanTests`.
- M8 `ReleaseIdentity.firstTester` values.
- `Makefile` with validation, mobile build, run, reset, mute, and package targets.
- `scripts/first-tester/validate.sh`.
- `scripts/first-tester/package-macos.sh`.
- `docs/implementation/M8-first-tester-automation.md`.
- `docs/implementation/M8-tester-feedback-workflow.md`.
- M8 milestone and specs.
- CI workflow coverage for `make validate`, `make package-first-tester`, and `make mobile-build`.

## Automated validation

Passed in CI on the PR head:

```bash
make validate
make package-first-tester
make mobile-build
```

The validation path covers:

```bash
swift build
swift test
xcodebuild \
  -project Apps/FlybyNighterMobile/FlybyNighterMobile.xcodeproj \
  -scheme FlybyNighterMobile \
  -sdk iphonesimulator \
  -destination 'generic/platform=iOS Simulator' \
  CODE_SIGNING_ALLOWED=NO \
  build
```

## Manual validation matrix

Passed:

1. `make validate` runs package build, tests, and mobile simulator build.
2. `make run-macos` launches the macOS shell.
3. `make run-macos-reset` launches with high scores reset.
4. `make run-macos-muted` launches with audio muted.
5. `make package-first-tester` creates `.build/first-tester/FlybyNighter-first-tester`.
6. The bundle includes `FlybyNighterApp`, `MANIFEST.md`, and `README-FIRST-TESTER.md`.
7. The manifest includes release identity, feedback token, commit, timestamp, validation status, validation commands, distribution boundary, and feedback categories.
8. The handoff README includes run instructions, smoke test focus, and feedback template.
9. No App Store, TestFlight, notarization, signing automation, telemetry, analytics, or crash-reporting SDKs are introduced.
10. M4-M7 title, route selection, scoring, best score, reset, mute, and result-screen behavior do not regress.

## Completion gate

M8 is complete:

1. `SPEC-0034`, `SPEC-0035`, and `SPEC-0036` are implemented.
2. Automated validation passed.
3. Manual automation and bundle validation passed.
4. The M8 milestone is ready to be marked Completed.
