# SPEC-0004: One-Map World Design

Status: Proposed  
Milestone: M0

## Map name

The Neon Rift

## Purpose

Provide one compact, original route that proves movement, shooting, enemies, obstacles, gifts, scoring, win, and failure.

## Duration target

A successful run should take roughly 60-120 seconds in M0.

## Route structure

The map should be authored as a sequence of readable segments rather than a fully procedural world.

Draft segments:

1. **Entry Lane**: safe movement space, first Drifters, first basic shooting.
2. **Broken Teeth**: static walls/rocks create narrow movement decisions.
3. **Pulse Gate Row**: timed gates introduce rhythm hazards.
4. **Ambush Bend**: Needlers rush across the lane while Drifters shoot.
5. **Gift Pocket**: optional risky pickup placement.
6. **Sentry Spine**: Sentries fire timed bursts from fixed positions.
7. **Exit Burn**: denser final stretch that leads to the exit gate.

## Map grammar

M0 should avoid copying legacy map layouts. Use original silhouettes, names, pacing, and spatial patterns.

Recommended visual identity:

- Dark sci-fi corridor.
- Neon fault lines.
- Cracked asteroid-metal terrain.
- Electric hazard gates.
- Original enemy silhouettes with readable color/shape language later.

## Completion

The player wins by reaching the exit gate alive. Destroying all enemies should not be required.

## Acceptance criteria

- The route has a beginning, middle, and exit.
- The player can complete the route without collecting every gift.
- At least one gift is placed in a risk/reward location.
- Obstacles force movement decisions but do not create unavoidable damage.
- Enemy and obstacle timing remains readable during normal play.
