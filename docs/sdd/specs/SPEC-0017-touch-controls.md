# SPEC-0017: Touch Controls

Status: Implemented  
Milestone: M2

## Goal

Provide clear touch controls for the playable route on iPhone and iPad while keeping input translated into the existing adapter-neutral `GameInput` model.

## Scope

- Touch movement control.
- Fire control.
- Start and restart control.
- Pause-ready layout if pause is introduced later.
- iPhone and iPad layout differences.

## Non-goals

- No advanced gesture system.
- No external controller support.
- No accessibility control remapping in M2.
- No gameplay rule changes.

## Acceptance criteria

1. The player can move without covering the ship for most of the route.
2. The player can fire intentionally.
3. Start and restart are obvious.
4. Touch controls do not hide HP, score, route progress, or active power.
5. The same deterministic core is used.
6. `swift test` passes.

## Manual validation

Validated on iPhone and iPad with drag movement, touch-and-hold firing, start/restart, safe-area layout, orientation changes, resizing, and lifecycle behavior. See `docs/implementation/M2BC-validation.md`.
