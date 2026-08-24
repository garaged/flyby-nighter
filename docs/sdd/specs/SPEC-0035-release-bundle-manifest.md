# SPEC-0035: Release Bundle Manifest

Status: Accepted  
Milestone: M8

## Goal

Define the evidence manifest that travels with a first-tester local development bundle.

## Scope

- Manifest content requirements.
- Bundle folder shape.
- Validation evidence fields.
- Distribution-boundary reminder.
- Local-only handoff rules.

## Requirements

1. The manifest must include release identity.
2. The manifest must include git commit or `unknown` when unavailable.
3. The manifest must include generated timestamp or `unknown` when unavailable.
4. The manifest must include validation commands and status fields.
5. The manifest must explicitly state that M8 bundles are local development/first-tester handoff artifacts, not public distribution artifacts.
6. The manifest must avoid personal data, telemetry, analytics identifiers, or machine-specific secrets.

## Implementation plan

- Add manifest generation support to `FirstTesterBuildPlan`.
- Add a local packaging script that writes `MANIFEST.md`.
- Add a handoff README to the generated bundle.
- Document expected evidence capture.

## Acceptance criteria

1. Manifest generation is test-covered.
2. Bundle script writes a manifest.
3. Manifest has release identity, commit, timestamp, validation commands, and distribution boundary.
4. Bundle script is local-only and does not upload artifacts.

## Validation

Pending implementation.
