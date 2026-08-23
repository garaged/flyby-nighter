# SPEC-0026: Playtest Reset and Settings

Status: Accepted  
Milestone: M5

## Goal

Provide intentional, understandable reset and settings affordances for repeated playtests without making accidental destructive actions easy.

## Scope

- Developer/playtest reset guidance for local best scores.
- Audio mute setting or launch affordance documentation.
- Clear distinction between player-facing controls and developer/debug controls.
- Verification that reset behavior remains outside `FlybyNighterCore`.

## Requirements

1. Resetting local best scores must be deliberate.
2. Reset behavior must be documented in the playtest guide.
3. Muting audio must remain possible for automated or quiet testing.
4. Reset and mute affordances must not change deterministic gameplay rules.
5. Missing or reset best-score values must display safely as zero.

## Non-goals

- No full settings screen unless needed by implementation.
- No preferences sync.
- No cloud profile.
- No gameplay difficulty presets.

## Acceptance criteria

1. A tester or developer can reset best scores using documented steps.
2. Audio can be disabled for quiet/manual test runs.
3. Reset and mute behavior do not regress route selection, scoring, or persistence.
4. Automated tests pass.

## Validation

Pending implementation.
