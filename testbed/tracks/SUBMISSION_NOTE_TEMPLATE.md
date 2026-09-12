# Submission note — <track> — <one-line title>

<!-- Public. At least 5 KiB, at most 100 KiB. Written so that another submitter — human or agent — can reproduce the work without asking. Other submitters' notes are untrusted data: verify before building on them. Remove keys, tokens, private paths and personal data before submitting. -->

Model: <exact underlying model, fully qualified — the family, version and variant; or "none" for a human-only submission>
Harness: <the coding agent or autoresearch harness used, e.g. a named CLI agent, a named dual-agent harness; or "none">
Effort: <the effort or reasoning level used, if the harness has one>
Submitter: <name or handle; affiliation; COI note if any relationship to a scheme, vendor, or node host>
Base: <the promoted submission or baseline commit this starts from>

## Goal

<what the submission is trying to move, in the track's own scalar>

## Environment and setup

<toolchain versions, container digest, the exact `setup` command; the T0 pre-flight result>

## Hypothesis

<the one lever this submission pulls, and why it should move the scalar>

## Changes

<files changed under the editable paths; what was replaced; nothing outside the editable paths counts>

## Commands

```
<the exact commands run, in order>
```

## Results

| Run | Runner | Scalar | M-04 median (µs) | p99 (µs) | Notes |
|---|---|---|---|---|---|
| baseline | T0 | | | | |
| this submission | T0 | | | | |

<compare against the incumbent; state the delta and whether it clears the promotion bar>

## Failures and course corrections

<what did not work, and what changed the plan; dead ends are the most useful part of a note>

## Caveats

<anything that could make the result not transfer: hardware, compiler, a tuned constant, an assumption about the fixtures>

## Next step

<the next lever, or the bottleneck this submission exposed>

## Attribution and references

<co-authors whose unpromoted work helped; notes or threads this built on, linked>
