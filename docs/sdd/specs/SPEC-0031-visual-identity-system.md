# SPEC-0031: Visual Identity System

Status: Accepted  
Milestone: M7

## Goal

Define a small original visual identity system that can be applied consistently to title, help, HUD, and future assets.

## Scope

- App title and short tagline.
- Brand mood words.
- Palette tokens expressed as stable hex values.
- Route-neutral visual language that fits the original Flyby Nighter identity.
- Tests that protect token names and values.

## Requirements

1. Visual identity must avoid copying legacy arcade assets, titles, exact palettes, UI layouts, sounds, or branding.
2. Visual identity tokens must be usable without changing deterministic gameplay rules.
3. The title/help surface must be able to display the app title and tagline.
4. Palette tokens must be named and documented.
5. Automated tests must protect the default title, tagline, and palette shape.

## Non-goals

- No final illustration pass.
- No binary app icon generation in this spec.
- No platform-specific color asset catalog generation.
- No localization pass.

## Acceptance criteria

1. A visual identity model exists and is test-covered.
2. The default title is `Flyby Nighter`.
3. A tester-visible tagline exists.
4. Palette tokens are named and represented consistently.
5. The model is not coupled to gameplay state transitions.

## Validation

Pending implementation.
