# M2: Apple App Shell

Status: Completed  
Milestone: M2

## Goal

Provide native macOS, iPhone, and iPad application shells while preserving the deterministic core and shared SpriteKit adapter.

## Completed scope

- Native macOS AppKit shell.
- Native iPhone/iPad Xcode target.
- Shared `FlybyNighterScene` hosting across platforms.
- macOS keyboard, firing, start/restart, focus, and lifecycle behavior.
- Touch drag movement and touch-and-hold firing.
- Mobile safe-area, orientation, resizing, and lifecycle handling.
- Automated Swift package and iOS Simulator build coverage.
- Manual macOS, iPhone, and iPad validation.

## Required specs

- `SPEC-0016-apple-app-shell.md`
- `SPEC-0017-touch-controls.md`
- `SPEC-0018-macos-controls.md`

## Acceptance results

- App shells launch successfully.
- The same M1 route runs on macOS, iPhone, and iPad.
- Keyboard and touch controls work as specified.
- Orientation and iPad resizing behave correctly.
- Pause/resume clears stale input and avoids time jumps.
- Completion, failure, and restart remain functional.
- Automated builds and tests pass with no deterministic-core regressions.

Validation completed on July 2, 2026. Details are recorded in `docs/implementation/M2BC-validation.md`.
