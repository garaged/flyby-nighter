# SPEC-0019: Audio Event Adapter

Status: Implemented  
Milestone: M3

## Goal

Map deterministic `GameEvent` values to platform audio behavior outside `FlybyNighterCore`.

## Scope

- Adapter-side event-to-audio mapping.
- Safe handling of repeated events.
- No-op behavior when audio is disabled or unavailable.
- Testable mapping where practical.

## Non-goals

- No core audio dependency.
- No final mix.
- No copyrighted or copied sounds.

## Acceptance criteria

1. `FlybyNighterCore` does not import audio frameworks.
2. The SpriteKit/app adapter maps gameplay events to audio cues.
3. Missing audio capability does not break gameplay.
4. Audio can be disabled.
5. `swift test` passes.

## Validation

Validated through mapper tests and cross-platform playtesting. See `docs/implementation/M3-validation.md`.
