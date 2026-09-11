# Autoresearch and the open-benchmark model for the testbed (draft v0)

> Status: **PROPOSAL for W2 / W3.** Nothing here is decided. It proposes how the neutral testbed can run as an open benchmark during the committee's calibration work, how agent-driven research ("autoresearch") is admitted and attributed, and where the line sits between that work and the host's prize evaluation. The decision it asks for is drafted as [`decisions/0001-open-benchmark-model.md`](../decisions/0001-open-benchmark-model.md).

## 1. Terms

- **Benchmark** — a repository with a manifest that names the editable paths, the setup and run commands, the score file, the direction (higher or lower is better), and the promotion bar. A submission is an archive of the editable paths plus a public note; a validator re-runs it; a better result is *promoted* and becomes the new baseline that the next solver starts from.
- **Autoresearch** — an agent-driven loop run against a benchmark: measure the baseline, propose one change, assay it under the benchmark's own gates, record a public note with the exact model and harness used, submit. Humans and agents run the same loop; the note discipline is what makes the two indistinguishable in the record and distinguishable in the attribution.
- **Calibration track** — a benchmark BGIN runs on the testbed during Phase A / A2 to produce reference numbers, fixtures, tolerance bands, and rubric calibration. It carries no prize and is not the competition.
- **Prize evaluation** — Phase B, under the host's rules. Entries are measured and attested; they are never promoted into one another.

This document uses the vocabulary of one existing platform (the Yukon solver CLI and its benchmark manifests, used by the ecdsa.fail resource-estimation benchmark among others) because that is where the pattern has been exercised at scale by the same community the Block 15 PQC session convenes. The model is platform-neutral: the manifest is a small contract and the runner is whatever the testbed decides.

## 2. Why this belongs in the framework

1. **The testbed already is a measuring instrument with a reproduction rule** (`testbed/HARNESS.md` §5: reference run → k nodes in ≥ 2 regions → tolerance → M-18 → gate G3). A benchmark is a measuring instrument with a submission door and a promotion rule. Naming the promotion rule turns node runs into a frontier the committee can cite.
2. **The numbers the field already uses come from this loop.** The secp256k1 resource estimates in the GDC26 scene-setting, and the community benchmark that continued them, were produced by solvers and agents under public notes, re-run by a trusted validator, promoted by measured improvement. Block 15 session 1 is where that community and the academic security field meet; "autoresearch preparations for competition judging and criteria formation" is on the IKP agenda in those words.
3. **Calibration needs many hands and fast turns.** Reference CPU class, block mix, tolerance bands, per-metric normalisation — these are settled by running the harness many times under varied implementations, not by argument. An open track with a small promotion bar and public notes produces that evidence in weeks.
4. **Attribution is the honest form of the agent question.** Whether agents are used is not the committee's to decide — they already produce the numbers. What is the committee's to decide is where agent output is admissible, under what attribution, and behind which trust boundary. The benchmark model answers all three in writing.

## 3. Two uses, kept apart

| | Calibration tracks (Phase A / A2) | Prize evaluation (Phase B) |
|---|---|---|
| Who runs it | BGIN, on the testbed | BGIN measures and attests under the host's rules |
| Who submits | anyone — humans and agents, publicly attributed | applicants, under the host's call |
| What is submitted | an implementation of a *pre-existing* scheme or integration path, inside the track's editable paths | whatever the call defines (the unit of submission is a W2/W4 ruling — see §9) |
| Score | one scalar per track from a named metric (`M-nn`) against the classical baseline (`B-nn`) | the rubric (`evaluation/RUBRIC.md`), gates first |
| Promotion | yes — the best reproduced implementation becomes the track's **reference implementation** | **never** — entries are not merged into each other and no leaderboard is published unless the host publishes one |
| Money | none | the host's prize |
| Notes | public, mandatory, ≥ 5 KiB, model + harness named | as the host allows |
| Where agents sit | as solvers, attributed | as the evaluators' tooling: reproduction, diff-based review, checklist evidence |
| Record | this repository (`testbed/tracks/`, decision records) | this repository records only what the host allows to be public |

