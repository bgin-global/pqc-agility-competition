#!/usr/bin/env bash
# Every commit in $BASE..$HEAD (or the whole history if unset) carries a Signed-off-by trailer.
#   - Human authors: the trailer must match the author's name and email exactly.
#   - GitHub App bots (author name ending in "[bot]", e.g. Dependabot): the trailer must name the bot; the email may
#     differ (Dependabot signs off as support@github.com while its author email is a noreply address). The
#     "signatures" job proves who actually committed.
# Runs in CI (provenance.yml, job "dco") and locally.
set -uo pipefail
if [ -n "${BASE:-}" ] && [ "${BASE}" != "0000000000000000000000000000000000000000" ]; then range="${BASE}..${HEAD:-HEAD}"; else range="${HEAD:-HEAD}"; fi
fail=0; n=0
for c in $(git rev-list "$range"); do
  n=$((n+1))
  an="$(git log -1 --format='%an' "$c")"; ae="$(git log -1 --format='%ae' "$c")"
  body="$(git log -1 --format='%B' "$c")"
  case "$an" in
    *"[bot]")
      if ! printf '%s\n' "$body" | grep -F "Signed-off-by: $an <" | grep -q -E '@.+>'; then
        echo "::error::bot commit ${c:0:7} lacks a 'Signed-off-by: $an <...>' trailer (DCO.md)"; fail=1
      fi ;;
    *)
      if ! printf '%s\n' "$body" | grep -q -F "Signed-off-by: $an <$ae>"; then
        echo "::error::commit ${c:0:7} lacks 'Signed-off-by: $an <$ae>' (DCO.md)"; fail=1
      fi ;;
  esac
done
echo "checked $n commit(s) in $range"
exit $fail
