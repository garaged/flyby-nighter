# M4: Content Expansion

Status: Validation Pending  
Milestone: M4

## Goal

Expand the game beyond the first tuned route after the core loop, app shell, and feedback systems are stable.

## Completed scope

- A deterministic route catalog.
- A second original route, **The Glass Tide**.
- Cross-platform route selection.
- Route-specific HUD labels.
- An original composed hazard family, **Glass Shear**.
- A documented deterministic score breakdown.
- An explicit no-combo decision for M4.
- Route-specific local best-score persistence.
- Live, title-screen, completion-screen, and failure-screen best-score presentation.
- Debug reset support through `--reset-high-scores`.

## Non-goals

- No online score service.
- No account system.
- No large campaign.
- No procedural content generation.
- No copied legacy maps, names, bosses, sounds, or art identity.
- No hidden or timing-based combo multiplier.

## Required specs

M4 is governed by:

- `SPEC-0022-second-route.md`
- `SPEC-0023-score-system.md`
- `SPEC-0024-local-high-score.md`

## Implementation status

1. Second route content model — completed and validated.
2. Cross-platform route selection and route-specific HUD — completed and validated.
3. Glass Shear hazard family — implemented; validation pending.
4. Score-depth decision and visible breakdown — implemented; validation pending.
5. Local route-specific high scores — implemented; validation pending.

## Acceptance criteria

A reviewer can:

1. Play at least two original routes.
2. Encounter and learn the Glass Shear hazard family.
3. Understand every visible score source.
4. See a route-specific local best score that survives relaunch.
5. Reset local best scores through a debug launch argument.
6. Replay without losing app stability.
7. Run `swift test` with no failures.

The final validation matrix is in `docs/implementation/M4CDE-validation.md`.
