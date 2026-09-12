# Neutral Evaluation Testbed (draft v0)

> Status: **DRAFT — spec for Workshop W3.** The testbed exists to produce transparent, reproducible evidence about *pre-existing* signature schemes deployed in Bitcoin- and Ethereum-mappable configurations. It is the (b) track of the dual-track evaluation model. The GDC26 report places the testbed infrastructure launch at Block 15 (Oct 2026).

## Concept: BSafe.network

- **Geographically distributed, neutral** evaluation nodes — order of **10–15 nodes**, multi-region, **multi-month runs** (the IKP-WG discussion planned an initial 10 nodes for a six-month period; more nodes may be contributed by other organizations).
- **Hosts:** accredited universities, nonprofit organizations, neutral R&D labs. Contracting comes later under the host process.
- **Role separation:** node operators are not judges; an operator running an artifact under evaluation is recused or a documented mitigation applies (`evaluation/COI_POLICY.md`).
- **Funding:** initial nodes funded by the host (METI/NEDO); additional nodes by contributing organizations; funding disclosed per node.

## What runs on a node

1. The **reference harness** (`HARNESS.md`) exercising the schemes in `SCHEMES.md` through one common interface, producing results in `schema/result.schema.json`.
2. **Scenario runs** that substitute a scheme into a reference client or block / tx replay to measure the mapped metrics (M-07 to M-12, M-21).
3. In Phase B: **submitted artifacts**, built from pinned sources, under the same manifest and reproduction protocol.

## Phases

| Phase | Window | Nodes | Purpose |
|---|---|---|---|
| T0 — Spec | Sep to Nov 2026 | none (a hosted development runner for pre-flight only) | Harness interface, result schema, node requirements, reproduction protocol (this directory); calibration-track contracts under [`tracks/`](tracks/README.md) *(proposed)* |
| T1 — Pilot | Jan to Sep 2027 | 3–5 volunteer | Reproduce reference runs for baseline + in-scope schemes; calibrate tolerance; validate node protocol |
| T2 — Evaluation | Nov 2027 to mid 2028 | 10–15 contracted | Multi-month runs of submitted artifacts |

## Node requirements (to be decided by decision record)

- Reference hardware class (CPU generation / core count / RAM / NVMe / bandwidth) — nodes report their fingerprint; results are normalized to the reference class only for cross-node comparison, never silently.
- Operating system image and container runtime pinned by digest.
- Time sync (NTP) and region label.
- Node operator key for signing run attestations.
- Network: nodes peer with each other for the propagation metrics (M-08); no dependence on mainnet.

## Node roster

| Node | Host | Region | Hardware class | Funding | Status |
|---|---|---|---|---|---|
| — | — | — | — | — | offers via the *Node host offer* issue template |
