# SPEC-0018: macOS Controls

Status: Proposed  
Milestone: M2

## Goal

Preserve and refine the macOS control path so local desktop playtesting remains fast and reliable.

## Scope

- Keyboard movement.
- Keyboard firing.
- Start and restart controls.
- Window focus behavior.
- Clear control documentation.

## Non-goals

- No gamepad support in M2.
- No control remapping UI.
- No platform-specific gameplay differences.

## Acceptance criteria

1. WASD and arrow-key movement work.
2. Space fires.
3. Return, keypad Enter, or click starts/restarts.
4. The window reliably receives keyboard focus after launch.
5. Local validation still supports `swift run FlybyNighterMac` until a fuller app launch path replaces it.
6. `swift test` passes.
