#!/usr/bin/env bash
# Every commit in $BASE...$HEAD is reported by GitHub as verified (signature made with a key registered on the
# author's account, or GitHub's own key for web-flow merges). Needs GH_TOKEN with contents:read and REPO=owner/name.
set -uo pipefail
: "${REPO:?REPO=owner/name required}"; : "${HEAD:?HEAD sha required}"
if [ -n "${BASE:-}" ] && [ "${BASE}" != "0000000000000000000000000000000000000000" ]; then
  commits="$(gh api --paginate "repos/$REPO/compare/${BASE}...${HEAD}" -q '.commits[] | "\(.sha) \(.commit.verification.verified) \(.commit.verification.reason)"')"
else
  commits="$(gh api "repos/$REPO/commits/${HEAD}" -q '"\(.sha) \(.commit.verification.verified) \(.commit.verification.reason)"')"
fi
fail=0; n=0
while read -r sha ok reason; do
  [ -z "$sha" ] && continue; n=$((n+1))
  if [ "$ok" != "true" ]; then echo "::error::commit ${sha:0:7} is not verified (reason: $reason). See docs/SIGNING.md"; fail=1; fi
done <<< "$commits"
echo "checked $n commit(s)"
exit $fail
