# Clay-

[![DOI](https://zenodo.org/badge/DOI/10.5281/zenodo.23653013.svg)](https://doi.org/10.5281/zenodo.23653013) [![License: Apache-2.0](https://img.shields.io/badge/License-Apache%202.0-blue.svg)](LICENSE)

Author: Benjamin Stanley Frohman
Copyright (c) 2026 Benjamin Stanley Frohman
License: Apache License, Version 2.0. See [LICENSE](LICENSE).

Private workspace for Fefferman statement (B): unforced 3D incompressible Navier--Stokes on $\mathbb{T}^3$.

**This repository is not a completed Clay resolution.**

- `lean/Clay/Gaps/TwoDClock.lean` — the 2D fact: constant direction, so Constantin–Fefferman holds, and the history integral still grows like $m^2 t$ wherever $M\ge m>0$. Steady Euler equality case $\|\phi(t)\|_\infty=M_0^2 t$.
- `lean/Clay/Gaps/MissingInputs.lean` — BKM integral, metriplectic/L2 gap, CZ/BMO gap, spike obstruction, holographic rejection. None closes Statement (B).
- `latex/two_d_fact.tex` — the same inputs in LaTeX.
- `COMPARATOR.md` — `FormalConjectures/Millennium/NavierStokes.lean`. Not a dependency.

See `STATUS.md` for the Section 10 referee finding.

---
## Archival DOI & Cryptographic Provenance

- **Dedicated 1-to-1 Zenodo DOI:** [10.5281/zenodo.23653013](https://doi.org/10.5281/zenodo.23653013)
- **Author:** Benjamin Stanley Frohman (ORCID: [0009-0006-7068-3718](https://orcid.org/0009-0006-7068-3718))
- **License:** Apache License, Version 2.0 (`Copyright (c) 2026 Benjamin Stanley Frohman`)
- **Earliest Commit Provenance:** `9e61806681bfce3f0edee28293d22a6a711f0780` (2026-10-07 06:16:45 AM CDT (UTC-5))
- **SealGuard SHA-256 Merkle Root:** `a8352277015c4827030f0b4bf6d8793a63fec3bc5855735713c8d646171c2d5f` (`PROVENANCE_MERKLE_ROOT.json`)
- **Titan Audit Certificate:** `audit/TITAN_AUDIT_CERTIFICATE.json` (Ed25519 key `b428fb72676f1c52`)
- **Scope & Scientific Boundary:** Explicitly titled and structured as a boundary and gap ledger (`STATUS.md: not a Clay resolution`), isolating the open analytic obligations (unforced BKM stretching integral finiteness) without using `sorry`.
