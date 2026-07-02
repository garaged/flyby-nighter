# AGENTS.md

## Project

Flyby Nighter is an original retro-inspired arcade shooter. It should borrow only broad genre ideas from early arcade shooters, not protected expression from any specific legacy game.

## Hard IP boundary

Do not copy or recreate protected material from classic Vanguard or any other arcade title, including ROM/code, sprites, tiles, enemy designs, boss designs, level layouts, zone order, cabinet art, sound effects, music, names, lore, manuals, UI composition, or marketing language that implies endorsement.

Use original names, original art direction, original map grammar, original enemy taxonomy, original audio, and original progression.

## Development mode

This repository uses Spec Driven Development.

Before implementing any feature:

1. Read `docs/sdd/README.md`.
2. Read `docs/sdd/registry.md`.
3. Read the milestone spec being implemented.
4. Implement only the accepted scope for that milestone.
5. Update the registry when a spec changes status.
6. Add or update tests before or alongside implementation.

## Architecture preference

Keep the gameplay core deterministic and testable. Prefer a small engine-independent simulation layer for player state, enemies, pickups, collisions, scoring, timers, and map rules. Rendering, audio, input, persistence, and platform integration should be adapters around that core.

Avoid burying game rules in rendering callbacks. Avoid frame-rate-dependent logic; use fixed timestep or time-delta code that is deterministic under tests.

## Quality gates

For docs-only changes:

- Keep status labels consistent: Proposed, Accepted, Implemented, Deferred, Rejected.
- Keep `docs/sdd/registry.md` updated.
- Record open decisions in `docs/sdd/questions.md`.

For code changes once the project scaffold exists:

- Build must pass.
- Unit tests for deterministic game rules must pass.
- At least one walking-skeleton smoke test must pass for the playable loop.
- New gameplay behavior must have acceptance criteria traced to a spec.

## Codex behavior

When asked to implement a milestone, do not expand scope. If a requirement is unclear, make a conservative assumption, document it, and keep the implementation small. Prefer clear seams and readable code over clever abstractions.
