# Resources — source material with provenance

Every entry: what it is, where it came from, when, who circulated it, and whether it is public. Add rows by PR (see `CONTRIBUTING.md`). Documents that are not cleared for publication are **linked, not copied**.

## Canonical documents

| File / link | What | Origin | Date | Public |
|---|---|---|---|---|
| `NEDO_PQC_Competition_Briefing_EN.pdf` | METI/NEDO PQC Migration Prize Competition — BGIN community briefing (15 pages): scope, roles, evaluation model, neutrality, participants, indicative schedule 2026–2028, SSR workshop, engagement menu | BGIN, community briefing | July 2026 | yes (community briefing) |
| `briefing-digest.md` | Plain-text digest of the briefing so the facts are greppable and citable by line | this repository | Sep 2026 | yes |
| [GDC26 meeting report — Post-Quantum Cryptography Migration on DLTs](https://bgin-global.org/news/260903-gdc26-pqc-migration) | Report of the GDC 2026 breakout (Geneva, 3 Sep 2026, Chatham House Rule): hybrid-then-cutover agility, legacy-signature verification, dormant funds, distinguishing real PQC-ready stacks; competition planning through 2026, SSR-adjacent workshops, Block 15 infrastructure launch; winner pathway BGIN Standard → ISO | BGIN website | 2026-09-03 | yes |
| [GDC26 session slides](https://bgin-global.org/documents/meeting-reports/gdc26/GDC26_PQC_Migration_DLTs_Slides.pdf) · [full meeting report PDF](https://bgin-global.org/documents/meeting-reports/gdc26/GDC26_PQC_Migration_DLTs_MR.pdf) | Slides and full report for the session above. **Note:** the report says winners are targeted for March 2029 and names a December 2026 "PQC-ready chain" definition as a deliverable; the July briefing says winner selection mid–Sep 2028. Both provisional; the host's call text settles it. | BGIN website | 2026-09-03 | yes |
| [BGIN project hub — PQC migration](https://bgin-global.org/projects/pqc-migration) | The IKP-WG project hub page (status, milestones, documents); since 2026-09-11 it carries the competition coordination, links this repository and the Discourse category | BGIN website | ongoing | yes |
| *Securing Elliptic Curve Cryptocurrencies against Quantum Vulnerabilities: Resource Estimates and Mitigations* — Babbush, Zalcman, Gidney, Broughton, Khattar, Neven, Bergamaschi, Drake, Boneh; PRX Quantum 7, 031001 (21 Aug 2026) — [DOI](https://doi.org/10.1103/j3xf-bw18) · [arXiv 2603.28846](https://arxiv.org/abs/2603.28846) · [ePrint 2026/625](https://eprint.iacr.org/2026/625) | secp256k1 ECDLP resource estimates (≤1,200 logical qubits / ≤90M Toffoli, or ≤1,450 / ≤70M), the on-spend / at-rest / on-setup attack taxonomy, attacks by on-chain consequence, mitigations; ZK-substantiated estimates without published attack circuits | Google Quantum AI et al. | 2026-08 | yes (open access) |
| [GDC26 scene-setting slides — *When ECC and RSA Break: Urgency of Migrating to Post-Quantum Cryptography*](https://bgin-global.org/documents/meeting-reports/gdc26/GDC26_PQC_Migration_DLTs_Slides_GoogleQuantumAI.pdf) | The Google Quantum AI deck presented at the GDC26 breakout, based on the paper above; hosted on the BGIN website beside the meeting report | Google Quantum AI (presented 2026-09-03) | 2026-09 | yes |
| IKP-WG meeting report *IKP Crypto Agility / PQC Migration* (`.docx`, with session transcript) | Scope of the competition, crypto agility vs. PQC readiness, evaluation test (10 nodes, six months initially), call-for-papers and symposium planning, node-count questions, Falcon / XMSS / BLS-aggregation discussion, evaluation-committee questions | IKP-WG, circulated to members | 2026-04 | **not yet cleared** — held by the conveners; ask on Discourse before citing verbatim |

## Discourse threads (bgin.discourse.group)

| Thread | Why |
|---|---|
| [The PQC Migration Prize: the working repository is open](https://bgin.discourse.group/t/the-pqc-migration-prize-the-working-repository-is-open/1053) | Launch topic, 2026-09-11 |
| [Workshop series W1–W6, Sep 2026 → Feb 2027](https://bgin.discourse.group/t/workshop-series-w1-w6-sep-2026-feb-2027/1054) | The calendar as posted; corrections land in `workshops/ROADMAP.md` |
| [Evaluation committee: nominations are open](https://bgin.discourse.group/t/evaluation-committee-nominations-are-open/1055) | Nominations call, 2026-09-11 |
| [BGIN × NEDO PQC competition — roadmap and community alignment](https://bgin.discourse.group/t/bgin-x-nedo-pqc-competition-roadmap-and-community-alignment/987) | The canonical public calendar (May 2026): NEDO / BGIN / academic / EF columns through 2028, and the open question of Bitcoin- and other-chain participation |
| [FC-CoDecFin 2026 PQC-Competition session report (draft)](https://bgin.discourse.group/t/fc-codecfin-pqc-competition-session-report-draft/931) | March 2026 workshop summary: testbed of 10–15 universities, 4–6-month experiments, call-for-papers and specification process |
| [CoDecFin 2027 — call for topics](https://bgin.discourse.group/t/codecfin-2027-call-for-topics-and-program-committee-nominations/1036) | FC'27 workshop proposal; special areas include *PQC Migration, Evaluation, and Crypto Agility* and *Advanced Key Management* |
| [IKP WG call on September 10](https://bgin.discourse.group/t/ikp-wg-call-on-september-10/1048) | Agenda naming the repository and the forming committee; the September ecosystem releases (state-reuse key recovery, Lattice Jolt, ProveKit) |
| [Post-Quantum Crypto Agility Competition — category](https://bgin.discourse.group/c/post-quantum-crypto-agility-competition/44) | The competition's public home on the BGIN Discourse: launch, nominations, metrics and schemes, testbed nodes, workshop threads |
| [IKP Post Quantum Cryptography Thread 06/26](https://bgin.discourse.group/t/ikp-post-quantum-cryptography-thread-06-26/1001) | The IKP-WG PQC archive thread: talk series, papers (Google cryptocurrency whitepaper; *Formalizing Blockchain PQC Signature Transition: How to Outpace Quantum Adversaries*, ePrint 2026/952; Oratomic, arXiv 2603.28627), ecdsa.fail tracker |
| [GDC26 meeting report published: PQC Migration on DLTs](https://bgin.discourse.group/t/gdc26-meeting-report-published-post-quantum-cryptography-migration-on-dlts/1045) | Report post + invitation for public comments, definitional proposals, and evaluation-committee participation |
| [GDC26 meeting report now on the BGIN website (PQC)](https://bgin.discourse.group/t/gdc26-meeting-report-now-on-the-bgin-website-post-quantum-cryptography-migration-on-dlts/1046) | Same report, IKP category |
| [GDC 2026 thread](https://bgin.discourse.group/t/gdc-2026-thread/1011) | GDC26 breakout proposals incl. the PQC session |
| [FYI: PQC and CMVP related conference](https://bgin.discourse.group/t/fyi-pqc-and-cmvp-related-conference/1032) | Adjacent conference notice |

## Events feeding the workshops

| Event | Date | Link |
|---|---|---|
| BGIN Block 15 (Georgetown University Capitol Campus, 111 Massachusetts Ave NW, Washington D.C., hybrid) — PQC keynote Oct 15 09:20–09:50; IKP PQC Migration sessions Oct 15 09:50–11:20 and 11:30–13:00 | 2026-10-15/16 | https://bgin-global.org/events/20261015-block15 · https://www.eventbrite.com/e/bgin-block15-tickets-1990274282957 |
| SSR 2026 co-located PQC workshop (Baltimore) | 2026-12-13 (working) | https://ssresearch26.umbc.edu |
| CoDecFin 2027 at FC'27 (Barbados) | 2027-02-08/12 | https://fc27.ifca.ai/ |

## Standards and specifications referenced

| Reference | Used in |
|---|---|
| NIST FIPS 204 (ML-DSA), FIPS 205 (SLH-DSA), FIPS 206 (FN-DSA, draft), SP 800-208 (stateful hash-based: XMSS, LMS) | `testbed/SCHEMES.md` |
| IETF RFC 8391 (XMSS), RFC 8554 (LMS/HSS); LAMPS composite-signature drafts | `testbed/SCHEMES.md` |
| BIP-340 (Schnorr), BIP-360 direction (P2QRH) — reference only, no endorsement | `testbed/SCHEMES.md`, `evaluation/METRICS.md` |
| ISO/TC 307 (BGIN Category A liaison) | `README.md`, `OUTCOMES.md` |

## To add

- Papers and talks from the IKP-WG PQC talk series (link the meeting reports as they publish).
- Block 14 meeting report *Crypto Agility and PQC Migration* (published PDF: https://bgin-global.org/documents/block-events/block14/IKP/IKP_Crypto_Agility_PQC_Migration.pdf) — the public counterpart of the held `.docx`.
- Ethereum Foundation Quantum Retreat outputs (Oct 9–12, 2026).
- CSS / BWS drafting outputs (Oct 19–23, 2026).
- SSR workshop CfP and programme.
