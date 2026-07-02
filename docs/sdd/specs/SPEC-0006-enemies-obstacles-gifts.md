# SPEC-0006: Enemies, Obstacles, and Gifts

Status: Proposed  
Milestone: M0

## Purpose

Define the first content catalog for M0.

## Enemy catalog

### Drifter

Role: basic pressure enemy.

Behavior:

- Enters from ahead or side of route.
- Moves slowly through the play area.
- Fires slow aimed or forward-biased bullets at intervals.
- Has low health.

Acceptance:

- Player can destroy it with base bullets.
- Its shots can damage the player.

### Needler

Role: movement disruption enemy.

Behavior:

- Rushes across the corridor in a straight or slightly curved attack line.
- May not need to shoot in M0.
- Damages player on collision.
- Has very low health or may be nonessential to destroy.

Acceptance:

- Player must dodge at least one Needler rush in the map.
- Needler timing is readable and avoidable.

### Sentry

Role: fixed burst-fire hazard.

Behavior:

- Anchored to terrain or a lane edge.
- Fires in timed bursts.
- Can be destructible or indestructible; destructible is preferred for M0 if easy.

Acceptance:

- Player can identify the firing rhythm.
- Burst fire creates a dodge/shoot decision.

## Obstacle catalog

### Static wall/rock

- Blocks or narrows route space.
- Damages player on collision.
- Uses fair collision bounds.

### Pulse gate

- Opens and closes on a fixed rhythm.
- Damage only when active/closed.
- Must have readable warning state before becoming dangerous.

## Gift catalog

### Rapid Gift

- Temporarily increases bullet fire rate.
- Suggested duration: 8 seconds.

### Spread Gift

- Temporarily changes firing pattern to triple-shot or angled side shots.
- Suggested duration: 8 seconds.

### Shield Gift

- Absorbs one hit or grants 3 seconds of invulnerability.
- One-hit shield is preferred for clearer rules.

## Gift rules

- Only one offensive gift needs to be active at a time in M0.
- Shield may stack separately with an offensive gift if implementation stays simple.
- Re-collecting the same gift should refresh duration.

## Acceptance criteria

- Each enemy type appears at least once in the map.
- Each obstacle type appears at least once in the map.
- Each gift type can be collected in normal play.
- Each gift produces an observable gameplay change.
- At least one pickup placement creates risk/reward rather than being directly on the safest path.
