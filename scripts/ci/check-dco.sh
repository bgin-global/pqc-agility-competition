#!/usr/bin/env bash
# Every commit in $BASE..$HEAD (or the whole history if unset) carries a Signed-off-by trailer that matches
# the commit author's name and email. Runs in CI (provenance.yml, job "dco") and locally.
set -uo pipefail
if [ -n "${BASE:-}" ] && [ "${BASE}" != "0000000000000000000000000000000000000000" ]; then range="${BASE}..${HEAD:-HEAD}"; else range="${HEAD:-HEAD}"; fi
fail=0; n=0
for c in $(git rev-list "$range"); do
  n=$((n+1))
  an="$(git log -1 --format='%an' "$c")"; ae="$(git log -1 --format='%ae' "$c")"
  if ! git log -1 --format='%B' "$c" | grep -q -F "Signed-off-by: $an <$ae>"; then
    echo "::error::commit ${c:0:7} lacks 'Signed-off-by: $an <$ae>' (DCO.md)"; fail=1
  fi
done
echo "checked $n commit(s) in $range"
exit $fail
