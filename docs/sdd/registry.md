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
| SPEC-0016 | Apple app shell | Proposed | M2 | Real app shell, scene hosting, lifecycle basics, launch validation. |
| SPEC-0017 | Touch controls | Proposed | M2 | iPhone/iPad movement, fire, start, restart, and visibility rules. |
| SPEC-0018 | macOS controls | Proposed | M2 | Keyboard movement, firing, focus, start/restart, local playtest path. |
| SPEC-0019 | Audio event adapter | Proposed | M3 | Adapter-side mapping from game events to sounds. |
| SPEC-0020 | Placeholder SFX | Proposed | M3 | Original temporary sound effects for playtesting. |
| SPEC-0021 | Feedback events | Proposed | M3 | Visual feedback for major gameplay events. |

## Implementation rule

No gameplay code should start until the relevant milestone specs are accepted or explicitly narrowed for a spike.
