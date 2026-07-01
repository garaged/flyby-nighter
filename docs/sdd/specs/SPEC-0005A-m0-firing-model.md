# SPEC-0005A: M0 Firing Model

Status: Accepted  
Milestone: M0

## Related decision

See `docs/sdd/decisions/ADR-0004-forward-fire-gift-multishot.md`.

## Decision summary

M0 uses base forward fire. Multi-shot exists only as a temporary gift power.

## Base firing

- The player fires forward along the horizontal route direction.
- The player can hold fire rather than tapping repeatedly.
- Base bullets travel left-to-right.
- Base bullets damage enemies and despawn on impact or after leaving the play area.
- Base fire uses a cooldown owned by the deterministic gameplay core.

## Rapid Gift

- Temporarily reduces the player fire cooldown.
- Suggested initial duration: 8 seconds.
- Re-collecting Rapid refreshes the timer.
- Rapid should produce an obvious increase in bullet frequency.

## Spread Gift

- Temporarily replaces base projectile spawning with a triple-shot pattern.
- Suggested initial pattern: one forward projectile, one shallow upward-angle projectile, one shallow downward-angle projectile.
- Suggested initial duration: 8 seconds.
- Re-collecting Spread refreshes the timer.
- Spread should produce an obvious wider attack pattern.

## Shield Gift

- Does not change firing.
- Absorbs one damage event or follows the accepted damage model for M0.

## Stacking rule

M0 should support only one active offensive firing power at a time. Picking up Rapid while Spread is active, or Spread while Rapid is active, replaces the current offensive power unless implementation can support stacking with clear tests.

Shield may be tracked separately from the offensive firing power.

## M0 non-goals

- No twin-stick aiming.
- No independent aim direction separate from movement.
- No permanent multi-direction fire.
- No weapon inventory.
- No upgrade tree.
- No ammo economy.

## Acceptance criteria

- A deterministic test can assert base fire creates one forward projectile.
- A deterministic test can assert Rapid reduces the cooldown while active.
- A deterministic test can assert Rapid expires.
- A deterministic test can assert Spread creates three projectiles while active.
- A deterministic test can assert Spread expires.
- A deterministic test can assert picking up one offensive power replaces or refreshes the current offensive power according to this spec.
- Manual play visibly shows normal, rapid, and spread firing states.
