# PQC Migration Prize — Crypto-Agility Competition

[![provenance](https://github.com/bgin-global/pqc-agility-competition/actions/workflows/provenance.yml/badge.svg)](https://github.com/bgin-global/pqc-agility-competition/actions/workflows/provenance.yml) [![OpenSSF Scorecard](https://api.scorecard.dev/projects/github.com/bgin-global/pqc-agility-competition/badge)](https://scorecard.dev/viewer/?uri=github.com/bgin-global/pqc-agility-competition) [![License: CC BY 4.0](https://img.shields.io/badge/docs-CC_BY_4.0-lightgrey.svg)](LICENSE-docs) [![License: Apache-2.0](https://img.shields.io/badge/code-Apache--2.0-blue.svg)](LICENSE)

**BGIN coordination repository** for the *PQC Migration Prize Competition*: a multi-year (2026–2028), internationally open prize competition on post-quantum cryptography (PQC) migration for public blockchains, hosted by the Japanese Government (METI/NEDO). BGIN coordinates internationally and runs the neutral evaluation testbed (BSafe.network concept).

This repository is where the collaborative, pre-call work happens:

1. **Form the evaluation committee** — see [`GOVERNANCE.md`](GOVERNANCE.md) and [`COMMITTEE.md`](COMMITTEE.md).
2. **Identify the core outcomes** — see [`OUTCOMES.md`](OUTCOMES.md).
3. **Draft the evaluation metrics and rubric** — see [`evaluation/`](evaluation/).
4. **Specify the crypto-agility testbed** — servers exercising *pre-existing* signature schemes in Bitcoin- and Ethereum-mappable configurations — see [`testbed/`](testbed/).
5. **Run the workshop series** (six months, Sep 2026 → Feb 2027) that ratifies 1–4 — see [`workshops/ROADMAP.md`](workshops/ROADMAP.md).

Discussion happens in the public [Post-Quantum Crypto Agility Competition category](https://bgin.discourse.group/c/post-quantum-crypto-agility-competition/44) on the BGIN Discourse; the [IKP working group](https://bgin.discourse.group/c/working-group-s/ikp-wg/8) carries the wider PQC arc. This repository is the **record**: decisions, drafts, source material, and testbed specifications. Nothing here is final until the evaluation committee ratifies it and the host publishes the official call.

A small amount of material cannot be published here — uncleared sources, nominations and conflict-of-interest disclosures, drafts under embargo. The *rule* for what is held back, and the gate it passes through to be released, is public: [`docs/CONFIDENTIALITY.md`](docs/CONFIDENTIALITY.md).

## What it is — and what it is not

| It is | It is not |
|---|---|
| A push to accelerate and de-risk migration to quantum-resistant signatures and advanced key management | Inventing new PQC primitives — it starts from NIST process outputs (ML-DSA and related) |
| Transparent, reproducible evaluation on a geographically distributed neutral testbed | Fear-based timelines — threat narratives are scenarios, not a single "Q-day" calendar claim |
| Focused on deployment on live / public networks, anchored on Bitcoin and Ethereum evidence | Chain endorsement — BGIN is an ecosystem-neutral forum |
| Globally open to applicants, funded by Japan | A one-off prize ceremony — the lasting goal is shared practice |

The hard problem on public chains is **deployment, evaluation, testbeds, and migration governance** — not selecting new PQC primitives.

## The path

```
Competition / evaluation  →  BGIN Standard  →  ISO (ISO/TC 307, BGIN Category A liaison)  →  Japan crypto-asset security criteria
```

## Roles

| Lane | Role |
|---|---|
| Japanese Government (METI/NEDO) | Host and organizer — publishes the call, sets rules, funds and awards the prize; later channel into Japan's crypto-asset security criteria |
| BGIN | International coordination, neutral evaluation testbed, multi-stakeholder dialogue; produces candidate BGIN Standards with a path to ISO/TC 307 |
| NIST (not a competition lane) | Algorithm / parameter authority for the PQC primitives in scope; measurement-methodology cooperation sought where appropriate |

## Repository map

```
README.md                 this file
GOVERNANCE.md             evaluation committee: purpose, phases, composition, decision process, membership
COMMITTEE.md              roster (empty until nominations are confirmed)
OUTCOMES.md               core outcomes O1–O6 (draft v0, for committee ratification)
CONTRIBUTING.md           how to add sources, propose metrics/schemes, offer a node, nominate a member
evaluation/METRICS.md     candidate metric register (M-01 …), dual-track frame, open questions
evaluation/RUBRIC.md      scoring frame skeleton: gates, tracks, dimensions, weights TBD
evaluation/COI_POLICY.md  neutrality and conflict-of-interest rules for evaluators and node operators
testbed/README.md         BSafe.network-concept testbed: nodes, hosts, phases, role separation
testbed/SCHEMES.md        register of pre-existing signature schemes and classical baselines
testbed/HARNESS.md        common bench interface, run manifest, reproduction protocol
testbed/schema/           JSON schema for a testbed run result
testbed/tracks/           calibration-track contracts (proposed): manifest, rules, runner, fixtures, note template; T1 drafted
workshops/ROADMAP.md      six-month workshop series W1–W6 with target outputs
workshops/TEMPLATE.md     workshop record template
decisions/                ADR-style decision records (0001 = open-benchmark model, proposed)
docs/AUTORESEARCH.md      proposal: the testbed's calibration tracks as open benchmarks; where agent-driven research is admitted and attributed
LICENSE / LICENSE-docs    Apache-2.0 for code, CC BY 4.0 for documents
CODE_OF_CONDUCT.md        Contributor Covenant 2.1
SUPPORT.md                where to ask
MAINTAINERS.md            conveners and maintainers
CHANGELOG.md              Keep-a-Changelog record, per signed tag
CITATION.cff              citation metadata
DCO.md                    Developer Certificate of Origin: the sign-off every commit must carry
SECURITY.md               reporting policy and the controls this repository enforces
docs/SIGNING.md           how to set up signed + signed-off commits (required)
docs/SECURITY_MODEL.md    why: layers, baseline controls, org checklist, ceremonies
.allowed_signers          SSH signing keys of contributors, for offline verification of the history
.githooks/ scripts/       commit-msg + pre-push hooks; setup-signing, verify-history, bootstrap-github, CI checks
.github/rulesets/         the branch and tag rulesets applied to GitHub, versioned here
resources/                source material with provenance: NEDO briefing PDF + briefing-digest.md, Discourse links, meeting reports
.github/                  issue and PR templates
```

## Status

**Phase A (Autumn 2026): committee forming; outcomes, metrics, and testbed spec in draft.**

2026-09-11 — the public channel is open: the [Post-Quantum Crypto Agility Competition](https://bgin.discourse.group/c/post-quantum-crypto-agility-competition/44) category on the BGIN Discourse carries the [launch](https://bgin.discourse.group/t/the-pqc-migration-prize-the-working-repository-is-open/1053), the [workshop series](https://bgin.discourse.group/t/workshop-series-w1-w6-sep-2026-feb-2027/1054) and the [committee nominations call](https://bgin.discourse.group/t/evaluation-committee-nominations-are-open/1055); the metrics and testbed calls follow in the week of 14 September. The [BGIN project hub](https://bgin-global.org/projects/pqc-migration) points here and at the category. Nominations are open by issue template.
Indicative calendar (all dates provisional until confirmed by organizers):

| When | Owner | What |
|---|---|---|
| 2026 Sep 1–3 | BGIN (GDC26) | PQC session(s) for policy alignment |
| 2026 Sep ~17 | Academic (CBT) | PQC-related academic session |
| 2026 Oct 9–12 | Ethereum Foundation | Quantum Retreat (Cambridge) — specs & testbeds |
| 2026 Oct 15–16 | BGIN Block 15 (Georgetown University Capitol Campus, Washington D.C.; hybrid) | PQC keynote 09:20; IKP PQC sessions 09:50–11:20 (resource estimates → judging criteria) and 11:30–13:00 (crypto agility and the NIST signature migration, with NIST participation) |
| 2026 Oct 19–23 | CSS / BWS | Academic drafting of guidelines & criteria |
| 2026 Dec 13 | SSR co-located workshop (Baltimore) | Formal call text targeted around this window |
| 2027 Jan | METI/NEDO | Competition applications open (planned) |
| 2027 Feb 8–12 | Academic (CoDecFin 2027 at FC'27, Barbados) | Workshop related to the competition; proposed special area *PQC Migration, Evaluation, and Crypto Agility* |
| 2027 Sep | METI/NEDO | Application deadline (planned) |
| 2027 Nov → 2028 mid | METI/NEDO / BGIN / testbed | Evaluation rounds; performance evaluation phase |
| 2028 mid–Sep | METI/NEDO | Winner selection & prize (planned) |
| 2028 Oct → | BGIN / academic | Toward BGIN Standard; ISO/TC 307 and Japan criteria follow-on |

## How to engage

- **Evaluation committee** — help draft call text, metrics, and rubrics in Autumn 2026 (Phase A); optionally join later evaluation rounds (Phase B) under the host process. Nominate via the issue template.
- **Technical advisor** — track-specific input (Bitcoin / Ethereum / measurement) without winner-selection votes.
- **Testbed node host** — a university or neutral lab hosts a BSafe.network evaluation node (contracting later; role separated from judging).
- **SSR workshop** — shape the 13 Dec 2026 programme; review; speak.
- **Submit / build** — enter the prize when the official call opens (planned 2027).
- **Discuss & amplify** — the public [competition category](https://bgin.discourse.group/c/post-quantum-crypto-agility-competition/44) on the BGIN Discourse (and the [IKP working group](https://bgin.discourse.group/c/working-group-s/ikp-wg/8)), GDC / Block / CSS-BWS sessions. Participants (committee, advisors, node hosts, entrants) also get a private Discourse space run by the conveners; decisions still land here (`GOVERNANCE.md` §7).

## Integrity

Every commit and tag in this repository is cryptographically signed and carries a Developer Certificate of Origin sign-off; `main` changes only by reviewed pull request, and there is no administrator bypass. Set up once with `scripts/setup-signing.sh` and read [`docs/SIGNING.md`](docs/SIGNING.md). The model is in [`docs/SECURITY_MODEL.md`](docs/SECURITY_MODEL.md).

## Community

- [`CODE_OF_CONDUCT.md`](CODE_OF_CONDUCT.md) — Contributor Covenant 2.1.
- [`CONTRIBUTING.md`](CONTRIBUTING.md) — thread → issue → pull request; signed and signed-off.
- [`SUPPORT.md`](SUPPORT.md) — where to ask.
- [`MAINTAINERS.md`](MAINTAINERS.md) — who reviews and who cuts tags.
- [`CHANGELOG.md`](CHANGELOG.md) — what changed, per signed tag.
- [`CITATION.cff`](CITATION.cff) — how to cite a tagged version.

## License

Documents, specifications, and records in this repository are licensed under [Creative Commons Attribution 4.0 International](LICENSE-docs) (CC BY 4.0). Code — scripts, hooks, workflows, the harness once it lands — is licensed under the [Apache License, Version 2.0](LICENSE). Copyright is held by the contributors; BGIN's publication of a BGIN Standard derived from this work follows BGIN's own process.
