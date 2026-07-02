# SPEC-0024: Local High Score

Status: Proposed  
Milestone: M4

## Goal

Persist a simple local best score so replay has a visible target without requiring accounts or network services.

## Scope

- Local-only best score value.
- Route-specific or global best score decision.
- Reset behavior for debug if needed.
- Display on start, completion, or failure screens.

## Non-goals

- No online leaderboard.
- No cloud sync.
- No user account.
- No anti-cheat.

## Acceptance criteria

1. Best score persists between launches on supported app shell path.
2. Best score display is visible and understandable.
3. Storage failure does not break gameplay.
4. Core deterministic tests still pass.
