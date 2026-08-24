# M7 Validation

Branch: `m7-visual-identity`  
Status: Passed

## Scope

M7 validates first-tester visual identity and title/menu polish:

- Original visual identity tokens.
- Tester-visible title and tagline.
- Icon and launch asset checklist.
- Title/menu hierarchy and readability.
- Confirmation that gameplay rules remain unchanged.

## Implemented

- `VisualIdentity.current` title, tagline, mood words, and palette tokens.
- `VisualPaletteToken` named hex values and roles.
- `VisualIdentityTests` for title, tagline, mood words, palette names, roles, and hex validation.
- `PlaytestGuide` title/help integration for the M7 tagline.
- `PlaytestGuideTests` for title-surface visual identity visibility.
- `docs/implementation/M7-icon-launch-assets.md`.
- `docs/implementation/M7-title-menu-polish.md`.
- Implemented SDD status for `SPEC-0031`, `SPEC-0032`, and `SPEC-0033`.

## Title readability regression

First manual review found the title screen cluttered:

- Route selector overlapped title/help copy.
- Help copy was too dense.
- Footer instructions overflowed horizontally.

Corrective patch:

- Shortened playtest guide copy.
- Removed duplicate route-summary prose from the guide body.
- Separated title, route selector, guide body, and footer into clearer vertical rows.
- Changed guide body and footer labels to top-aligned multiline text.
- Wrapped footer controls into two lines.
- Added compact-guide test coverage.

The corrected title surface was manually retested and accepted.

## Automated validation

Passed on PR #6 head `f6c3cbc30852fa913bf5545686594f2ae217f27e`:

```bash
swift build
swift test
```

Mobile build passed:

```bash
xcodebuild \
  -project Apps/FlybyNighterMobile/FlybyNighterMobile.xcodeproj \
  -scheme FlybyNighterMobile \
  -sdk iphonesimulator \
  -destination 'generic/platform=iOS Simulator' \
  CODE_SIGNING_ALLOWED=NO \
  build
```

## Manual validation matrix

Passed:

1. Title surface clearly says Flyby Nighter.
2. Tagline is visible and original: `Arcade night flight, rebuilt for first-testers.`
3. Route selection remains obvious and does not overlap help copy.
4. Release identity remains visible before testing.
5. Reset and mute guidance remain available and do not overflow horizontally.
6. Help text is readable enough for first-tester use.
7. Result screens still show replay/change-route guidance.
8. No copied legacy arcade assets, names, exact palettes, or UI compositions are introduced.
9. macOS title/help surface is readable; iPhone and iPad builds remain green for the shared title surface.

## Completion gate

M7 is complete:

1. `SPEC-0031`, `SPEC-0032`, and `SPEC-0033` are implemented.
2. Automated validation passed.
3. Manual visual identity validation passed.
4. The M7 milestone is marked Completed.
