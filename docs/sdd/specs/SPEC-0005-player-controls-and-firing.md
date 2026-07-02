# SPEC-0005: Player Controls and Firing

Status: Proposed  
Milestone: M0

## Purpose

Define the first playable feel for an Apple-first Swift + SpriteKit game without locking the project into final App Store controls.

## M0 input model

M0 should support keyboard input first so the game is playable in macOS and iPad/iPhone simulator during development:

- Move: Arrow keys or WASD.
- Fire: Space or primary action.
- Pause: Escape or P.
- Restart after win/loss: Enter or Space.

Touch controls should be added as soon as the SpriteKit scene exists, but they can be minimal for M0:

- Drag or virtual stick region for movement.
- Tap/hold fire button or auto-fire toggle.
- Restart button on win/loss overlay.

Game controller support is deferred unless trivial.

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

## SpriteKit integration notes

The SpriteKit scene should translate input into core commands rather than directly mutating every gameplay rule. For example, the scene can emit movement vectors and fire intents, while `GameCore` owns cooldowns, projectile creation, collision outcomes, scoring, and run state.

## Acceptance criteria

- Player can move through the whole route using one input device.
- Keyboard controls work in simulator/macOS development builds.
- Touch movement/fire has a minimal M0 path or is explicitly deferred before implementation starts.
- Holding fire produces a predictable shot stream.
- Base shots can destroy enemies.
- Rapid Gift visibly changes fire rate.
- Spread Gift visibly changes firing pattern.
- Movement and firing can be tested in the deterministic core where practical.
