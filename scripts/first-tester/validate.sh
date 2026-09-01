#!/usr/bin/env bash
set -euo pipefail

repo_root="$(cd "$(dirname "${BASH_SOURCE[0]}")/../.." && pwd)"
cd "$repo_root"

printf '==> Flyby Nighter first-tester validation\n'
printf '==> swift build\n'
swift build

printf '==> swift test\n'
swift test

printf '==> iPhone/iPad Simulator build\n'
xcodebuild \
  -project Apps/FlybyNighterMobile/FlybyNighterMobile.xcodeproj \
  -scheme FlybyNighterMobile \
  -sdk iphonesimulator \
  -destination 'generic/platform=iOS Simulator' \
  CODE_SIGNING_ALLOWED=NO \
  build

printf '==> first-tester validation passed\n'
