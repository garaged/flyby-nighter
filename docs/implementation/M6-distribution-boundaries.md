# M6 Distribution Boundaries

Status: Implemented; validation pending  
Milestone: M6

M6 prepares a first-tester development build. It does not ship public distribution infrastructure.

## Supported in M6

M6 supports:

- Local macOS development builds.
- iPhone and iPad Simulator builds.
- Development-device builds through a maintainer-controlled Xcode environment.
- Manual first-tester handoff using the release-candidate checklist.
- Manual evidence collection from testers.

## Not supported in M6

M6 does not support:

- App Store release.
- TestFlight automation.
- App Store Connect metadata.
- Notarization pipeline.
- Production code-signing automation.
- Analytics SDKs.
- Crash-reporting SDKs.
- Telemetry collection.
- Privacy-policy generation.
- Public beta distribution.

## Build definitions

### Development build

A build produced locally from a repository checkout using SwiftPM or Xcode. It is intended for maintainer validation and controlled first-tester sharing only.

### First-tester build

A development build that has passed the M6 release-candidate checklist and includes visible release identity.

### Public release

A build distributed through App Store, TestFlight, notarized macOS distribution, or any broader public channel. Public release is deferred beyond M6.

## Guardrails

- Do not add telemetry dependencies in M6.
- Do not add signing or notarization workflows in M6.
- Do not add App Store Connect credentials or metadata in M6.
- Do not add crash-reporting SDKs in M6.
- Do not change deterministic gameplay rules for release metadata.

## Future milestone candidates

Potential future milestones may cover:

- TestFlight packaging.
- macOS notarization.
- App Store metadata.
- Privacy policy and support links.
- Crash-reporting and analytics decisions.

Each requires explicit approval before implementation.
