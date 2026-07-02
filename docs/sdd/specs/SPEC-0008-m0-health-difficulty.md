# SPEC-0008: M0 Health and Difficulty

Status: Accepted  
Milestone: M0

## Related decision

See `docs/sdd/decisions/ADR-0005-three-hit-damage-model.md`.

## Decision summary

M0 uses 3 player hit points, 1 damage per common damaging event, one-hit shield absorption, brief post-hit invulnerability, and fast restart.

## Player health

- The player starts each run with 3 HP.
- HP cannot exceed 3 in M0 unless a later spec adds health pickups or overheal.
- The run transitions to lost when HP reaches 0.
- A restart resets HP to 3, clears active powers, clears projectiles/enemies, resets route progress, and returns to the start of the map.

## Damage sources

These events deal 1 damage:

- Enemy bullet hits player.
- Enemy collides with player.
- Player collides with static obstacle.
- Player contacts a pulse gate while it is dangerous.

## Shield Gift

- Shield absorbs one damaging event.
- Shield is consumed after absorbing damage.
- Shield absorption happens before HP reduction.
- Shield may coexist with one offensive gift power.

## Post-hit invulnerability

After taking HP damage, the player gets a short invulnerability window to prevent repeated damage from a single overlap.

Suggested initial duration: 1 second.

Shield absorption may either grant the same invulnerability window or only consume the shield. Prefer granting the same window if implementation remains simple.

## Difficulty tuning for M0

M0 should be learnable rather than punishing:

- The first route should be completable by a new player after a few attempts.
- Obstacles should be readable and avoidable.
- Gifts should be easy enough to test manually.
- At least one gift should require a mild risk/reward choice.
- Enemy fire speed should start slow enough that damage feels fair.

## M0 non-goals

- No one-hit death mode.
- No lives/continues system.
- No difficulty selection.
- No permanent health upgrades.
- No health pickups unless accepted later.

## Acceptance criteria

- A deterministic test can assert player starts with 3 HP.
- A deterministic test can assert each damage source reduces HP by 1 when unshielded.
- A deterministic test can assert shield absorbs one damage event without HP loss.
- A deterministic test can assert shield is consumed after absorption.
- A deterministic test can assert post-hit invulnerability prevents immediate repeated damage.
- A deterministic test can assert HP reaching 0 transitions the run to lost.
- A deterministic test can assert restart resets HP, route progress, active powers, and run state.
- Manual play supports losing and restarting quickly.
