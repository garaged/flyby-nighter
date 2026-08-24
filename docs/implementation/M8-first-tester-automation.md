# M8 First-Tester Automation

Status: Implementation complete; validation pending

## Purpose

M8 turns the M6/M7 first-tester readiness work into repeatable local commands.

## Root commands

```bash
make validate
make build
make test
make mobile-build
make run-macos
make run-macos-reset
make run-macos-muted
make package-first-tester
make clean-first-tester
```

## Validation command

`make validate` runs:

1. `swift build`
2. `swift test`
3. iPhone/iPad Simulator build through `xcodebuild`

The script fails fast with `set -euo pipefail`.

## macOS playtest commands

```bash
make run-macos
make run-macos-reset
make run-macos-muted
```

These cover the common first-tester paths without remembering launch arguments.

## Local bundle command

```bash
make package-first-tester
```

This creates:

```text
.build/first-tester/FlybyNighter-first-tester/
├── FlybyNighterApp
├── MANIFEST.md
└── README-FIRST-TESTER.md
```

The bundle is intentionally local-only. It is not notarized, signed for distribution, uploaded, or prepared for App Store/TestFlight.

## Guardrails

M8 does not add:

- App Store Connect automation
- TestFlight automation
- notarization
- code-signing automation
- telemetry
- analytics
- crash-reporting SDKs
- gameplay rule changes

## Manual validation

A maintainer should run:

```bash
make validate
make package-first-tester
.build/first-tester/FlybyNighter-first-tester/FlybyNighterApp
```

Then verify the manifest and handoff README are present and readable.
