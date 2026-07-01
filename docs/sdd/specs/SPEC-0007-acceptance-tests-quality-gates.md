# SPEC-0007: M0 Acceptance Tests and Quality Gates

Status: Proposed  
Milestone: M0

## Purpose

Define what must be true before M0 is considered playable rather than just partially implemented.

## Manual acceptance path

A reviewer should be able to run the game and complete this path:

1. Start a new run.
2. Move the ship around the first segment.
3. Shoot and destroy a Drifter.
4. Dodge a Needler rush.
5. Dodge or destroy a Sentry burst pattern.
6. Navigate static obstacles.
7. Pass at least one pulse gate.
8. Collect Rapid Gift and observe faster firing.
9. Collect Spread Gift and observe multi-shot firing.
10. Collect Shield Gift and survive one otherwise-damaging hit.
11. Lose a run and restart.
12. Complete a run and restart.

## Automated test targets

Automated tests should prioritize deterministic core behavior over rendering details.

Recommended tests:

- Player damage reduces health and reaches lost state at zero.
- Shield absorbs one damage event.
- Rapid Gift reduces firing cooldown while active, then expires.
- Spread Gift emits multiple projectiles while active, then expires.
- Projectile/enemy collision destroys a low-health enemy and awards score.
- Player/gift collision activates the expected power.
- Player/exit collision in playing state transitions to won.
- Fixed-step simulation produces stable results for the same input sequence.

## Walking-skeleton smoke test

Once a runtime exists, add one thin smoke path that launches the game, starts a run, advances the simulation enough to verify the playable loop exists, and asserts no fatal runtime error.

## Validation record

When M0 is implemented, update this spec or the milestone document with:

- Build command used.
- Test command used.
- Manual acceptance notes.
- Known deferred polish.

## Non-goals

- Pixel-perfect rendering tests.
- Full asset snapshot testing.
- Exhaustive balance validation.
- Performance benchmarking beyond obvious playability.