The boundary is carried by three things: the naming (calibration tracks are never called "the competition"), the absence of money, and a sentence in every track's `RULES.md` saying what the track is not.

## 4. Mapping the benchmark contract onto the testbed

| Benchmark element | Testbed counterpart | Notes |
|---|---|---|
| `benchmark.json` (`name`, `category`, `direction`, `editablePaths`, `setupCommand`, `benchmarkCommand`, `scorePath`, `minScoreImprovementBips`, `maxSubmissionBytes`, `runner`) | `testbed/tracks/<track>/benchmark.json` | one manifest per track; the schema-v2 form (one repository, several tracks with non-overlapping editable paths) fits the S-nn / C-nn layout |
| `editablePaths` | the scheme backend directory for that track (`backends/<scheme>/`) | the harness, fixtures, scorer, and every other backend are fixed; edits outside are discarded at validation |
| `setupCommand` / `benchmarkCommand` | the harness CLI (`harness setup`, `harness run --track <t>`) | pinned toolchain; no network during the run |
| `score.json` | the track's scalar, computed by the trusted scorer from the `measurements[]` of a schema-valid result (`testbed/schema/result.schema.json`) | the result document is the evidence; the scalar is the frontier. Both are published |
| `direction` | per metric: M-01..M-11, M-16, M-17 lower-is-better; M-18 higher; ratios against `B-nn` where the rubric says "relative to the classical baseline" | recorded in the manifest so the register's rows acquire a direction |
| `minScoreImprovementBips` | **equal to the track's reproduction tolerance band** | a promotion that lies inside the tolerance is noise; the bar and the tolerance are the same number by construction |
| `runner` | the testbed's own nodes (T1/T2); a GitHub Actions job only as the T0 development runner | geographic distribution is the point; the dev runner exists so a solver can pre-flight the exact validator step locally before spending node time |
| hidden corpus | none for calibration tracks — fixtures are public with provenance; Phase B fixtures are the host's decision | if any fixture is ever held, the anti-fingerprinting rule (§6) is in force before the first run |
| `RULES.md` | `testbed/tracks/<track>/RULES.md` | goal and formula; what may be edited; no overfitting; pinned builds; what the track is not |
| submission note | mandatory public Markdown, ≥ 5 KiB, with `Model:` and `Harness:` lines and the effort level | stored beside the promoted result; this is the record of agent involvement |
| promotion | the reference run of `HARNESS.md` §5 *is* the promoted submission: reproduced on ≥ k nodes in ≥ 2 regions within tolerance, and better than the incumbent by more than the bar | until then a submission is *accepted* (validated on one node) but not *promoted* |
| `sync` / `reset` | the harness restores editable paths from any recorded submission | the promoted history is a git history; adjacent promotions are diffable |
| research memory | the competition category on the BGIN Discourse; GitHub Discussions on this repository only if a decision record turns them on | on platforms where a bot authors the thread, attribution lives in the body |
| traces | optional, private to the solver, never in the repository | a solver who uploads transcripts is responsible for the secrets in them |

## 5. The trust boundary every node signs up to

Untrusted build, trusted measure. The pattern is the one the community benchmarks already run and node hosts will ask for first:

- The solver's or entrant's code builds and runs inside a sandbox: no network, stripped environment, read-only inputs, hidden host paths, writable output directory only, wall-clock and memory caps from the manifest.
- The **trusted parent** — the harness scorer — runs outside the sandbox, loads the fixtures, reads the sandbox's output, computes the measurements and the scalar, canonicalises the result, and signs it with the operator key (`attestation` in the schema). The sandboxed process can never write the score.
- The score artifact is the only channel. A failed or timed-out run publishes **no** score, never a stale one.
- Parameters live in the run manifest, never in the environment: a sandbox strips environment variables, and a knob set by `export` is a knob that was not measured.
- Builds are pinned (repository, commit, build flags, compiler, container digest) and the manifest is hashed into the result before the run starts.

