#!/usr/bin/env bash
set -euo pipefail

repo_root="$(cd "$(dirname "${BASH_SOURCE[0]}")/../.." && pwd)"
cd "$repo_root"

bundle_root=".build/first-tester"
bundle_dir="$bundle_root/FlybyNighter-first-tester"
manifest_file="$bundle_dir/MANIFEST.md"
handoff_file="$bundle_dir/README-FIRST-TESTER.md"
commit_sha="$(git rev-parse --short HEAD 2>/dev/null || printf 'unknown')"
generated_at="$(date -u +%Y-%m-%dT%H:%M:%SZ)"

printf '==> Preparing Flyby Nighter first-tester bundle\n'
rm -rf "$bundle_dir"
mkdir -p "$bundle_dir"

printf '==> Building macOS executable\n'
swift build --product FlybyNighterApp

binary_path="$(swift build --show-bin-path)/FlybyNighterApp"
if [[ ! -x "$binary_path" ]]; then
  printf 'error: expected executable not found at %s\n' "$binary_path" >&2
  exit 1
fi

cp "$binary_path" "$bundle_dir/FlybyNighterApp"

cat > "$manifest_file" <<MANIFEST
# Flyby Nighter First-Tester Manifest

- Release identity: Flyby Nighter v0.8.0 (m8-dev) • first-tester
- Feedback token: app=Flyby Nighter; version=0.8.0; build=m8-dev; channel=first-tester
- Commit: $commit_sha
- Generated at: $generated_at
- Validation status: package-script-built-macos-executable

## Validation commands

- \`make validate\`: Run Swift package build, Swift tests, and iPhone/iPad Simulator build.
- \`make run-macos\`: Launch the macOS first-tester shell.
- \`make run-macos-reset\`: Launch with local high scores reset.
- \`make run-macos-muted\`: Launch with audio disabled.

## Distribution boundary

M8 bundles are local development handoff artifacts only; they are not App Store, TestFlight, notarized, signed, telemetry-enabled, or public distribution artifacts.

## Feedback categories

blocker, regression, usability, visual, polish
MANIFEST

cat > "$handoff_file" <<'HANDOFF'
# Flyby Nighter First-Tester Handoff

Thank you for testing Flyby Nighter.

## Run

From this folder on macOS:

```bash
./FlybyNighterApp
```

The repository workflow can also launch from source:

```bash
make run-macos
make run-macos-reset
make run-macos-muted
```

## What to test

1. Title screen readability.
2. Route selection between Neon Rift and Glass Tide.
3. Movement, firing, gifts, hazards, scoring, and best scores.
4. Reset and muted playtest workflows.
5. Result screen replay/change-route guidance.

## Feedback template

- Release identity:
- Platform and input mode:
- Route:
- Category: blocker / regression / usability / visual / polish
- Expected behavior:
- Actual behavior:
- Reproduction steps:
- Screenshot or short recording, if helpful:

Do not include secrets, private data, or unrelated logs.
HANDOFF

printf '==> Bundle ready: %s\n' "$bundle_dir"
printf '==> Manifest: %s\n' "$manifest_file"
