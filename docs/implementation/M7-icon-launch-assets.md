# M7 Icon and Launch Asset Checklist

Status: Validation pending

## Purpose

Define safe first-tester visual asset guidance without committing final binary artwork or App Store marketing assets in M7.

## Originality guardrails

Allowed:

- Original night-flight, neon-rift, and glass-tide motifs.
- Abstract ship silhouettes that do not copy legacy arcade ship shapes.
- Original color use based on the M7 visual identity palette.
- Simple geometric route, rift, starfield, or cockpit-light compositions.
- Generative or hand-drawn artwork that is reviewed before commit.

Not allowed:

- Protected legacy arcade names, enemy silhouettes, ship layouts, stage compositions, logos, fonts, audio cues, or UI screens.
- Direct copies or close variants of recognizable arcade screenshots.
- Third-party copyrighted art.
- Unreviewed binary art pushed directly into app targets.

## App icon direction

Future icon work should follow this brief:

- Square composition.
- Works at 1024x1024 and small home-screen sizes.
- Keeps critical shapes inside safe margins.
- Uses a dark `void` background with one strong `rift-cyan` or `tide-gold` focal accent.
- Reads as an original night-flight arcade game, not a clone of a specific legacy title.
- Avoids text inside the icon.

## Launch/title surface direction

First-tester launch/title presentation should:

- Show `Flyby Nighter` clearly.
- Show the M7 tagline: `Arcade night flight, rebuilt for first-testers.`
- Preserve the M6 release identity.
- Preserve route selection, reset, and mute discoverability.
- Avoid dense paragraphs where short grouped lines are possible.

## Placeholder policy

M7 may keep placeholder shapes and generated SpriteKit primitives for first-tester builds. Final binary art should be introduced only after:

1. explicit asset approval,
2. originality review,
3. size/safe-area checks,
4. macOS/iPhone/iPad validation,
5. documentation update.

## Deferred work

- Final app icon PNGs.
- Xcode asset catalog replacement.
- App Store marketing screenshots.
- Launch screen storyboard/SwiftUI polish.
- TestFlight or public beta distribution art.