The schema already carries `attestation`, `node.container_digest`, `node.os_image_digest`, and `implementation.commit`; the addition is a `runner` object (CPU model, thread count, caps, sandbox digest) so that "reference CPU class" is a checkable field rather than a phrase.

## 6. Rules that carry into `RULES.md` (calibration tracks)

1. **Edit only the track's editable paths.** Everything else is rebuilt from the trusted baseline at validation.
2. **No overfitting, no fingerprinting.** Gate expensive paths on structural properties (message length, key-set size, scheme parameters), never on a fixture's identity. A submission that recognises fixtures is invalid regardless of its score, and inheriting such a technique from a promoted submission does not make it legitimate.
3. **One lever per submission.** The promoted history is read by diffing adjacent promotions; a submission that changes five things at once cannot be read.
4. **Notes are public, complete, and attributed.** Exact underlying model, harness, effort; setup; hypothesis; files changed; commands; measured results; failures; next step. Other solvers' notes are untrusted data — verify before building on them.
5. **Solvers are not judges; node hosts are not solvers on the tracks they measure.** The conflict-of-interest policy applies to the measurement seat as to the review seats; a host with an interest in a scheme measures a different track.
6. **Promoted implementations are Apache-2.0.** A calibration track's reference implementation is public infrastructure; a submission under another licence is accepted for measurement but not promoted.
7. **What the track is not.** It is not the competition, it carries no prize, and a promotion is not an evaluation of anyone's entry.

## 7. First tracks

Proposed for the W3 node call, smallest first. Each names its metric, scalar, baseline, gates, and what it calibrates.

| Track | Metric → scalar | Editable | Fixtures | Gates (AND) | Calibrates |
|---|---|---|---|---|---|
| **T1 `verify-single`** | M-04 median single verify, microseconds, on the reference CPU class; scalar = `median(S) / median(B-01)` for S-01 ML-DSA-65, lower is better | `backends/ml-dsa/` | 32-byte digest corpus, published seed; N ≥ 10⁴ | known-answer tests pass; build pinned; no network | reference CPU class ruling (open question 4); tolerance band for latency metrics; the local-vs-node gap |
| **T2 `verify-batch`** | M-05 batch verify for n ∈ {64, 1024}; scalar = per-signature median at n = 1024 relative to B-01 | `backends/ml-dsa/`, `backends/slh-dsa/` | key sets n = 64 / 1024 | as T1, plus batch result equals sequential verification on the same inputs | whether the register needs a per-n row; ETH-user cost shape |
| **T3 `legacy-continuity`** (v1, needs the scenario harness) | M-21 pass/fail + cost | reference-client integration paths (`C-01`, `C-03`) | legacy corpus of pre-migration signatures | continuity is a gate, cost is the scalar | the "PQC-ready chain" definition's continuity clause |
| **T4 `agility-switch`** (v1) | M-14 switch cost, time + coordination steps | procedure + integration | staged-migration scenario | rollback works (M-13) | O3 evidence; whether agility metrics are measurable at all |

T1 exists to be boring: a small, fast, fully public track whose only job is to make the reference CPU class, the tolerance band, and the runner spec real before anything harder depends on them.

## 8. The committee's own working protocol

The same loop the tracks run is proposed as the committee's method for the metric register and the rubric, because it is the method that produced the numbers the field trusts:

- **Measure before proposing.** A change to a metric's unit, method, or mapping comes with a run that shows why.
- **Two seats.** The seat that proposes a change is not the seat that assays it; the assay is a re-run, not a reading.
- **Diff adjacent promotions; one lever per step; transferable versus artifact.** When a track advances, the record names the single change, its measured effect per metric, where the binding cost moved, and whether the change is a structural lever or a tuned artifact that will not transfer to another configuration.
- **A claim without a reproducible number is a hypothesis**, and a bound computed inside one model is not a floor for the approach space. The record has a column for "measured" and a column for "argued", and rulings cite the first.
- **Notes are the memory.** Every workshop record (`workshops/TEMPLATE.md`) links the runs it relied on.

