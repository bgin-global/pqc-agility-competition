# Security model — why every action here carries a signature

This repository is the record of a competition whose rubric and evidence are meant to become a BGIN Standard and travel to ISO/TC 307 and to Japan's crypto-asset security criteria. A record that can be silently altered is not citable. The model below makes every change **attributable** (who), **certified** (the author's DCO statement), **reviewed** (a code owner), and **tamper-evident** (signed history, no rewrites), and it does so without a bypass lane for administrators.

## 1. Layers

| Layer | Control | Where it is enforced |
|---|---|---|
| L0 Identity | Two-factor authentication required org-wide; verified committer email | GitHub organization settings |
| L1 Commit | SSH or GPG signature with a key registered on the author's account; `Signed-off-by` matching author name and email | Client hooks (`.githooks/`), rulesets `required_signatures` on **all** branches, CI jobs `signatures` and `dco` |
| L2 Branch | `main` accepts only pull requests: 1 approving review, code-owner review, last-push approval, resolved threads, required checks, linear history, no force-push, no deletion, **no bypass actors** | `.github/rulesets/main.json` |
| L3 Tag / release | Only repository admins create, move, or delete tags; tags must be signed; deliverables to the host are signed tags | `.github/rulesets/tags.json` |
| L4 Automation | `GITHUB_TOKEN` read-only by default; every action pinned to a commit SHA; only GitHub-owned and verified-creator actions; Dependabot updates pins weekly | `provenance.yml`, `dependabot.yml`, `bootstrap-github.sh settings` |
| L5 Content | Secret scanning with push protection; private vulnerability reporting; no wiki (unreviewed surface) | `bootstrap-github.sh settings` |
| L6 Offline verifiability | `.allowed_signers` roster + `scripts/verify-history.sh` let anyone verify the full history without GitHub | this repository |

## 2. What "signing before push, commits, pulls" means on GitHub

- **Commits:** signed at creation (`commit.gpgsign`) and refused otherwise by the `all branches` ruleset. Web-UI edits are signed by GitHub's own key and get a sign-off because `web_commit_signoff_required` is on.
- **Push:** GitHub does not verify git push certificates (`git push --signed`), so "signed push" is realized as *every commit in the push is signed* — checked by the client `pre-push` hook and by the server rule. There is no way to land an unsigned object on any branch.
- **Pull requests:** the PR's commits must be signed and signed-off (`signatures`, `dco` checks); the merge is a squash or rebase whose resulting commit GitHub signs with its web-flow key; the reviewer's approval is bound to the last push (`require_last_push_approval`), so a later push cannot ride an earlier approval.
- **Tags:** signed by the admin who cuts them; only admins may.

## 3. Baseline controls

| Control | This repository |
|---|---|
| DCO sign-off | `web_commit_signoff_required`, client `commit-msg` hook, and CI job `dco` that also matches the sign-off to the author |
| CLA | None; the DCO carries the certification unless BGIN adopts a CLA |
| Cryptographic signatures | **Required on every branch and tag**, no bypass |
| `main` | PR-only, threads resolved, 3 required checks (dco, signatures, validate), linear history; no force-push, no deletion. Merged by **fast-forward push of the signed head** (`CONTRIBUTING.md`), never the squash or rebase buttons. Approvals: **0 while a single convener is seated** (2026-09-13); the intended posture is 1 approval from a code owner who is not the author, with last-push approval — restore it in `main.json` when the second convener holds a signing key |
| Org ruleset | "no creations" (repository create / delete / transfer blocked) — recommended for `bgin-global`, section 5; not available on the organization's current plan |
| Actions | SHA-pinned, `permissions: contents: read`, Dependabot weekly |
| Bypass | none |

## 4. Teams and ownership

| Team (`bgin-global/`) | Repo permission | Owns (CODEOWNERS) |
|---|---|---|
| `pqc-conveners` | maintain | governance, roster, outcomes, decisions, security files, hooks, scripts, rulesets, `.allowed_signers` |
| `pqc-maintainers` | maintain | everything else by default |
| `pqc-evaluation` | write | `evaluation/` (with maintainers) |
| `pqc-testbed` | write | `testbed/` (with maintainers) |

Admin (the role that may cut tags and edit rulesets) is held by the organization owners plus at most two named conveners, listed in `COMMITTEE.md`.

## 5. Organization-level checklist (owners of `bgin-global`)

These cannot be set from inside the repository; an organization owner runs them once.

1. **Require two-factor authentication** for all members and outside collaborators.
2. **Org ruleset "no creations"**: block repository create / delete / transfer except by owners (Settings → Repository → Rulesets → New ruleset, target *repository*).
3. **Base permission** for members: *read* (or *none*); access flows through the four teams.
4. **Install the DCO GitHub App** on the organization (adds a second, independent `DCO` check; add it to `main.json` required checks once it appears).
5. **Actions policy** at org level: allow only GitHub-owned and verified-creator actions; require approval for first-time contributors' workflow runs; default `GITHUB_TOKEN` read-only.
6. **Secret scanning and push protection** as the org default for new repositories.
7. Optional: **SAML SSO / enterprise verified domains** if BGIN adopts them; then require sign-off emails on verified domains.

## 6. Ceremonies

- **Onboarding a signer:** 2FA → signing key registered → `scripts/setup-signing.sh` → PR adding the `.allowed_signers` line, reviewed by a convener, merged → roster row in `COMMITTEE.md` if a committee member.
- **Key rotation:** add the new key line by PR; mark the old line `valid-before="YYYYMMDD"` rather than deleting it, so older history still verifies.
- **Deliverable to the host (W4 call-text package):** tag `vX.Y-call-text` signed by a convener; the tag message lists the SHA-256 of the exported archive; the Discourse post links the tag.
- **Emergency:** there is no bypass. If a ruleset must change, an organization owner edits it in the UI (audit-logged), and the JSON here is updated by PR within the week so the record and the enforcement agree.

## 7. Threats this addresses, and what it does not

Addresses: an unauthorized or impersonated commit reaching `main`; a maintainer account compromise rewriting history; a workflow with an over-broad token exfiltrating or editing; a dependency or action swap; a tag being moved after delivery; a reviewer's approval being reused for later changes.

Does not address: a signer's endpoint compromised while their key is unlocked (mitigated by dedicated keys with passphrases and short agent lifetimes); collusion of a code owner and an author (mitigated by raising `required_approving_review_count` to 2 once the committee is seated — a one-line change in `main.json`); GitHub itself as a trusted party for web-flow merge signatures (mitigated by `.allowed_signers` plus `verify-history.sh`, which still verifies every *authored* commit offline).
