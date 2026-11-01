# Clay-

[![DOI](https://zenodo.org/badge/DOI/10.5281/zenodo.23653012.svg)](https://doi.org/10.5281/zenodo.23653012) [![License: Apache-2.0](https://img.shields.io/badge/License-Apache%202.0-blue.svg)](LICENSE)

Author: Benjamin Stanley Frohman
Copyright (c) 2026 Benjamin Stanley Frohman
License: Apache License, Version 2.0. See [LICENSE](LICENSE).

Private workspace for Fefferman statement (B): unforced 3D incompressible Navier--Stokes on $\mathbb{T}^3$.

**This repository is not a completed Clay resolution.** Statement (B) is stated precisely but is not proved.

**Continuation:** the active programme, which decomposes the remaining gap into finer named statements, is [BenFrohman/periodic-ns-classical-continuation](https://github.com/BenFrohman/periodic-ns-classical-continuation).

## The main result, stated (not proved)

`lean/Clay/StatementB.lean` defines `Clay.StatementB.FeffermanStatementB : Prop`, mirroring Statement (B) of Fefferman's official Clay problem description: for every $\nu>0$ and every smooth, divergence-free, $1$-periodic $u^\circ$ on $\mathbb{R}^3$, there exist smooth $u,p$ on $\mathbb{R}^3\times[0,\infty)$, $1$-periodic in space, with
$\partial_t u_i+\sum_j u_j\partial_j u_i=\nu\Delta u_i-\partial_i p$, $\operatorname{div}u=0$, $u(\cdot,0)=u^\circ$.

Kernel-checked (0 `sorry`; axioms `propext`, `Classical.choice`, `Quot.sound` only):

- `feffermanStatementB_of_bkm`: `PeriodicMaximalSolutionWithBKM` (classical local theory + Beale–Kato–Majda, **not formalized**) and `PeriodicBKMIntegrability` (**open**, the Clay core) imply `FeffermanStatementB`.
- `bkmIntegralFinite_of_vortSup_le`, `bkmIntegralFinite_of_holographic`: a uniform $\|\omega\|_{L^\infty}$ bound on finite intervals gives the BKM integral.
- `tetherProj_self` ($\Pi_u u=0$), `historyIntegralNotUniform_holds`, `clock_fails_on_aligned_2d_solutions`, `conditional_riccati`.

Open named Props (not asserted): `PeriodicBKMIntegrability`, `metriplecticControlsEnstrophyL2`, `holographicNotAZFCBound`, `depletedStretching`, `stretchingIntegralFinite`, `criticalNormBounded`. Classical but not formalized here: `PeriodicMaximalSolutionWithBKM`, `czGivesBMONotLinf`, `spikeObstruction`, `cfAlignmentImpliesRegularity`, `dhyImpliesRegularity`. Former `True`/`opaque` placeholders are kept as `*_placeholder` (deprecated). Audit: `lean/AxiomAudit.lean`.

- `lean/Clay/Gaps/TwoDClock.lean` — the 2D fact: constant direction, so Constantin–Fefferman holds, and the history integral still grows like $m^2 t$ wherever $M\ge m>0$. Steady Euler equality case $\|\phi(t)\|_\infty=M_0^2 t$.
- `lean/Clay/Gaps/MissingInputs.lean` — BKM integral, metriplectic/$L^2$ gap, CZ/BMO gap, spike obstruction, holographic ceiling, depleted stretching, each now a precise Prop. None closes Statement (B).
- `latex/two_d_fact.tex` — the same inputs in LaTeX.
- `COMPARATOR.md` — `FormalConjectures/Millennium/NavierStokes.lean`. Not a dependency.

See `STATUS.md` for the Section 10 referee finding.

---
## Archival DOI & Cryptographic Provenance

- **Dedicated 1-to-1 Zenodo DOI:** [10.5281/zenodo.23653012](https://doi.org/10.5281/zenodo.23653012)
- **Author:** Benjamin Stanley Frohman (ORCID: [0009-0006-7068-3718](https://orcid.org/0009-0006-7068-3718))
- **License:** Apache License, Version 2.0 (`Copyright (c) 2026 Benjamin Stanley Frohman`)
- **Earliest Commit Provenance:** `9e61806681bfce3f0edee28293d22a6a711f0780` (2026-10-07 06:16:45 AM CDT (UTC-5))
- **SealGuard SHA-256 Merkle Root:** `a8352277015c4827030f0b4bf6d8793a63fec3bc5855735713c8d646171c2d5f` (`PROVENANCE_MERKLE_ROOT.json`)
- **Titan Audit Certificate:** `audit/TITAN_AUDIT_CERTIFICATE.json` (Ed25519 key `b428fb72676f1c52`)
- **Scope & Scientific Boundary:** Explicitly titled and structured as a boundary and gap ledger (`STATUS.md: not a Clay resolution`), isolating the open analytic obligations (unforced BKM stretching integral finiteness) without using `sorry`.

**Final status:** Statement (B) is precisely stated and reduced, kernel-checked, to the open Prop `PeriodicBKMIntegrability` plus the classical local theory; it is not proved. Not a Clay resolution.
