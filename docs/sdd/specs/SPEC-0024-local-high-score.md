# SPEC-0024: Local High Score

Status: Validation Pending  
Milestone: M4

## Goal

Persist a simple local best score so replay has a visible target without requiring accounts or network services.

## Decision

Best scores are stored per route rather than globally.

The Neon Rift and The Glass Tide have different encounter counts and pacing, so a global value would not provide a fair target.

## Scope

- Local-only route-specific best scores.
- `UserDefaults` persistence in the shared SpriteKit adapter.
- Best-score display in the live HUD, title screen, completion screen, and failure screen.
- `NEW BEST` feedback when a run exceeds the stored value.
- `--reset-high-scores` debug launch argument.
- Safe default of zero when no value exists.

## Storage behavior

- Only a strictly higher score replaces the stored best.
- Equal and lower scores leave the best unchanged.
- Negative values are ignored.
- Each `RouteID` uses a separate storage key.
- Storage remains outside `FlybyNighterCore`.

## Non-goals

- No online leaderboard.
- No cloud sync.
- No user account.
- No anti-cheat.
- No cross-app-container sharing between unrelated executable identities.

## Acceptance criteria

1. Best score persists between launches on each supported app shell path.
2. Best-score display is visible and understandable.
3. Storage failure or missing values do not break gameplay.
4. Scores remain separate per route.
5. A debug reset path exists.
6. Core deterministic tests still pass.

## Validation

Implementation is complete. Automated and relaunch validation remain before this spec is marked Implemented.

See `docs/implementation/M4CDE-validation.md`.
