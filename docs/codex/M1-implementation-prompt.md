# Codex Prompt: M1 Game Feel and Pacing

You are implementing M1 for Flyby Nighter on branch `m0-apple-scaffold` or a new branch based on it.

## Read first

Read these SDD files before editing code:

- `AGENTS.md`
- `docs/sdd/registry.md`
- `docs/sdd/milestones/M1-game-feel-and-pacing.md`
- `docs/sdd/specs/SPEC-0012-m1-game-feel.md`
- `docs/sdd/specs/SPEC-0013-m1-map-pacing.md`
- `docs/sdd/specs/SPEC-0014-m1-visual-readability.md`
- `docs/sdd/specs/SPEC-0015-m1-playtest-validation.md`
- `docs/implementation/M0-apple-scaffold.md`

## Hard constraints

- Keep the deterministic game rules in `FlybyNighterCore`.
- Keep SpriteKit and AppKit details outside the core.
- Do not copy layout, names, assets, behaviors, sounds, or visual identity from any legacy game.
- Use original placeholder names and original placeholder visuals.
- Prefer small vertical slices over broad rewrites.
- Preserve existing tests unless the spec explicitly requires a change.

## First implementation slice: M1-A Route Tuning

Implement only the route tuning slice first.

Focus on:

- Route length and run duration.
- Spawn thresholds and placement for existing enemies.
- Spawn thresholds and placement for existing gifts.
- Obstacle and timed gate placement.
- Ensuring each route sector has a clear purpose.
- Keeping all three gift types reachable.
- Avoiding unavoidable overlaps.

Do not add:

- New route.
- Boss.
- Permanent upgrade system.
- Economy.
- Final art.
- Large audio work.
- Platform expansion.

## Suggested code areas

Likely files:

- `Sources/FlybyNighterCore/FlybyNighterCore.swift`
- `Tests/FlybyNighterCoreTests/FlybyNighterCoreTests.swift`
- `Sources/FlybyNighterSpriteKit/FlybyNighterScene.swift` only if route readability requires small adapter polish.
- `docs/implementation/M1-validation.md`

## Required tests

Add or update tests only for deterministic behavior, such as:

- Authored content spawn order.
- Gift availability.
- Route completion.
- Power duration if tuning changes it.
- HP/end-state behavior if tuning affects it.

## Required validation

Run:

```bash
swift test
swift run FlybyNighterMac
```

For `swift run FlybyNighterMac`, perform at least three manual attempts and record:

- Attempt count.
- Completion or learning result.
- Confusing moments.
- Tuning notes.

## Required output

Create or update `docs/implementation/M1-validation.md` with:

```text
Implemented:
Validation:
Manual attempts:
Outcome summary:
Confusing moments:
Deferred polish:
Spec trace:
```

## Definition of done for M1-A

- Route still launches and plays locally.
- `swift test` passes.
- Route sectors feel more intentional.
- All three gifts are reachable.
- Completion is possible after learning the route.
- No known unavoidable HP-loss pattern is introduced.
- Implementation note documents validation and deferred polish.
