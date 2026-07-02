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

1. Second route content model — completed and validated.
2. Cross-platform route selection and route-specific HUD — completed and validated.
3. New enemy or hazard family — pending.
4. Score depth or combo pass — pending decision and implementation.
5. Local high score storage — pending.

## Completed route expansion

M4-A and M4-B delivered:

- A deterministic `RouteCatalog` with stable route identifiers and metadata.
- The existing Neon Rift route as the first catalog entry.
- A second original route, **The Glass Tide**.
- Route-specific pacing, enemies, gifts, obstacles, and segment names.
- Cross-platform selection from title, completion, and failure screens.
- macOS keyboard and click selection.
- iPhone/iPad touch selection.
- Route-specific HUD names and segment labels.
- Deterministic core and adapter tests.
- Successful macOS, iPhone, and iPad validation.
- Successful completion of both routes after learning.

`SPEC-0022` is implemented.

## Remaining M4 work

- A new enemy or hazard family.
- Score-depth decision and optional combo rules.
- Local-high-score persistence.

## Acceptance criteria

A reviewer can:

1. Play at least two original routes.
2. Understand how scores are earned.
3. See a local high score or best-run value.
4. Replay without losing app stability.
5. Run `swift test` with no failures.
