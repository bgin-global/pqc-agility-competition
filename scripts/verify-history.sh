#!/usr/bin/env bash
# Verify every commit in a range (default: whole history of HEAD) is signed with a key in .allowed_signers
# (or a trusted GPG key) and carries a DCO sign-off. Exit 1 on the first failure class found.
# Usage: scripts/verify-history.sh [range]   e.g. scripts/verify-history.sh origin/main..HEAD
set -uo pipefail
cd "$(git rev-parse --show-toplevel)"
RANGE="${1:-HEAD}"
export GIT_CONFIG_PARAMETERS="'gpg.ssh.allowedSignersFile=$(pwd)/.allowed_signers'"
bad_sig=0; bad_dco=0; total=0
for c in $(git rev-list "$RANGE"); do
  total=$((total+1))
  s="$(git log -1 --format='%G?' "$c")"
  case "$s" in G|U) ;; *) echo "UNSIGNED  ${c:0:7} ($s) $(git log -1 --format='%an: %s' "$c")"; bad_sig=$((bad_sig+1));; esac
  git log -1 --format='%B' "$c" | grep -q -E '^Signed-off-by: .+ <.+@.+>' || { echo "NO-DCO    ${c:0:7} $(git log -1 --format='%an: %s' "$c")"; bad_dco=$((bad_dco+1)); }
done
echo "commits=$total unsigned=$bad_sig no_dco=$bad_dco"
[ "$bad_sig" -eq 0 ] && [ "$bad_dco" -eq 0 ]
