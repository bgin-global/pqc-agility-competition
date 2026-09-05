# Signature Scheme Register (draft v0)

> Status: **DRAFT — scope rulings at Workshop W2 (decision records).** Rule of the competition: **deploy NIST-selected / standardized PQC — do not invent new primitives.** This register lists pre-existing schemes the testbed can exercise, the classical baselines they are measured against, and integration paths that give the target mapping. Sizes are reference values for the named parameter set; the harness measures them (M-01, M-02).

## A. Post-quantum signature schemes (candidates for the testbed)

| ID | Scheme | Standard | Family | Parameter sets (pk / sig bytes) | Notes | Status |
|---|---|---|---|---|---|---|
| S-01 | ML-DSA | NIST FIPS 204 | Module lattice (Dilithium lineage) | ML-DSA-44 (1312 / 2420) · ML-DSA-65 (1952 / 3309) · ML-DSA-87 (2592 / 4627) | Named in the briefing as the starting point | candidate |
| S-02 | SLH-DSA | NIST FIPS 205 | Stateless hash-based (SPHINCS+ lineage) | SHA2/SHAKE-128s (32 / 7856) · 128f (32 / 17088) · 192s (48 / 16224) · 256s (64 / 29792) | Conservative assumptions; large signatures | candidate |
| S-03 | FN-DSA (Falcon) | NIST FIPS 206 (draft status — confirm at ruling) | NTRU lattice | Falcon-512 (897 / about 666) · Falcon-1024 (1793 / about 1280) | Smallest lattice signatures; floating-point signing is the implementation risk; raised in the IKP-WG session as a top candidate for blockchains, including smart-contract-executable verification | candidate |
| S-04 | XMSS / XMSS^MT | NIST SP 800-208 (IETF RFC 8391) | Stateful hash-based | e.g. XMSS-SHA2_10_256 (64 / 2500) | State management is the operational risk; Ethereum consensus-layer work is heading toward hash-based aggregation (XMSS-style with Poseidon2 for ZK-friendliness — a non-SP-800-208 parameterization: **ruling needed**) | candidate |
| S-05 | LMS / HSS | NIST SP 800-208 (IETF RFC 8554) | Stateful hash-based | e.g. LMS-SHA256_M32_H10 (60 / about 1600) | Same state caveat as S-04 | candidate |

## B. Classical baselines (measured for the deltas, not candidates)

| ID | Scheme | Where used | pk / sig bytes | Role |
|---|---|---|---|---|
| B-01 | secp256k1 ECDSA | Bitcoin (legacy / SegWit v0), Ethereum EOAs | 33 / 64–72 | baseline for BTC-tx, ETH-user |
| B-02 | secp256k1 Schnorr (BIP-340) | Bitcoin Taproot | 32 / 64 | baseline for BTC-tx |
| B-03 | BLS12-381 | Ethereum consensus layer (validator aggregation) | 48 / 96 | baseline for ETH-cons |

## C. Compositions and integration paths (ruling needed on what counts as in scope)

| ID | Path | Mapping | Notes | Status |
|---|---|---|---|---|
| C-01 | Hybrid classical + PQ (e.g. Schnorr or ECDSA alongside ML-DSA; IETF LAMPS composite-signature direction) | BTC-tx, ETH-user | Staged / hybrid migration is a named theme and the GDC26 recommendation ("hybrid then cutover"); the harness measures the composite as one unit | ruling |
| C-02 | Bitcoin quantum-resistant output type (P2QRH / BIP-360 direction) | BTC-tx | Proposal-stage; reference for the BTC mapping only, no endorsement | ruling |
| C-03 | Ethereum account-abstraction path (user-chosen verification logic; precompile vs. contract verification) | ETH-user | Gives M-10 both paths | ruling |
| C-04 | Ethereum consensus-layer BLS to hash-based aggregation | ETH-cons | Aggregation is the dominant cost; see S-04 note | ruling |
| C-05 | ZK-wrapped verification (prove many PQ signatures, verify one proof) | L2, ETH-cons | Aggregation via ZKP came up repeatedly in the IKP-WG session; gives M-16 | ruling |
| C-06 | Advanced key management: MPC / threshold, multisig, recovery, custody boundaries | all | Named theme; may be a separate evaluation lane rather than a scheme row | ruling |

## D. Reference implementations (committee to pick; neutrality matters)

- Open Quantum Safe `liboqs` (C, with language wrappers) — broad coverage of S-01 to S-03 in one API; a natural first harness backend.
- NIST reference / optimized C code from the standardization submissions.
- Rust: `pqcrypto` crate family; hash-based: RFC reference code, `hash-sigs` (LMS), `xmss-reference`.
- Baselines: `libsecp256k1`, `blst`.

The harness pins implementation, commit, and build flags in the run manifest; results are never comparable across unpinned builds.
