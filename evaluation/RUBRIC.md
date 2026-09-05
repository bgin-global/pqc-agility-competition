# Scoring Rubric (skeleton, draft v0)

> Status: **SKELETON — structure only; weights and thresholds are Workshop W2–W4 decisions.** The rubric consumes the metric register (`METRICS.md`). It is written to travel: competition → BGIN Standard → ISO/TC 307 → Japan crypto-asset security criteria.

## 1. Gates (must pass before scoring)

| Gate | Rule | Source |
|---|---|---|
| G1 — Primitive scope | The signature primitive is NIST-standardized or NIST-selected (or a committee-ruled hybrid / stateful hash-based scheme). No new primitives. | Briefing: "deploy NIST-selected / standardized PQC — not invent new PQC primitives"; GDC26: "using NIST-class schemes" |
| G2 — Target mapping | Evidence maps to Bitcoin and/or Ethereum (BTC-tx, ETH-user, ETH-cons, L2). | Briefing, Scope |
| G3 — Reproducibility | The reference run reproduces on at least k independent testbed nodes across at least 2 regions within tolerance (k, tolerance: decision record). | M-18 |
| G4 — Disclosure | Submitter COI and affiliations disclosed; evaluators for the round recused as required. | `COI_POLICY.md` |

## 2. Tracks and dimensions

| Track | Dimension | Metrics | Weight |
|---|---|---|---|
| (a) Theoretical security review | Assumptions, parameters, composition | M-19 | TBD |
| (a) | Key-management and migration-window threat model | M-19, M-20, M-21 | TBD |
| (a) | PQC-readiness substantiation | M-22 | TBD |
| (b) Implementation / performance | Verifier cost and latency | M-03, M-04, M-05, M-09 | TBD |
| (b) | Block / mempool overhead | M-01, M-06, M-07, M-08 | TBD |
| (b) | On-chain and L2 cost | M-10, M-16 | TBD |
| (b) | Decentralization cost | M-11, M-17 | TBD |
| (a+b) | Crypto-agility: switch, staged migration, rollback, legacy continuity | M-12, M-13, M-14, M-21 | TBD |
| (a) | Compatibility, wallet / UX | M-15 | TBD |
| (a) | Governance fit | M-20 | TBD |

## 3. Scoring conventions (proposed)

- Performance dimensions are scored **relative to the classical baseline** on the same node (delta or ratio), never as absolute numbers alone.
- Each dimension is scored by at least two evaluators; disagreements beyond one band go to the full committee.
- Qualitative dimensions use a published 5-band scale with written justification.
- Rationale is published with the score; that is what makes the result citable.

## 4. To decide (decision records)

- Weights per dimension; whether ETH-cons and user-level evidence share one rubric.
- k and tolerance for G3.
- Reference CPU class, reference block / tx mix, and baseline schemes.
- Whether general-purpose entries are scored after mapping or scored on the mapping itself.
- The "PQC-ready chain" definition (December 2026 deliverable alongside SSR) that M-22 scores against.
