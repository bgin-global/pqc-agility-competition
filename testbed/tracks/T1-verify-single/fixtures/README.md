# T1 fixtures (pending)

Nothing here is published yet. The track opens with these files present, each with a provenance row below and a digest recorded in `benchmark.json` as `h_fixtures`.

| Fixture | Contents | Generation | Digest | Status |
|---|---|---|---|---|
| `digests-32B-v0.bin` | 2^16 32-byte messages modelled on transaction digests (BTC sighash-like, ETH tx-hash-like) | `harness fixtures gen --track T1 --seed <published>` — deterministic from a published seed | — | pending |
| `keys-n1-v0/` | ML-DSA-65 key pairs, deterministic from seed, n = 1 (T1 measures single verify) | same | — | pending |
| `kat/` | known-answer test vectors for the parameter set, from the specification's published vectors | copied, with source URL | — | pending |
| `baseline-B-01/` | the classical baseline backend pinned by repository + commit | recorded in `benchmark.json` | — | pending |

## The draw

A node does not run the bank in a fixed order. It runs the instance sequence drawn from

```
seed = SHA-256( h_fixtures || h_submission || salt_round )
```

- `h_fixtures` — digest of the bank above (published with the track).
- `h_submission` — digest of the canonical submission archive (the editable paths, sorted, LF, no timestamps).
- `salt_round` — a round secret whose hash the conveners publish before submissions close for that round; the secret is revealed with the results.

The submitter therefore commits first and cannot predict which instances are timed; every node derives the same sequence, so reproduction compares like with like; and once the salt is revealed anyone can re-derive the draw from the published bytes. Nodes may run a second, private draw (their own nonce) as a sanity check; only the round draw counts.
