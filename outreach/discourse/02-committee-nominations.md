# Draft — call for committee nominations

**Where:** new topic in category 44.
**Title:** `Evaluation committee: nominations are open`

---

Nominations are open for the evaluation committee of the PQC Migration Prize. Nominations are collected now; nothing is decided until W1 ratifies the composition table, and seats are filled at W2.

**How:** the *Committee nomination* issue template at https://github.com/bgin-global/pqc-agility-competition/issues/new/choose, or a reply here and it will be carried over.

### What the committee does

Two evaluation tracks, following the NIST-style split named in the GDC26 report:

- **Theoretical security review** — assumptions, parameter choices, composition (hybrids, aggregation, ZK wrapping), key-management risk, side-channel posture, migration-window threat model. Written review against a checklist; no testbed run needed.
- **Implementation and performance** — measured cost and behaviour on the neutral testbed, reproduced across nodes.

Both tracks need people. So does the work before either starts: the metric register, the rubric weights, and the scheme scope rulings are committee decisions, and they happen in the next three months.

### What is being looked for

The composition table in `GOVERNANCE.md` §3 is a draft: 12–18 seats across academic cryptography, protocol engineering on Bitcoin and Ethereum, wallet and custody, measurement and testbed operations, and standards. It is a draft, and arguing with it is a legitimate way to respond to this post. The quorum rule is open too.

Self-nomination is normal and expected.

### What a nomination involves

A nomination records the lane proposed, relevant experience, and declared interests. Anyone seated files a conflict-of-interest disclosure before taking part in evaluation work — the policy is public at `evaluation/COI_POLICY.md`; the disclosures themselves are not.

That is the general shape: **decisions are published, deliberation is not.** A seated member's roster entry carries only what that person agreed to publish, which is asked at nomination. The fact that a member recused, and what from, is published; the disclosure behind it is not. Nominations that are declined are kept on the record with the reason, because a competition that discards that record cannot show it was neutral.

### Conveners

Conveners are named on ratification at W1. That is one of the things W1 is for. Before W1, one seat is needed immediately: a **second convener with a signing key**, because the repository's review rule (a code-owner approval that is not the author's, no bypass) means a single convener cannot merge anything — including the committee's own nominations. Setup is `docs/SIGNING.md` §1–3; it takes an afternoon.

Names for the two track leads — theoretical security, implementation and performance — are the next ask, and nominations for them are read first.
