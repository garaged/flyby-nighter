# M4: Content Expansion

Status: In Progress  
Milestone: M4

## Goal

Expand the game beyond the first tuned route after the core loop, app shell, and feedback systems are stable.

## Scope

M4 includes:

- A second original route.
- One new enemy or hazard family.
- Local high score or simple score memory.
- Optional score combo rules if playtests show score needs more depth.
- Route selection or simple route progression if needed.

## Non-goals

- No online score service.
- No account system.
- No large campaign.
- No procedural content generation.
- No copied legacy maps, names, bosses, sounds, or art identity.

## Required specs

M4 is governed by:

- `SPEC-0022-second-route.md`
- `SPEC-0023-score-system.md`
- `SPEC-0024-local-high-score.md`

## Implementation slices

1. Second route content model.
2. Second route playable tuning and selection.
3. New enemy or hazard family.
4. Score depth or combo pass.
5. Local high score storage.

## Current progress

M4-A adds:

- A deterministic `RouteCatalog` with stable route identifiers and metadata.
- The existing Neon Rift route as the first catalog entry.
- A second original route, **The Glass Tide**.
- Route-specific pacing, enemies, gifts, obstacles, and segment names.
- Deterministic tests for catalog identity, content ordering, route bounds, gift availability, pacing, and completion configuration.

Still pending:

- Playable route selection in the Apple shells.
- Manual tuning and completion validation for The Glass Tide.
- A new enemy or hazard family.
- Score-depth decisions.
- Local high-score persistence.

## Acceptance criteria

A reviewer can:

1. Play at least two original routes.
2. Understand how scores are earned.
3. See a local high score or best-run value.
4. Replay without losing app stability.
5. Run `swift test` with no failures.
