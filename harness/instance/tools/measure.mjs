#!/usr/bin/env node
// measure.mjs — the counting rule as code (GR-1). The runner executes this
// before every round and hands its JSON to every prompt as ctx.args.measured.
//
//   node tools/measure.mjs                       # the frontier: measure the reference implementation
//   node tools/measure.mjs --candidate <dir> --draw <gap.json> --runner <runner.json>   # an assay
//
// Today this adapter reports UNMEASURED, honestly: the harness v0 of
// testbed/HARNESS.md §7 (the trusted scorer over liboqs ML-DSA-65 and the
// libsecp256k1 baseline, inside the sandbox, on the reference runner) is not
// built. When it exists, this file calls it and returns the scalar plus the
// path of the schema-valid result.json. Until then every assay is BLOCKED for
// want of executable evidence — never an imagined number (GR-4).
import { readFileSync, existsSync } from 'node:fs'
import { join, resolve, dirname } from 'node:path'
import { fileURLToPath } from 'node:url'

const here = dirname(fileURLToPath(import.meta.url))
const instance = resolve(here, '..')
const args = process.argv.slice(2)
const opt = (k) => { const i = args.indexOf(k); return i >= 0 ? args[i + 1] : null }
const frontier = JSON.parse(readFileSync(join(instance, 'frontier.json'), 'utf8'))
const trackDir = resolve(instance, '..', '..', 'testbed', 'tracks', frontier.track || 'T1-verify-single')
const manifest = existsSync(join(trackDir, 'benchmark.json')) ? JSON.parse(readFileSync(join(trackDir, 'benchmark.json'), 'utf8')) : null

const out = {
  status: 'unmeasured',
  metric: null,
  stale: false,
  track: frontier.track || null,
  trackStatus: manifest?.status || null,
  scalarRule: manifest?.scalar || null,
  candidate: opt('--candidate'),
  draw: opt('--draw'),
  runner: opt('--runner'),
  harnessV0: 'not built — testbed/HARNESS.md §7',
  leverCosts: [
    { lever: 'vectorised-ntt', cost: 'medium', ceiling: 'unknown until the baseline is measured' },
    { lever: 'hash-path', cost: 'medium', ceiling: 'unknown until the baseline is measured' },
    { lever: 'memory-layout', cost: 'low', ceiling: 'unknown until the baseline is measured' },
    { lever: 'verify-batch-reuse', cost: 'low', ceiling: 'unknown until the baseline is measured' },
  ],
  notes: 'frontier.baseline.metric is null; no number exists to compare against. This is the open target OT-1.',
}
process.stdout.write(JSON.stringify(out))
