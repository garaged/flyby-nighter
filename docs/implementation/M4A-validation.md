# M4-A Route Catalog Validation

Branch: `m4-content-expansion`  
Status: Implemented; automated validation tracked by PR #3

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

## Validation

```bash
swift package clean
swift build
swift test
```

The mobile target remains covered by Mobile CI.

## Follow-up

Playable cross-platform route selection, route-specific HUD labels, and the manual validation matrix are documented in `M4B-validation.md`.
