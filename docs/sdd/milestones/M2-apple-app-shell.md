# M2: Apple App Shell

Status: In Progress  
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

1. App target and native macOS shell — implemented.
2. Shared SpriteKit scene hosting — implemented.
3. macOS keyboard and click controls — implemented and manually validated.
4. macOS pause/resume and stale-input clearing — implemented; local validation pending.
5. iPhone/iPad app shell and touch controls — deferred to the next M2 slice.
6. Final cross-platform launch validation — pending.

## Acceptance criteria

A reviewer can:

1. Launch the app shell locally.
2. Start the same M1 route from the app shell.
3. Move and fire on macOS.
4. Move and fire on touch platforms through a clear control surface.
5. Restart after completion or failure.
6. Run `swift test` with no failures.
