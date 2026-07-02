# SPEC-0002: M0 Minimal Playable Version

Status: Proposed  
Milestone: M0

## Goal

Create the smallest playable version of Flyby Nighter that proves the game can be fun: one original map, one controllable ship, basic shooting, a few enemy attack behaviors, obstacles, collectible gifts that grant temporary powers, score, damage/failure, a win condition, and restart.

## Player fantasy

The player is a night-run pilot entering a collapsing corridor system. The ship is fragile but responsive. Survival depends on dodging hazards, shooting attackers, grabbing unstable gifts, and reaching the exit.

## M0 scope

M0 includes:

- One playable map: **The Neon Rift**.
- One player ship with movement and firing.
- One health/energy model.
- Three enemy behaviors:
  - **Drifters**: enter from the route and fire slow aimed shots.
  - **Needlers**: rush across the corridor in short attack lines.
  - **Sentries**: fixed or semi-fixed hazards that shoot in timed bursts.
- Two obstacle families:
  - **Static walls/rocks** that damage or kill on contact.
  - **Pulse gates** that open/close on a readable rhythm.
- Three collectible gifts:
  - **Rapid Gift**: faster bullets for a short duration.
  - **Spread Gift**: forward triple-shot or angled side shots.
  - **Shield Gift**: absorbs one hit or grants brief invulnerability.
- Score for survival, enemy defeat, pickup collection, and route completion.
- Win condition: reach the exit gate alive.
- Fail condition: player health/energy reaches zero.
- Restart from win or failure.

## M0 non-goals

- No multiple maps.
- No boss unless the core loop feels too empty after the first implementation.
- No permanent upgrades.
- No economy.
- No saved progression.
- No polished final art.
- No online score service.
- No clone-faithful map, enemy, boss, audio, or UI replication from any legacy game.

## Acceptance criteria

A reviewer can:

1. Start a new run from a simple start screen or direct launch state.
2. Move the ship through the map without frame-rate-dependent behavior.
3. Fire bullets and destroy at least one enemy type.
4. Encounter at least three distinct enemy attack behaviors.
5. Dodge at least two obstacle families.
6. Grab at least three gifts and observe each power changing gameplay.
7. Take damage from enemies or obstacles.
8. Lose, restart, and try again.
9. Reach the map exit and see a win/completion state.
10. Run deterministic core tests for collisions, gifts, scoring, and end states.

## Open decisions

See `docs/sdd/questions.md` before accepting this spec.
