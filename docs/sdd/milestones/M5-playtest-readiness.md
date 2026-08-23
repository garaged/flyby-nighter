# M5: Playtest Readiness and Usability

Status: Completed  
Milestone: M5

## Goal

Make the current two-route playable version easier to hand to a tester, observe, reset, and validate without developer assistance.

M5 focuses on discoverability, repeatable playtest runs, and developer-operated distribution hygiene. It does not expand the game with more routes or scoring systems.

## Completed scope

- Clear in-game help and controls reference.
- Playtest-safe settings and reset affordances.
- A repeatable playtest script and evidence template.
- First-tester packaging guidance for macOS and iPhone/iPad development builds.
- Guardrails that keep deterministic gameplay code separate from presentation, persistence, and platform adapters.

## Non-goals

- No App Store/TestFlight release automation yet.
- No online leaderboard.
- No user accounts or cloud sync.
- No new route, enemy, weapon, or scoring mechanics.
- No final art or audio identity pass.
- No monetization or analytics SDK.

## Required specs

M5 is governed by:

- `SPEC-0025-playtest-onboarding.md`
- `SPEC-0026-playtest-reset-and-settings.md`
- `SPEC-0027-first-tester-packaging.md`

All M5 specs are implemented.

## Delivered slices

1. In-game playtest help and controls reference.
2. Playtest reset/settings affordances.
3. Manual playtest script and evidence template.
4. First-tester packaging notes for macOS and iPhone/iPad.
5. Validation and milestone closure.

## Acceptance results

A reviewer can:

1. Start the game and understand route selection, firing, movement, scoring, best scores, and reset behavior without reading source code.
2. Reset local best scores intentionally before a playtest.
3. Run a documented playtest matrix and record evidence.
4. Produce a macOS or iPhone/iPad development build using documented steps.
5. Run `swift build`, `swift test`, and the iPhone/iPad Simulator build successfully.

## Validation

Completed and validated on August 23, 2026.

See `docs/implementation/M5-validation.md` and `docs/implementation/M5-first-tester-handoff.md`.
