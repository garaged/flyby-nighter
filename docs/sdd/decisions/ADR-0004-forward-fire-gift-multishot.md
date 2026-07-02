# ADR-0004: Forward Fire with Gift-Only Multi-Shot for M0

Status: Accepted  
Date: 2026-07-01

## Context

M0 needs a small firing model that proves the core arcade loop without overbuilding aiming, twin-stick controls, or permanent multi-direction weapons.

The game fantasy includes powers that change how the ship fights. The first playable should make those gifts meaningful while keeping player controls simple on keyboard and touch.

## Decision

M0 will use **base forward fire with gift-only multi-shot**.

The base ship fires forward in the route direction. Multi-shot is not always available in M0. It is granted temporarily by the Spread Gift.

## Implementation direction

- Base fire shoots forward, left-to-right, matching the M0 route direction.
- Fire can be held down.
- The deterministic core owns fire cooldowns, projectile spawning, active power state, and power timers.
- Rapid Gift temporarily reduces the fire cooldown.
- Spread Gift temporarily changes projectile spawning to a triple-shot pattern.
- Shield Gift affects damage handling and does not alter firing.
- Re-collecting Rapid or Spread should refresh that power duration.
- M0 should support only one active offensive firing power at a time unless stacking is trivial and tested.

## M0 non-goals

- No twin-stick aiming.
- No independent aim direction separate from movement.
- No permanent multi-direction firing.
- No weapon inventory.
- No weapon upgrade tree.
- No complex ammo system.

## Consequences

- Controls stay simple for SpriteKit M0.
- The power-gift system has an immediate visible purpose.
- Full independent directional firing can be revisited after the first playable loop is fun.
