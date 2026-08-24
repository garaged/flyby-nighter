# SPEC-0030: Distribution Boundaries

Status: Implemented  
Milestone: M6

## Goal

Keep first-tester release-readiness work clear about what is supported now and what remains deferred.

## Scope

- Development-build and first-tester-build definitions.
- Explicit deferred distribution channels.
- Guardrails for App Store, TestFlight, notarization, analytics, and crash reporting.
- Maintainer-facing release notes about unsupported production distribution.

## Requirements

1. M6 must document that first-tester builds are development builds unless a later milestone approves a distribution channel.
2. M6 must not introduce App Store Connect or TestFlight automation.
3. M6 must not introduce notarization or code-signing automation beyond local development build instructions.
4. M6 must not introduce analytics or crash-reporting SDKs.
5. M6 must preserve the existing Apple-first app shell architecture.

## Implementation

`docs/implementation/M6-distribution-boundaries.md` defines:

- supported development and first-tester build paths
- unsupported public distribution channels
- development-build, first-tester-build, and public-release definitions
- guardrails against telemetry, signing automation, notarization, App Store, and TestFlight work in M6
- future milestone candidates requiring explicit approval

## Non-goals

- No App Store release.
- No public beta.
- No paid distribution.
- No telemetry collection.
- No privacy policy generation.

## Acceptance results

1. The repository has a distribution-boundary note.
2. The release-candidate checklist references the boundary.
3. The PR does not add distribution automation or telemetry dependencies.
4. `swift build`, `swift test`, and the mobile simulator build pass.

## Validation

Implemented and validated on August 23, 2026.

See `docs/implementation/M6-validation.md`.
