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
- Authored M0 content model.
- Drifter, Needler, and Sentry enemy records.
- Enemy spawn triggers based on route progress.
- Enemy projectile emission events.
- Rapid, Spread, and Shield gift records.
- Gift pickup collision and effect application.
- Static obstacle and pulse gate records.
- Obstacle collision and pulse-gate danger phase checks.
- Projectile/enemy collision.
- Enemy projectile/player collision.
- Enemy body/player collision.
- Deterministic event emission for adapter layers.

## Current SpriteKit adapter behavior

`FlybyNighterSpriteKit` currently provides:

- `FlybyNighterScene` as a thin `SKScene` adapter.
- Placeholder player shape.
- Placeholder projectile shapes.
- Placeholder enemy shapes for Drifter, Needler, and Sentry.
- Placeholder gift shapes for Rapid, Spread, and Shield.
- Placeholder obstacle shapes for static obstacles and pulse gates.
- Visible pulse-gate dangerous/safe state.
- HUD text for HP, score, and active power.
- Title overlay.
- Completion/failed-run overlays.
- Tap/click start and restart.
- Public adapter hooks for movement and firing input.

## Known deferred implementation

- Real Xcode app target/project wrapper.
- Keyboard mapping into `setMovement` and `setFiring`.
- Touch virtual controls.
- Tuned authored map layout and pacing.
- Richer enemy movement and attack patterns.
- Placeholder audio playback.
- CI workflow.

## Expected validation command

Once checked out locally on macOS with Swift/Xcode tools installed:

```bash
swift test
```

I have not run validation from this environment; this branch should be validated locally or by CI before merging.
