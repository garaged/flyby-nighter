# SPEC-0010: M0 Audio Style

Status: Accepted  
Milestone: M0

## Related decision

See `docs/sdd/decisions/ADR-0007-placeholder-audio-m0.md`.

## Decision summary

M0 uses minimal original placeholder sound effects only. Background music is deferred until after the first playable loop is validated.

## Audio goals

M0 audio should support:

- Clear feedback for major gameplay events.
- Fast implementation.
- Easy replacement later.
- Original project identity.
- No dependency on final music or polished sound design.

## Placeholder sound list

M0 should include simple placeholder sounds for:

- Player shot.
- Enemy removed.
- Player damaged.
- Gift collected.
- Shield used.
- Run completed.
- Run failed.

## Architecture rule

The deterministic gameplay core should not play sounds directly.

Recommended flow:

1. `GameCore` updates gameplay state.
2. `GameCore` emits gameplay events.
3. SpriteKit/app adapter maps those events to placeholder audio playback.

## Originality and licensing

All audio must be one of:

- Created specifically for this project.
- Generated specifically for this project.
- Licensed for project use with notes stored in the repo.

Do not use or imitate protected audio from any specific legacy arcade game.

## M0 non-goals

- No background music.
- No final sound design pass.
- No commercial music dependency.
- No voice acting.
- No dynamic music system.

## Acceptance criteria

- Manual play provides audible feedback for shooting, pickup, damage, shield use, run completion, and run failure.
- Audio playback can be muted or disabled later without changing core gameplay rules.
- Core tests do not require SpriteKit audio playback.
- Placeholder audio source/licensing is clear in the repository.
