# Changelog

All notable changes to this repository are recorded here. The format follows [Keep a Changelog](https://keepachangelog.com/en/1.1.0/); versions are signed tags. Call-text packages delivered to the host are tagged `vX.Y-call-text`.

## [Unreleased]

### Added
- `docs/AUTORESEARCH.md` and `decisions/0001-open-benchmark-model.md` (proposed): the open-benchmark model for the testbed's calibration tracks and the boundary with the prize evaluation.
- Resources: the PRX Quantum paper the GDC26 scene-setting was built on (DOI, arXiv, ePrint), the scene-setting deck as hosted on the BGIN website, the Discourse launch / workshop / nominations topics, the roadmap and CoDecFin threads, CoDecFin 2027 as an event; the Block 14 meeting report noted for the resources list.
- Metric open question 6 carries the on-spend / at-rest / on-setup taxonomy with its source; S-05 and C-05 carry the September 2026 evidence (state-reuse key recovery; lattice zkVM and client-side proving).
- `outreach/`: launch drafts and the record of what was posted on 2026-09-11.
- `docs/CONFIDENTIALITY.md`: the public rule for what is held and how it is released.

### Changed
- README status names the open public channel and the hub; the calendar carries the Block 15 venue and sessions and CoDecFin 2027.
- The Trust over IP framing is dropped from README, DCO, the security model, the rulesets note and dependabot; the controls stand on their own.
- Public channel named precisely: the *Post-Quantum Crypto Agility Competition* category on the BGIN Discourse (README, GOVERNANCE §7, CONTRIBUTING, SUPPORT, resources); the IKP working-group link in SUPPORT corrected.

### Notes
- 2026-09-05: repository created under `mitchuski/pqc-agility-competition` with the full hardening, then transferred the same day into `bgin-global` (history, signatures, rulesets, and settings carried over; teams `pqc-conveners`, `pqc-maintainers`, `pqc-evaluation`, `pqc-testbed` created).

### Added
- Repository charter: README, governance (evaluation committee phases, composition, decision process), empty roster, core outcomes O1–O6, contributing guide.
- Evaluation drafts: metric register M-01…M-22, rubric skeleton with gates G1–G4, conflict-of-interest policy.
- Testbed drafts: BSafe.network-concept node model, signature scheme register (S/B/C rows), reference harness spec, JSON result schema.
- Workshop roadmap W1–W6 (Sep 2026 → Feb 2027) and record template; ADR-style decision records.
- Resources with provenance: METI/NEDO community briefing (July 2026) and digest, Discourse threads, GDC26 meeting report links.
- Integrity layer: DCO, signed-commit requirement, client hooks, provenance CI, rulesets for main / all branches / tags, signing and security-model documentation, bootstrap script.
- Community files: licenses (Apache-2.0 code, CC BY 4.0 documents), code of conduct, support, maintainers, citation metadata, OpenSSF Scorecard workflow.
