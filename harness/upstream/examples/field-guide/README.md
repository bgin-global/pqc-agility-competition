# the spar — reset to its baseline

A practice bout: compress `artifact/GUIDE.md` (730 words,
measured by: `tr -s '[:space:]' '\n' < artifact/GUIDE.md | grep -c .  (whitespace-split tokens of the full markdown file)`) while the census gate stays a full
pass — every enumerable fact probed, drawn against the ORIGINAL by hashing
your proposal with a run secret you never see. No folds have happened here:
OT-1 is open, the frontier is yours to move, and the first chronicle is
yours to write.

Run a round with a driver (no model, a local model, or the Claude API):

```bash
node drivers/run.mjs --instance examples/field-guide --driver stub --run smoke
node drivers/run.mjs --instance examples/field-guide --driver ollama --model <m> --run r1
node drivers/run.mjs --instance examples/field-guide --driver anthropic --run r1      # ANTHROPIC_API_KEY
```

Or with the Claude Code Workflow tool (the reference runtime):

```
scriptPath: examples/field-guide/harness.workflow.mjs
args: { "repo": "<abs>/examples/field-guide", "root": "<abs of this clone>", "runId": "r1" }
```

Then audit (`node tools/verify_run.mjs examples/field-guide r1`), fold as
keystone (`seats/keystone.md`), and seal (`node tools/mint_artefact.mjs`).
The origin repository's spar walked this same ground to a validated 472 —
its chronicles are the worked example; its numbers are not yours to inherit.
