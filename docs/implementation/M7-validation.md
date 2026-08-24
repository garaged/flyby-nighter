# M7 Validation

Branch: `m7-visual-identity`  
Status: Specification baseline created; implementation pending

## Scope

M7 validates first-tester visual identity and title/menu polish:

- Original visual identity tokens.
- Tester-visible title and tagline.
- Icon and launch asset checklist.
- Title/menu hierarchy and readability.
- Confirmation that gameplay rules remain unchanged.

## Expected automated validation

```bash
swift build
swift test
```

Mobile build:

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

Pending implementation. The final matrix must include:

1. Title surface clearly says Flyby Nighter.
2. Tagline is visible and original.
3. Route selection remains obvious.
4. Release identity remains visible before testing.
5. Reset and mute guidance remain available.
6. Help text is more readable than the M5/M6 dense paragraph form.
7. Result screens still show replay/change-route guidance.
8. No copied legacy arcade assets, names, exact palettes, or UI compositions are introduced.
9. macOS, iPhone, and iPad title/help surfaces remain readable.

## Completion gate

M7 is complete after:

1. `SPEC-0031`, `SPEC-0032`, and `SPEC-0033` are implemented.
2. Automated validation passes.
3. Manual visual identity validation passes.
4. The M7 milestone is marked Completed.
