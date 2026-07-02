# SPEC-0015: M1 Playtest Validation

Status: Proposed  
Milestone: M1

## Goal

Define a repeatable validation process for M1 so game-feel and pacing changes can be judged consistently instead of relying on vague impressions.

## Scope

This spec covers manual validation plus the required automated commands for M1.

## Non-goals

- No analytics pipeline.
- No remote playtest system.
- No final QA matrix.
- No App Store release checklist.

## Required local commands

Run these before marking any M1 slice complete:

```bash
swift test
swift run FlybyNighterMac
```

## Manual playtest script

Run at least three attempts after any meaningful tuning change.

For each attempt, record:

- Did the run start correctly?
- Was movement understandable?
- Was firing understandable?
- Was the route progress readable?
- Was the current route section readable?
- Did the first threat feel fair?
- Did at least one gift appear reachable?
- Did active power feedback make sense?
- Did HP or score feedback make sense?
- Did the run end clearly?
- Did restart work immediately?

## Outcome categories

Record each attempt as one of:

- Complete: reached the end of the route.
- Learned: did not complete, but the reason was understandable.
- Confusing: did not understand what happened.
- Blocked: technical issue prevented play.

## Acceptance criteria

An M1 implementation slice can be considered valid when:

1. `swift test` passes.
2. `swift run FlybyNighterMac` launches.
3. The reviewer can complete or meaningfully learn from at least one of three attempts.
4. Any confusing outcome is documented with a likely cause.
5. Deferred polish is explicitly listed.

## Validation note format

Each M1 implementation note should include:

```text
Validation:
- swift test: passed/failed/not run
- swift run FlybyNighterMac: passed/failed/not run
- Manual attempts: N
- Outcome summary:
- Confusing moments:
- Deferred polish:
```

## Deferred polish

- Formal usability study.
- Input latency instrumentation.
- Automated screenshot tests.
- Recording capture workflow.
