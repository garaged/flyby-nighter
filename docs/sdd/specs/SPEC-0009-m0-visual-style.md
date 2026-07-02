# SPEC-0009: M0 Visual Style

Status: Accepted  
Milestone: M0

## Related decision

See `docs/sdd/decisions/ADR-0006-dark-neon-placeholder-visuals.md`.

## Decision summary

M0 uses dark neon sci-fi visuals with simple SpriteKit vector/shape placeholders first. Final original art is deferred until after the core playable loop is validated.

## Visual goals

M0 visuals should support:

- Fast implementation.
- High readability.
- Clear gameplay roles.
- Easy replacement with final assets.
- Original visual expression.

## Placeholder style

Use simple SpriteKit primitives, generated textures, or minimal original placeholder sprites.

Recommended first pass:

- Dark background.
- Neon corridor accents.
- High-contrast player shape.
- Distinct enemy silhouettes.
- Clearly dangerous obstacle shapes.
- Clearly collectible gift shapes.
- Simple UI labels for HP, score, active power, win, loss, and restart.

## Entity readability

Each gameplay entity must be visually distinguishable during normal play:

- Player ship.
- Player bullets.
- Enemy bullets.
- Drifter enemy.
- Needler enemy.
- Sentry enemy.
- Static obstacle.
- Pulse gate safe state.
- Pulse gate dangerous state.
- Rapid Gift.
- Spread Gift.
- Shield Gift.
- Exit gate.

## Originality constraints

Do not copy or closely imitate protected visual expression from any specific legacy arcade game.

This includes:

- Specific ship silhouettes.
- Specific enemy shapes.
- Specific map layouts.
- Specific terrain arrangements.
- Specific UI composition.
- Specific sprite proportions or animation patterns.
- Specific color compositions strongly associated with another title.

## Deferred polish

Deferred until after M0 loop validation:

- Final ship art.
- Final enemy art.
- Final terrain/background art.
- Final animation pass.
- Final particles.
- Final title screen art.
- Final icon/app branding.

## Acceptance criteria

- M0 can be played using placeholder visuals only.
- Player, bullets, enemies, obstacles, gifts, and exit are readable during normal play.
- Dangerous and safe pulse gate states are visibly different.
- Active gift state is visible through HUD text, player effect, projectile behavior, or a simple icon.
- Win/loss/restart states are visible enough for manual testing.
- Placeholder visuals can be replaced without rewriting core gameplay rules.
