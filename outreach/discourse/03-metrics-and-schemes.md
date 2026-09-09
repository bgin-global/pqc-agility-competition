# Draft — call for comment on metrics and scheme scope

**Where:** new topic in category 44.
**Title:** `Metric register v0 and the scheme scope rulings: comment before W2`

---

Two draft documents are open for comment ahead of W2 (mid-October, around Block 15).

- **`evaluation/METRICS.md`** — 22 candidate metrics. Every row is `candidate` until the committee adopts or parks it. A metric without units, method and target mapping is not adoptable, so incomplete rows are the useful thing to attack.
- **`testbed/SCHEMES.md`** — five post-quantum signature schemes (ML-DSA, SLH-DSA, FN-DSA, XMSS/XMSS^MT, LMS/HSS), classical baselines measured for the deltas, and six composition and integration paths.

https://github.com/bgin-global/pqc-agility-competition/tree/main/evaluation

### The scope rule

Only pre-existing NIST-class schemes are in scope. The competition is not selecting new primitives. Every *integration path*, though, is an explicit committee ruling rather than a default — `C-01` hybrid classical + PQ, `C-02` the Bitcoin P2QRH / BIP-360 direction, `C-03` the Ethereum account-abstraction path, `C-04` consensus-layer BLS to hash-based aggregation, `C-05` ZK-wrapped verification, `C-06` advanced key management. Each needs a decision record with reasons. Arguments for and against any of the six are directly useful now.

Two known soft spots: FN-DSA is carried as FIPS 206 in draft status and the status needs confirming at the ruling; and the Ethereum consensus direction is heading toward XMSS-style hash-based aggregation with Poseidon2 for ZK-friendliness, which is not an SP 800-208 parameterisation — whether that is in scope is a ruling, not a detail.

### Six open questions

Carried from the IKP-WG discussion, all assigned at W2:

1. Is the headline quantity total overhead, or migration speed?
2. Who must upgrade first — node operators or users — and how does a metric reflect the burden split?
3. How is the legitimate-owner-versus-attacker race scored during a migration window?
4. Which reference CPU class, and which reference transaction mix or block, anchor the cost metrics?
5. Are consensus-layer and user-level evidence scored on one rubric or two?
6. Which of the GDC26 attack classes does each metric defend against — in-flight, at-rest against on-chain keys, or exploit manufacture separated from deployment?

Question 4 in particular is a decision somebody has to make concretely, and it will be made better with implementers in the thread than without.

### Anchoring

Comparative evaluation anchors on Bitcoin and Ethereum: `BTC-tx` transaction-level, `ETH-user` user-level, `ETH-cons` consensus-layer. Other-chain and general-purpose work is in scope where its results map to that evidence. This is a measurement decision, not an endorsement — BGIN is ecosystem-neutral and the anchoring is there so numbers can be compared at all.

Comment here, or use the *Metric proposal* and *Scheme proposal* issue templates.
