#!/usr/bin/env bash
# Create and harden the GitHub repository bgin-global/pqc-agility-competition.
# Requires: gh (GitHub CLI) authenticated as an owner/admin of the bgin-global organization; git; this clone.
# Every step is idempotent and printed before it runs. Nothing is pushed unless you pass `push`.
#
#   scripts/bootstrap-github.sh preflight   # who am I, what can I do in the org
#   scripts/bootstrap-github.sh create      # create the repo (public, no wiki/projects), add origin
#   scripts/bootstrap-github.sh settings    # merge policy, web sign-off, security features
#   scripts/bootstrap-github.sh teams       # create the four teams and grant repo access (org admin only)
#   scripts/bootstrap-github.sh rulesets    # apply / update .github/rulesets/*.json by name
#   scripts/bootstrap-github.sh key         # register your SSH signing key on your GitHub account
#   scripts/bootstrap-github.sh push        # first signed commit + push main (prompts before pushing)
#   scripts/bootstrap-github.sh all         # preflight create settings teams rulesets key   (no push)
#   scripts/bootstrap-github.sh verify      # read back what GitHub enforces
set -euo pipefail
ORG="${ORG:-bgin-global}"; REPO="${REPO:-pqc-agility-competition}"; FULL="$ORG/$REPO"
DESC="BGIN coordination repository for the METI/NEDO PQC Migration Prize: evaluation committee, outcomes, metrics, crypto-agility testbed"
cd "$(git rev-parse --show-toplevel)"
need() { command -v "$1" >/dev/null 2>&1 || { echo "missing: $1 (Windows: winget install GitHub.cli)" >&2; exit 1; }; }
# Windows ships a "python3" stub that only opens the Store; prefer whichever interpreter actually runs.
PY="$(python3 -c "print(1)" >/dev/null 2>&1 && echo python3 || echo python)"
say() { printf '\n== %s ==\n' "$*"; }

preflight() {
  need gh; need git
  say "gh auth"; gh auth status
  ME="$(gh api user -q .login)"; say "login: $ME"
  say "org $ORG"; gh api "orgs/$ORG" -q '"2fa_required=\(.two_factor_requirement_enabled) members_can_create_repos=\(.members_can_create_repositories) default_repo_permission=\(.default_repository_permission)"' || echo "cannot read org (not a member?)"
  say "my role in $ORG"; gh api "orgs/$ORG/memberships/$ME" -q '"role=\(.role) state=\(.state)"' || echo "not a member of $ORG"
  say "repo exists?"; gh repo view "$FULL" --json url -q .url 2>/dev/null || echo "no: $FULL does not exist yet"
  say "local signing"; git config --get gpg.format || echo "gpg.format unset -> run scripts/setup-signing.sh first"; git config --get user.signingkey || true
}

create() {
  need gh
  if gh repo view "$FULL" --json url -q .url >/dev/null 2>&1; then echo "$FULL already exists"; else
    echo "+ gh repo create $FULL --public"
    gh repo create "$FULL" --public --description "$DESC" --disable-wiki --disable-issues=false
  fi
  if git remote get-url origin >/dev/null 2>&1; then echo "origin = $(git remote get-url origin)"; else
    git remote add origin "https://github.com/$FULL.git"; echo "origin added: https://github.com/$FULL.git"; fi
}

settings() {
  need gh
  echo "+ merge policy, sign-off, housekeeping"
  gh api -X PATCH "repos/$FULL" \
    -F web_commit_signoff_required=true \
    -F delete_branch_on_merge=true \
    -F allow_merge_commit=false -F allow_squash_merge=true -F allow_rebase_merge=true \
    -F allow_auto_merge=false -F allow_update_branch=true \
    -F has_wiki=false -F has_projects=false -F has_discussions=false \
    -f squash_merge_commit_title=PR_TITLE -f squash_merge_commit_message=PR_BODY >/dev/null
  echo "+ security features"
  gh api -X PUT "repos/$FULL/vulnerability-alerts" >/dev/null && echo "  dependabot alerts on"
  gh api -X PUT "repos/$FULL/automated-security-fixes" >/dev/null && echo "  dependabot security updates on"
  gh api -X PUT "repos/$FULL/private-vulnerability-reporting" >/dev/null && echo "  private vulnerability reporting on"
  gh api -X PATCH "repos/$FULL" --input - <<'JSON' >/dev/null && echo "  secret scanning + push protection on"
{"security_and_analysis":{"secret_scanning":{"status":"enabled"},"secret_scanning_push_protection":{"status":"enabled"}}}
JSON
  echo "+ actions policy: only actions from GitHub and verified creators, pinned in workflows"
  gh api -X PUT "repos/$FULL/actions/permissions" --input - <<'JSON' >/dev/null && echo "  actions restricted"
{"enabled":true,"allowed_actions":"selected"}
JSON
  gh api -X PUT "repos/$FULL/actions/permissions/selected-actions" --input - <<'JSON' >/dev/null && echo "  github-owned + verified only"
{"github_owned_allowed":true,"verified_allowed":true,"patterns_allowed":[]}
JSON
  gh api -X PUT "repos/$FULL/actions/permissions/workflow" --input - <<'JSON' >/dev/null && echo "  GITHUB_TOKEN read-only by default"
{"default_workflow_permissions":"read","can_approve_pull_request_reviews":false}
JSON
}

