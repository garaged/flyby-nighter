# M2-B SwiftUI Focus Fix

Status: Pending local validation

## Problem

`FlybyNighterApp` displayed the scene correctly, but keyboard controls did not work while `FlybyNighterMac` remained functional.

## Cause

The SwiftUI host could reclaim first-responder status after the SpriteKit view requested focus synchronously.

## Fix

- Defer first-responder acquisition to the next main-loop turn.
- Request focus when the view enters a window.
- Request focus from the SwiftUI representable update path.
- Request focus on mouse-down and mouse-up.
- Accept the first mouse click.

## Validation

```bash
swift test
swift build --product FlybyNighterApp
swift run FlybyNighterApp
```

Verify WASD, arrows, Space, Return, keypad Enter, and click start/restart.
