# ADR-0002: Apple-First Swift + SpriteKit

Status: Accepted  
Date: 2026-07-01

## Context

M0 needs a concrete runtime target before gameplay implementation begins. The project could be built web-first, Apple-first, or with a cross-platform engine.

The chosen direction is Apple-first because Flyby Nighter should prioritize native Apple gameplay feel and a path toward iPhone, iPad, macOS, and potentially Apple TV later.

## Decision

Flyby Nighter will target **Apple-first Swift + SpriteKit** for M0.

The first implementation should use:

- Swift as the primary language.
- SpriteKit for rendering, scene graph, sprites, particles, camera, and simple 2D presentation.
- A deterministic gameplay core separated from SpriteKit-specific rendering where practical.
- XCTest for gameplay-core tests.
- Xcode project or Swift Package structure suitable for local development and CI.

## Architecture direction

M0 should avoid placing all game rules directly inside `SKScene` callbacks.

Preferred shape:

- `GameCore`: deterministic rules for run state, player, enemies, projectiles, gifts, obstacles, collisions, scoring, and timers.
- `SpriteKitAdapter`: translates SpriteKit input/update/rendering into and out of `GameCore`.
- `FlybyNighterApp` or platform shell: app lifecycle and scene presentation.
- Tests around `GameCore` first.

## Consequences

- Future specs and Codex prompts should refer to Swift + SpriteKit, not TypeScript, Phaser, or web-first assumptions.
- M0 validation should include `xcodebuild` or Swift Package test commands once the scaffold exists.
- UI/input specs should consider Apple hardware first: keyboard for macOS/simulator, touch controls for iPhone/iPad, and controller support as a future possibility.
- The deterministic core should remain portable enough that a future web or non-Apple version is not impossible, but portability is not the M0 priority.

## Non-goals

- No Unity/Godot implementation for M0.
- No web prototype for M0.
- No SpriteKit-specific rule lock-in that makes gameplay impossible to test outside rendering.
