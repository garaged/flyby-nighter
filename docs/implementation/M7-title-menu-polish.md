# M7 Title and Menu Polish

Status: Validation pending

## Implemented polish

M7 reuses the M5/M6 title/help surface and adds a small visual identity layer:

- `VisualIdentity.current.appTitle`: `Flyby Nighter`
- `VisualIdentity.current.tagline`: `Arcade night flight, rebuilt for first-testers.`
- named palette tokens for first-tester visual consistency
- title/help summary integration through `PlaytestGuide`

## Title surface hierarchy

The first-tester title surface should now present:

1. game title,
2. M7 tagline,
3. M6 release identity,
4. selected route description,
5. route selection controls,
6. best score summary,
7. reset/mute/start instruction line.

## Readability rules

- Keep title and route selector visually distinct.
- Keep the release identity copyable for tester feedback.
- Keep route selection visible before starting a run.
- Keep reset and mute visible for repeatable playtests.
- Avoid adding gameplay terminology that is not implemented.
- Avoid dense legal or distribution language inside the game shell.

## Manual validation

Validate on macOS, one iPhone layout, and one iPad layout:

1. Title says `Flyby Nighter`.
2. Tagline is visible.
3. Release identity remains visible.
4. Route selection remains obvious.
5. Start/replay guidance remains visible.
6. Reset and mute guidance remain available.
7. Result screens still preserve score, best score, replay, and change-route guidance.
8. No gameplay behavior differs from M6.
