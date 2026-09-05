# Contributing

This repository is the record; the BGIN Discourse is the conversation. Most contributions follow *thread → issue → pull request*.

## Ground rules

- **Signed and signed-off, always.** Every commit carries a cryptographic signature from a key registered on your GitHub account and a `Signed-off-by` trailer certifying the [DCO](DCO.md). Unsigned pushes are refused. Setup: `scripts/setup-signing.sh`, details in [`docs/SIGNING.md`](docs/SIGNING.md).
- **Discourse first.** Substantive proposals link a Discourse thread. PRs that change `OUTCOMES.md`, `evaluation/`, `testbed/SCHEMES.md`, or `GOVERNANCE.md` must cite the thread and, where relevant, the workshop record.
- **Provenance on every source.** Anything added to `resources/` gets a row in `resources/README.md`: origin, date, who circulated it, and whether it is public. Do not add documents you are not permitted to publish; link them instead.
- **Neutral voice.** No vendor or chain endorsement. Describe, measure, cite.
- **No secrets, no personal data** beyond the roster fields members consent to in `COMMITTEE.md`.
- **English** for the record; translations welcome alongside.
- **Conduct.** The [Contributor Covenant](CODE_OF_CONDUCT.md) applies on Discourse, in issues, in reviews, and at workshops.

## What to contribute, and how

| Contribution | Route |
|---|---|
| Source material (paper, spec, Discourse summary, meeting report) | Issue *Resource* → PR adding the file or link plus a `resources/README.md` row |
| A candidate metric | Issue *Metric proposal* → PR adding an `M-nn` row to `evaluation/METRICS.md` with status `candidate` |
| A signature scheme or integration path for the testbed | Issue *Scheme proposal* → committee scope ruling (`decisions/`) → PR to `testbed/SCHEMES.md` |
| Offer to host a testbed node | Issue *Node host offer* (institution, region, hardware class, constraints) |
| Committee nomination | Issue *Committee nomination* + COI disclosure per `evaluation/COI_POLICY.md` |
| Workshop record | Copy `workshops/TEMPLATE.md` to `workshops/Wn-YYYY-MM-DD-slug.md`; PR within a week of the session |
| Decision record | Copy `decisions/0000-template.md`; number sequentially |

## Pull requests

- One topic per PR. Keep drafts marked `draft vN` in the file header until ratified.
- Reference the Discourse thread and the issue.
- Reviewers: at least one convener for governance and scope files; at least one member of the relevant seat for metrics, schemes, and harness changes.

## License

Documents and records are contributed under CC BY 4.0 (`LICENSE-docs`); code under Apache-2.0 (`LICENSE`). Your DCO sign-off (`DCO.md`) is the certification that you have the right to contribute under those terms. No CLA is required.
