# M1 Validation

Branch: `m0-apple-scaffold`

## Implemented

M1-A route tuning baseline:

- Added `GameContent.m1NeonRift` with a tuned single-route content layout.
- Added `GameConfig.m1` for M1 route timing and feel constants.
- Pointed the playable SpriteKit scene at `GameConfig.m1`.
- Preserved `GameConfig.m0` and `GameContent.neonRift` as the M0 baseline.
- Added deterministic tests for M1 route duration, content order, gift availability, opening setup time, and M0/M1 config separation.

## Tuning intent

- Run duration target is about 54 seconds.
- Opening enemy appears after roughly 3.6 seconds of route time.
- Gifts appear before the final route quarter.
- Enemy pressure increases from early Drifter to later Needler/Sentry combinations.
- Timed gates are spaced away from the opening and use shorter danger windows than M0.

## Validation

Pending local validation:

```bash
swift test
swift run FlybyNighterMac
```

## Manual attempts

Not run yet from this environment.

## Outcome summary

Pending local playtest.

## Confusing moments

Pending local playtest.

## Deferred polish

- Further visual motion cues for the corridor.
- Full placeholder audio event wiring.
- More precise per-sector tuning after manual playtest.
- Possible authored route notes per spawn if tuning grows.

## Spec trace

- `SPEC-0012-m1-game-feel.md`
- `SPEC-0013-m1-map-pacing.md`
- `SPEC-0014-m1-visual-readability.md`
- `SPEC-0015-m1-playtest-validation.md`
