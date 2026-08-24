# SPEC-0032: Icon and Launch Assets

Status: Validation Pending  
Milestone: M7

## Goal

Define safe, original icon and launch asset requirements for a first-tester build without committing to App Store-ready marketing artwork yet.

## Scope

- App icon direction and constraints.
- Launch/splash identity requirements.
- Required sizes/checklist for future binary assets.
- Originality guardrails.
- Documentation of deferred App Store art work.

## Requirements

1. Icon direction must be original and not reference protected legacy arcade ships, enemies, logos, names, or exact compositions.
2. Icon guidance must support square app-icon composition and safe inner margins.
3. Launch/splash guidance must preserve readable title and release identity.
4. Binary art generation or replacement must be a deliberate future task with explicit asset review.
5. M7 must document what is acceptable for first-tester placeholder identity.

## Implementation

`docs/implementation/M7-icon-launch-assets.md` defines:

- originality guardrails
- app icon direction
- launch/title surface direction
- first-tester placeholder policy
- deferred final art work

M7 intentionally does not add unreviewed binary artwork.

## Non-goals

- No App Store marketing screenshots.
- No App Store Connect metadata.
- No TestFlight setup.
- No generated binary artwork unless explicitly approved.
- No use of third-party copyrighted art.

## Acceptance criteria

1. The repository includes an icon/launch asset checklist.
2. The checklist includes originality guardrails.
3. The checklist includes square icon and launch/splash requirements.
4. First-tester placeholder policy is explicit.
5. The PR does not add unreviewed binary art.

## Validation

Implementation is in place. Manual checklist review remains before this spec can be marked Implemented.
