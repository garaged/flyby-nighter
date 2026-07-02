# M4-B Route Selection Validation

Branch: `m4-content-expansion`  
Status: Passed  
Validated: July 2, 2026

M4-B route selection, route-specific HUD presentation, lifecycle behavior, and both routes passed automated and manual validation on macOS, iPhone, and iPad.

## Automated validation

```bash
swift build
swift test
```

The iPhone/iPad Simulator target and both macOS executable products also compile successfully.

## Manual validation

- The Neon Rift is the default route.
- Selection wraps between The Neon Rift and The Glass Tide.
- Keyboard, click, and touch selection work on title and result screens.
- Selection is unavailable during active play.
- Route-specific `Sector` and `Tide` HUD labels display correctly.
- Existing movement, firing, pause/resume, completion, failure, and restart behavior do not regress.
- Both routes are completable after learning.

## Result

M4-A and M4-B acceptance criteria passed. `SPEC-0022` is implemented.

## Remaining M4 work

- A new enemy or hazard family.
- Score-depth decision and optional combo rules.
- Local high-score persistence.
