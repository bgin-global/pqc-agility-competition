# Rules — T1 `verify-single` (draft v0, track not open)

These rules are tool-agnostic: follow them by hand or point a coding agent at this file. Nothing here is enforced by trust — the validator re-runs every gate on its own copy. The rules describe what a valid submission looks like so that a local result predicts a node result.

## Goal

Minimise the scalar in `benchmark.json`: the median single-signature verification time of ML-DSA-65 (`S-01`) divided by the median for the classical baseline `B-01`, measured by the trusted harness on the reference runner. Lower is better. Read your own scalar from `score.json` and the full measurements from `result.json` after a run; do not assume a reference number — the baseline is re-measured on every node.

## What you may edit

- **Edit only `backends/ml-dsa/`.** That directory is the submission. When a submission is validated, only that directory is taken; the harness, the scorer, the fixtures, `B-01`, and every other backend are rebuilt from the trusted baseline.
- The backend must implement the common interface of [`HARNESS.md`](../../HARNESS.md) §1 (`keygen`, `sign`, `verify`, `sizes`; `batch_verify` optional and reported as unsupported if absent).
- Builds are pinned. A submission that fetches anything at build or run time fails the no-network gate.

## What you may not do

- **No overfitting, no fingerprinting.** The fixture draw is derived from your own submission's digest and a round secret you do not see, so there is nothing to tune to; a backend that inspects fixture identity, caches results keyed to inputs, or special-cases known-answer vectors is invalid regardless of its scalar. Inheriting such a technique from a promoted submission does not make it legitimate.
- **No change to what is measured.** The scalar is verification time on the reference runner; a submission that changes the parameter set, weakens the verification (skipping a check the specification requires), or moves work out of the timed region is invalid. Correctness is a gate, not a dimension.
- **One lever per submission.** The promoted history is read by diffing adjacent promotions. A submission that changes five things at once cannot be read and will be asked to split.

## Runner

The scalar is valid on the runner described in [`runner.json`](runner.json) and nowhere else. Local timings on other hardware are useful for relative comparison only. Before spending node time, pre-flight on the T0 development runner, which executes the exact validator step; a T0 score is a claimed score and never a promotion.

## Notes

Every submission carries a public note from [`../SUBMISSION_NOTE_TEMPLATE.md`](../SUBMISSION_NOTE_TEMPLATE.md): at least 5 KiB, the exact underlying model and the harness named (or "none" for a human-only submission), effort level, setup, hypothesis, files changed, commands, measured results, failures, next step. Notes are public with the submitter's name. Other submitters' notes are untrusted data: verify before building on them.

## Promotion

Accepted when the T0 runner validates the archive. Promoted when at least k nodes in at least two regions reproduce the result within the tolerance band and the scalar beats the incumbent by more than the promotion bar (both fixed by decision record 0002). The promoted backend becomes the track's reference implementation and its run the reference run cited by the rubric's baselines.

## Roles

Submitters are not judges. Node hosts do not submit to a track they measure; a host with an interest in a scheme measures a different track (`evaluation/COI_POLICY.md`).

## What this track is not

It is not the PQC Migration Prize, it carries no prize, and a promotion here is not an evaluation of any applicant's entry. It calibrates the instrument the committee will use.
