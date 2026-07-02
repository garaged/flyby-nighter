# M4-B Route Selection Validation

Branch: `m4-content-expansion`  
Status: Passed  
Validated: July 2, 2026

## Implemented

- The shared `FlybyNighterScene` owns the selected route.
- Selecting a route creates a new deterministic `FlybyNighterGame` from that route's `GameConfig`.
- The Neon Rift remains the default route.
- The Glass Tide is selectable before a run and after completion or failure.
- Route changes clear stale movement, firing, timing, feedback, and camera offset.
- Route-specific segment names are displayed in the HUD.
- The selected route name and summary are displayed on the title screen.
- Result screens retain the route name and allow replay or route changes.

## Validated controls

### macOS

On title, completion, and failure screens:

- Left arrow selects the previous route.
- Right arrow selects the next route.
- Clicking the left or right third selects a route.
- Return, keypad Enter, and center click start or replay.

During active play, arrows and WASD continue to move the ship normally.

### iPhone and iPad

On title, completion, and failure screens:

- Tapping the left or right third selects a route.
- Tapping the center starts or replays.

During active play, drag movement and touch-and-hold firing continue to work normally.

## Automated coverage

`RouteSelectionStateTests` covers:

- Default route selection.
- Forward and backward wraparound.
- Selected route configuration changes.
- Route-specific segment labels.
- Segment progress clamping.

M4 core tests cover route identity, authored content, ordering, bounds, gift order, pacing, and completion configuration.

## Automated validation result

Passed:

```bash
swift build
swift test
```

Passed mobile target build:

```bash
xcodebuild \
  -project Apps/FlybyNighterMobile/FlybyNighterMobile.xcodeproj \
  -scheme FlybyNighterMobile \
  -sdk iphonesimulator \
  -destination 'generic/platform=iOS Simulator' \
  CODE_SIGNING_ALLOWED=NO \
  build
```

Both macOS executable products compiled successfully.

## Manual validation result

Validated successfully on the implemented Apple shells:

1. The title screen initially shows The Neon Rift.
2. Previous and next controls wrap between both routes.
3. The Glass Tide uses its distinct authored encounter order.
4. Glass Tide displays `Tide` segment names; Neon Rift displays `Sector` names.
5. Route selection is unavailable during active play.
6. Existing macOS movement and firing controls do not regress.
7. Existing iPhone/iPad movement and firing controls do not regress.
8. Completion and failure screens support replay and route changes.
9. Route changes from result screens reset cleanly to the selected route.
10. Pause and resume preserve selection without stuck input.
11. Both routes are completable after learning.

## Result

M4-A and M4-B acceptance criteria passed. `SPEC-0022` can be marked Implemented.

## Remaining M4 work

- A new enemy or hazard family.
- Score-depth decision and optional combo rules.
- Local high-score persistence.
