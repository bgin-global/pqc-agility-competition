# What is held back, and why

This competition claims neutrality. A claim like that is worth something only if the rule for what gets held back is public, even when the material is not. This document is that rule.

**The default is publication.** Everything about the competition's substance — the governance, the outcomes, the metric register, the rubric and its weights, the scheme scope rulings, the testbed harness and result schema, the workshop records, and every ratified decision — is public, in this repository, and is public *while it is still wrong*. Draft v0 documents are red-penned in the open. That is the point.

A small amount of material cannot be published here. It is held in a separate, access-controlled repository, `bgin-global/pqc-agility-competition-private`, readable by the conveners and the seated committee.

## The four tests

Material is held **only** if at least one of these is true.

| Test | Meaning | Example |
|---|---|---|
| **Not ours to publish** | Circulated to members without a publication clearance, said under the Chatham House Rule, or a third party holds rights or expectations in it | The IKP-WG meeting report and transcript, listed in `resources/README.md` as *linked, not copied* |
| **Names a person deliberatively** | A nomination under consideration, a conflict-of-interest disclosure, a score before it is announced, a reservation recorded in minutes | Committee nominations, COI disclosures under `evaluation/COI_POLICY.md` |
| **Would pre-empt an announcement** | Draft call text before the host publishes it; a workshop output before participants have agreed the record | The call-text input package (outcome O5) |
| **Arrived under terms** | Applicant material, or testbed results tied to a named operator | Submissions, once applications open |

## Two things that are not reasons

- **Unfinished is not confidential.** Every governance, metric and testbed document here is `draft v0` and public.
- **Awkward is not confidential.** Disagreement about a metric, a scheme, a date or a scope ruling is public work.

## What is published from what is held

| Held | Published |
|---|---|
| A nomination and its assessment | The seated member's roster row, carrying only what that person agreed to publish |
| A conflict-of-interest disclosure | The fact of a recusal, and what it covers |
| Minutes recording who argued what | The decision, its reasons, and the vote |
| An uncleared source | Its existence, origin, date and non-availability — the `resources/README.md` row pattern; and where possible a digest of its substance |
| Operator-identified testbed results | Aggregate results identifying no operator |

## Guards

Three, so that the classification cannot quietly become a habit:

1. **Every hold has a named holder and a written reason**, recorded in a clearance register. A hold with no reason is not a hold.
2. **Every embargo has a trigger** — a date or a named event. An embargo with no trigger is a refusal, and needs a different justification.
3. **Refusals are registered, not silent.** A request to publish that is refused leaves a row naming the test that decided it. A competition that leaves no trace of what it declined to release cannot show it was neutral.

## Release

Material moves one way, private to public, through a gate: a request, four tests worked by a convener other than the requester, then a pull request to *this* repository, then a register row. Redaction — publishing a digest rather than a transcript — is a normal outcome, and `resources/briefing-digest.md` is the worked example.

Material does not move public to private. Publishing is not reversible, and pretending otherwise is worse than the original exposure; the response to something published in error is a correction here, not a deletion elsewhere.

## Enforcement, stated honestly

This repository enforces its rules with GitHub rulesets: signed commits, pull requests only, code-owner review, no bypass for anyone including administrators. The private repository **cannot** do the same — GitHub does not offer rulesets or branch protection on private repositories under the organisation's current plan. There, the same checks run and the same hooks apply, but they are conventions with an after-the-fact audit rather than server-enforced rules. That is a real difference and it is stated rather than glossed.
