# M1: Game Feel and Pacing

Status: Proposed  
Milestone: M1

## Goal

Turn the M0 scaffold into a more readable and more enjoyable first route. M1 should keep the current one-route scope while improving timing, fairness, readability, and moment-to-moment feel.

## Player experience target

A first-time player should understand the route, recognize why they succeeded or failed, and want to replay immediately. The route should feel active within the first few seconds, teach its rules before pressure increases, and end with a clear final push.

## M1 scope

M1 includes:

- Tuning the existing player movement and firing feel.
- Tuning the existing authored route length, spawn timing, and route sections.
- Tuning existing enemy, gift, and obstacle placement for readability and fairness.
- Improving visual feedback for hits, pickups, score changes, route progress, and route completion.
- Improving placeholder shapes and screen cues enough for playtesting.
- Creating a repeatable manual playtest script.

## M1 non-goals

- No new route.
- No boss or large set-piece.
- No permanent upgrades.
- No economy or meta-progression.
- No final art pass.
- No clone-faithful layout, names, visual language, audio, or behavior from any legacy game.
- No platform expansion beyond keeping the current macOS wrapper and reusable SpriteKit scene working.

## Required specs

M1 is governed by:

- `SPEC-0012-m1-game-feel.md`
- `SPEC-0013-m1-map-pacing.md`
- `SPEC-0014-m1-visual-readability.md`
- `SPEC-0015-m1-playtest-validation.md`

## Implementation slices

M1 should be implemented as small reviewable PRs or commits:

1. Route tuning and timing.
2. Enemy and obstacle placement pass.
3. Gift placement and usefulness pass.
4. Visual feedback and readability pass.
5. Playtest validation note and final M1 tuning adjustments.

## Acceptance criteria

A reviewer can:

1. Launch the current playable wrapper with `swift run FlybyNighterMac`.
2. Start a run and understand basic movement, firing, route progress, HP, score, and active power state.
3. Encounter a quiet opening, a medium-pressure middle, and a higher-pressure final section.
4. Reach all gift types through reasonable play.
5. Complete the route at least once after learning the pattern.
6. Fail or succeed with clear on-screen feedback.
7. Run `swift test` with no failures.

## Validation

Expected local validation:

```bash
swift test
swift run FlybyNighterMac
```

Manual playtest validation is defined in `SPEC-0015-m1-playtest-validation.md`.
