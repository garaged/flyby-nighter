# SPEC-0012: M1 Game Feel

Status: Proposed  
Milestone: M1

## Goal

Improve the feel of the current playable route without changing the overall M0 feature set. The ship, firing, hazards, gifts, scoring, win state, and restart loop should feel responsive, readable, and fair enough for repeated playtesting.

## Scope

This spec covers tuning and feel only:

- Player movement speed and acceleration feel.
- Projectile speed, fire cadence, and visible spacing.
- Gift duration and usefulness.
- Hitbox fairness for the player, enemies, gifts, and obstacles.
- Post-hit recovery timing and feedback.
- Restart responsiveness.
- Route duration target.

## Non-goals

- No new permanent systems.
- No new route.
- No final art or final audio.
- No platform-specific app-store polish.
- No direct copying of legacy arcade behavior, tuning, map structure, or audiovisual identity.

## Tuning targets

- A run should last roughly 45 to 75 seconds in M1.
- The player ship should feel nimble but not twitchy.
- The player should have enough time to react to the first enemy and first obstacle.
- Basic fire should feel useful without requiring perfect precision.
- Rapid and Spread should feel meaningfully stronger than basic fire.
- Shield should be clearly useful even when no other power is active.
- A player should not lose HP immediately after a hit unless the recovery window has clearly ended.

## Acceptance criteria

A reviewer can verify that:

1. Movement responds immediately to keyboard and touch-adapter input hooks.
2. The player can dodge early threats without memorizing the route.
3. Basic firing can remove at least one early enemy reliably.
4. Rapid and Spread visibly improve offensive output.
5. Shield absorbs or prevents one mistake in a way the player can understand.
6. Post-hit recovery avoids instant repeated HP loss.
7. Restart after completion or failure is quick and reliable.
8. `swift test` passes.

## Automated tests

Core tests should continue to cover:

- Movement bounds.
- Firing cadence.
- Power duration expiration.
- Shield behavior.
- HP and end-state transitions.

M1 may add tests for any changed constants or deterministic behavior.

## Manual validation

Use `SPEC-0015-m1-playtest-validation.md`. Record notable feel problems as implementation notes, not as hidden assumptions.

## Deferred polish

- Gamepad support.
- Advanced acceleration curves.
- Final sound mix.
- Full animation pass.
