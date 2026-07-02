# SPEC-0011: M0 Playable Acceptance

Status: Accepted  
Milestone: M0

## Related decision

See `docs/sdd/decisions/ADR-0008-m0-playable-shell.md`.

## Decision summary

M0 requires a minimal title screen, in-game HUD, score/result overlays, and restart flow. The UI may be plain SpriteKit text and shapes.

## Required screens and overlays

### Title screen

Minimum content:

- Game title: Flyby Nighter.
- Start prompt.
- Optional one-line instruction summary.

### In-game HUD

Minimum content:

- HP.
- Score.
- Active power, or clear indicator when no power is active.

### Completion overlay

Minimum content:

- Completion/result label.
- Final score.
- Restart prompt.

### Failed-run overlay

Minimum content:

- Result label.
- Final score.
- Restart prompt.

## Restart behavior

Restart should reset:

- Run state.
- Player HP.
- Player position.
- Active powers and timers.
- Shield state.
- Route progress.
- Score.
- Enemies.
- Projectiles.
- Gifts that were collected.
- Obstacles and gate timers.

## Manual acceptance path

A reviewer must be able to:

1. Launch the app.
2. Start a run from the title screen.
3. Move and fire during the single map.
4. Read HP, score, and active power during play.
5. Destroy at least one enemy.
6. Collect Rapid Gift and observe faster firing.
7. Collect Spread Gift and observe triple-shot firing.
8. Collect Shield Gift and observe one protected hit.
9. Take damage.
10. Reach the failed-run state and restart.
11. Reach the completion state and restart.

## Automated acceptance targets

The deterministic core should have tests for:

- Initial run state.
- Start transition.
- Route progress.
- Base firing.
- Rapid Gift behavior.
- Spread Gift behavior.
- Shield behavior.
- Damage behavior.
- Score changes.
- Completion transition.
- Failed-run transition.
- Restart reset.

## Build and validation notes

Once code exists, M0 implementation notes must record:

- Xcode or Swift Package build command.
- Test command.
- Manual acceptance notes.
- Known deferred polish.

## M0 non-goals

- No polished final menu.
- No settings screen.
- No save system.
- No persistent high-score table.
- No online features.
- No final UI animation pass.
