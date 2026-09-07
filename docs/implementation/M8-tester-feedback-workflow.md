# M8 Tester Feedback Workflow

Status: Implementation complete; validation pending

## Feedback goal

Every tester report should include enough build and platform context to reproduce or triage the issue without collecting private data or telemetry.

## Required fields

- Release identity
- Feedback token, if copied from the manifest or title surface
- Platform: macOS, iPhone Simulator, iPad Simulator, or device if manually installed later
- Input mode: keyboard, mouse, touch, or mixed
- Route: Neon Rift or Glass Tide
- Category: blocker, regression, usability, visual, or polish
- Expected behavior
- Actual behavior
- Reproduction steps
- Optional screenshot or short recording

## Triage categories

| Category | Meaning |
|---|---|
| blocker | Prevents launch, play, validation, or bundle use. |
| regression | Previously accepted M4-M7 behavior is broken. |
| usability | A tester can proceed, but the interaction is confusing or slow. |
| visual | Readability, layout, color, scale, or title/menu polish issue. |
| polish | Minor improvement that does not block a first-tester build. |

## Privacy and data minimization

Testers should not include:

- secrets
- private documents
- unrelated logs
- Apple ID details
- personal contact data beyond the intended feedback channel
- analytics IDs or telemetry payloads

M8 does not add automatic report upload, telemetry, analytics, or crash-reporting SDKs.

## Maintainer intake checklist

1. Confirm the release identity or manifest commit.
2. Confirm platform and input mode.
3. Reproduce using the route and steps provided.
4. Classify severity and category.
5. Decide whether it blocks first-tester sharing.
6. Convert accepted issues into the next milestone scope.
