# Neutrality and Conflict of Interest (draft v0)

> Status: **DRAFT — adopt at Workshop W3.** Neutrality is what makes the outputs usable as standards inputs (BGIN → ISO → Japan criteria) rather than a private scorecard.

## Principles (from the briefing)

1. **Mandatory COI disclosure** for evaluators and node operators.
2. **Role separation.** Submitters (and close affiliates) do not judge that round. Test-node operators running an artifact under evaluation are recused, or a documented mitigation applies.
3. **Sponsor vs. judgment.** Prize funding (Japanese Government / METI/NEDO) and coordination (BGIN) must not compromise technical neutrality.
4. **No authority, no endorsement.** BGIN is not the algorithm authority (NIST is) and does not endorse a vendor or chain.

## Disclosure form (fields)

| Field | Required of |
|---|---|
| Name, affiliation(s), role sought (member / advisor / node operator) | all |
| Employment and paid advisory roles in the last 24 months | all |
| Financial interests in entities likely to submit, or in specific chains / wallets / vendors in scope | all |
| Participation in any team intending to submit | all |
| Grants or contracts from the host (METI/NEDO) or from BGIN | all |
| Node hosting relationship (institution, funding source) | node operators |
| Anything else a reasonable observer would want to know | all |

Disclosures are summarized in `COMMITTEE.md`; the full form is held by the conveners and updated whenever circumstances change.

## Recusal rules

- A member with a disclosed interest in a submission is recused from scoring it and from the discussion of its score. Recusal is per round, recorded in the round's record.
- A node operator whose institution submits does not run that artifact; if unavoidable, a second, unaffiliated node reproduces the run and the mitigation is recorded.
- Technical advisors may comment on any submission but never vote.
- Conveners recuse from calling consensus on any matter in which they have a disclosed interest.

## Sponsor separation

- The host observes; it does not score in the BGIN committee's track.
- BGIN coordination staff do not score.
- Funding for nodes is disclosed per node in `testbed/README.md`.

## Publication

Disclosure summaries, recusals, and mitigations are published with the evaluation record unless the host requires otherwise.
