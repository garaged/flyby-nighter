# Open Design Questions

This file is the discussion backlog for turning proposed specs into accepted specs.

## Round 1: Platform and runtime

Recommended default: **web-first TypeScript prototype**, because it gives fast iteration, easy sharing, deterministic tests, and low setup friction.

Open options:

1. Web-first: TypeScript + Canvas or Phaser-style 2D runtime.
2. Apple-first: Swift + SpriteKit for iPhone/iPad/macOS.
3. Cross-platform engine: Godot or Unity.
4. Other.

Decision needed:

- What should M0 run on first?
- Should the first implementation optimize for local development speed, mobile feel, or eventual app-store release?

## Round 2: Camera and route direction

Recommended default: **forward scrolling through a horizontal/diagonal corridor** with authored route segments.

Decision needed:

- Horizontal, vertical, diagonal, or mixed scrolling?
- Auto-scroll, player-pushed progression, or hybrid?
- Should route direction ever change in M0, or should M0 keep one camera direction?

## Round 3: Firing fantasy

Recommended default: **base forward fire plus power-based spread fire**.

Decision needed:

- Should normal firing be forward-only?
- Should multi-direction firing be always available, or gift-only for M0?
- Should the player aim independently from movement, or should M0 keep one-button firing?

## Round 4: Health and difficulty

Recommended default: **3 hit points with fast restart**.

Decision needed:

- 1-hit arcade death or 3-hit learning-friendly M0?
- Should obstacles damage or instantly kill?
- Should gifts be generous for M0 testing or scarce for arcade challenge?

## Round 5: Visual style

Recommended default: **dark neon sci-fi with original silhouettes and no legacy-game mimicry**.

Decision needed:

- Pixel art, vector shapes, low-poly/2.5D, or modern illustrated sprites?
- Should M0 use placeholder primitives first, or immediately use generated original assets?

## Round 6: Audio style

Recommended default: **placeholder procedural/simple original effects only in M0**.

Decision needed:

- Chiptune-inspired, synthwave, dark ambient, or silent until visuals feel good?
- Are generated sound effects acceptable if they are original and stored with source notes?

## Round 7: M0 acceptance threshold

Recommended default: M0 is accepted when the route is completeable, losing/restarting works, all three enemy types appear, all three gifts work, and deterministic core tests pass.

Decision needed:

- Is a score screen required in M0, or is win/loss text enough?
- Should a simple title screen be required, or can launch start directly in-game?
