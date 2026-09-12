// harness.config.mjs — the pqc-calibration instance (draft v0, T1 verify-single).
//
// The calibration harness of the PQC Migration Prize testbed, as a dual-agent
// harness instance: the PROPOSER is a submitter (an implementation of a
// pre-existing signature scheme inside the track's editable paths); the PROVER
// is a testbed node (it runs the drawn instances inside the sandbox and signs
// what it measured); the GAP between them is the fixture draw, derived from the
// submission's digest and a round secret the submitter never sees. See
// docs/AUTORESEARCH.md §5b and testbed/tracks/T1-verify-single/.
//
// Lineage: scaffolded from the agentprivacy dual-agent harness default
// distribution vendored at ../upstream (harness/UPSTREAM.json pins the commit).
// Contract: ../upstream/SEAT_CONTRACT.md. Constitution: ../upstream/TRUSTS.md.
//
// Status: this instance runs the plumbing (stub driver) today. A real round
// needs the harness v0 of testbed/HARNESS.md §7, which tools/measure.mjs will
// call; until then measure.mjs reports the frontier as unmeasured and the assay
// seat returns BLOCKED for want of executable evidence (GR-4: never imagined).

const TRACK = '../../testbed/tracks/T1-verify-single'
const SCALAR_RULE =
  'scalar = median_verify_us(S-01 ML-DSA-65) / median_verify_us(B-01), both measured by the trusted harness on the reference runner ' +
  '(testbed/tracks/T1-verify-single/runner.json) over the drawn instance sequence; lower is better; the median is over timed_ops_min ops after warmup_ops'

