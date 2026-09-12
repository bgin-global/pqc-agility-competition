# Upstream defects found by running this instance

Filed here so the record says what was wrong and when it was fixed; reported upstream to the harness (the fix arrives by `scripts/sync-harness.sh` when the pin in `../../UPSTREAM.json` moves). Every defect below was invisible to inspection and obvious on execution — the upstream's own rule.

| id | where | found | what | fix | status |
|---|---|---|---|---|---|
| D-1 | `engine/gap.mjs` `draw()` | 2026-09-12, first stub round (N = 65,536, count = 10,000; `runs/smoke/`) | one byte per pick — `idx = bytes[k] % remaining.length` — so every pick lands in the first 256 of the remaining list; the 10,000-draw reached index 10,230 at most. Exact for a census or N ≤ 256; a biased draw for a large bank, which a proposer could tune to. | expand ≥ 4 bytes per pick and reduce a 32-bit unsigned modulo `remaining.length` (or rejection-sample); leave the census path unchanged | **FIXED upstream `ea25f42`** (draw v2; `gap.json` carries `drawVersion: 2`); vendored 2026-09-12; `runs/smoke-v2/` shows the draw reaching the top of the bank |
| D-2 | `engine/gap.mjs` `seedBytes()` | 2026-09-12, by reading | the expansion counter is one byte (`counter & 0xff`): after 256 blocks (8,192 bytes) the stream repeats, so any draw needing more bytes reuses them | a 4-byte big-endian counter in the expansion block | **FIXED upstream `ea25f42`** with D-1 (4-byte counter) |
