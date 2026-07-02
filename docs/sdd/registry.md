# SDD Registry

| ID | Title | Status | Milestone | Notes |
|---|---|---:|---|---|
| ADR-0001 | Originality and IP boundaries | Accepted | Foundation | Required constraint for every future spec. |
| ADR-0002 | Apple-first Swift and SpriteKit | Accepted | Foundation | M0 runtime target and architecture direction. |
| SPEC-0001 | Product brief | Proposed | Foundation | Defines the game identity and non-goals. |
| SPEC-0002 | M0 minimal playable version | Proposed | M0 | One map, player flight, shooting, enemies, obstacles, gifts, win/fail loop. |
| SPEC-0003 | Core gameplay loop | Proposed | M0 | Start, play, score, damage, death, win, restart. |
| SPEC-0004 | One-map world design | Proposed | M0 | Original first map, hazards, pacing, completion target. |
| SPEC-0005 | Player controls and firing | Proposed | M0 | Movement, aiming/firing model, input assumptions. |
| SPEC-0006 | Enemies, obstacles, and gifts | Proposed | M0 | First catalog of attackers, hazards, and powers. |
| SPEC-0007 | M0 acceptance tests and quality gates | Proposed | M0 | Manual and automated validation expectations. |
| SPEC-0012 | M1 game feel | Proposed | M1 | Movement, firing, powers, fairness, restart feel, route duration target. |
| SPEC-0013 | M1 map pacing | Proposed | M1 | Route sections, spawn timing, gift reachability, pressure ramp. |
| SPEC-0014 | M1 visual readability | Proposed | M1 | HUD, route progress, player feedback, gifts, hazards, overlays. |
| SPEC-0015 | M1 playtest validation | Proposed | M1 | Repeatable manual playtest script and validation note format. |
| SPEC-0016 | Apple app shell | Implemented | M2 | Native macOS, iPhone, and iPad shells validated with the shared SpriteKit scene. |
| SPEC-0017 | Touch controls | Implemented | M2 | Drag movement, hold-to-fire, safe-area layout, orientation, resizing, and lifecycle behavior validated. |
| SPEC-0018 | macOS controls | Implemented | M2 | Keyboard/click controls, focus recovery, pause/resume, and stale-input clearing validated. |
| SPEC-0019 | Audio event adapter | Implemented | M3 | Adapter-side mapping from deterministic core events to tested audio and visual cues validated. |
| SPEC-0020 | Placeholder SFX | Implemented | M3 | Original runtime-generated tones and mute behavior validated across app shells. |
| SPEC-0021 | Feedback events | Implemented | M3 | Brief flashes, pulses, HUD emphasis, and bounded camera impulses manually validated. |
| SPEC-0022 | Second route | Accepted | M4 | M4-A route catalog and Glass Tide deterministic content model implemented; playable selection and tuning pending. |
| SPEC-0023 | Score system | Proposed | M4 | Score-depth and optional combo rules remain to be decided. |
| SPEC-0024 | Local high score | Proposed | M4 | Local-only best-score persistence remains to be implemented. |

## Implementation rule

No gameplay code should start until the relevant milestone specs are accepted or explicitly narrowed for a spike.
