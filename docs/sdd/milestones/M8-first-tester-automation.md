# M8: First-Tester Automation

Status: Validation Pending  
Milestone: M8

## Goal

Make the first-tester development build repeatable enough to prepare, validate, package, and hand off without relying on scattered manual commands.

M8 batches release-readiness automation, local packaging, manifest generation, and tester feedback workflow while preserving the explicit M6 distribution boundaries.

## Scope

M8 includes:

- A test-covered first-tester build plan in `FlybyNighterCore`.
- Root-level helper commands for validation, macOS launch, reset, mute, and packaging.
- Local scripts for validation and macOS first-tester bundle preparation.
- A release-bundle manifest format for evidence and tester handoff.
- Documentation for first-tester handoff and feedback intake.
- Updated release identity for the M8 first-tester automation milestone.

## Non-goals

- No App Store Connect work.
- No TestFlight automation.
- No notarization or signing automation.
- No telemetry, analytics, or crash-reporting SDKs.
- No final marketing asset generation.
- No gameplay rule, route, score, or enemy changes.

## Required specs

M8 is governed by:

- `SPEC-0034-first-tester-build-automation.md`
- `SPEC-0035-release-bundle-manifest.md`
- `SPEC-0036-tester-feedback-workflow.md`

## Implementation slices

1. First-tester build plan model and tests.
2. Root `Makefile` developer commands.
3. Local validation and macOS bundle scripts.
4. Bundle manifest template and evidence docs.
5. Tester feedback workflow docs.
6. Automated validation and manual handoff validation.

## Acceptance criteria

A reviewer can:

1. Run a single command for package validation.
2. Run a single command to launch the macOS app.
3. Run reset and muted macOS playtests with documented commands.
4. Prepare a local first-tester bundle that includes a manifest and handoff docs.
5. Confirm the manifest includes release identity, commit, validation status, and distribution boundaries.
6. Confirm no public distribution, telemetry, signing, or notarization automation was added.
7. Run `swift build`, `swift test`, and the iPhone/iPad Simulator build successfully.

## Implementation status

Implementation is in place across the build plan model, tests, root `Makefile`, local scripts, handoff docs, and validation matrix.

## Validation

Automated and manual validation pending.