export default {
  name: 'pqc-calibration',

  objective: {
    metric: 'T1 scalar: ' + SCALAR_RULE + '. frontier.json carries the promoted reference implementation\'s scalar (GR-1).',
    gate:
      'The track gates, as an AND (T5: any zero collapses): known-answer tests for ML-DSA-65 pass · the build is pinned (repository, commit, build flags, ' +
      'compiler, container digest in the manifest) · no network during setup or run · result.json validates against testbed/schema/result.schema.json and ' +
      'carries manifest.runner matching runner.json and manifest.draw whose seed re-derives · the operator attestation is present · reproduced on >= k nodes ' +
      'in >= 2 regions within the tolerance band (decisions/0002; until then k = 1 on the T0 runner and the verdict is a CLAIMED score, never a promotion).',
    hardConstraint:
      'Only backends/ml-dsa/ changed; verification unchanged in what it checks (no skipped check, no weakened acceptance); parameter set unchanged; ' +
      'nothing moved out of the timed region; the submission note is present, >= 5 KiB, and names Model, Harness and Effort (RULES.md).',
    // The canary: the promoted reference implementation itself (or, before any
    // promotion, the pinned baseline backend). It passes every gate by
    // construction, so an 8/8-style full pass is reachable and a failure is
    // always the candidate's, never the gate's.
    canary:
      'The current reference implementation (frontier.json best; before the first promotion, the pinned baseline ML-DSA-65 backend named in ' +
      'testbed/tracks/T1-verify-single/benchmark.json). It passes the KATs, builds pinned, validates against the schema and reproduces on itself ' +
      'within any tolerance — the feasible set is non-empty by construction.',
  },

  door: 'first-person', // T6 — submit, push, publish and the node onboarding are the First Person's

  // The witness bank is the fixture bank: 2^16 32-byte digests (T1 fixtures/README.md).
  // Too large to enumerate, so the gate is a SAMPLE: the engine draws `count`
  // instance indices from the seed. Detection here is not "did a fact survive"
  // but "does the median move outside the tolerance band on a draw the
  // proposer could not predict"; the assay seat prints that in its coverage
  // stanza so no reader mistakes a sample for a census.
  gate: { N: 65536, count: 10000, mode: 'sample', censusThreshold: 200 },

  // hSource: the runner hashes this file and binds every seed to it. Today it
  // is the track manifest; when the fixture bank is published it becomes the
  // bank's digest file, which is what fixtures/README.md calls h_fixtures.
  sourceFile: TRACK + '/benchmark.json',

  heldApartRule:
    'You are BLIND to verification witnesses (T2/GR-4). After you commit your submission, the engine derives ' +
    'seed = SHA-256(h_fixtures || h_submission || salt) — h_fixtures from the published fixture bank, h_submission from the ' +
    'canonical bytes of YOUR proposal, salt from a round secret you never see — and draws the instance sequence the nodes will ' +
    'time. You cannot predict which 32-byte digests are timed, so there is nothing to tune to; a backend that inspects fixture ' +
    'identity, caches by input, or special-cases known-answer vectors is invalid regardless of its scalar. The round secret is ' +
    'one secret per round, shared with the k assay nodes after your commitment and revealed with the results, so every node ' +
    'runs the same draw and the auditor can re-derive it from published bytes. Do not suggest, request, or optimise for any ' +
    'particular inputs.',

  keystoneOnlyWrites: ['frontier.json', 'claims_register.md', 'manifest.yaml'],

  // One lens per lever family. Each proposes exactly one change confined to
  // backends/ml-dsa/. Distinct by construction (conform checks it).
  finders: [
    { lens: 'vectorised-ntt', hint: 'the number-theoretic transform and pointwise multiplication in verification: SIMD width, butterfly scheduling, lazy reduction, precomputed twiddles. Never change what is verified.' },
    { lens: 'hash-path', hint: 'the SHAKE/SHA-3 absorption and expansion on the verify path: fewer squeezes, batching the matrix expansion, avoiding recomputation of rho-derived material. Never change what is verified.' },
    { lens: 'memory-layout', hint: 'data layout and allocation on the verify path: stack versus heap, alignment, avoiding copies of the public key and signature, cache behaviour over 10^4 verifications. Never change what is verified.' },
    { lens: 'verify-batch-reuse', hint: 'work that is legitimately shareable across verifications under the same public key (matrix expansion, precomputed tables) without moving any per-signature check out of the timed region. Never change what is verified.' },
  ],

  prompts: {
    measure: (ctx) =>
      `Seat MEASURE. The counting rule is code: ${ctx.repo}/tools/measure.mjs ran before this round and its JSON is ${JSON.stringify(ctx.args?.measured ?? null)}. ` +
      `The rule it implements: ${SCALAR_RULE}. Compare to ${ctx.repo}/frontier.json (baseline and best); flag stale if they disagree; if measured.status is "unmeasured" say so — the frontier is not yet measured and every metric this round is a claimed number at best. ` +
      `Then price the four lever families (vectorised-ntt, hash-path, memory-layout, verify-batch-reuse): rough cost to try, rough ceiling as a scalar if fully successful. Numbers only, no advocacy.`,

    propose: (finder, measure, ctx) =>
      `Seat PROPOSE — soulbae 🧙 (bnot), lens = ${finder.lens}: ${finder.hint}
Frontier context: ${JSON.stringify(measure)}.
Read ${ctx.repo}/notes/KILLED_LEVERS.md first (never re-propose a K-id without new cited evidence) and ${ctx.repo}/${TRACK}/RULES.md (what may be edited, what may not).
Propose exactly 1 lever through YOUR lens as a submission: a unified diff confined to backends/ml-dsa/ (field "patch"), the public submission note (field "note", >= 5120 characters, following ${ctx.repo}/../../testbed/tracks/SUBMISSION_NOTE_TEMPLATE.md), and your attribution (fields "model", "harness", "effort" — exact underlying model, the harness you are running in, the effort level; never a family-only label). State expectedMetric = the scalar you expect on the reference runner and hardConstraintNote = why verification is unchanged in what it checks. Plan and write text only — never touch files; the Gap hashes what you return.`,

    holdApart: (proposal, i, ctx, derived) => derived
      ? `Seat HOLD-APART — the Gap ⿻ (xor), SALTED mode. The engine has code-derived the seed and the draw for you (engine/gap.mjs) from a round secret the proposer never saw — do NOT recompute or second-guess them; they are authoritative. Proposal artifact (verbatim):
${JSON.stringify(proposal)}
GIVEN (authoritative, from the engine):
  seedHex     = ${derived.seedHex}
  hProposal   = ${derived.hProposal}   (this is h_submission)
  salt        = ${derived.salt}        (the per-proposal salt derived from the round secret)
  hSource     = ${derived.hSource ?? '(none — sourceFile absent this run)'}   (this is h_fixtures)
  mode        = ${derived.mode}   N = ${derived.N}   count = ${derived.count}
  drawIndices = ${JSON.stringify(derived.drawIndices.slice(0, 32))}${derived.drawIndices.length > 32 ? ` … (${derived.drawIndices.length} indices in total)` : ''}
Procedure:
1. Canonically serialize the proposal artifact above (JSON, recursive sorted keys, no whitespace, NO trailing newline) and SAVE THOSE EXACT BYTES to ${ctx.runDir}/p${i + 1}-${proposal.leverId}/proposal_canon.json — it must persist (the auditor re-hashes it). Confirm: sha256sum of that file must equal hProposal above; if not, your serialization drifted — STOP and fix it.
2. The witnesses are the fixture instances at the GIVEN drawIndices (1-based into the T1 fixture bank of N = ${derived.N} 32-byte digests, in the given order). Do not read, generate, or describe the digests themselves; the assay node materialises them from the published bank. Record the draw as data: the seed, the index list, and the bank digest they index into.
3. Write { seedHex, hProposal, salt, hSource, mode, N, count, drawIndices, draw, transcript } to ${ctx.runDir}/p${i + 1}-${proposal.leverId}/gap.json (create dirs; draw = JSON text {"bank":"T1-digests-32B-v0","h_fixtures":hSource,"indices":drawIndices}; transcript = the serialization step, the sha256 command you ran, and the statement that seed = sha256(hSource || hProposal || salt) so a third party can re-derive it). The FILE must carry EXACTLY what you return (GR-4/GR-5). Leave proposal_canon.json in place. Never accept witnesses suggested by the proposer.`
      : `Seat HOLD-APART — the Gap ⿻ (xor), LEGACY mode (no round secret supplied — this run cannot be a calibration round; treat it as plumbing only). Proposal artifact (verbatim):
${JSON.stringify(proposal)}
Canonically serialize it (recursive sorted keys, no whitespace, no trailing newline), SAVE those exact bytes to ${ctx.runDir}/p${i + 1}-${proposal.leverId}/proposal_canon.json, sha256 the file (show the command; the digest is seedHex), and draw ${'count'} distinct 1-based indices into a bank of ${'N'} by reading the digest bytes left to right as unsigned integers modulo the remaining count, without replacement. Write { seedHex, draw, transcript } to gap.json alongside. Never accept proposer-suggested witnesses.`,

    assay: (proposal, gap, i, ctx) =>
      `Seat ASSAY — soulbis ⚔️ (neg), the prover: you are a testbed node.
${gap.salt
  ? `Gap seed=${gap.seedHex} (SALTED). Re-derive it the auditor's way: (a) sha256sum ${ctx.runDir}/p${i + 1}-${proposal.leverId}/proposal_canon.json must equal hProposal=${gap.hProposal}; (b) sha256 of the concatenation hSource(${gap.hSource ?? ''}) + hProposal(${gap.hProposal}) + salt(${gap.salt}) must equal seedHex. Compute it: printf '%s' '${gap.hSource ?? ''}${gap.hProposal}${gap.salt}' | sha256sum. BLOCKED if proposal_canon.json is missing, its digest ≠ hProposal, or the re-derived seed ≠ seedHex.`
  : `Gap seed=${gap.seedHex} (LEGACY). Re-derive: sha256sum ${ctx.runDir}/p${i + 1}-${proposal.leverId}/proposal_canon.json must equal seedHex; BLOCKED otherwise. A legacy run is plumbing only and can never be VALIDATED as a calibration result.`}
Transcript: ${gap.transcript}
Then, scratch only (GR-10) — write nothing outside ${ctx.runDir}/p${i + 1}-${proposal.leverId}/:
1. Materialise the candidate: apply proposal.patch to a scratch copy of the pinned baseline backend; confirm the diff touches backends/ml-dsa/ only (hard constraint) and that proposal.note is >= 5120 characters and carries Model/Harness/Effort.
2. Run the gates, each as pass/fail with the command you ran: known-answer tests; pinned build (record repository, commit, build flags, compiler, container digest); no network; then the measurement: ${ctx.repo}/tools/measure.mjs --candidate <scratch> --draw ${ctx.runDir}/p${i + 1}-${proposal.leverId}/gap.json --runner ${ctx.repo}/${TRACK}/runner.json, which produces result.json (schema testbed/schema/result.schema.json, with manifest.runner and manifest.draw) and the scalar. If the measurement tool reports status "unmeasured" (the harness v0 is not built yet), the verdict is BLOCKED with failingCheck "executable evidence absent: harness v0 (HARNESS.md §7) not built" — never an imagined number (GR-4).
3. Verdict VALIDATED only if EVERY gate passed AND the hard constraint holds AND the scalar beats frontier.json best by more than the promotion bar (read ${ctx.repo}/frontier.json; if the bar is null the verdict is at most CLAIMED — write status MIRAGE with failingCheck "promotion bar unset (decisions/0002)" so the keystone cannot fold it). A gate fail on a candidate that "reads fine" is a MIRAGE — name the gate. Report a coverage stanza { mode: "${gap.mode || 'sample'}", N: ${gap.N || 65536}, count: ${gap.count || 10000}, detection: "a draw of count/N instances the proposer could not predict; the median is robust to any subset it did not see" }.
4. Write verdict.json to ${ctx.runDir}/p${i + 1}-${proposal.leverId}/ with EXACTLY the schema's shape — flat fields, metric a bare number (the scalar) or absent when BLOCKED, gateResult "passed/total", runner as recorded, resultPath, coverage, failingCheck (empty if none), evidence, scratchDir. The file an auditor reads must match the data the orchestrator receives. Your only output on disk is verdict.json in your scratch dir.`,

    critic: (proposals, verdicts, ctx) =>
      `Seat CRITIC — frontier archaeology in one paragraph per lever. Proposals: ${JSON.stringify(proposals.map(p => ({ leverId: p.leverId, lens: p.lens, title: p.title, expectedMetric: p.expectedMetric, model: p.model, harness: p.harness })))}
Verdicts: ${JSON.stringify(verdicts)}
For each closed lever: classify structural / probe-limited / noise / mis-gated; name the single change the patch made (one lever per submission — if it changed several things, say so, that is itself a finding); say whether it is transferable (a structural change, a knob) or an artifact (a constant tuned to this runner that will not transfer); say where the binding cost on the verify path moved. Red-team the proposer's rationale, never the prover's verdict. Draft KILLED_LEVERS entries for structural kills with a re-open condition. Name exactly ONE next lead.`,

    chronicle: (round, ctx) =>
      `Seat CHRONICLE. Draft ${ctx.runDir}/CHRONICLE_DRAFT.md following ${ctx.root}/templates/chronicle.md: verdict first (cite frontier.json only for numbers), what happened in order (measure → proposals → gap seeds → assay → critic), reversals at win-prominence, ledger entries returned (claims_register / KILLED_LEVERS proposals for the keystone), handoff ending in the critic's nextLead. Round data: ${JSON.stringify({ roundId: round.roundId, measure: round.measure, proposals: round.proposals.map(p => ({ leverId: p.leverId, lens: p.lens, expectedMetric: p.expectedMetric, model: p.model, harness: p.harness, effort: p.effort })), verdicts: round.verdicts, critic: round.critic })}. Return the path plus a 5-line verdict summary.`,
  },

  schemas: {
    measure: {
      type: 'object', required: ['metric', 'stale', 'leverCosts'],
      properties: {
        metric: { type: ['number', 'null'], description: 'the T1 scalar as measured by tools/measure.mjs; null while unmeasured' },
        stale: { type: 'boolean' },
        status: { type: 'string', enum: ['measured', 'unmeasured'] },
        leverCosts: { type: 'array', items: { type: 'object', required: ['lever', 'cost', 'ceiling'], properties: { lever: { type: 'string' }, cost: { type: 'string' }, ceiling: { type: 'string' } } } },
        notes: { type: 'string' },
      },
    },
    proposal: {
      type: 'object', required: ['proposals'],
      properties: {
        proposals: {
          type: 'array', minItems: 1,
          items: {
            type: 'object',
            required: ['leverId', 'title', 'lens', 'rationale', 'expectedMetric', 'hardConstraintNote', 'patch', 'note', 'model', 'harness', 'effort'],
            properties: {
              leverId: { type: 'string', description: 'short kebab id, e.g. ntt-lazy-reduction' },
              title: { type: 'string' }, lens: { type: 'string' },
              rationale: { type: 'string' }, expectedMetric: { type: 'number' },
              hardConstraintNote: { type: 'string' },
              patch: { type: 'string', description: 'unified diff confined to backends/ml-dsa/' },
              note: { type: 'string', description: 'the public submission note, >= 5120 characters' },
              model: { type: 'string', description: 'exact underlying model, fully qualified' },
              harness: { type: 'string', description: 'the coding agent or autoresearch harness, or "none"' },
              effort: { type: 'string' },
              killedLeverCitations: { type: 'array', items: { type: 'string' } },
            },
          },
        },
      },
    },
    gap: {
      type: 'object', required: ['seedHex', 'draw', 'transcript'],
      properties: {
        seedHex: { type: 'string' }, hProposal: { type: 'string' }, salt: { type: 'string' }, hSource: { type: ['string', 'null'] },
        mode: { type: 'string' }, N: { type: 'integer' }, count: { type: 'integer' },
        drawIndices: { type: 'array', items: { type: 'integer' } },
        draw: { type: 'string', description: 'the witnesses drawn, as data: bank id, h_fixtures, indices' },
        transcript: { type: 'string', description: 'serialization + hash command + the seed rule, third-party re-derivable' },
      },
    },
    verdict: {
      type: 'object', required: ['leverId', 'status', 'evidence'],
      properties: {
        leverId: { type: 'string' },
        status: { type: 'string', enum: ['VALIDATED', 'MIRAGE', 'BLOCKED'] },
        metric: { type: 'number', description: 'the T1 scalar; absent when BLOCKED' },
        gateResult: { type: 'string', description: 'passed/total' },
        runner: { type: 'object' },
        resultPath: { type: 'string' },
        coverage: { type: 'object' },
        failingCheck: { type: 'string' }, evidence: { type: 'string' }, scratchDir: { type: 'string' },
      },
    },
    critic: {
      type: 'object', required: ['classifications', 'nextLead'],
      properties: {
        classifications: { type: 'array', items: { type: 'object', required: ['leverId', 'class', 'why'], properties: { leverId: { type: 'string' }, class: { type: 'string', enum: ['structural', 'probe-limited', 'noise', 'mis-gated'] }, why: { type: 'string' }, lever: { type: 'string' }, transferable: { type: 'boolean' }, binderMovedTo: { type: 'string' } } } },
        nextLead: { type: 'string' },
        killedLeverDrafts: { type: 'array', items: { type: 'string' } },
      },
    },
  },

  stop: { dryRounds: 2, maxRounds: 5 },

  isValidated: (v) => v.status === 'VALIDATED',
  isStructural: (critic, leverId) =>
    (critic.classifications || []).some(c => c.leverId === leverId && c.class === 'structural'),

  // Instance-specific checks conform.mjs runs on frontier.json (the four ways
  // this instance can lie while looking green — chronicle 2026-09-12 §5.9).
  conformChecks: [
    (f) => {
      const errs = []
      const bar = f?.promotion?.minScoreImprovementBips
      const tol = f?.promotion?.toleranceBips
      if (bar != null && tol != null && bar < tol) errs.push(`promotion bar (${bar} bips) is below the tolerance band (${tol} bips): a promotion inside the noise`)
      if (f?.promotion?.saltScope && f.promotion.saltScope !== 'round') errs.push(`promotion.saltScope must be "round" (every node must run the same draw), got ${f.promotion.saltScope}`)
      if (f?.best?.metric != null && f?.best?.attestations != null && f.best.attestations < (f?.promotion?.k ?? 1)) errs.push(`best.metric is recorded with ${f.best.attestations} attestations, fewer than promotion.k=${f?.promotion?.k}`)
      if (f?.baseline?.metric != null && f?.baseline?.runner == null) errs.push('baseline.metric is recorded without the runner it is valid on')
      return errs
    },
  ],
}
