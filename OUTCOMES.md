# Core Outcomes (draft v0)

> Status: **DRAFT — for ratification at Workshop W1.** Seeded from the METI/NEDO community briefing (July 2026) and the IKP-WG crypto-agility / PQC-migration discussions. Each outcome lists a definition of done, the workshop where it is ratified, and an owner seat (names filled in when the committee is seated).

## Outcomes

### O1 — Evaluation framework (metrics + rubric) in standards-ready vocabulary
- **What:** a published metric register and scoring rubric for PQC migration proposals, anchored on Bitcoin and Ethereum evidence, usable verbatim as call-text input and later as a BGIN Standard section.
- **Done when:** `evaluation/METRICS.md` and `evaluation/RUBRIC.md` are frozen by formal vote before the host's application deadline; every metric has a unit, a measurement method, and a target mapping.
- **Ratified at:** W2 (v0 → v1); frozen in Phase A2.
- **Owner seat:** measurement / testbed operations + academic security review.

### O2 — Neutral, reproducible testbed evidence
- **What:** multi-region, multi-month runs of *pre-existing* signature schemes on a geographically distributed testbed (BSafe.network concept, on the order of 10–15 nodes), with results reproducible across nodes and citable in standards and supervisory conversations.
- **Done when:** harness and result schema in `testbed/` are adopted; at least three volunteer pilot nodes in two regions reproduce a reference run within the agreed tolerance.
- **Ratified at:** W3 (spec); Phase A2 (pilot).
- **Owner seat:** measurement / testbed operations.

### O3 — Crypto-agility evidence, not only PQC readiness
- **What:** evidence on the *mechanism of switching* — hybrid and staged migration, scheme substitution cost, rollback, policy flexibility — because agility is harder than readiness and is what future-proofs the system.
- **Done when:** the metric register carries agility metrics (switch cost, rollback cost, staged-migration throughput) with measurement methods the testbed can execute.
- **Ratified at:** W2.
- **Owner seat:** Bitcoin + Ethereum member seats.

### O4 — Migration-governance evidence
- **What:** transition-period design, stakeholder fit, treatment of dormant / vulnerable assets, the legitimate-owner-versus-attacker race during a migration window — as **discussion input**, not a policy decree.
- **Done when:** a governance-fit dimension exists in the rubric with a documented qualitative method, and at least one workshop record captures the open positions.
- **Ratified at:** W3–W4.
- **Owner seat:** governance / policy.

### O5 — Call-text inputs delivered to the host
- **What:** metrics, rubric, in-scope scheme ruling, eligibility considerations, testbed description — handed to METI/NEDO around the SSR window (Dec 2026) ahead of applications opening (planned Jan 2027).
- **Done when:** a versioned package is tagged in this repository and its receipt is acknowledged by the host.
- **Ratified at:** W4.
- **Owner seat:** conveners.

### O6 — Standards path
- **What:** the evidence and rubric become a BGIN Standard candidate, carried toward ISO/TC 307 (BGIN Category A liaison) and offered to Japan's crypto-asset security criteria.
- **Done when:** a BGIN Standard outline v0 exists (W6) and a maintainer group is named for Phase C.
- **Ratified at:** W6.
- **Owner seat:** conveners + academic.

## Non-outcomes (explicitly out of scope)

- New PQC primitives or parameter sets — NIST outputs are the reference.
- Chain endorsement or vendor scorecards.
- A "Q-day" date claim — threat narratives are scenarios.
- Prize adjudication itself — that is the host's process; BGIN organizes the committee and testbed.

## Cross-cutting themes (from the briefing)

- **PQC migration:** formats, aggregation, L2 / rollups, hybrid / staged migration, throughput and decentralization cost.
- **Advanced key management:** MPC, multisig, ZKP; t-of-n availability; recovery; custody boundaries.
- **Governance & incentives:** stakeholder fit, dormant / vulnerable assets.
