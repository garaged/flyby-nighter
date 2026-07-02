# SPEC-0020: Placeholder SFX

Status: Implemented  
Milestone: M3

## Goal

Provide original temporary sound effects that improve playtest feedback without becoming final audio identity.

## Scope

Placeholder cues for:

- Player firing.
- Gift pickup.
- Shield use.
- Player hit.
- Enemy removal.
- Route completion.
- Run failure.

## Non-goals

- No final soundtrack.
- No copied arcade sounds.
- No third-party asset dependency.
- No large audio asset pipeline in M3.

## Acceptance criteria

1. Each major cue is audibly distinct.
2. Sounds are original generated tones or original bundled files.
3. Sounds are short and do not mask gameplay.
4. Audio can be disabled.
5. Validation notes list the cue set tested.

## Validation

Validated successfully. See `docs/implementation/M3-validation.md`.
