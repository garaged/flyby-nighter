# ADR-0008: M0 Playable Shell

Status: Accepted  
Date: 2026-07-01

## Context

M0 should feel like a small playable slice rather than only a test scene. It still needs to stay lightweight and avoid polished menu work.

## Decision

M0 requires a simple playable shell:

- A title screen with a clear Start action.
- An in-game HUD showing HP, score, and active power.
- A completion overlay showing score and restart.
- A failed-run overlay showing score and restart.
- Fast restart from both result states.

The UI can be plain SpriteKit text and simple shapes. It does not need final branding or final art.

## Implementation direction

- The deterministic core owns run state, score, HP, active power, result transitions, and restart reset.
- SpriteKit owns presentation of the title screen, HUD, overlays, and input prompts.
- The title screen may be minimal: project title plus Start prompt.
- Result overlays may be minimal: result label, score, and restart prompt.
- The player should not need to relaunch the app to replay.

## M0 validation threshold

M0 is accepted only when a reviewer can:

1. Launch the app.
2. Start a run from the title screen.
3. Play the single map.
4. See HP, score, and active power during the run.
5. Reach each result state and restart.
6. Complete deterministic core tests for route progress, firing, gifts, damage, scoring, result states, and restart.

## M0 non-goals

- No polished menu art.
- No settings screen.
- No level select.
- No save system.
- No high-score persistence.
- No online leaderboard.
- No final UI animation pass.

## Consequences

- The first playable has enough structure to evaluate as a game.
- The UI remains cheap to implement and easy to replace later.
- M0 implementation has a clear finish line.
