# ADR-0003: Horizontal Auto-Scroll for M0

Status: Accepted  
Date: 2026-07-01

## Context

M0 needs a concrete camera and route model before implementation begins. The game could use horizontal, vertical, diagonal, mixed-direction, auto-scroll, player-pushed scrolling, or a hybrid route.

## Decision

M0 will use **horizontal left-to-right auto-scroll** through one authored corridor map.

The first map should be authored as route segments arranged along increasing X coordinates. The camera advances at a controlled scroll speed. The player moves within the visible play lane while the route scrolls forward.

## Implementation direction

- The route progresses from left to right.
- The camera or world offset advances automatically while the run is in the playing state.
- The player is bounded inside the visible play area.
- Player movement is primarily local to the visible lane: up, down, forward, and backward within the camera window.
- Enemies, obstacles, gifts, and exit triggers are placed or spawned by route progress.
- The deterministic core should represent route progress independently from SpriteKit camera presentation.
- SpriteKit should render the camera/world movement, but the core should own route distance, timers, collisions, and run state where practical.

## Consequences

- M0 map authoring can stay simple: one corridor path with increasing X positions.
- Spawn triggers can be keyed by route distance.
- The first camera implementation can avoid diagonal and vertical direction changes.
- Touch controls can map naturally to ship movement within the visible lane.
- Later milestones may add diagonal, vertical, branching, player-pushed, or mixed-direction route segments without changing M0.

## Non-goals

- No mixed-direction route changes in M0.
- No fully free-roaming map in M0.
- No player-controlled camera in M0.
- No procedural route generation in M0.
