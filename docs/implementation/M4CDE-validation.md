# M4-C/D/E Validation

Branch: `m4-content-expansion`  
Status: Passed  
Validated: August 23, 2026

## M4-C: Glass Shear hazard family

Implemented and validated as an original composed hazard using existing deterministic obstacle primitives:

- Two narrow pulse gates.
- Opposing vertical velocities.
- Closely spaced spawn timing.
- Distinct yellow rendering in the SpriteKit adapter.
- Registered as the `glass-shear` hazard family on The Glass Tide.

The corrective patch made this discoverable with explicit `ROUTE 2/2 — The Glass Tide` text and a Glass Shear description before launch.

## M4-D: score-depth decision

M4 keeps scoring linear and does not add a combo multiplier.

Validated score sources:

- Enemy removals.
- Gift pickups.
- Route completion.
- Remaining HP after completion.

`ScoreLedger` and `ScoreBreakdown` provide deterministic category totals. Result screens show the breakdown and the live HUD shows current and best scores.

## M4-E: local high scores

Validated behavior:

- Stored per route with `UserDefaultsHighScoreStore`.
- Missing values default to zero.
- Only strictly higher values replace the best.
- Best values persist across relaunches in the same app shell.
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

Package CI and Mobile CI passed after the corrective patch.

## Focused corrective retest result

Passed:

1. `ROUTE 1/2 — The Neon Rift` is visible on the title screen.
2. `2`, Right Arrow, and side selection expose `ROUTE 2/2 — The Glass Tide`.
3. Glass Shear appears late in The Glass Tide as two yellow crossing gates.
4. The Glass Shear movement leaves a readable and avoidable opening.
5. Separate route best scores are visible when each route is selected.
6. Route best scores persist after quitting and relaunching the same app shell.
7. `--reset-high-scores` resets both route bests to zero.

## Result

M4-C, M4-D, and M4-E acceptance criteria passed. M4 is complete.
