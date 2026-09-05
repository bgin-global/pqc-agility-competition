# Reference Harness (draft v0)

> Status: **DRAFT — interface and protocol for Workshop W3; code follows the spec, not the other way round.** One common interface, one run manifest, one result schema, one reproduction protocol. That is what turns node runs into evidence.

## 1. Common interface

Every scheme backend exposes the same operations. Optional operations return "unsupported" rather than being absent, so the result schema stays uniform.

| Operation | Required | Notes |
|---|---|---|
| `keygen(param_set, seed) -> (pk, sk)` | yes | Deterministic from seed for reproducibility |
| `sign(sk, msg) -> sig` | yes | For stateful schemes (XMSS / LMS) the backend must expose and persist state; the harness records the leaf index |
| `verify(pk, msg, sig) -> bool` | yes | |
| `batch_verify([(pk, msg, sig)]) -> bool` | optional | Reports whether the scheme has a native batch path |
| `aggregate([sig]) -> agg_sig`, `verify_aggregate(...)` | optional | ETH-cons mapping |
| `sizes(param_set) -> {pk, sk, sig_min, sig_max}` | yes | |

## 2. Fixtures

- **Messages:** fixed corpora modelled on the targets — 32-byte digests (BTC sighash-like, ETH tx-hash-like) plus a variable-length corpus; seeds published.
- **Key sets:** n in {1, 64, 1024, 100000} for batch and aggregate scenarios.
- **Reference block / tx mix** for M-07 to M-09: chosen by decision record; published as a fixture file with its provenance.
- **Legacy corpus** for M-21: pre-migration signatures that must remain verifiable after cutover.

## 3. Run manifest

Recorded before the run starts; hashed; included in the result.

```
run_id, scheme_id (S-nn / B-nn / C-nn), param_set,
implementation {name, repo, commit, build_flags, compiler, version},
harness_version,
node {id, host_org, region, hw_fingerprint, os_image_digest, container_digest},
fixtures {corpus_id, key_set_id, block_mix_id},
started_at, finished_at, operator_key_id
```

## 4. Result

One JSON document per run conforming to `schema/result.schema.json`: manifest + a `measurements` array of `{metric_id (M-nn), value, unit, n, stats{min, median, p99, max}}` + `attestation` (operator signature over the canonical JSON). Raw per-operation timings are kept alongside as CSV for audit.

## 5. Reproduction protocol

1. A **reference run** is declared (manifest published).
2. At least **k independent nodes** in **at least 2 regions** execute the same manifest (same digests, same fixtures).
3. A measurement reproduces when each node's median lies within the agreed tolerance band of the reference (tolerance per metric class; hardware normalization only where a decision record allows it).
4. The reproduction count is M-18 and feeds gate G3 of the rubric.
5. All manifests, results, and attestations are published together; disagreements are published too.

## 6. Non-goals of the harness

- It does not judge. It measures and attests.
- It does not depend on mainnet; propagation metrics use the testbed's own peer network.
- It does not accept unpinned builds.

## 7. Implementation plan (after W3 adoption)

- v0: single-node harness over `liboqs` + `libsecp256k1` + `blst` producing schema-valid results for S-01 to S-03 and B-01 to B-03 (M-01 to M-05).
- v0.1: stateful hash-based backends (S-04, S-05) with state accounting.
- v0.2: multi-node runner + attestation + reproduction report.
- v1: scenario runs against a reference client for M-07 to M-12 and M-21 (needs the block-mix decision).
