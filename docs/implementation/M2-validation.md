# M2 Validation

Branch: `m0-apple-scaffold`

## Implemented

M2-A app shell baseline:

- Added `FlybyNighterApp` executable product.
- Added `Sources/FlybyNighterApp/main.swift`.
- The new app shell uses SwiftUI on macOS.
- The shell hosts the existing `FlybyNighterScene` in an `SKView`.
- Preserved the existing `FlybyNighterMac` wrapper as the keyboard-playtest path.

## Current app shell behavior

- Launches a macOS SwiftUI window.
- Presents the current SpriteKit playable scene.
- Supports scene-level click start/restart behavior.
- Full keyboard movement/fire parity remains in `FlybyNighterMac` for now.

## Validation

Pending local validation:

```bash
swift test
swift build --product FlybyNighterApp
swift run FlybyNighterApp
swift run FlybyNighterMac
```

## Deferred polish

- Keyboard control parity in the SwiftUI app shell.
- iPhone/iPad app target or project structure.
- App lifecycle pause/resume behavior.
- App icon, bundle metadata, and distribution packaging.

## Spec trace

- `SPEC-0016-apple-app-shell.md`
- `SPEC-0017-touch-controls.md`
- `SPEC-0018-macos-controls.md`
