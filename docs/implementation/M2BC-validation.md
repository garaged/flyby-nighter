# M2 Validation

Branch: `m0-apple-scaffold`

## Implemented

### macOS app shell and controls

- Native AppKit `FlybyNighterApp` shell.
- Shared `FlybyNighterScene` and `MacKeyboardGameView` adapter.
- WASD and arrow-key movement.
- Space firing.
- Return, keypad Enter, and click start/restart.
- Input clearing on focus loss.
- Pause/resume on app and window activation changes.

Manual macOS validation passed on July 2, 2026.

### iPhone and iPad shell

- Native `FlybyNighterMobile` iOS/iPadOS application target.
- Shared local Swift package dependency on `FlybyNighterSpriteKit`.
- Supports iPhone and iPad device families.
- Supports portrait and landscape orientations.
- Keeps gameplay and HUD inside the safe area with black fill outside it.
- Resizes the shared scene when the device orientation or iPad window size changes.
- Pauses and clears input when the mobile scene becomes inactive.

### Touch controls

- Touch down starts or restarts a run when needed.
- Touch and hold fires continuously.
- Dragging steers relative to the ship position.
- Releasing or cancelling a touch stops movement and firing.
- No deterministic gameplay rules are duplicated in the app target.

## Automated validation

Swift package validation:

```bash
swift package clean
swift build
swift test
```

macOS application validation:

```bash
swift build --product FlybyNighterApp
swift run FlybyNighterApp
swift run FlybyNighterMac
```

iPhone/iPad target validation:

```bash
xcodebuild \
  -project Apps/FlybyNighterMobile/FlybyNighterMobile.xcodeproj \
  -scheme FlybyNighterMobile \
  -sdk iphonesimulator \
  -destination 'generic/platform=iOS Simulator' \
  CODE_SIGNING_ALLOWED=NO \
  build
```

The mobile build is also covered by `.github/workflows/mobile-ci.yml`.

## Manual mobile validation matrix

Run at least three attempts on an iPhone simulator or device and three attempts on an iPad simulator or device.

Confirm:

- Touch down starts the run.
- Holding the touch fires repeatedly.
- Dragging moves without requiring the finger to cover the ship.
- Releasing stops movement and firing.
- HP, score, route progress, and active power remain visible.
- Portrait and landscape transitions resize cleanly.
- iPad split-view or resizable simulator windows update the scene without stretching stale coordinates.
- Moving the app to the background pauses gameplay and clears touch state.
- Returning to the app resumes without a large time jump.
- Completion, failure, and restart remain functional.

## M2 completion gate

M2 can be marked complete after:

1. `swift test` passes.
2. The mobile Xcode target builds for the iOS Simulator.
3. The mobile manual validation matrix passes.
4. No deterministic-core regression is observed.

## Deferred polish

- Final app icons and branding.
- Distribution signing and App Store packaging.
- External controller support.
- Accessibility control remapping.
