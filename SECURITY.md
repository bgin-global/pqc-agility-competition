# Security Policy

This repository is the record of a competition whose outputs are meant to travel into standards. Its integrity model is documented in `docs/SECURITY_MODEL.md`; the hands-on setup is in `docs/SIGNING.md`.

## Reporting a vulnerability

- **In this repository's content or automation** (a workflow, a script, the harness once it lands): use GitHub's private vulnerability reporting on this repository (Security tab, "Report a vulnerability"). Do not open a public issue.
- **In BGIN infrastructure** (Discourse, website, testbed nodes): email the BGIN administrators at the address published on bgin-global.org, and reference this repository.
- **In a signature scheme or implementation under evaluation**: that is not a vulnerability in this repository. Raise it through the evaluation committee's security-review track (`evaluation/`) so it is scored, not silently patched.

Expect an acknowledgement within five working days. Coordinated disclosure timelines are agreed per report.

## What we enforce

| Layer | Control |
|---|---|
| Identity | Organization-wide two-factor authentication; verified email on every account that commits |
| Commits | Cryptographic signature (SSH or GPG) **and** Developer Certificate of Origin sign-off on every commit; both checked by rulesets and by CI |
| Branches | `main` accepts pull requests only: code-owner review, required checks, conversation resolution, linear history, no force-push, no deletion |
| Tags / releases | Only maintainers create tags; tags must be signed; call-text packages delivered to the host are signed tags |
| Automation | Workflows run with `contents: read` unless a job needs more; every action pinned to a commit SHA; Dependabot keeps pins current |
| Local | `scripts/setup-signing.sh` installs hooks that refuse to commit without a sign-off and refuse to push unsigned commits |

## Scope

Security fixes to this repository's own files follow the same signed-and-reviewed path as everything else. There is no fast lane that bypasses signatures.
