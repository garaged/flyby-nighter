# ADR-0007: Placeholder Audio for M0

Status: Accepted  
Date: 2026-07-01

## Context

M0 needs simple audio feedback for important game events. Full music and polished sound design can wait until the first playable loop is working.

All audio must be original or properly licensed. The game must not reuse or imitate audio from any specific legacy arcade title.

## Decision

M0 will use minimal original placeholder sound effects only. Background music is deferred.

## Implementation direction

- Add short original placeholder sounds for key feedback moments.
- Keep sounds simple and easy to replace.
- The SpriteKit adapter or app layer handles playback.
- The deterministic game core may emit event names, but it should not play audio directly.
- Audio source notes or license notes should be stored in the repo when external assets are used.

## M0 sound list

M0 should include placeholder sounds for:

- Player shot.
- Enemy removed.
- Player damaged.
- Gift collected.
- Shield used.
- Run completed.
- Run failed.

## M0 non-goals

- No background music.
- No final sound design pass.
- No commercial music.
- No borrowed legacy arcade audio.
- No voice acting.
- No dynamic music system.

## Consequences

- M0 remains focused on gameplay feel and readability.
- Audio still confirms important gameplay events.
- Music direction can be decided after the first playable exists.
