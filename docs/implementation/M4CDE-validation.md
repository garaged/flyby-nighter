# M4-C/D/E Validation

Branch: `m4-content-expansion`  
Status: Automated validation passed; corrective manual retest pending

## M4-C: Glass Shear hazard family

Implemented as an original composed hazard using existing deterministic obstacle primitives:

- Two narrow pulse gates.
- Opposing vertical velocities.
- Closely spaced spawn timing.
- Distinct yellow rendering in the SpriteKit adapter.
- Registered as the `glass-shear` hazard family on The Glass Tide.

The pattern rewards reading the open diagonal lane instead of adding a new special-case collision system.

## M4-D: score-depth decision

M4 keeps scoring linear and does not add a combo multiplier.

Visible score sources:

- Enemy removals.
- Gift pickups.
- Route completion.
- Remaining HP after completion.

`ScoreLedger` and `ScoreBreakdown` provide deterministic category totals. Result screens show the breakdown and the live HUD shows current and best scores.

## M4-E: local high scores

- Stored per route with `UserDefaultsHighScoreStore`.
- Missing values default to zero.
- Only strictly higher values replace the best.
- Best values persist across store and app instances in the same app domain.
- `NEW BEST` is shown on completion or failure when appropriate.
- `--reset-high-scores` clears known route values for debugging.

## Automated validation result

Passed on PR #3:

```bash
swift build
swift test
```

Both macOS executable products compile successfully.

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

## First manual validation result

Passed:

- Live enemy and gift scoring.
- Completion and remaining-HP bonuses.
- Failure bonus exclusion.
- Result breakdown totals.
- Lower/equal scores do not replace the best.
- Movement, firing, route selection, pause/resume, audio, and feedback regressions were not observed.

Not sufficiently visible or reliable:

- Selecting The Glass Tide was not obvious.
- Glass Shear could not be identified and evaluated.
- Separate route bests were not clear.
- Best scores did not reliably survive relaunch.

## Corrective patch

- Route names now show `ROUTE 1/2` and `ROUTE 2/2`.
- Neon Rift explicitly explains how to select Glass Tide.
- Glass Tide explicitly describes the two yellow Glass Shear gates.
- macOS supports direct `1` and `2` route shortcuts in addition to arrows and click zones.
- Local scores use the stable `com.garaged.flyby-nighter.local-scores` preferences suite.
- Score writes and resets are explicitly synchronized before process exit.

Package CI and Mobile CI pass after the corrective patch.

## Focused manual retest

1. On the title screen, confirm `ROUTE 1/2 — The Neon Rift` is visible.
2. Press `2`, Right Arrow, or tap/click the right side and confirm `ROUTE 2/2 — The Glass Tide` is visible.
3. Start Glass Tide and identify the two yellow crossing gates late in the route.
4. Confirm the Glass Shear movement leaves a readable and avoidable opening.
5. Record different best scores on the two routes and verify each appears when that route is selected.
6. Quit and relaunch the same app shell and verify both best values remain.
7. Launch with `--reset-high-scores` and verify both route bests return to zero.

## Completion gate

M4 is complete after:

1. Package CI passes — passed.
2. Mobile CI passes — passed.
3. The focused corrective retest passes.
4. `SPEC-0023` and `SPEC-0024` are marked Implemented.
5. The M4 milestone is marked Completed.
