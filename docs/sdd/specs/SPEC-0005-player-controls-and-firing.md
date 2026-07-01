# SPEC-0005: Player Controls and Firing

Status: Proposed  
Milestone: M0

## Purpose

Define the first playable feel without locking the project into a final input scheme.

## Recommended M0 control model

Until a platform decision is accepted, assume keyboard/web controls:

- Move: Arrow keys or WASD.
- Fire: Space or primary action.
- Pause: Escape or P.
- Restart after win/loss: Enter or Space.

## Movement feel

The ship should feel responsive and arcade-like:

- Immediate directional movement.
- No complex inertia in M0 unless it improves fun quickly.
- Clamp player inside the playable lane.
- Collision bounds should be fair and slightly smaller than the sprite/ship visual.

## Firing model

Base firing:

- Fires forward along the route direction.
- Uses a cooldown so holding fire is allowed.
- Bullets damage enemies and disappear on hit or after leaving bounds.

Power-modified firing:

- Rapid Gift: reduces cooldown for a short duration.
- Spread Gift: fires one forward shot plus two angled shots, or enables side shots depending on final platform and camera orientation.
- Shield Gift: does not change bullets; affects damage handling.

## Directional firing note

Multi-direction firing is a core fantasy, but M0 should implement the smallest version that is fun. The recommended first implementation is Spread Gift angled shots. Full independent aim/facing can be deferred if it delays the first playable.

## Acceptance criteria

- Player can move through the whole route using one input device.
- Holding fire produces a predictable shot stream.
- Base shots can destroy enemies.
- Rapid Gift visibly changes fire rate.
- Spread Gift visibly changes firing pattern.
- Movement and firing can be tested in the deterministic core where practical.
