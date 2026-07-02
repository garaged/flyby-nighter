# SPEC-0022: Second Route

Status: Accepted  
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
- Playable route selection in a follow-up slice.

## Accepted route identity

The second route is **The Glass Tide**.

Its initial identity is rhythm-first rather than pressure-first:

- An early pulse gate introduces timing before the first enemy wave.
- Shield appears before offensive gifts.
- Cross-lane Needler movement arrives later than the opening gate lesson.
- The final third increases speed and alternates Sentry, Drifter, and Needler pressure.

## Non-goals

- No procedural generation.
- No copied map layout from any legacy game.
- No final art pass.
- No new enemy or hazard family in the M4-A content-model slice.
- No score persistence in this spec.

## Acceptance criteria

1. Second route is selectable or reachable.
2. It has a distinct pacing identity from the first route.
3. It is completable after learning.
4. It uses original layout and naming.
5. Deterministic tests cover content availability and completion configuration.

## Implementation status

M4-A implements the route catalog and deterministic Glass Tide content model. Playable shell selection and manual route tuning remain pending before this spec can be marked Implemented.
