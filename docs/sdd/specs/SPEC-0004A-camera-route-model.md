# SPEC-0004A: M0 Camera and Route Model

Status: Accepted  
Milestone: M0

## Related decision

See `docs/sdd/decisions/ADR-0003-horizontal-autoscroll-m0.md`.

## Decision summary

M0 uses a horizontal left-to-right route with automatic camera advance through one authored corridor map.

## Route model

- The first map is authored as segments along increasing X positions.
- Route progress is measured as distance from the start of the map.
- The exit gate is placed near the end of the route.
- Enemy, obstacle, and gift placement can be defined by route distance.
- M0 keeps one route direction only.

## Camera model

- The visible play area advances from left to right while the run is active.
- The player can move inside the visible lane but cannot move outside the camera window.
- The player should have room to dodge vertically and reposition slightly forward/backward.
- SpriteKit owns visual camera presentation, but the deterministic core should own route distance and run state where practical.

## M0 non-goals

- No vertical route direction.
- No diagonal route direction.
- No mixed route direction changes.
- No player-controlled camera.
- No branching map.
- No procedural route generation.

## Acceptance criteria

- The route advances consistently during play.
- The player remains bounded inside the visible play lane.
- Route distance can trigger enemies, obstacles, gifts, and the exit.
- A deterministic test can advance route progress without requiring SpriteKit rendering.
- The map can be completed from start to exit using one continuous left-to-right route.
