# M0 Apple Scaffold

Branch: `m0-apple-scaffold`

## Purpose

This branch starts M0 implementation with an Apple-first Swift package structure while preserving the SDD constraint that gameplay rules stay deterministic and testable outside SpriteKit.

## Added targets

- `FlybyNighterCore`: deterministic gameplay rules.
- `FlybyNighterSpriteKit`: thin SpriteKit adapter scaffold.
- `FlybyNighterCoreTests`: XCTest coverage for M0 core rules.

## Current core behavior

`FlybyNighterCore` currently covers:

- Title, playing, completed, and failed run states.
- Start and restart flow.
- Horizontal route progress.
- Player movement bounded inside a local play lane.
- Base forward firing.
- Rapid Gift fire cooldown behavior.
- Spread Gift triple-shot behavior.
- Shield Gift one-hit absorption.
- Three-hit damage model.
- Post-hit invulnerability window.
- Enemy removal score event.
- Route completion score.
- Deterministic event emission for adapter layers.

## Current SpriteKit adapter behavior

`FlybyNighterSpriteKit` currently provides:

- `FlybyNighterScene` as a thin `SKScene` adapter.
- Placeholder player shape.
- Placeholder projectile shapes.
- HUD text for HP, score, and active power.
- Title overlay.
- Completion/failed-run overlays.
- Tap/click start and restart.
- Public adapter hooks for movement and firing input.

## Known deferred implementation

- Real Xcode app target/project wrapper.
- Keyboard mapping into `setMovement` and `setFiring`.
- Touch virtual controls.
- Authored M0 map data.
- Enemy entities and collision resolution.
- Obstacles and pulse gates.
- Gift placement/collision.
- Placeholder audio playback.
- CI workflow.

## Expected validation command

Once checked out locally on macOS with Swift/Xcode tools installed:

```bash
swift test
```

I have not run validation from this environment; this branch should be validated locally or by CI before merging.
