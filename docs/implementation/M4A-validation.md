# M4-A Route Catalog Validation

Branch: `m4-content-expansion`  
Status: Automated validation pending

## Implemented

- Added `RouteID` and `RouteDefinition` as deterministic core types.
- Added `RouteCatalog` with The Neon Rift and The Glass Tide.
- Added The Glass Tide route content:
  - 6 authored enemy encounters.
  - 3 gifts in Shield, Rapid, Spread teaching order.
  - 5 authored obstacles and pulse gates.
  - 7 original route segment names.
- Added `GameConfig.m4GlassTide` with an approximately 57-second route target.
- Added deterministic tests for catalog identity, distinct pacing, content order, route bounds, gifts, and completion configuration.

## Architecture

- Route data remains in `FlybyNighterCore`.
- No SpriteKit, AppKit, UIKit, persistence, or audio dependency was added to the core.
- Existing M1 configuration remains unchanged and is reused by the Neon Rift catalog entry.
- Route selection UI is intentionally deferred to M4-B.

## Expected automated validation

```bash
swift package clean
swift build
swift test
```

The existing mobile build should also remain valid because Swift Package sources are discovered automatically:

```bash
xcodebuild \
  -project Apps/FlybyNighterMobile/FlybyNighterMobile.xcodeproj \
  -scheme FlybyNighterMobile \
  -sdk iphonesimulator \
  -destination 'generic/platform=iOS Simulator' \
  CODE_SIGNING_ALLOWED=NO \
  build
```

## Manual validation

Not required for M4-A because the second route is not yet wired into playable shell selection.

## Deferred to M4-B

- macOS route selection.
- iPhone/iPad route selection.
- Route-specific HUD segment names.
- Manual Glass Tide completion and fairness tuning.
- Marking `SPEC-0022` Implemented.
