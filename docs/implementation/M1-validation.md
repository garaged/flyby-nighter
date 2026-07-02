# M1 Validation

Branch: `m0-apple-scaffold`

## Implemented

M1-A route tuning baseline:

- Added `GameContent.m1NeonRift` with a tuned single-route content layout.
- Added `GameConfig.m1` for M1 route timing and feel constants.
- Pointed the playable SpriteKit scene at `GameConfig.m1`.
- Preserved `GameConfig.m0` and `GameContent.neonRift` as the M0 baseline.
- Added deterministic tests for M1 route duration, content order, gift availability, opening setup time, and M0/M1 config separation.

M1 route backdrop readability:

- Added `RouteBackdropNode` in the SpriteKit adapter.
- Added moving route rails, diagonal flow lines, small drifting specks, sector tinting, and a late-route exit cue.
- Kept backdrop rendering out of the deterministic core.

## Tuning intent

- Run duration target is about 54 seconds.
- Opening enemy appears after roughly 3.6 seconds of route time.
- Gifts appear before the final route quarter.
- Enemy pressure increases from early Drifter to later Needler/Sentry combinations.
- Timed gates are spaced away from the opening and use shorter danger windows than M0.
- The route should no longer read as a fully black empty field between active objects.

## Validation

Max confirmed validation passed after the route backdrop pass.

Validated locally:

```bash
swift test
swift run FlybyNighterMac
```

## Manual attempts

Run locally by Max.

## Outcome summary

- Tests passed.
- Playable route looks fine.
- Route backdrop improvement is accepted.
- Background no longer reads as a plain black field.

## Confusing moments

No new confusing moments reported after the route backdrop pass.

## Deferred polish

- Full placeholder audio event wiring.
- More precise per-sector tuning after further playtest.
- Possible authored route notes per spawn if tuning grows.
- Richer background art after the placeholder readability pass.
- Wiring `ReadableSpriteFactory` into `FlybyNighterScene` remains deferred because the connector blocked the scene rewrite; the factory file is staged infrastructure only.

## Spec trace

- `SPEC-0012-m1-game-feel.md`
- `SPEC-0013-m1-map-pacing.md`
- `SPEC-0014-m1-visual-readability.md`
- `SPEC-0015-m1-playtest-validation.md`
