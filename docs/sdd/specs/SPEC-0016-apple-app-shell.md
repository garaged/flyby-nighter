# SPEC-0016: Apple App Shell

Status: Proposed  
Milestone: M2

## Goal

Create a real Apple app shell that hosts the existing SpriteKit playable scene without moving gameplay rules out of `FlybyNighterCore`.

## Scope

- App target or project structure.
- Scene hosting.
- Window or device sizing behavior.
- App lifecycle start, pause, and resume basics.
- Debug-friendly local launch path.

## Non-goals

- No final distribution setup.
- No store metadata.
- No account, cloud, or network services.
- No gameplay rewrite.

## Acceptance criteria

1. The app shell launches locally.
2. It hosts the current playable scene.
3. The route can start, play, complete, fail, and restart.
4. Core gameplay remains deterministic and testable without SpriteKit.
5. `swift test` passes.

## Validation

```bash
swift test
```

Run the app shell locally through Xcode or the selected launch command and record results in an implementation note.
