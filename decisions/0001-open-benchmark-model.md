# 0001 — Open-benchmark model for the testbed's calibration tracks

- **Status:** proposed
- **Date:** 2026-09-11 (drafted); for W2
- **Workshop / thread:** W2 (Block 15, 15–16 Oct 2026); thread to be opened in the *Post-Quantum Crypto Agility Competition* category
- **Method:** vote (for / against / abstain, quorum per `GOVERNANCE.md` §5)

## Context

The testbed specification (`testbed/HARNESS.md`) defines a reproduction protocol — a reference run reproduced on k nodes in two regions within a tolerance — but not how a reference run is chosen, how implementations improve over time, or how agent-driven work is admitted and attributed. The community that produces the resource estimates the field cites runs an open benchmark: a manifest, editable paths, a trusted validator, public attributed notes, promotion by measured improvement. The committee has to calibrate the metric register, the tolerance bands, and the runner specification before the host's call opens in January 2027, and that calibration is produced by running the harness many times under varied implementations. `docs/AUTORESEARCH.md` sets out the model and the boundary between calibration work and the prize.

## Decision

The testbed's calibration work (Phase A / A2) runs as open benchmark tracks: one manifest per track naming the editable backend paths, pinned commands, a scalar from a named metric against the classical baseline, a direction, and a promotion bar equal to the track's reproduction tolerance; submissions carry public notes with mandatory model and harness attribution; the reference run of `HARNESS.md` §5 is the promoted submission; untrusted build and trusted measurement are separated by a sandbox on every node. Calibration tracks carry no prize, are never called the competition, and prize entries (Phase B) are measured and attested but never promoted into one another.

## Consequences

- `testbed/tracks/<track>/{benchmark.json, RULES.md, fixtures/}` become part of the testbed specification; the result schema gains a `runner` object; the metric register's rows acquire a direction.
- `HARNESS.md` §5 is restated as the promotion rule; k and the tolerance band per metric class are the next decision (0002).
- `evaluation/COI_POLICY.md` gains the measurement-seat clause (node hosts are not solvers on the tracks they measure) and the attribution rule.
- The first track (T1 `verify-single`) is defined at W3 with the node call; `testbed/README.md` §T0 names the development runner.
- Out of scope: any leaderboard of prize entries; any use of calibration results as a judgement of an applicant.

## Recusals

none recorded yet — to be completed at the vote per `evaluation/COI_POLICY.md`; conveners with an interest in an autoresearch harness or platform disclose it before the vote.
