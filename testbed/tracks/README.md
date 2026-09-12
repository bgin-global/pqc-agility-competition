# Calibration tracks (draft v0)

> Status: **PROPOSED — structure only, pending `decisions/0001-open-benchmark-model.md` at W2.** A track is the unit in which the testbed runs as an open benchmark during Phase A / A2. The model, the boundary with the prize evaluation, and the rulings that block are in [`docs/AUTORESEARCH.md`](../../docs/AUTORESEARCH.md). No track is open until its decision record says so.

## What a track is

One directory, one contract:

```
testbed/tracks/<track>/
  benchmark.json     the manifest: editable paths, pinned commands, score file, direction, promotion bar, runner
  RULES.md           what may be edited, the score formula, the anti-overfitting rule, what the track is not
  runner.json        the runner specification the score is valid on (CPU class, threads, caps, sandbox)
  fixtures/          corpora, key sets, seeds — public, with provenance; or a README saying what is pending
  promoted/          one directory per promotion: the result document, the attestation, the public note
```

The manifest is deliberately the shape used by existing open benchmarks, so that a solver — or an agent harness — that already knows the pattern can run a track without new tooling, and so that a self-hosted validator meets the same contract. The runner is the testbed's own nodes; a hosted development runner (T0) exists so a solver can pre-flight the exact validator step before spending node time.

## Lifecycle

| State | Meaning | Who moves it |
|---|---|---|
| `proposed` | directory exists; manifest and rules drafted; fixtures may be pending | anyone, by PR |
| `open` | a decision record opened it; the promotion bar and runner are fixed; submissions accepted | committee vote |
| `frozen` | no further promotions; the promoted history is the record | committee vote (before the host's application deadline for anything the call cites) |
| `closed` | superseded or withdrawn | committee vote |

## Promotion

A submission is **accepted** when the T0 runner validates it (build pinned, gates pass, schema-valid result). It is **promoted** when the reproduction protocol of [`HARNESS.md`](../HARNESS.md) §5 holds — reproduced on at least k nodes in at least two regions within the track's tolerance band — and its scalar beats the incumbent by more than `minScoreImprovementBips`, which is set equal to the tolerance band. The promoted submission's implementation becomes the track's reference implementation; its run is the reference run that the rubric's baselines cite.

## Notes

Every submission carries a public note from [`SUBMISSION_NOTE_TEMPLATE.md`](SUBMISSION_NOTE_TEMPLATE.md): at least 5 KiB, the exact underlying model and the harness named, effort level, setup, hypothesis, files changed, commands, measured results, failures, next step. The note is stored under `promoted/` when the submission is promoted, and is the record of who — human or agent — did what.

## What a track is not

It is not the competition, it carries no prize, and a promotion is not an evaluation of anyone's entry. Prize entries are measured and attested under the host's rules; they are never promoted into one another and no leaderboard of entries is published by this repository.

## Tracks

| Track | Metric → scalar | Status | Decision |
|---|---|---|---|
| [`T1-verify-single`](T1-verify-single/) | M-04 median single verify vs. B-01, lower is better | proposed | 0001 (model), 0002 (k, tolerance) |
| `T2-verify-batch` | M-05 per-signature batch verify at n = 1024 vs. B-01 | planned (W5) | — |
| `T3-legacy-continuity` | M-21 pass/fail gate + cost | planned (v1 harness) | — |
| `T4-agility-switch` | M-14 switch cost with M-13 rollback as a gate | planned (v1 harness) | — |