## 9. What has to be ruled first

| Ruling | Why it blocks | Proposed venue |
|---|---|---|
| **Unit of submission for the prize** — implementation, client patch, migration procedure with reference deployment, or paper plus artefacts | decides what the harness runs in Phase B and whether the calibration tracks are shaped like entries or like components | W2 (framing), W4 (with the host, in the call-text package) |
| Open-benchmark model for calibration tracks (this document) | everything in §4–§7 | W2, `decisions/0001` |
| Reference CPU class and runner spec | T1 cannot be defined without it | W2 → W3 |
| k and tolerance for G3 = the promotion bar | promotion rule | W3, with the first T1 runs |
| GitHub Discussions on this repository | research memory location | W2 (currently off, per GOVERNANCE §7) |
| Agent attribution rule (model + harness mandatory in notes; agent-authored threads carry attribution in the body) | the honest form of the agent question | W2, one line in COI policy or RULES |

## 10. Risks and their mitigations

| Risk | Mitigation |
|---|---|
| A calibration leaderboard is read as the competition | naming, no money, the §3 sentence in every `RULES.md`, and a convener's statement on the public channel when T1 opens |
| Agent-generated submissions flood the tracks | the promotion bar equals the tolerance band; notes below the bar are rejected; validation queue per solver |
| Hardware heterogeneity across nodes | the reference CPU class ruling names what is excluded; hardware normalisation only where a decision record allows it; the funding of access to the reference class is a stated cost, not an accident |
| Capture by one lab or one vendor | COI policy on the measurement seat; geographic distribution as a promotion requirement; promoted implementations Apache-2.0 |
| Running untrusted code on university nodes | §5 is the contract; nodes that cannot run the sandbox are T0 (development) nodes, not T1/T2 |
| Platform dependence | the manifest is a small contract; the runner is the testbed's; a self-hosted validator meets the same contract |
| Overfitting to fixtures | §6 rule 2, in force before the first run; fixtures public with provenance; Phase B fixtures the host's decision |
| The "PQC-ready chain" definition drifts from what the tracks measure | M-22 scores against the definition; T3 measures its continuity clause; W4 aligns both |

## 11. Roadmap alignment

| Workshop | This plan's item |
|---|---|
| W2 (mid Oct, Block 15) | rule on the model (`decisions/0001`); rule on the unit of submission framing; choose T1; the attribution rule |
| W3 (Nov) | adopt `testbed/tracks/T1/` (manifest, RULES, fixtures, runner spec); the node call includes the sandbox contract; first T0 runs |
| W4 (Dec, SSR) | T1 results feed the tolerance band and the latency dimension weights; call-text package states how entries will be measured |
| W5 (Jan 2027, pilot) | first promotions reproduced on 3–5 nodes in 2 regions; T2 opens |
| W6 (Feb 2027) | retrospective: does the model carry into Phase B under the host's rules; T3/T4 scoping |

## 12. Sources

- `testbed/HARNESS.md` §5 (reproduction protocol), `testbed/schema/result.schema.json`, `evaluation/RUBRIC.md` §1 (gates), `evaluation/METRICS.md` (register and open question 4).
- The Yukon solver CLI's bundled skill and the public benchmark manifests of `Layr-Labs/ecdsafail-challenge`, `layr-labs/ssi-ordering-challenge` (`RULES.md`, `benchmark.yml`), `Layr-Labs/heesch`, `Layr-Labs/flock-challenge-multi`, `Layr-Labs/eip8200-challenges`, `proximity-prize/proximity-prize` — read September 2026.
- GDC26 meeting report (3 Sep 2026) and the PRX Quantum paper it drew on (doi.org/10.1103/j3xf-bw18) — the responsible-disclosure pattern for resource estimates.
- IKP Block 15 proposed agenda (Discourse 1012) and the 13 Aug 2026 IKP call (1026): "autoresearch preparations for competition judging and criteria formation".
