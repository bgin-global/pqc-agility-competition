#!/usr/bin/env bash
# check-harness.sh — CI gate for the calibration harness (harness/).
#
#   1. harness/upstream/ matches harness/UPSTREAM.json byte for byte (the pin holds).
#   2. The vendored distribution passes its own gates (node harness/upstream/tools/check.mjs).
#   3. The instance's structure validates and its conformance is REPORTED.
#      Conformance is a hard gate only once frontier.json carries a measured
#      baseline (HARNESS_CONFORM_STRICT=1, or automatically when
#      frontier.baseline.metric is non-null); until then the instance is
#      expected not to conform — the harness refuses an unmeasured baseline by
#      design, and the record says so (frontier.json openTarget OT-1).
set -euo pipefail
PY=""; for c in python3 python; do if command -v "$c" >/dev/null 2>&1 && "$c" -c "import sys" >/dev/null 2>&1; then PY="$c"; break; fi; done; [ -n "$PY" ] || { echo "python3 or python is required"; exit 1; }
cd "$(dirname "$0")/../.."
command -v node >/dev/null || { echo "node is required"; exit 1; }

echo "== 1. pin"
bash scripts/sync-harness.sh --verify

echo "== 2. upstream gates"
(cd harness/upstream && node tools/check.mjs) | tail -3

echo "== 3. instance"
node harness/instance/tools/measure.mjs >/dev/null && echo "measure.mjs runs"
baseline=$("$PY" -c 'import json;print(json.load(open("harness/instance/frontier.json"))["baseline"]["metric"])' | tr -d '
')
if [ "${HARNESS_CONFORM_STRICT:-0}" = "1" ] || [ "$baseline" != "None" ]; then
  (cd harness/upstream && node engine/conform.mjs ../instance) && echo "instance conforms"
else
  set +e
  (cd harness/upstream && node engine/conform.mjs ../instance) 2>&1 | tail -4
  set -e
  echo "instance conformance reported, not enforced: baseline unmeasured (frontier.json OT-1)"
fi
