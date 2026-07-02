# Codex Prompt: M2 Apple App Shell

You are implementing M2 for Flyby Nighter.

## Read first

- `AGENTS.md`
- `docs/sdd/registry.md`
- `docs/sdd/milestones/M2-apple-app-shell.md`
- `docs/sdd/specs/SPEC-0016-apple-app-shell.md`
- `docs/sdd/specs/SPEC-0017-touch-controls.md`
- `docs/sdd/specs/SPEC-0018-macos-controls.md`
- `docs/implementation/M1-validation.md`

## Hard constraints

- Keep deterministic rules in `FlybyNighterCore`.
- Keep SpriteKit/AppKit/UIKit/SwiftUI concerns outside the core.
- Do not copy legacy game layouts, names, assets, sounds, or visual identity.
- Keep `swift test` passing.
- Preserve the current macOS playable path until the replacement is validated.

## First slice: M2-A App Shell

Implement the smallest real Apple app shell that can host the current playable SpriteKit scene.

Prefer a small, reviewable change:

- Create app shell files or project structure.
- Host the current SpriteKit scene.
- Preserve current macOS wrapper until the new path is validated.
- Document launch instructions.

## Validation

Run:

```bash
swift test
swift run FlybyNighterMac
```

Also run the new app shell launch path and record it in `docs/implementation/M2-validation.md`.

## Definition of done

- Existing tests pass.
- Existing macOS wrapper remains usable.
- New app shell launches locally.
- Scene starts and plays from the app shell.
- Validation note documents what passed and what is deferred.
