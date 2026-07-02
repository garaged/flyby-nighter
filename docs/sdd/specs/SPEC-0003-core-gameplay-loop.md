# SPEC-0003: Core Gameplay Loop

Status: Proposed  
Milestone: M0

## Purpose

Define the minimal loop that must exist before content expansion.

## Loop

1. Player starts a run.
2. Map scrolls or progresses through a fixed route.
3. Player moves, shoots, dodges, and collects gifts.
4. Enemies and hazards apply pressure.
5. Player score changes based on actions and survival.
6. Player either reaches the exit alive or loses all health/energy.
7. End state allows immediate restart.

## State model

M0 should model at least:

- Run state: notStarted, playing, won, lost.
- Player position, velocity, health/energy, active power, and power timer.
- Enemy positions, health, behavior type, firing timers.
- Projectile positions, owner, damage, direction.
- Gift positions, type, activation state, duration.
- Obstacle positions, collision bounds, optional timing phase.
- Score and elapsed route time.

## Scoring draft

- Enemy destroyed: +100.
- Gift collected: +50.
- Survive route segment: small time/distance-based score.
- Finish map: +1000 plus remaining health/energy bonus.

Exact values are tunable and should not block implementation.

## Damage draft

The recommended M0 health model is simple: player has 3 hit points. Enemy bullets and most enemy collisions remove 1 hit point. Heavy obstacles may remove 1 hit point in M0 rather than instant death, unless the route feels too forgiving.

## Determinism requirement

The gameplay core should be testable without rendering. Given the same initial state, inputs, and timestep sequence, the result should be the same.

## Acceptance criteria

- A test can simulate start -> enemy defeated -> gift collected -> player damaged -> win.
- A test can simulate player damage to zero and assert lost state.
- A test can assert score changes for enemy defeat, pickup collection, and completion.
- A test can assert gift duration expires.
