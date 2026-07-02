# Spec Driven Development

Flyby Nighter is developed spec-first. Specs are the contract between design, implementation, tests, and AI-assisted coding.

## Workflow

1. Capture the desired player experience.
2. Convert it into a small milestone spec with explicit non-goals.
3. Define acceptance criteria that can be manually tested first and automated later.
4. Implement only the accepted milestone.
5. Validate through build, tests, and a playable smoke path.
6. Mark the spec implemented only after validation is documented.

## Status labels

- **Proposed**: candidate spec; useful for discussion but not ready for implementation.
- **Accepted**: approved scope; implementation may start.
- **Implemented**: shipped in code and validated.
- **Deferred**: intentionally postponed.
- **Rejected**: not part of the product direction.

## Repository structure

- `docs/sdd/registry.md`: canonical index of specs and status.
- `docs/sdd/product-brief.md`: game identity, design pillars, and non-goals.
- `docs/sdd/milestones/`: milestone-level playable targets.
- `docs/sdd/specs/`: detailed feature specs.
- `docs/sdd/decisions/`: architecture/design records.
- `docs/sdd/questions.md`: active design questions for incremental discussion.

## First playable definition

The first playable version should prove the core loop with one original map, controllable flight, shooting, enemies that attack, obstacles that force movement decisions, collectible gifts that grant powers, scoring, damage/failure, and a win/restart path.

It should not attempt a full campaign, polished assets, mobile store readiness, save systems, online leaderboards, monetization, or clone-accurate recreation of any legacy arcade game.