teams() {
  need gh
  for t in pqc-conveners:maintain pqc-maintainers:maintain pqc-evaluation:push pqc-testbed:push; do
    name="${t%%:*}"; perm="${t##*:}"
    if gh api "orgs/$ORG/teams/$name" -q .slug >/dev/null 2>&1; then echo "team $name exists"; else
      echo "+ create team $name"; gh api -X POST "orgs/$ORG/teams" -f name="$name" -f privacy=closed -f description="PQC agility competition: $name" >/dev/null; fi
    echo "+ grant $name -> $perm on $REPO"
    gh api -X PUT "orgs/$ORG/teams/$name/repos/$FULL" -f permission="$perm" >/dev/null
  done
  echo "note: CODEOWNERS references @$ORG/pqc-conveners etc. Add members: gh api -X PUT orgs/$ORG/teams/pqc-conveners/memberships/<login> -f role=maintainer"
}

rulesets() {
  need gh
  existing="$(gh api --paginate "repos/$FULL/rulesets" -q '.[] | "\(.id) \(.name)"')"
  for f in .github/rulesets/*.json; do
    name="$($PY -c "import json,sys;print(json.load(open(sys.argv[1]))['name'])" "$f")"
    id="$(printf '%s\n' "$existing" | awk -v n="$name" '{ id=$1; $1=""; sub(/^ /,""); if ($0==n) print id }' | head -1)"
    if [ -n "$id" ]; then echo "+ update ruleset '$name' (#$id)"; gh api -X PUT "repos/$FULL/rulesets/$id" --input "$f" >/dev/null
    else echo "+ create ruleset '$name'"; gh api -X POST "repos/$FULL/rulesets" --input "$f" >/dev/null; fi
  done
}

key() {
  need gh
  KEY="$(git config --get user.signingkey || true)"
  [ -n "$KEY" ] && [ -f "$KEY" ] || { echo "no user.signingkey configured; run scripts/setup-signing.sh" >&2; exit 1; }
  fp="$(cut -d' ' -f2 "$KEY")"
  if gh api user/ssh_signing_keys -q '.[].key' | grep -q -F "$fp"; then echo "signing key already registered on GitHub"; else
    echo "+ gh ssh-key add $KEY --type signing"; gh ssh-key add "$KEY" --type signing --title "pqc-agility signing $(date +%Y-%m-%d)"; fi
}

push() {
  need gh; need git
  [ "$(git config --get commit.gpgsign)" = "true" ] || { echo "commit.gpgsign is not true; run scripts/setup-signing.sh" >&2; exit 1; }
  git config core.hooksPath .githooks
  if [ -z "$(git log --oneline -1 2>/dev/null)" ]; then
    echo "+ first signed commit"; git add -A; git commit -s -S -m "Charter the repository" -m "BGIN coordination repository for the METI/NEDO PQC Migration Prize Competition: governance, outcomes, evaluation drafts, testbed specification, workshop roadmap, and the signing and review enforcement layer."
  fi
  git log --show-signature -1 | head -12
  scripts/verify-history.sh HEAD
  read -r -p "push main to https://github.com/$FULL ? [y/N] " a; [ "$a" = "y" ] || { echo "not pushed"; exit 0; }
  git push -u origin main
}

verify() {
  need gh
  say "repo"; gh api "repos/$FULL" -q '"visibility=\(.visibility) default=\(.default_branch) web_signoff=\(.web_commit_signoff_required) merge_commit=\(.allow_merge_commit) squash=\(.allow_squash_merge) rebase=\(.allow_rebase_merge) wiki=\(.has_wiki)"'
  say "rulesets"; gh api --paginate "repos/$FULL/rulesets" -q '.[] | "\(.id) \(.enforcement) \(.target) \(.name)"'
  for id in $(gh api --paginate "repos/$FULL/rulesets" -q '.[].id'); do gh api "repos/$FULL/rulesets/$id" -q '"  \(.name): " + ([.rules[].type] | join(", "))'; done
  say "security"; gh api "repos/$FULL" -q '.security_and_analysis'
  say "latest commits"; gh api "repos/$FULL/commits?per_page=5" -q '.[] | "\(.sha[0:7]) verified=\(.commit.verification.verified) \(.commit.verification.reason) | \(.commit.message | split("\n")[0])"' 2>/dev/null || echo "(no commits yet)"
  say "org-level items only an owner can set (see docs/SECURITY_MODEL.md)"; echo "  2FA required, org ruleset 'no creations', base permission, DCO app, org Actions policy"
}

case "${1:-}" in
  preflight|create|settings|teams|rulesets|key|push|verify) "$1" ;;
  all) preflight; create; settings; teams; rulesets; key; echo; echo "done (nothing pushed). Next: scripts/bootstrap-github.sh push" ;;
  *) sed -n '2,15p' "$0"; exit 2 ;;
esac
