# pqc-calibration — the instance

The dual-agent harness instance for the testbed's calibration tracks (T1 `verify-single` first). Read [`../README.md`](../README.md) for the two halves and the lineage; read [`../../docs/AUTORESEARCH.md`](../../docs/AUTORESEARCH.md) §5b for why the testbed *is* this shape.

| Seat | Here |
|---|---|
| Measure | `tools/measure.mjs` — the counting rule as code; the runner executes it before every round and hands its JSON to every prompt. Today it reports `unmeasured` because the harness v0 (`testbed/HARNESS.md` §7) is not built. |
| Propose — soulbae 🧙 | a submitter: one lever through one lens, as a unified diff confined to `backends/ml-dsa/` plus a public note (≥ 5 KiB) with Model / Harness / Effort |
| Hold-apart — the Gap ⿻ | the fixture draw: `seed = sha256(hSource ‖ hProposal ‖ salt)`; `hSource` = the digest of the track's `benchmark.json` (the fixture bank's digest once it is published), `hProposal` = the canonical submission bytes, `salt` = derived from one secret per round that the proposer never sees; a sample of 10,000 indices from a bank of 65,536 |
| Assay — soulbis ⚔️ | a testbed node: re-derive the seed, materialise the candidate, run every gate, measure on the reference runner, sign the result; BLOCKED without executable evidence, never an imagined number |
| Critic | frontier archaeology: one lever, transferable or artifact, where the binding cost moved, one next lead |
| Chronicle | `templates/chronicle.md` upstream; drafts land in `runs/<id>/` and the keystone files them |
| Keystone (the First Person) | the only writer of `frontier.json`, `claims_register.md`, `manifest.yaml`; the door (submit, push, publish, node onboarding) |

## State

- `frontier.json` — **baseline unmeasured** (OT-1). Conformance fails on exactly that, by design; `scripts/ci/check-harness.sh` reports it and enforces conformance once a baseline is recorded.
- `runs/smoke/` — the stub round on record; `verify_run` passes (every seed re-derives).
- `notes/UPSTREAM_DEFECTS.md` — two engine defects found on the first round, reported upstream; T1 does not open on a biased draw.
- `claims_register.md` — C-PQC-1 (the draw makes fixture overfitting impossible by construction: **argued**, enforced by nothing yet) and C-PQC-2 (promotion = k attestations over one draw: **specified**).

## Conformance checks specific to this instance

`harness.config.mjs` `conformChecks` refuses a `frontier.json` in which the promotion bar is below the tolerance band, the salt scope is not `round`, a best is recorded with fewer attestations than `promotion.k`, or a baseline is recorded without the runner it is valid on — the four ways this instance could lie while looking green.

## What this is not

Not the prize evaluation; not a leaderboard of entries; not a substitute for the nodes. Every verdict on the T0 runner is a claimed score.
