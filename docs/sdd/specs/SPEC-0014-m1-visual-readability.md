# SPEC-0014: M1 Visual Readability

Status: Proposed  
Milestone: M1

## Goal

Improve placeholder visuals enough that a tester can understand route progress, player state, active powers, threats, gifts, and outcome without needing a designer to explain the screen.

## Scope

This spec covers placeholder readability, not final art:

- HUD layout and text hierarchy.
- Route progress bar and route section label.
- Player state feedback.
- Gift readability and pickup feedback.
- Enemy silhouette readability.
- Obstacle and timed gate readability.
- Completion and failure overlays.
- Background/corridor motion cues when safe to implement.

## Non-goals

- No final sprite art.
- No licensed assets.
- No clone-faithful visual language from any legacy arcade game.
- No full animation system.
- No particle-heavy effects pass.

## Visual requirements

- Player, enemy, gift, obstacle, and projectile shapes should be visually distinct.
- Route progress should be readable at a glance.
- Current HP and score should remain readable during play.
- Active power and remaining duration should be clear.
- Timed gate safe/danger states should be easy to distinguish.
- Completion and failure overlays should not hide the final score.
- Visual feedback should be brief and should not obscure gameplay.

## Acceptance criteria

A reviewer can verify that:

1. HP, score, active power, route percentage, and route section are visible during play.
2. Power duration appears when Rapid or Spread is active.
3. Shield state is visible when a shield is available.
4. Player feedback appears when HP changes.
5. HUD feedback appears when score changes.
6. Gift types are distinguishable from enemies and obstacles.
7. Pulse gate state is distinguishable without needing exact timing knowledge.
8. Route completion and failure overlays are clear.
9. `swift test` passes.

## Automated tests

Visual rendering remains mostly manual in M1. Automated tests should remain focused on deterministic core behavior.

## Manual validation

Use the M1 playtest script from `SPEC-0015-m1-playtest-validation.md` and note any confusion points.

## Deferred polish

- Final iconography.
- Final color palette.
- Final particle effects.
- Screen shake.
- Accessibility color alternatives.
