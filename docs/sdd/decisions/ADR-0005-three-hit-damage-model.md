# ADR-0005: Three-Hit Damage Model for M0

Status: Accepted  
Date: 2026-07-01

## Context

M0 needs a damage and difficulty model that is easy to understand, easy to test, and forgiving enough for tuning the first playable map. A one-hit arcade death could be added later, but it would make early development and playtesting more brittle.

## Decision

M0 will use a **three-hit player health model** with fast restart.

The player starts each run with 3 hit points. Most damaging contacts remove 1 hit point. The run is lost when health reaches 0.

## Damage rules

- Player starts with 3 HP.
- Enemy bullets deal 1 damage.
- Enemy collision deals 1 damage.
- Static obstacle collision deals 1 damage.
- Pulse gate contact while dangerous deals 1 damage.
- Damage should have a short invulnerability window to prevent instant repeated damage from the same overlap.
- The Shield Gift absorbs one damage event, then is consumed.
- Shield damage absorption should happen before HP is reduced.

## Restart rule

Win and loss states must allow fast restart without relaunching the game.

## Implementation direction

- The deterministic core owns HP, shield state, damage events, invulnerability timers, win/loss transitions, and restart state reset.
- SpriteKit may render hit flashes, shield visuals, overlays, and restart UI, but should not own damage rules.

## M0 non-goals

- No one-hit arcade death mode.
- No lives/continues system.
- No health pickups unless explicitly accepted later.
- No armor tiers.
- No difficulty selection.

## Consequences

- The first map can be tuned around learning and iteration.
- Tests can verify damage, shield, invulnerability, loss, and restart without rendering.
- Harder one-hit or score-attack modes can be added after M0.
