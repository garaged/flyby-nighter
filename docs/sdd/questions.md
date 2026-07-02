# Open Design Questions

This file is the discussion backlog for turning proposed specs into accepted specs.

## Round 1: Platform and runtime

Status: **Decided**  
Decision: **Apple-first Swift + SpriteKit**. See `docs/sdd/decisions/ADR-0002-apple-first-spritekit.md`.

M0 should optimize for native Apple gameplay feel and a clean path toward iPhone, iPad, and macOS. The gameplay core should stay deterministic and testable outside SpriteKit where practical.

## Round 2: Camera and route direction

Recommended default: **horizontal auto-scroll through an authored left-to-right corridor** for M0.

Why this default:

- It is the simplest SpriteKit camera model for a first playable.
- It keeps player movement, collision, enemy spawning, and map authoring straightforward.
- It supports future vertical/diagonal/mixed route segments without forcing them into M0.

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
