# SPEC-0030: Distribution Boundaries

Status: Accepted  
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

## Non-goals

- No App Store release.
- No public beta.
- No paid distribution.
- No telemetry collection.
- No privacy policy generation.

## Acceptance criteria

1. The repository has a distribution-boundary note.
2. The release-candidate checklist references the boundary.
3. The PR does not add distribution automation or telemetry dependencies.
4. `swift build`, `swift test`, and the mobile simulator build pass.

## Validation

Pending implementation.
