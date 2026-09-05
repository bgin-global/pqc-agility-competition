# Digest — METI/NEDO PQC Migration Prize Competition, BGIN community briefing (July 2026)

Plain-text digest of `NEDO_PQC_Competition_Briefing_EN.pdf` (15 pages) so the facts are greppable and citable. Page numbers refer to the PDF. Supplemented at the end with the GDC26 meeting report (3 Sep 2026), which updates a few points.

## In one minute (p2)

- Multi-year (2026–2028), internationally open prize competition on PQC migration for public blockchains.
- Hosted by the Japanese Government (METI/NEDO). BGIN coordinates internationally and runs a neutral evaluation testbed (BSafe.network).
- Deploy NIST-selected / standardized PQC — do not invent new primitives.
- Path: Competition / evaluation → BGIN Standard → ISO (ISO/TC 307; BGIN is Category A liaison) → Japan crypto-asset security criteria.

## What it is / is not (p4)

- Is: accelerate and de-risk migration to quantum-resistant signatures and advanced key management; transparent, reproducible evaluation on a geographically distributed neutral testbed; deployment on live / public networks; globally open, funded by Japan; a pipeline toward standards.
- Is not: new PQC primitives (starts from NIST outputs, e.g. ML-DSA); fear-based timelines (threat narratives are scenarios, not a single "Q-day"); chain endorsement.
- Takeaway: the hard problem is deployment, evaluation, testbeds, migration governance.

## Roles (p6)

- Japanese Government (METI/NEDO): host and organizer — publishes the call, sets rules, funds and awards; later channel into Japan's criteria.
- BGIN: international coordination and neutral evaluation testbed; multi-stakeholder dialogue; candidate BGIN Standards with ISO/TC 307 path.
- NIST (not a competition lane): algorithm / parameter authority; measurement and evaluation-methodology cooperation sought where appropriate.

## Scope (p7)

- Comparative evaluation anchored on Bitcoin and Ethereum migration evidence; general-purpose / other-chain work welcome when mappable to BTC and/or ETH evidence.
- Cross-cutting themes: PQC migration (formats, aggregation, L2 / rollups, hybrid / staged migration, throughput and decentralization cost); advanced key management (MPC, multisig, ZKP; t-of-n availability; recovery; custody boundaries); governance and incentives (stakeholder fit, dormant / vulnerable assets — discussion input, not policy decree).

## Evaluation model (p8)

- NIST-style dual track: (a) theoretical security review; (b) implementation / performance on a neutral, geographically distributed testbed (BSafe.network concept; order of 10–15 nodes; multi-region; multi-month runs planned).
- Rubric directions (indicative): migration evidence and reproducibility; verifier cost, latency, block / mempool overhead; compatibility / rollback / governance fit; wallet / UX and L2 impact where relevant.

## Neutrality and COI (p9)

- Mandatory COI disclosure for evaluators and node operators.
- Role separation: submitters (and close affiliates) do not judge that round; node operators running an artifact under evaluation are recused (or documented mitigation).
- Sponsor vs. judgment: funding (host) and coordination (BGIN) must not compromise technical neutrality.
- BGIN is not the algorithm authority and does not endorse a vendor or chain.

## Who can participate (p10)

- Entrants: Bitcoin and Ethereum developers / project teams (primary focus); other-chain / general-purpose teams when results map; wallet and infrastructure providers; academia and industry R&D.
- Evaluation node hosts: accredited universities, nonprofits, neutral R&D labs.
- Eligibility details (sanctions, vendor roles, regulatory risk) finalized in the official call.

## Indicative schedule (p11, p13) — all provisional

