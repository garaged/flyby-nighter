# M7: Visual Identity and Asset Polish

Status: Accepted  
Milestone: M7

## Goal

Give the first-tester build a clearer original visual identity without changing deterministic gameplay rules or prematurely doing final App Store distribution work.

M7 focuses on brand tokens, title/menu polish, icon/launch asset planning, and readability consistency across macOS, iPhone, and iPad.

## Scope

M7 includes:

- A documented original visual identity system.
- Testable brand/title copy and visual tokens.
- Title/menu presentation polish using the existing SpriteKit shell.
- Icon and launch asset requirements for future binary assets.
- First-tester visual consistency checks.

## Non-goals

- No App Store Connect metadata.
- No TestFlight automation.
- No notarization pipeline.
- No analytics or crash-reporting SDK.
- No copied legacy arcade art, names, layouts, audio, or UI identity.
- No new route, enemy, weapon, or scoring rules.
- No requirement to commit final binary artwork in this milestone unless explicitly approved.

## Required specs

M7 is governed by:

- `SPEC-0031-visual-identity-system.md`
- `SPEC-0032-icon-and-launch-assets.md`
- `SPEC-0033-title-and-menu-polish.md`

## Implementation slices

1. Visual identity token model and tests.
2. Title/help surface copy and layout polish.
3. Icon and launch asset checklist/documentation.
4. First-tester visual validation matrix.
5. Validation and milestone closure.

## Acceptance criteria

A reviewer can:

1. Identify the game as Flyby Nighter from the title/help surface.
2. Confirm the title/menu presentation uses consistent original visual language.
3. Confirm visual identity tokens are test-covered and separated from gameplay rules.
4. Follow an icon/launch asset checklist for future binary art.
5. Confirm the PR does not add copied or infringing retro-arcade assets.
6. Run `swift build`, `swift test`, and the iPhone/iPad Simulator build successfully.

## Validation

Pending implementation.
