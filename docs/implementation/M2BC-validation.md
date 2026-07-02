# M2 Validation

Branch: `m0-apple-scaffold`  
Status: Passed  
Validated: July 2, 2026

## Validated platforms

### macOS

- Native AppKit `FlybyNighterApp` shell launches successfully.
- WASD and arrow-key movement work.
- Space firing works.
- Return, keypad Enter, and click start/restart work.
- Focus loss clears input.
- Application and window pause/resume behavior works without stuck input or time jumps.

### iPhone and iPad

- Native `FlybyNighterMobile` target launches successfully.
- Touch down starts or restarts the run.
- Touch and hold fires continuously.
- Dragging steers relative to the ship.
- Releasing or cancelling stops movement and firing.
- HUD elements remain visible inside safe areas.
- Portrait and landscape transitions resize correctly.
- iPad resizing updates the scene without stale coordinates.
- Background and foreground transitions pause and resume correctly.

## Automated validation

Passed:

```bash
swift package clean
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

CI coverage:

- `.github/workflows/ci.yml`
- `.github/workflows/mobile-ci.yml`

## Result

M2 acceptance criteria passed with no observed deterministic-core regressions.

## Deferred polish

- Final app icons and branding.
- Distribution signing and App Store packaging.
- External controller support.
- Accessibility control remapping.
