# M2-B App Key Event Monitor Fix

Status: Pending local validation

## Problem

Keyboard controls in `FlybyNighterApp` still did not work after explicit first-responder focus handling. The legacy `FlybyNighterMac` executable continued to work.

## Fix

The SwiftUI app shell now installs a local macOS key-event monitor through its `NSViewRepresentable` coordinator.

The monitor:

- captures key-down and key-up events while the app window is active
- maintains movement key state
- forwards movement directly to `FlybyNighterScene`
- forwards Space firing
- forwards Return and keypad Enter start/restart
- does not depend on the SwiftUI/AppKit first-responder chain
- removes itself when the coordinator is released

## Validation

```bash
swift test
swift build --product FlybyNighterApp
swift run FlybyNighterApp
```

Verify WASD, arrows, Space, Return, and keypad Enter.
