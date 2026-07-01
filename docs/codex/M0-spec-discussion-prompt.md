# Codex Prompt: M0 Spec Refinement

Use this prompt when asking Codex to refine or implement the M0 specs.

```text
Read AGENTS.md, docs/sdd/README.md, docs/sdd/registry.md, docs/sdd/milestones/M0-minimal-playable.md, and every SPEC/ADR referenced by the registry.

Goal: refine or implement only the accepted M0 scope for Flyby Nighter.

Important constraints:
- This is an original retro-inspired arcade shooter, not a remake or clone.
- Do not copy protected assets, names, layouts, enemy designs, audio, or UI composition from Vanguard or any other legacy game.
- Keep the gameplay core deterministic and testable.
- Do not expand beyond M0 without updating docs/sdd/questions.md and the registry.

Before writing code, verify which specs are Accepted. If a spec is still Proposed, update docs/specs only and do not implement gameplay code unless explicitly instructed.

For implementation PRs:
- Add/update tests for deterministic gameplay rules.
- Add a thin playable smoke path once runtime exists.
- Update docs/sdd/registry.md and validation notes.
```
