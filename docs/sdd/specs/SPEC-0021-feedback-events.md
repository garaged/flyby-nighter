# SPEC-0021: Feedback Events

Status: Proposed  
Milestone: M3

## Goal

Make important gameplay events visible and understandable through short visual feedback in addition to audio.

## Scope

Feedback for:

- Player hit.
- Score gain.
- Gift pickup.
- Shield use.
- Active power expiration.
- Route completion.
- Run failure.

## Non-goals

- No heavy particle system.
- No full animation framework.
- No final art pass.

## Acceptance criteria

1. Feedback is brief and readable.
2. Feedback does not hide projectiles, enemies, gifts, or hazards.
3. Feedback works without audio.
4. Repeated events do not create excessive clutter.
5. `swift test` passes.
