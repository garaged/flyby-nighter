# M4-C/D/E Validation

Branch: `m4-content-expansion`  
Status: Automated validation passed; manual validation pending

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

## Automated coverage

Core tests cover:

- Glass Shear registration and obstacle membership.
- Opposing vertical gate movement.
- Score-source accounting.
- Completion and remaining-HP bonuses.
- Ledger reset behavior.
- Explicit no-combo policy.

SpriteKit adapter tests cover:

- Route-specific high-score separation.
- Lower/equal score rejection.
- Persistence across store instances.
- Reset behavior.
- Negative-score safety.

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

## Manual validation matrix

Validate on `FlybyNighterApp`, one iPhone simulator/device, and one iPad simulator/device:

1. The Glass Shear appears late in The Glass Tide as two yellow crossing pulse gates.
2. The gates move on opposing vertical diagonals and remain readable.
3. The pattern is avoidable after learning and does not create an unavoidable full-screen wall.
4. Live score increases by the documented enemy and gift values.
5. Completion adds the documented completion and remaining-HP bonuses.
6. Failure adds neither completion nor remaining-HP bonus.
7. Result-screen category values add up to the displayed total.
8. The title and HUD display a separate best value for each route.
9. A higher run shows `NEW BEST` and updates the route best.
10. A lower or equal run does not replace the best.
11. Quit and relaunch the same app shell; both route bests remain.
12. Launch with `--reset-high-scores`; both route bests return to zero.
13. Movement, firing, route selection, pause/resume, audio, and feedback do not regress.

## Completion gate

M4 is complete after:

1. Package CI passes — passed.
2. Mobile CI passes — passed.
3. The manual validation matrix passes.
4. `SPEC-0023` and `SPEC-0024` are marked Implemented.
5. The M4 milestone is marked Completed.
