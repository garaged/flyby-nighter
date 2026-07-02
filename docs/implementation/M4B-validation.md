# M4-B Route Selection Validation

Branch: `m4-content-expansion`  
Status: Automated and manual validation pending

## Implemented

- The shared `FlybyNighterScene` now owns the selected route.
- Selecting a route creates a new deterministic `FlybyNighterGame` from that route's `GameConfig`.
- The Neon Rift remains the default route.
- The Glass Tide is selectable before a run and after completion or failure.
- Route changes clear stale movement, firing, timing, feedback, and camera offset.
- Route-specific segment names are displayed in the HUD.
- The selected route name and summary are displayed on the title screen.
- Result screens retain the route name and allow replay or route changes.

## Controls

### macOS

On the title, completion, or failure screen:

- Left arrow: previous route.
- Right arrow: next route.
- Click the left third: previous route.
- Click the right third: next route.
- Return, keypad Enter, or click the center third: start/replay.

During active play, arrows and WASD retain their existing movement behavior.

### iPhone and iPad

On the title, completion, or failure screen:

- Tap the left third: previous route.
- Tap the right third: next route.
- Tap the center third: start/replay.

During active play, drag movement and touch-and-hold firing retain their existing behavior.

## Automated coverage

`RouteSelectionStateTests` covers:

- Default route selection.
- Forward and backward wraparound.
- Selected route configuration changes.
- Route-specific segment labels.
- Segment progress clamping.

Existing M4 core tests continue to cover route identity, authored content, ordering, bounds, gift order, pacing, and completion configuration.

## Expected commands

```bash
swift package clean
swift build
swift test
swift build --product FlybyNighterApp
swift build --product FlybyNighterMac
```

Mobile build:

```bash
xcodebuild \
  -project Apps/FlybyNighterMobile/FlybyNighterMobile.xcodeproj \
  -scheme FlybyNighterMobile \
  -sdk iphonesimulator \
  -destination 'generic/platform=iOS Simulator' \
  CODE_SIGNING_ALLOWED=NO \
  build
```

## Manual validation matrix

Validate on `FlybyNighterApp`, `FlybyNighterMac`, one iPhone simulator/device, and one iPad simulator/device:

1. The title screen initially shows The Neon Rift.
2. Previous/next controls wrap between The Neon Rift and The Glass Tide.
3. Selecting The Glass Tide and starting uses its distinct enemy, gift, and obstacle ordering.
4. HUD segment labels use `Tide` names on The Glass Tide and `Sector` names on The Neon Rift.
5. Route selection is unavailable during active play.
6. Arrow keys still move the ship during active macOS play.
7. Drag movement and hold-to-fire still work during mobile play.
8. Completion and failure screens allow replaying the same route.
9. Side selection from a result screen returns to the selected route's title state.
10. Pause/resume does not change the selected route or introduce stuck input.
11. Both routes can be completed after learning.

## Deferred after M4-B

- Fairness and pacing adjustments from Glass Tide playtest observations.
- A new enemy or hazard family.
- Score-depth decisions.
- Local high-score persistence.
