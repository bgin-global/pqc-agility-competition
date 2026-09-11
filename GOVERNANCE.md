# Evaluation Committee — Governance (draft v0)

> Status: **DRAFT for ratification at Workshop W1/W2** (see `workshops/ROADMAP.md`). BGIN organizes the evaluation committee; the host (METI/NEDO) sets the rules of the prize itself. Where the two differ, the official call text governs the competition and this document governs BGIN's coordination work.

## 1. Purpose

The evaluation committee is the multi-stakeholder body that:

- drafts the **evaluation metrics, rubric, and call-text inputs** (Phase A, Autumn 2026);
- oversees the **neutral testbed** specification and the reproducibility protocol;
- optionally carries into the **evaluation rounds** (Phase B, from about Nov 2027) under the host process;
- turns the evidence into **standards-ready artifacts** (BGIN Standard candidate → ISO/TC 307 → Japan criteria).

It is modelled on a NIST-style process: open criteria, published rationale, reproducible results, mandatory conflict-of-interest handling.

## 2. Phases

| Phase | Window | Committee work | Output |
|---|---|---|---|
| **A — Criteria** | Sep 2026 → Jan 2027 | Ratify outcomes; draft metrics register and rubric; rule on in-scope schemes; specify testbed harness; adopt COI policy | Call-text inputs to the host around the SSR window (Dec 2026); rubric v1; testbed spec v0 |
| **A2 — Pilot** | Jan → Sep 2027 | Pilot runs on volunteer nodes; reproducibility dry-runs; rubric v1.x; node-host onboarding | Validated harness; node roster; rubric frozen before application deadline |
| **B — Evaluation** | Nov 2027 → mid 2028 | Theoretical security review track; testbed performance track; screening / presentation formats with CSS | Evaluation reports; evidence set citable in standards |
| **C — Standards** | Oct 2028 → | Fold evidence and rubric into a BGIN Standard candidate | BGIN Standard → ISO/TC 307 submission → Japan criteria uptake |

Membership in Phase A does not oblige membership in Phase B; Phase B seating follows the host process.

## 3. Composition (proposed)

| Seat | Count (indicative) | Notes |
|---|---|---|
| Conveners | 2 | BGIN IKP-WG co-chairs convene until the committee elects its own chairs at W2 |
| Members — academia / security review | 3–5 | Theoretical track lead drawn from here |
| Members — Bitcoin developers / projects | 2–3 | Primary evaluation focus |
| Members — Ethereum developers / projects | 2–3 | Primary evaluation focus |
| Members — wallet & infrastructure providers | 2 | Wallet / UX and L2 impact |
| Members — measurement / testbed operations | 2 | Reproducibility, harness, node protocol |
| Members — governance / policy | 1–2 | Transition-period design, dormant / vulnerable assets (discussion input, not policy decree) |
| Technical advisors | open | Track-specific input; **no winner-selection votes** |
| Observers | as invited | Host (METI/NEDO); NIST liaison where appropriate; ISO/TC 307 liaison |

Target size: 12–18 voting members. Geographic and ecosystem balance is a seating criterion, not an afterthought.

## 4. Neutrality

See [`evaluation/COI_POLICY.md`](evaluation/COI_POLICY.md). In short:

- mandatory COI disclosure for evaluators and node operators, published in `COMMITTEE.md`;
- submitters (and close affiliates) do not judge the round they submit to;
- node operators running an artifact under evaluation are recused, or a documented mitigation applies;
- prize funding (host) and coordination (BGIN) must not compromise technical neutrality;
- BGIN is not the algorithm authority and endorses no vendor or chain.

## 5. Decision process

1. **Discuss on Discourse.** Every substantive proposal starts as (or links to) a Discourse thread.
2. **Record by pull request.** The proposal lands in this repository as a PR that cites the thread and, where relevant, the workshop.
3. **Rough consensus** decides drafts. Conveners call consensus; objections must be recorded in the PR or the decision record.
4. **Formal votes** are reserved for: ratifying `OUTCOMES.md`; freezing the rubric; ruling a scheme in or out of scope; adopting or amending this document and the COI policy. Simple majority of voting members with a quorum of half; conveners vote only to break ties.
5. **Decision records.** Every formal vote and every scope ruling gets a record in `decisions/` (ADR style, see the template).
6. **Phase B** evaluations follow the host's rules; this repository records only what the host allows to be public.

## 6. Membership process

1. Nominate (self or other) with the *Committee nomination* issue template.
2. Submit the COI disclosure (fields in `evaluation/COI_POLICY.md`).
3. Conveners confirm the seat against the composition table and post the decision on the issue.
4. Roster entry added to `COMMITTEE.md` by PR (name, affiliation, seat, disclosure summary, date).

Members serve through Phase A; re-confirmation for A2 / B. A member may step down at any time by issue; recusal per COI policy is per round, not a resignation.

## 7. Records and cadence

**Channels.** Three channels, one record:

| Channel | Who | What belongs there |
|---|---|---|
| [BGIN Discourse — *Post-Quantum Crypto Agility Competition* category](https://bgin.discourse.group/c/post-quantum-crypto-agility-competition/44) (public; the [IKP working-group category](https://bgin.discourse.group/c/working-group-s/ikp-wg/8) carries the wider PQC arc) | anyone | open discussion, proposals, announcements, public comment on drafts |
| Private participants' Discourse (being set up by the conveners; invitation only) | committee members, advisors, node hosts, entrants once the call opens | conflict-of-interest disclosures, recusal handling, node-operations coordination, submission logistics — anything that must not be public before the host allows it |
| This repository (issues, pull requests, decision records) | contributors with signing keys | **the record**: nothing decided in either Discourse counts until it lands here by signed pull request |

GitHub Discussions are disabled on purpose; the private space is not a second record, and a summary of any private discussion that shapes a decision goes into the decision record.

- Workshops: roughly monthly, W1–W6 (`workshops/ROADMAP.md`); each produces a record from `workshops/TEMPLATE.md`.
- Between workshops: Discourse plus asynchronous PR review.
- Minutes, drafts, and decisions are public unless the host requires otherwise.
