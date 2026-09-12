# Claims register

Every load-bearing claim gets a CR-id and a tier (GR-2). Prose elsewhere may
assert nothing that does not resolve to a CR-id here. Keystone-only writes;
other seats return proposed entries.

Tiers (epistemic strength): **PROVEN** (executed here, re-runnable) ·
**DERIVED** (follows from a PROVEN claim, derivation cited) · **REPORTED**
(external, slug-cited via SOURCES.md) · **OPEN** (must state what would settle
it) · **MYTH** (chronicles only).

**enforced by** (the second axis — the *mechanism*, not the strength; D4):
`code` (a gate re-runs it) · `protocol` (impossible-by-construction, e.g. a
hash commitment) · `runtime` (denied by the sandbox/mount) · `prompt` (a seat
card asks) · `manual` (honest human discipline) · `nothing` (unenforced).
`tools/check_claims.mjs` is a hard gate: **a PROVEN or DERIVED claim enforced
only by `prompt`, `manual`, or `nothing` is a failure** — it is a claim
stronger than its enforcement. Downgrade the tier or build the enforcement.
When enforcement is improving, write `now → later, post-Cx` and the checker
reads the *current* (pre-arrow) value.

| id | claim | tier | enforced by | evidence | status |
|---|---|---|---|---|---|
| CR-1 | Baseline metric is N by the counting rule in frontier.json | PROVEN | code | frontier.json baseline.how, run of YYYY-MM-DD | accepted |

## Claims

| id | claim | tier | enforced by | evidence | what would settle it |
|---|---|---|---|---|---|
| C-PQC-1 | The fixture draw — seed = sha256(h_fixtures ‖ h_submission ‖ salt_round) — makes fixture overfitting impossible by construction, not by rule | OPEN (argued) | nothing → protocol, post D-1 fix and first node round | `plan` §5b; `smoke` shows the seed binding to hSource | a node result whose `manifest.draw` re-derives from published bytes on a bank the submitter did not see; D-1 fixed first (a biased draw is tunable) |
| C-PQC-2 | A promotion is k independent attestations over one draw; a single-node verdict is a claimed score | OPEN (specified) | manual → code, once `frontier.json` records `promotion.k` and the keystone's fold rule checks `best.attestations >= k` | `harness-spec` §5 item 6; `conformChecks` in `harness.config.mjs` | decisions/0002 fixing k and the tolerance band; a fold refused for attestations < k |
| C-PQC-3 | The upstream draw is biased for N > 256 (one byte per pick) | PROVEN | code (`runs/smoke/` gap.json: 10,000 picks, max index 10,230 of 65,536) | `defects` D-1 | the upstream fix landing via `scripts/sync-harness.sh` and a re-run whose max index approaches N |

