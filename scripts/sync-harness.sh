#!/usr/bin/env bash
# sync-harness.sh — harness-only sync of harness/upstream/ from a pinned commit
# of the agentprivacy dual-agent harness. Never touches harness/instance/.
#
#   scripts/sync-harness.sh <path-to-harness-checkout> [commit]
#   scripts/sync-harness.sh --verify            # recompute hashes against harness/UPSTREAM.json
#
# The pattern is the one the community benchmark CLIs use for `sync
# --harness-only`: tracked non-editable files are replaced from upstream, the
# editable paths (here: the instance) are preserved exactly, and a dirty
# instance refuses the sync so nothing is silently overwritten. The vendored
# distribution is dist/default-harness of the upstream repository at the pinned
# commit; harness/UPSTREAM.json carries the commit and a sha256 per file so the
# record is self-contained and auditable offline.
set -euo pipefail
PY=""; for c in python3 python; do if command -v "$c" >/dev/null 2>&1 && "$c" -c "import sys" >/dev/null 2>&1; then PY="$c"; break; fi; done; [ -n "$PY" ] || { echo "python3 or python is required"; exit 1; }
cd "$(dirname "$0")/.."
UP=harness/upstream
MANIFEST=harness/UPSTREAM.json

hash_tree() { # <dir> -> sorted "path  sha256" lines, paths relative to <dir>
  (cd "$1" && find . -type f | sed 's|^\./||' | LC_ALL=C sort | while read -r f; do printf '%s  %s\n' "$f" "$(sha256sum "$f" | cut -d' ' -f1)"; done)
}

write_manifest() { # <repo-url> <commit> <dist-path>
  "$PY" - "$1" "$2" "$3" <<'EOF'
import json, sys, os, hashlib
repo, commit, dist = sys.argv[1:4]
files = {}
for root, _, names in os.walk('harness/upstream'):
    for n in names:
        p = os.path.join(root, n)
        rel = os.path.relpath(p, 'harness/upstream').replace(os.sep, '/')
        files[rel] = hashlib.sha256(open(p, 'rb').read()).hexdigest()
old = json.load(open('harness/UPSTREAM.json')) if os.path.exists('harness/UPSTREAM.json') else {}
doc = {
  "$comment": "Pinned upstream of harness/upstream/. Regenerate with scripts/sync-harness.sh; verify with scripts/sync-harness.sh --verify. The instance (harness/instance/) is never touched by a sync.",
  "repository": repo,
  "commit": commit,
  "distribution": dist,
  "license": "Apache-2.0 (upstream LICENSE vendored at harness/upstream/LICENSE)",
  "vendored_at": __import__('datetime').date.today().isoformat(),
  "knownDefects": old.get("knownDefects", []),
  "files": dict(sorted(files.items())),
}
with open('harness/UPSTREAM.json', 'w', newline='\n') as fh:
    json.dump(doc, fh, indent=2); fh.write('\n')
print(f"UPSTREAM.json: {len(files)} files, commit {commit}")
EOF
}

if [ "${1:-}" = "--verify" ]; then
  [ -f "$MANIFEST" ] || { echo "no $MANIFEST"; exit 1; }
  listing=$(mktemp)
  "$PY" - "$MANIFEST" "$listing" <<'EOF'
import json, sys
d = json.load(open(sys.argv[1]))
with open(sys.argv[2], 'w', newline='\n') as fh:
    for k, v in sorted(d['files'].items()):
        fh.write(f"{k}\t{v}\n")
print(f"{len(d['files'])} files, commit {d['commit']}")
EOF
  fail=0
  while IFS=$'\t' read -r f h; do
    [ -f "$UP/$f" ] || { echo "MISSING $f"; fail=1; continue; }
    have=$(sha256sum "$UP/$f" | cut -d' ' -f1)
    [ "$have" = "$h" ] || { echo "MISMATCH $f"; fail=1; }
  done < "$listing"
  extra=$(comm -23 <(cd "$UP" && find . -type f | sed 's|^\./||' | LC_ALL=C sort) <(cut -f1 "$listing" | LC_ALL=C sort))
  [ -z "$extra" ] || { echo "UNLISTED files in $UP:"; echo "$extra"; fail=1; }
  rm -f "$listing"
  [ $fail -eq 0 ] && echo "harness/upstream matches UPSTREAM.json"
  exit $fail
fi

SRC="${1:?usage: scripts/sync-harness.sh <path-to-harness-checkout> [commit] | --verify}"
[ -d "$SRC/dist/default-harness" ] || { echo "$SRC has no dist/default-harness"; exit 1; }
if [ -n "$(git status --porcelain -- harness/instance)" ]; then
  echo "refusing: harness/instance has uncommitted changes — commit or stash them first (the sync never touches the instance, but a dirty tree makes the diff unreadable)"; exit 1
fi
COMMIT="${2:-$(git -C "$SRC" rev-parse --short HEAD)}"
if [ -n "$(git -C "$SRC" status --porcelain -- dist/default-harness)" ]; then
  echo "refusing: $SRC/dist/default-harness is dirty in the upstream checkout — commit upstream first so the pin means something"; exit 1
fi
REPO_URL=$(git -C "$SRC" remote get-url origin 2>/dev/null | sed -E 's#\.git$##; s#git@github.com:#https://github.com/#')
rm -rf "$UP"; mkdir -p "$UP"; cp -r "$SRC/dist/default-harness/." "$UP/"
write_manifest "$REPO_URL" "$COMMIT" "dist/default-harness"
git add -A "$UP" "$MANIFEST"
git diff --cached --stat -- "$UP" "$MANIFEST" | tail -1
echo "synced harness/upstream from $SRC @ $COMMIT — review the staged diff, run scripts/ci/check-harness.sh, then commit (signed)."
