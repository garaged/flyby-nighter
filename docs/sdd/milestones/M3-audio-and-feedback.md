# M3: Audio and Feedback

Status: In Progress  
Milestone: M3

## Goal

Add original placeholder audio and stronger event feedback while keeping deterministic gameplay logic independent from audio systems.

## Scope

M3 includes:

- Adapter-side audio event mapping.
- Original placeholder sound effects.
- Mute/debug-disable behavior.
- Stronger visual feedback for important gameplay events.
- Validation of audio and feedback clarity.

## Non-goals

- No final soundtrack.
- No licensed or copied sound assets.
- No core dependency on AVFoundation, SpriteKit sound actions, or platform audio APIs.
- No full settings UI unless required for mute/debug behavior.

## Required specs

M3 is governed by:

- `SPEC-0019-audio-event-adapter.md`
- `SPEC-0020-placeholder-sfx.md`
- `SPEC-0021-feedback-events.md`

## Implementation slices

1. Audio event adapter contract — implemented.
2. Original runtime-generated placeholder tones — implemented.
3. Scene event wiring — implemented.
4. Debug mute through `--mute-audio` and scene API — implemented.
5. Visual flashes, pulses, and small camera impulses — implemented.
6. Cross-platform audio and feedback validation — pending local playtest.

## Acceptance criteria

A reviewer can:

1. Hear distinct cues for firing, pickup, player hit, shield use, enemy removal, completion, and failure.
2. Disable audio for debugging or comfort.
3. See visual feedback for the same important events.
4. Confirm the core package remains free of platform audio dependencies.
5. Run `swift test` with no failures.
