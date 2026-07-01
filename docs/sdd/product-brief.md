# SPEC-0001: Product Brief

Status: Proposed  
Milestone: Foundation

## Working title

Flyby Nighter

## One-line pitch

A fast original arcade shooter where a night-run pilot dives through hostile neon corridors, survives attacking machines and environmental hazards, and grabs unstable power gifts to escape before the route collapses.

## Product identity

Flyby Nighter should feel immediate, readable, and replayable. The first version should prioritize a strong 60-120 second arcade loop over content volume.

## Design pillars

1. **Readable danger**: enemies and obstacles must telegraph enough for fair reactions.
2. **Directional aggression**: shooting should reward positioning, timing, and power selection.
3. **Hazard navigation**: the map itself should pressure movement, not just enemies.
4. **Short-run mastery**: a player should improve through repeated attempts on a compact route.
5. **Original expression**: art, audio, lore, map structure, names, enemies, and powers must be original.

## Initial audience

Players who like compact arcade challenge, score chasing, retro-inspired movement, and fast restarts.

## Non-goals for M0

- No campaign.
- No online leaderboard.
- No account system.
- No monetization.
- No clone-accurate recreation of any legacy game.
- No borrowed assets, names, layouts, or sound-alike audio.
- No large content library before the core loop is fun.

## Accepted first technical target

M0 targets Apple-first Swift + SpriteKit. See `docs/sdd/decisions/ADR-0002-apple-first-spritekit.md`.

The gameplay core should remain deterministic and testable outside SpriteKit where practical, with SpriteKit acting as the rendering/input/audio adapter around the core rules.
