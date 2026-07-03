# SPEC-0023: Score System

Status: Validation Pending  
Milestone: M4

## Goal

Make scoring more informative while keeping it understandable and deterministic.

## Decision

M4 uses a linear score model and does not add a combo multiplier.

The current route density is low enough that a timer-based combo would reward spawn timing more than player mastery. Route mastery is instead expressed through enemy removals, gift collection, route completion, and preserving HP.

## Score sources

- Enemy removal: `GameConfig.enemyScore` per enemy.
- Gift pickup: `GameConfig.giftScore` per gift.
- Route completion: `GameConfig.completionScore`.
- Remaining HP: `remainingHP * GameConfig.remainingHPBonus` after completion.

Failure receives no completion or remaining-HP bonus.

## Implementation

- `ScoreLedger` tracks enemy removals and gift pickups from deterministic `GameEvent` values.
- `ScoreBreakdown` calculates the four visible score categories.
- The live HUD shows current score and the selected route's best score.
- Completion and failure screens show total score and a category breakdown.
- `M4ScorePolicy` records the explicit no-combo decision.

## Non-goals

- No online leaderboard.
- No economy.
- No permanent upgrade purchases.
- No hidden multiplier.
- No timing-based combo in M4.

## Acceptance criteria

1. Score sources are documented.
2. Score changes are visible during play.
3. The no-combo decision is explicit and test-covered.
4. Completion and remaining-HP bonuses are clear.
5. Result totals match the deterministic core score.
6. `swift test` passes.

## Validation

Implementation is complete. Automated and cross-platform presentation validation remain before this spec is marked Implemented.

See `docs/implementation/M4CDE-validation.md`.
