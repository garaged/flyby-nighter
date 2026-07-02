# ADR-0006: Dark Neon Placeholder Visuals for M0

Status: Accepted  
Date: 2026-07-01

## Context

M0 needs a visual direction that supports readability and fast implementation without spending too much time on final art before the core loop is fun.

The project also needs to stay clearly original and avoid mimicking protected visual expression from any specific legacy arcade game.

## Decision

M0 will use a **dark neon sci-fi visual direction** with **simple SpriteKit vector/shape placeholders first**.

Final sprites, illustrations, particle polish, backgrounds, and UI art are deferred until the playable loop is validated.

## Implementation direction

- Use SpriteKit shape nodes, simple generated textures, or minimal original placeholder sprites for M0.
- Prioritize gameplay readability over visual polish.
- Use distinct placeholder silhouettes for the player, enemy types, obstacles, gifts, projectiles, and exit gate.
- Keep contrast high enough that danger, pickups, bullets, and the player are easy to read.
- Visuals should suggest a dark neon sci-fi corridor without copying any specific legacy game layout, sprite, color composition, terrain, UI, or enemy identity.
- Placeholder visuals should be easy to replace with final original assets later.

## Suggested placeholder language

- Player ship: compact bright triangular or dart-like silhouette.
- Drifter: slow diamond or rounded drone shape.
- Needler: narrow spike or arrow-like shape.
- Sentry: anchored turret shape.
- Static obstacle: jagged dark rock/metal polygons.
- Pulse gate: bright segmented vertical energy bars.
- Gifts: glowing icons with distinct shapes for Rapid, Spread, and Shield.
- Exit gate: large readable portal or threshold.

## M0 non-goals

- No final art pass.
- No asset pack dependency.
- No AI-generated asset dependency for M0 implementation.
- No pixel-perfect visual identity.
- No cinematic intro.
- No clone-faithful legacy arcade visual imitation.

## Consequences

- M0 can be implemented quickly with SpriteKit primitives.
- The first playable can focus on movement, collisions, enemies, powers, and route feel.
- Final original assets can be produced after the gameplay contract is validated.
