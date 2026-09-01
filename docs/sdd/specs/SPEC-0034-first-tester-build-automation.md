# SPEC-0034: First-Tester Build Automation

Status: Implemented  
Milestone: M8  
Validated: September 1, 2026

## Goal

Provide repeatable local commands for validating and preparing a first-tester development build.

## Scope

- A test-covered first-tester build plan.
- Root-level helper targets for common validation and playtest commands.
- Local shell scripts for validation and macOS bundle preparation.
- Guardrails that keep automation local-development only.

## Requirements

1. Build automation must include `swift build` and `swift test`.
2. Build automation must include the iPhone/iPad Simulator build command.
3. Root helper commands must include macOS launch, reset, mute, and package preparation.
4. Automation must fail fast on command failures.
5. Automation must not add App Store Connect, TestFlight, notarization, signing, telemetry, analytics, or crash-reporting automation.
6. Automation must not change deterministic gameplay rules.

## Implementation

- `FirstTesterBuildPlan` defines validation and macOS playtest commands.
- `FirstTesterBuildPlanTests` protect command coverage and distribution boundaries.
- Root `Makefile` provides `validate`, `mobile-build`, `run-macos`, `run-macos-reset`, `run-macos-muted`, and `package-first-tester`.
- `scripts/first-tester/validate.sh` runs package build, tests, and the mobile simulator build.
- `scripts/first-tester/package-macos.sh` prepares the local macOS handoff bundle.
- CI validates `make validate`, `make package-first-tester`, and `make mobile-build`.

## Acceptance criteria

1. The build plan is test-covered.
2. A developer can run `make validate`.
3. A developer can run `make run-macos`, `make run-macos-reset`, and `make run-macos-muted`.
4. A developer can run `make package-first-tester` to create a local bundle folder.
5. `swift build`, `swift test`, and mobile CI pass.

## Validation

Implemented and validated by automated CI plus manual acceptance.
