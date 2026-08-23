# M5 First Tester Handoff

Status: Draft validation guide  
Milestone: M5

## Purpose

This guide defines the repeatable handoff path for a first tester without adding App Store, TestFlight, notarization, analytics, or crash-reporting automation in M5.

## Supported shells

M5 first-tester validation covers:

- `FlybyNighterApp` macOS app shell.
- `FlybyNighterMac` secondary macOS executable shell.
- `Apps/FlybyNighterMobile/FlybyNighterMobile.xcodeproj` for iPhone and iPad Simulator or development-device testing.

## Clean local validation

```bash
git fetch origin
git switch m5-playtest-readiness
git reset --hard origin/m5-playtest-readiness

swift package clean
swift build
swift test
swift build --product FlybyNighterApp
swift build --product FlybyNighterMac
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

## Reset and quiet-test workflows

Reset best scores before a fresh playtest:

```bash
swift run FlybyNighterApp -- --reset-high-scores
```

Run quietly:

```bash
swift run FlybyNighterApp -- --mute-audio
```

Run a clean and quiet test:

```bash
swift run FlybyNighterApp -- --reset-high-scores --mute-audio
```

For iPhone/iPad, add the same launch arguments in the Xcode scheme:

- `--reset-high-scores`
- `--mute-audio`

These are adapter-layer launch affordances. They do not change deterministic gameplay rules in `FlybyNighterCore`.

## First-tester smoke matrix

Ask the tester to verify:

1. The title screen explains how to select routes.
2. The tester can start a run without reading repository docs.
3. The tester can move, fire, restart, and replay.
4. The tester can identify route-specific best scores.
5. The tester understands the score categories after a run.
6. The tester can select both routes.
7. The tester sees the Glass Shear warning before starting Glass Tide.
8. Audio is present by default.
9. Quiet mode works when launched with `--mute-audio`.
10. Reset mode clears best scores when launched with `--reset-high-scores`.
11. iPhone/iPad touch controls remain discoverable and usable.
12. No crash, stuck input, or unreadable overlay appears during a 10-minute session.

## Tester feedback template

Collect:

- Device and OS version.
- Shell tested: macOS app, macOS executable, iPhone, or iPad.
- First route selected.
- Whether route selection was understood without explanation.
- First score and best score observed.
- Whether scoring felt understandable.
- Whether movement/firing felt responsive.
- Whether the Glass Shear cue was understandable.
- Any unreadable text, cramped overlay, or confusing instruction.
- Any crash, freeze, audio issue, stuck input, or persistence issue.
- One suggested improvement before a wider test.

## Known M5 limitations

- No TestFlight automation.
- No notarized distributable.
- No App Store Connect metadata.
- No analytics SDK.
- No crash-reporting SDK.
- No online leaderboards.
- Local score persistence is per local app preferences domain.
