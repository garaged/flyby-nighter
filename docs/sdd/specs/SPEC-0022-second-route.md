# SPEC-0022: Second Route

Status: Implemented  
Milestone: M4

## Goal

Add a second original playable route that reuses the existing deterministic systems while changing pacing, layout feel, and encounter order.

## Scope

- Stable route identifiers and catalog metadata.
- Second route content definition.
- Route-specific spawn timing.
- Route-specific gift placement.
- Route-specific obstacle and hazard placement.
- Route-specific segment names.
- Deterministic tests for route content.
- Playable selection across macOS, iPhone, and iPad.

## Route identity

The second route is **The Glass Tide**.

Its identity is rhythm-first rather than pressure-first:

- An early pulse gate introduces timing before the first enemy wave.
- Shield appears before offensive gifts.
- Cross-lane Needler movement arrives later than the opening gate lesson.
- The final third increases speed and alternates Sentry, Drifter, and Needler pressure.

## Selection behavior

- The Neon Rift is selected by default.
- Previous and next selection wrap across the route catalog.
- Selection is available on title, completion, and failure screens.
- Selection is disabled during active play.
- Starting a route creates a deterministic game using the selected route configuration.
- HUD progress and segment names reflect the selected route.

## Non-goals

- No procedural generation.
- No copied map layout from any legacy game.
- No final art pass.
- No new enemy or hazard family in M4-A or M4-B.
- No score persistence in this spec.

## Acceptance results

1. The second route is selectable on macOS, iPhone, and iPad.
2. It has a distinct pacing identity from the first route.
3. It is completable after learning.
4. It uses original layout and naming.
5. Deterministic tests cover content availability and completion configuration.
6. Route-specific HUD segment names are visible.
7. Existing movement, firing, lifecycle, and restart controls do not regress.

## Validation

Implemented and validated on July 2, 2026.

See `docs/implementation/M4A-validation.md` and `docs/implementation/M4B-validation.md`.
