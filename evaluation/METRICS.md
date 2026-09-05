# Metric Register (draft v0)

> Status: **DRAFT — candidate metrics for Workshop W2.** Every row is `candidate` until the committee moves it to `adopted` (in the rubric) or `parked`. Units, methods, and target mappings are what make a metric standards-ready; a metric without all three is not adopted.

## Frame: NIST-style dual track

| Track | What is assessed | Who | Evidence |
|---|---|---|---|
| **(a) Theoretical security review** | Assumptions, parameter choices, composition (hybrids, aggregation, ZK wrapping), key-management risk, side-channel posture, migration-window threat model | Academic / security-review seats | Written review against a checklist; no testbed run needed |
| **(b) Implementation / performance** | Measured cost and behaviour on the neutral, geographically distributed testbed (order of 10–15 nodes, multi-region, multi-month) | Testbed operators + measurement seat | Harness runs per `testbed/HARNESS.md`, reproduced across nodes |

Rubric directions from the briefing (indicative): migration evidence and reproducibility · verifier cost, latency, block / mempool overhead · compatibility / rollback / governance fit · wallet / UX and L2 impact where relevant. The GDC26 report names the two evaluation axes as **theoretical security** and **implementation efficiency**.

## Target mapping

Comparative evaluation is anchored on **Bitcoin (BTC)** and **Ethereum (ETH)**. General-purpose or other-chain work is in scope when its results map to BTC and/or ETH evidence. Each metric names the mapping it needs:

- **BTC-tx** — transaction-level signature (script / witness; e.g. proposals in the P2QRH / BIP-360 direction).
- **ETH-user** — user-level signature (EOA / account-abstraction path; on-chain verification cost).
- **ETH-cons** — consensus-layer signature (validator BLS aggregation and its hash-based successors).
- **L2** — proof cost of verifying the PQ signature inside a rollup / ZK circuit.

## Register

| ID | Metric | Unit | Track | Mapping | How measured | Status |
|---|---|---|---|---|---|---|
| M-01 | Signature size | bytes | b | all | Harness, per scheme + parameter set; report min / mean / max (Falcon-family sizes vary) | candidate |
| M-02 | Public key size | bytes | b | all | Harness | candidate |
| M-03 | Sign time | microseconds, single core, fixed reference CPU class | b | all | Harness, N >= 10^4 ops, report median + p99 | candidate |
| M-04 | Verify time (single) | microseconds | b | all | Harness, same as M-03 | candidate |
| M-05 | Batch / aggregate verify throughput | verifications / s | b | ETH-cons, BTC-tx | Harness batch mode; n = 1, 64, 1024, 10^5 signers where the scheme supports it | candidate |
| M-06 | Aggregate signature size | bytes at n signers | b | ETH-cons | Harness; n as in M-05 | candidate |
| M-07 | Per-block overhead at a reference tx mix | BTC: vbytes / weight units; ETH: calldata bytes + gas | b | BTC-tx, ETH-user | Replay a published reference block mix with the scheme substituted; delta vs classical baseline | candidate |
| M-08 | Mempool / gossip propagation delta | ms at p50 / p95 across regions | b | BTC-tx, ETH-user | Multi-node testbed run; compare to baseline scheme | candidate |
| M-09 | Block validation time delta | ms per block at reference full-node spec | b | BTC-tx, ETH-user, ETH-cons | Testbed node running reference client with scheme substituted | candidate |
| M-10 | On-chain verification cost | gas (precompile vs. contract-level implementation) | b | ETH-user | Reference EVM implementation; report both paths where both exist | candidate |
| M-11 | State growth | bytes per account / UTXO | b | BTC-tx, ETH-user | Analytic + harness confirmation | candidate |
| M-12 | Migration throughput | keys / accounts migrated per unit time under the proposed procedure | b | all | Scenario run on testbed; documents user vs. node-operator burden split | candidate |
| M-13 | Rollback cost | time + coordination steps to revert a staged migration | a+b | all | Scenario; qualitative steps + measured time on testbed | candidate |
| M-14 | Agility switch cost | time + coordination steps to swap scheme A to scheme B under the proposed mechanism | a+b | all | Scenario; the core crypto-agility metric (O3); GDC26: "hybrid then cutover", not a one-time rewrite | candidate |
| M-15 | Wallet / UX impact | ordinal scale (key ceremony steps, seed compatibility, hardware-wallet support) | a | BTC-tx, ETH-user | Structured checklist scored by wallet seat | candidate |
| M-16 | L2 / ZK verification cost | constraints (or prover seconds) to verify one signature in a reference proof system | b | L2 | Reference circuit; aggregation via ZKP is a stated theme | candidate |
| M-17 | Decentralization cost | hardware requirement delta for a full node (CPU, RAM, storage, bandwidth) | b | all | Derived from M-07 / M-09 / M-11 against a reference spec | candidate |
| M-18 | Reproducibility | count of independent nodes / regions reproducing the reference run within tolerance | b | all | Reproduction protocol in `testbed/HARNESS.md`; the gate metric | candidate |
| M-19 | Security review score | checklist result (assumptions, parameter set, side channels, stateful-key handling for XMSS / LMS-class schemes) | a | all | Track (a) written review | candidate |
| M-20 | Governance fit | qualitative: stakeholder fit, transition-period design, dormant / vulnerable asset treatment | a | all | Structured narrative scored by governance seat (O4) | candidate |
| M-21 | Legacy verification continuity | pass / fail + cost: can pre-migration signatures still be verified after cutover, and at what node cost | a+b | all | Scenario; GDC26 raised keeping verification of legacy signatures as a practical challenge | candidate |
| M-22 | PQC-readiness claim substantiation | checklist: does the stack meet the "PQC-ready chain" definition (Dec 2026 deliverable) rather than a superficial claim | a | all | Track (a) against the published definition | candidate |

## Open questions carried from the IKP-WG discussion

1. Is the headline quantity **total overhead** or **migration speed**? (Both appear in the register; the rubric decides the weights.)
2. Who must upgrade first — **node operators or users** — and how does the metric reflect the burden split (M-12)?
3. How to score the **legitimate-owner-versus-attacker race** during a migration window (M-20 and track (a)).
4. Which **reference CPU class** and which **reference tx mix / block** anchor M-03 to M-09? (Needs a decision record.)
5. Whether **consensus-layer** (ETH-cons) and **user-level** (BTC-tx, ETH-user) evidence are scored on one rubric or two.
6. Attack classes from GDC26 — **in-flight** (fast machine), **at-rest** (slow machine against on-chain keys), **exploit manufacture separated from deployment** — which does each metric defend against? Tag rows at W2.

## Change log

- v0 (2026-09) — seeded from the METI/NEDO community briefing (July 2026), IKP-WG session notes, and the GDC26 meeting report (3 Sep 2026).
