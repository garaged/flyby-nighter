# SPEC-0025: Playtest Onboarding

Status: Validation Pending  
Milestone: M5

## Goal

A first tester should understand how to play, select routes, read scoring, and interpret best scores from the game itself.

## Scope

- In-game controls reference.
- Route-selection explanation for macOS, iPhone, and iPad.
- Score-source explanation.
- Best-score and reset explanation.
- Presentation-layer implementation only.

## Requirements

1. The title or help surface must explain route selection.
2. The help surface must explain movement and firing controls.
3. The help surface must explain the four score sources:
   - enemy removals
   - gift pickups
   - route completion
   - remaining HP after completion
4. The help surface must explain route-specific best scores.
5. The help surface must mention debug reset behavior only as a developer/playtest affordance.
6. Help must not block active play unexpectedly.

## Implementation

- `PlaytestGuide` provides the canonical adapter-layer onboarding copy.
- `PlaytestGuideTests` cover route selection, controls, scoring, best scores, reset, and mute guidance.
- `FlybyNighterScene` renders the guide summary directly on the title overlay before active play.
- Active gameplay still hides the overlay, so help does not block play.

## Non-goals

- No tutorial campaign.
- No interactive training route.
- No localization pass.
- No accessibility remediation pass beyond readable copy and layout.

## Acceptance criteria

1. A tester can find controls and scoring information without reading repository docs.
2. Existing route selection remains usable.
3. Existing active-play movement and firing do not regress.
4. `swift test` passes.

## Validation

Implementation is in place. Automated and cross-platform manual readability validation remain before this spec can be marked Implemented.
