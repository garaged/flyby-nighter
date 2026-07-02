# M3 Audio and Feedback Validation

Branch: `m0-apple-scaffold`

## Implemented cue mapping

| Game event | Audio cue | Visual feedback |
|---|---|---|
| Player fired | Short high shot tone | Small yellow muzzle pulse |
| Enemy removed | Low impact tone | Brief orange flash and small camera impulse |
| Player damaged | Low damage tone | Red flash and stronger camera impulse |
| Gift collected | Rising pickup tone | Green flash and pulse around the ship |
| Shield used | Distinct shield tone | Cyan flash and pulse around the ship |
| Power expired | None | Subtle gray flash |
| Route completed | Completion tone | Green completion flash and small impulse |
| Run failed | Failure tone | Red failure flash and impulse |

All sounds are generated at runtime from original sine and harmonic combinations. No third-party or legacy audio assets are included.

## Architecture

- `FlybyNighterCore` continues to return deterministic `GameEvent` values.
- `GameEventFeedbackMapper` maps events in the SpriteKit adapter.
- `PlaceholderAudioPlayer` owns AVFoundation behavior and has a no-op fallback.
- `FlybyNighterScene` applies audio and bounded visual feedback.
- Mapper behavior is covered by `FlybyNighterSpriteKitTests`.

## Mute behavior

Audio can be disabled through either:

- `FlybyNighterScene.setAudioEnabled(false)`
- the `--mute-audio` launch argument

Examples:

```bash
swift run FlybyNighterApp -- --mute-audio
```

For the iOS target, add `--mute-audio` to the scheme launch arguments.

## Automated validation

```bash
swift package clean
swift build
swift test
```

Expected checks:

- Core tests remain green.
- Feedback mapping tests remain green.
- `FlybyNighterCore` has no AVFoundation or SpriteKit dependency.
- The macOS and mobile app targets compile.

## Manual playtest

Verify on macOS and at least one iPhone or iPad simulator/device:

1. Firing produces a short cue without masking gameplay.
2. Enemy removal is distinguishable from player damage.
3. Gift and shield cues are distinguishable.
4. Completion and failure cues are distinguishable.
5. Red/green/cyan flashes remain brief and do not hide hazards.
6. Camera impulses remain small and never leave the world layer offset.
7. Rapid firing does not create excessive visual clutter.
8. `--mute-audio` disables sound while visual feedback remains active.

## Remaining M3 work

- Local cross-platform audio and feedback validation.
- Tune volume, duration, and impulse strength from playtest observations.
- Decide whether a visible mute control belongs in a later settings milestone.
