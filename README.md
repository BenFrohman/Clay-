# Clay-

[![DOI](https://zenodo.org/badge/DOI/10.5281/zenodo.23653012.svg)](https://doi.org/10.5281/zenodo.23653012) [![License: Apache-2.0](https://img.shields.io/badge/License-Apache%202.0-blue.svg)](LICENSE)

Author: Benjamin Stanley Frohman
Copyright (c) 2026 Benjamin Stanley Frohman
License: Apache License, Version 2.0. See [LICENSE](LICENSE).

Research workspace for Fefferman statement (B): unforced 3D incompressible Navier--Stokes on $\mathbb{T}^3$.

**This repository is not a completed Clay resolution.** Statement (B) is stated precisely but is not proved.

**Continuation:** the active programme, which decomposes the remaining gap into finer named statements, is [BenFrohman/periodic-ns-classical-continuation](https://github.com/BenFrohman/periodic-ns-classical-continuation).

## The main result, stated (not proved)

`lean/Clay/StatementB.lean` defines `Clay.StatementB.FeffermanStatementB : Prop`, mirroring Statement (B) of Fefferman's official Clay problem description: for every $\nu>0$ and every smooth, divergence-free, $1$-periodic $u^\circ$ on $\mathbb{R}^3$, there exist smooth $u,p$ on $\mathbb{R}^3\times[0,\infty)$, $1$-periodic in space, with
$\partial_t u_i+\sum_j u_j\partial_j u_i=\nu\Delta u_i-\partial_i p$, $\operatorname{div}u=0$, $u(\cdot,0)=u^\circ$.

Kernel-checked (0 `sorry`; axioms `propext`, `Classical.choice`, `Quot.sound` only):

- `feffermanStatementB_of_bkm`: `PeriodicMaximalSolutionWithBKM` (classical local theory + Beale–Kato–Majda, **not formalized**) and `PeriodicBKMIntegrability` (**open**, the Clay core) imply `FeffermanStatementB`.
- `bkmIntegralFinite_of_vortSup_le`, `bkmIntegralFinite_of_holographic`: a uniform $\|\omega\|_{L^\infty}$ bound on finite intervals gives the BKM integral.
- `tetherProj_self` ($\Pi_u u=0$), `historyIntegralNotUniform_holds`, `clock_fails_on_aligned_2d_solutions`, `conditional_riccati`.

Open named Props (not asserted): `PeriodicBKMIntegrability`, `metriplecticControlsEnstrophyL2`, `holographicNotAZFCBound`, `depletedStretching`, `stretchingIntegralFinite`, `criticalNormBounded`. Classical but not formalized here: `PeriodicMaximalSolutionWithBKM`, `czGivesBMONotLinf`, `spikeObstruction`, `cfAlignmentImpliesRegularity`, `dhyImpliesRegularity`. The former `True`/`opaque` placeholders in `MissingInputs.lean` have been removed (git history keeps them); all five gap statements are non-trivial Props. New: `TwoDPlanar.curl_planar` (proved): a planar field $v=(v_1(x_1,x_2),v_2(x_1,x_2),0)$ has vorticity parallel to $e_3$; `TwoDClock.lean` is labelled a schematic `rfl` model. `Tether.lean` is labelled schematic beyond $\Pi_u u=0$. Audit: `lean/AxiomAudit.lean` (headline theorems) and `lean/AxiomReport.lean` (every theorem; output in `AXIOMS.md`).

- `lean/Clay/Gaps/TwoDClock.lean` — the 2D fact: constant direction, so Constantin–Fefferman holds, and the history integral still grows like $m^2 t$ wherever $M\ge m>0$. Steady Euler equality case $\|\phi(t)\|_\infty=M_0^2 t$.
- `lean/Clay/Gaps/MissingInputs.lean` — BKM integral, metriplectic/$L^2$ gap, CZ/BMO gap, spike obstruction, holographic ceiling, depleted stretching, each now a precise Prop. None closes Statement (B).
- `latex/two_d_fact.tex` — the same inputs in LaTeX.
- `COMPARATOR.md` — `FormalConjectures/Millennium/NavierStokes.lean`. Not a dependency.

See `STATUS.md` for the Section 10 finding.

## Status summary

**Proved** (kernel-checked, standard axioms only; full list in `AXIOMS.md`):
the reduction `feffermanStatementB_of_bkm`; `bkmIntegralFinite_of_vortSup_le`; `bkmIntegralFinite_of_holographic`;
`tetherProj_self`; `historyIntegralNotUniform_holds`; `clock_fails_on_aligned_2d_solutions`; and `conditional_riccati` (as a conditional statement).

**Conditional on** (named `Prop` hypotheses, never `axiom`):
- `PeriodicMaximalSolutionWithBKM`: classical local existence plus the Beale–Kato–Majda criterion; standard in the literature, **not formalized** here.
- `PeriodicBKMIntegrability`: finiteness of the BKM integral for every smooth periodic datum. This is **open**; it is the core of the Clay problem.
- `CorrectedMaxRate` (hypothesis of `conditional_riccati`): **open**.

**Open** (stated, not asserted): `PeriodicBKMIntegrability`, `metriplecticControlsEnstrophyL2`, `holographicNotAZFCBound`,
`depletedStretching`, `stretchingIntegralFinite`, `criticalNormBounded`. Classical but not formalized: `czGivesBMONotLinf`, `spikeObstruction`,
`cfAlignmentImpliesRegularity`, `dhyImpliesRegularity`.

`FeffermanStatementB` itself is **not proved**. Nothing here is a Clay resolution, and nothing here has been peer reviewed.

## Build

```
cd lean
lake exe cache get
lake build
lake env lean AxiomReport.lean
```
CI (`.github/workflows/lean.yml`) runs these on every push and fails on `sorryAx` or any non-standard axiom.


---
## Archival DOI & Cryptographic Provenance

- **Zenodo DOI (all versions):** [10.5281/zenodo.23653012](https://doi.org/10.5281/zenodo.23653012). This concept DOI resolves to the latest archived version (v1.1.1). The v1.0.0 snapshot (commit `00fee0f`) has its own version DOI, 10.5281/zenodo.23653013.
- **Author:** Benjamin Stanley Frohman (ORCID: [0009-0006-7068-3718](https://orcid.org/0009-0006-7068-3718))
- **License:** Apache License, Version 2.0 (`Copyright (c) 2026 Benjamin Stanley Frohman`)
- **Earliest Commit Provenance:** `9e61806681bfce3f0edee28293d22a6a711f0780` (2026-10-07 06:16:45 AM CDT (UTC-5))
- **Provenance hashes:** SHA-256 Merkle root `a8352277015c4827030f0b4bf6d8793a63fec3bc5855735713c8d646171c2d5f` (`provenance/PROVENANCE_MERKLE_ROOT.json`) and per-file hashes (`provenance/PROVENANCE_HASHES.json`, signed with Ed25519 key `b428fb72676f1c52`). These are file-integrity fingerprints only; they are not a certificate of correctness or review. See `provenance/README.md`.
- **Scope & Scientific Boundary:** Explicitly titled and structured as a boundary and gap ledger (`STATUS.md: not a Clay resolution`), isolating the open analytic obligations (unforced BKM stretching integral finiteness) without using `sorry`.

**Final status:** Statement (B) is precisely stated and reduced, kernel-checked, to the open Prop `PeriodicBKMIntegrability` plus the classical local theory; it is not proved. Not a Clay resolution.


**PDF note:** the PDF in `paper/` predates the 2026-11-01 revision of the `.tex` source (no TeX toolchain was available when this revision was made). The `.tex` file is authoritative; rebuild the PDF from it.
