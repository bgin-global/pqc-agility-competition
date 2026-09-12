# The calibration harness (draft v0)

> Status: **PROPOSED, runnable as plumbing.** This directory is the dual-agent harness instance that runs the testbed's calibration tracks as described in [`docs/AUTORESEARCH.md`](../docs/AUTORESEARCH.md) §5b: the *proposer* is a submitter, the *prover* is a testbed node, and the Gap between them is the fixture draw. It lives in this repository so that the instrument is part of the record — anyone can re-run a round and re-derive every seed from the saved bytes. It opens for real rounds only when a track opens (`decisions/0001`, `0002`) and the harness v0 of [`testbed/HARNESS.md`](../testbed/HARNESS.md) §7 exists.

## Two halves

```
harness/
  UPSTREAM.json     the pin: upstream repository, commit, distribution path, sha256 per vendored file, known defects
  upstream/         the agentprivacy dual-agent harness, default distribution, vendored VERBATIM at the pinned commit — NOT editable here
  instance/         the pqc-calibration instance — the editable half, and the record
```

**`upstream/`** is synced, never edited. `scripts/sync-harness.sh <checkout> [commit]` generates the distribution with the upstream's own `tools/make_default.mjs` in a clean temporary worktree at the pinned commit (the distribution is not tracked upstream — it is derived from the commit, so what lands here never depends on the state of anyone's working tree), replaces `upstream/`, and rewrites `UPSTREAM.json`; it refuses to run while `instance/` has uncommitted changes. `scripts/sync-harness.sh --verify` recomputes every hash. This is the same discipline the community benchmark CLIs call `sync --harness-only`: the non-editable files follow upstream, the editable paths are preserved exactly.

**`instance/`** is the pqc-calibration instance scaffolded by the upstream's own `tools/new_instance.mjs` and then filled: `harness.config.mjs` (the Gap first, then the objective, the gates, the lenses, the seat prompts, the schemas, the conformance checks), `tools/measure.mjs` (the counting rule as code), `frontier.json` (the only place numbers live), `claims_register.md`, `manifest.yaml`, `notes/`, `runs/` (every round's saved bytes), `chronicles/`. Its README says what it is and what it is not.

## Lineage

Upstream: **[`mitchuski/agentprivacy-harness`](https://github.com/mitchuski/agentprivacy-harness)** (Apache-2.0), `dist/default-harness` at the commit in `UPSTREAM.json` — the engine, the seats, the constitution (`GROUND_RULES.md`, `TRUSTS.md`, `SEAT_CONTRACT.md`), three drivers, the tools, three examples. No results, no fleet: the record starts here. The harness is one of the conveners' lanes and is disclosed as such under [`evaluation/COI_POLICY.md`](../evaluation/COI_POLICY.md); the public attribution form is *Harness: \<runtime\> with the agentprivacy dual-agent harness (pqc-calibration instance)*.

A convener's local working copy of the instance (scaffolded from the upstream checkout itself, where real rounds run against a model) carries the same `instance/` files; validated rounds are published back here by the keystone. The repository copy is canonical; the local copy is where the door stays shut until the First Person opens it (T6).

## Run it

```bash
scripts/sync-harness.sh --verify                                     # the pin holds
(cd harness/upstream && node tools/check.mjs)                        # the vendored engine passes its own eleven gates
node harness/instance/tools/measure.mjs                              # the counting rule (reports UNMEASURED until harness v0 exists)
(cd harness/upstream && node engine/conform.mjs ../instance)         # conformance — FAILS today on the unmeasured baseline, by design
(cd harness/upstream && node drivers/run.mjs --instance ../instance --driver stub --run smoke)   # one round, no model: seeds derive, files land
(cd harness/upstream && node tools/verify_run.mjs ../instance smoke) # re-derive every seed and draw from the saved bytes
scripts/ci/check-harness.sh                                          # what CI runs: pin · upstream gates · instance (conformance reported, enforced once the baseline is measured)
```

The stub rounds on record (`instance/runs/smoke/`, pre-fix; `instance/runs/smoke-v2/`, post-fix) show the plumbing: four proposals (one per lens), each with `proposal_canon.json` whose sha256 is `hProposal`, a `gap.json` whose `seedHex = sha256(hSource ‖ hProposal ‖ salt)` with `hSource` = the digest of `testbed/tracks/T1-verify-single/benchmark.json`, a 10,000-index draw from a bank of 65,536, and a verdict of MIRAGE (the stub never validates). `verify_run` passes on it.

## What is known to be wrong

`UPSTREAM.json` carries `knownDefects` — and their fixes. Two were found on the first stub round (`instance/runs/smoke/`): the draw took one byte per pick (biased for a large bank — a 10,000-draw from 65,536 never passed index 10,230) and the seed expansion counter was one byte. Both were fixed upstream the same day (`ea25f42`, draw v2: 32-bit rejection-sampled picks, a 4-byte counter, `drawVersion` recorded in every `gap.json`, v1 kept so older records replay) and vendored here by `scripts/sync-harness.sh`; `instance/runs/smoke-v2/` shows the draw reaching the top of the bank. `instance/notes/UPSTREAM_DEFECTS.md` keeps the record of the finding.

## What it is not

It is not the competition's evaluation. Prize entries are measured and attested under the host's rules and never promoted into one another; this instance runs calibration tracks, which carry no prize. It is also not a substitute for the testbed nodes: until real nodes are seated, the assay seat runs on the T0 development runner and every verdict is a claimed score, never a promotion.
