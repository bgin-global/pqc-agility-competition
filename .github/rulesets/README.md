# Rulesets

Applied to the GitHub repository by `scripts/bootstrap-github.sh` (`gh api -X POST repos/bgin-global/pqc-agility-competition/rulesets --input <file>`). Kept in the repository so the enforcement is itself reviewed, signed, and versioned.

| File | Target | What it enforces |
|---|---|---|
| `main.json` | `refs/heads/main` | No deletion, no force-push, linear history, **signed commits**, pull request with 1 approving review + code-owner review + last-push approval + resolved threads, squash or rebase merges only, required checks `dco` / `signatures` / `validate` (strict: branch must be current). **No bypass actors** — administrators are bound too. |
| `all-branches-signatures.json` | every branch | **Signed commits on every push**, including feature branches and forks' PR heads when pushed here. This is the server-side "sign before push". |
| `tags.json` | every tag | Only repository admins (role id 5) create, move, or delete tags; **tags must be signed**. Call-text packages to the host are signed tags. |

Measured baseline these extend (Trust over IP, `trustoverip/dtgwg-zkp-spec`, read 2026-09-05): `main` ruleset = deletion + non_fast_forward + required check `EasyCLA` + pull_request (0 approvals); org ruleset "no creations" = repository_create / delete / transfer blocked; `web_commit_signoff_required = true`; DCO app check on PRs. ToIP does not require cryptographic signatures by rule; this repository does.

To change a rule: edit the JSON by PR (code-owned by conveners), then re-apply with `scripts/bootstrap-github.sh rulesets` which updates by name. Emergency changes made in the GitHub UI must be back-ported here in the same week.
