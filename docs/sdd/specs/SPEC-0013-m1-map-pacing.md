# SPEC-0013: M1 Map Pacing

Status: Proposed  
Milestone: M1

## Goal

Tune the existing M0 route into a readable first playable route with clear sections, escalating pressure, reachable gifts, and fair obstacle/enemy placement.

## Scope

This spec covers the single current route only:

- Route length and scroll speed.
- Route section names and timing.
- Enemy spawn timing and placement.
- Gift spawn timing and placement.
- Obstacle and pulse gate placement.
- Difficulty ramp across the route.
- Completion timing and exit readability.

## Non-goals

- No second route.
- No boss.
- No procedural route generation.
- No clone-faithful map recreation from any legacy title.
- No final environment art.

## Route structure

The M1 route should read as seven simple sections:

1. Sector 01 Entry: teach movement and basic firing.
2. Sector 02 Narrow: introduce static-space pressure.
3. Sector 03 Gates: introduce timing-based passage.
4. Sector 04 Midway: combine one enemy pattern with one route hazard.
5. Sector 05 Cache: give a reachable gift and room to use it.
6. Sector 06 Spine: higher pressure, but still avoid unavoidable overlaps.
7. Sector 07 Exit: final push and clear completion marker.

The names are placeholders and may change, but the section roles should remain clear.

## Pacing targets

- First threat appears after the player has enough time to move and fire.
- First gift appears early enough for the player to understand the power system.
- Each gift should be reachable without requiring perfect play.
- Hazards should not overlap in ways that force guaranteed HP loss.
- Final section should be more intense than the opening but still completable.
- Completion should be visually and mechanically clear.

## Acceptance criteria

A reviewer can verify that:

1. The route has a quiet opening and a stronger final section.
2. The route segment label changes as progress advances.
3. All three gift types appear in useful locations.
4. At least one early enemy can be removed with basic fire.
5. At least one timed obstacle can be crossed by observation rather than guesswork.
6. The player can complete the route after learning the pattern.
7. The route does not include direct layout replication from any legacy game.
8. `swift test` passes.

## Automated tests

Add or preserve tests for deterministic route content when practical:

- Spawn thresholds.
- Gift availability.
- Route completion.
- End-state transitions.

## Manual validation

Use the M1 playtest script from `SPEC-0015-m1-playtest-validation.md`.

## Deferred polish

- Route editor tooling.
- Multiple difficulty levels.
- Multiple maps.
- Final authored art pass.
