# Sources

Trace or delete (GR-9): nothing is citable unless it resolves through this
registry to a concrete path or reference.

Evidence classes:

- **E-RUN** — output produced in this repo; path to the run dir or log.
- **E-DOC** — a document in this repo; path.
- **E-EXT** — external source; stable reference (URL, DOI, spec name).

| slug | class | resolves to | note |
|---|---|---|---|
| baseline-run | E-RUN | runs/r0/measure.log | first baseline measurement |
| track-t1 | E-DOC | `../../testbed/tracks/T1-verify-single/` | the track contract this instance runs: manifest, RULES, runner, fixtures README |
| plan | E-DOC | `../../docs/AUTORESEARCH.md` | §5b: proposers and provers — why the testbed is a dual-agent instance |
| upstream-pin | E-DOC | `../UPSTREAM.json` | the vendored harness, commit and hashes; known defects D-1, D-2 |
| smoke | E-RUN | `runs/smoke/` | first stub round, 2026-09-12: 4 proposals × 2 rounds, every seed re-derived by `verify_run` |
| harness-spec | E-DOC | `../../testbed/HARNESS.md` | the reproduction protocol (§5) that the promotion rule restates; §7 the unbuilt harness v0 |
| defects | E-DOC | `notes/UPSTREAM_DEFECTS.md` | D-1 biased draw, D-2 short expansion counter |