| Period | Owner | Activity |
|---|---|---|
| 2026 May–Jul | BGIN | Lecture series; community alignment |
| 2026 Sep 1–3 | BGIN (GDC) | PQC session(s) for policy alignment |
| 2026 Sep ~17 | Academic (CBT) | PQC-related academic session |
| 2026 Oct 9–12 | Ethereum Foundation | Quantum Retreat (Cambridge) — specs and testbeds |
| 2026 Oct 15–16 | BGIN (Block 15) | PQC / evaluation session (NIST-facing, DC) |
| 2026 Oct 19–23 | CSS / BWS | Academic drafting of guidelines and criteria |
| 2026 Dec 13 | SSR WS | Co-located PQC workshop (Baltimore); formal call text targeted around this window |
| 2027 Jan | METI/NEDO | Competition applications open (planned) |
| 2027 Feb | Academic / BGIN | Workshops (e.g. CoDecFin; Block discussions) |
| 2027 Jun | Academic (ICBC) | Competition-related workshop |
| 2027 Sep | METI/NEDO | Application deadline (planned) |
| 2027 Oct | BGIN / CSS | Screening / presentation formats |
| 2027 Nov– | METI/NEDO / BGIN | Evaluation rounds begin |
| 2027 Dec – 2028 mid | Testbed | Performance evaluation phase (indicative) |
| 2028 mid–Sep | METI/NEDO | Winner selection and prize (planned) |
| 2028 Oct– | BGIN / academic | Toward BGIN Standard; ISO/TC 307 and Japan criteria follow-on |

## SSR 2026 co-located PQC workshop (p12)

- Working date Sunday 13 December 2026, about 10:00–16:00, Baltimore (ssresearch26.umbc.edu); co-located workshop, not a parallel track of the main conference; BGIN carries operational / financial responsibility.
- Programme: submitted talks + invited / panel (archival full papers may use SSR 2027 pathways).
- Milestones: PC locked by 31 July 2026; CfP early–mid August 2026; papers due October 2026.

## Ways to engage (p14)

Evaluation committee (Phase A: call text, metrics, rubrics in Autumn 2026; optional Phase B evaluation rounds under the host process) · technical advisor (no winner-selection votes) · SSR workshop PC / speaker · testbed node (university / neutral lab; contracting later; separated from judging) · submit / build (call planned 2027) · discuss and amplify.

## Updates from the GDC26 meeting report (3 Sep 2026, Geneva, Chatham House Rule)

Source: https://bgin-global.org/news/260903-gdc26-pqc-migration (report PDF: /documents/meeting-reports/gdc26/GDC26_PQC_Migration_DLTs_MR.pdf; slides: GDC26_PQC_Migration_DLTs_Slides.pdf).

- Scope wording: "efficient methods to migrate blockchain networks to quantum-resistant signatures and advanced key management, using NIST-class schemes". Evaluation axes: theoretical security and implementation efficiency. Targets: Bitcoin and Ethereum.
- Timeline as stated at GDC26: December 2026 = a "PQC-ready" chain **definition** plus a one-day workshop alongside SSR; applications open next year (2027); **winners targeted March 2029** (later than the briefing's mid–Sep 2028 — treat both as provisional; the host's call text will settle it). Block 15 = infrastructure launch for evaluation.
- Practical challenges named: staging hybrid systems then cutover when all nodes must validate new rules; keeping verification of legacy signatures; preventing dormant-fund losses; distinguishing genuine PQC-ready stacks from superficial claims.
- Design objective: crypto agility — hybrid then cutover; do not freeze a one-time elliptic-curve-to-ML-DSA rewrite. Aggressive protocol migration = two to three years minimum, with an undefined user-migration tail.
- Threat framing: qubit count and a single Q-day date are the wrong monitors; watch error correction, interconnects, compiler progress. Attack classes: in-flight (fast machine), at-rest (slow machine against on-chain keys), exploit manufacture separated from deployment. Stablecoin contagion into traditional finance named as systemic risk. AI cryptanalysis already drives urgency.
- Block 15 continuation: PQC keynote Oct 15 09:20–09:50; IKP PQC Migration sessions Oct 15 09:50–11:20 and 11:30–13:00 (hybrid). Public comments, definitional proposals, and evaluation-committee participation invited via Discourse.
