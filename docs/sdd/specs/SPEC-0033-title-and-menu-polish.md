# SPEC-0033: Title and Menu Polish

Status: Implemented  
Milestone: M7

## Goal

Improve the first-tester title/menu surface so it feels intentional, branded, readable, and usable on macOS, iPhone, and iPad.

## Scope

- Title, tagline, release identity, route selector, and help text hierarchy.
- Readability guardrails for compact windows and mobile layouts.
- Reuse of existing M5 playtest help and M6 release identity.
- Manual validation matrix for macOS, iPhone, and iPad.

## Requirements

1. Title/menu polish must not change gameplay rules.
2. Route selection, start/replay, reset, mute, and release identity guidance must remain visible or discoverable.
3. The title surface must use the M7 visual identity model.
4. Text hierarchy must avoid one dense paragraph where possible.
5. Result screens must keep replay/change-route guidance.
6. M7 must preserve M4/M5/M6 manual acceptance behavior.

## Implementation

- `PlaytestGuide.titleScreenSummary` includes the M7 tagline before release identity and route copy.
- The title overlay separates title, route selector, guide body, and footer instructions into clearer rows.
- Footer instructions wrap instead of overflowing horizontally.
- `docs/implementation/M7-title-menu-polish.md` defines title hierarchy and readability rules.
- Existing result-screen score, best-score, replay, and change-route guidance is preserved.
- No gameplay rule changes are introduced.

## Non-goals

- No full settings menu.
- No controller-remapping UI.
- No save/profile management UI.
- No final animation pass.

## Acceptance criteria

1. Title/menu visual copy uses the M7 title and tagline.
2. Route selection remains obvious.
3. Release identity remains visible before testing.
4. Reset/mute guidance remains available.
5. `swift build`, `swift test`, and mobile simulator build pass.
6. Manual title/menu checks pass on macOS, iPhone, and iPad.

## Validation

Implemented and validated in M7. Automated validation passes, the initial cluttered title-screen regression was corrected, and the corrected surface was manually accepted.
