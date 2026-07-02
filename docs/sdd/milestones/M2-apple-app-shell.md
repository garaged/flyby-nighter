# M2: Apple App Shell

Status: Proposed  
Milestone: M2

## Goal

Move from a SwiftPM playable wrapper to a real Apple app shell while preserving the deterministic core and SpriteKit adapter split.

## Scope

M2 includes:

- A real app target suitable for local Apple-platform development.
- SpriteKit scene hosting from an app shell.
- Clear macOS, iPhone, and iPad launch behavior.
- Basic app lifecycle handling.
- Input surfaces appropriate to each platform.
- Smoke validation for app launch.

## Non-goals

- No App Store release package.
- No final icons or branding set.
- No saved progression.
- No cloud services.
- No rewrite of deterministic gameplay rules.

## Required specs

M2 is governed by:

- `SPEC-0016-apple-app-shell.md`
- `SPEC-0017-touch-controls.md`
- `SPEC-0018-macos-controls.md`

## Implementation slices

1. Create app target or project structure.
2. Host the SpriteKit scene from the app shell.
3. Add iPhone/iPad touch controls.
4. Preserve and refine macOS controls.
5. Add app launch validation notes.

## Acceptance criteria

A reviewer can:

1. Launch the app shell locally.
2. Start the same M1 route from the app shell.
3. Move and fire on macOS.
4. Move and fire on touch platforms through a clear control surface.
5. Restart after completion or failure.
6. Run `swift test` with no failures.
