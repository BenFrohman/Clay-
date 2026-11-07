# Clay-

[![lean.yml](https://github.com/BenFrohman/Clay-/actions/workflows/lean.yml/badge.svg?branch=main)](https://github.com/BenFrohman/Clay-/actions/workflows/lean.yml)

[![DOI](https://zenodo.org/badge/DOI/10.5281/zenodo.23653012.svg)](https://doi.org/10.5281/zenodo.23653012) [![License: Apache-2.0](https://img.shields.io/badge/License-Apache%202.0-blue.svg)](LICENSE)

Author: Frohman, Benjamin Stanley
Copyright (c) 2026 Benjamin Stanley Frohman
License: Apache License, Version 2.0. See [LICENSE](LICENSE).

Research workspace for Fefferman statement (B): unforced 3D incompressible Navier--Stokes on $\mathbb{T}^3$.

**This repository is not a completed Clay resolution.** Statement (B) is stated precisely but is not proved.

**Continuation:** the active programme, which decomposes the remaining gap into finer named statements, is [BenFrohman/periodic-ns-classical-continuation](https://github.com/BenFrohman/periodic-ns-classical-continuation). Its named statements (the Frohmanian Tether Hypothesis (A)/(B), `FrohmanianDirectionCoercivity`, the line-field form of (B), the viscous-term decomposition) are **open or conditional**; only its individually proved lemmas (for example the planar `sinShear` obstruction) are proved. Naming: [`NAMING.md`](NAMING.md).

## The main result, stated (not proved)

`lean/Clay/StatementB.lean` defines `Clay.StatementB.FeffermanStatementB : Prop`, mirroring Statement (B) of Fefferman's official Clay problem description: for every $\nu>0$ and every smooth, divergence-free, $1$-periodic $u^\circ$ on $\mathbb{R}^3$, there exist smooth $u,p$ on $\mathbb{R}^3\times[0,\infty)$, $1$-periodic in space, with
$\partial_t u_i+\sum_j u_j\partial_j u_i=\nu\Delta u_i-\partial_i p$, $\operatorname{div}u=0$, $u(\cdot,0)=u^\circ$.

Kernel-checked (0 `sorry`; axioms `propext`, `Classical.choice`, `Quot.sound` only):

- `feffermanStatementB_of_bkm`: `PeriodicMaximalSolutionWithBKM` (classical local theory + Beale–Kato–Majda, **not formalized**) and `PeriodicBKMIntegrability` (**open**, the Clay core) imply `FeffermanStatementB`.
- `bkmIntegralFinite_of_vortSup_le`, `bkmIntegralFinite_of_holographic`: a uniform $\|\omega\|_{L^\infty}$ bound on finite intervals gives the BKM integral.
- `tetherProj_self` ($\Pi_u u=0$), `historyIntegralNotUniform_holds`, `clock_fails_on_aligned_2d_solutions`, `conditional_riccati`.

Open named Props (not asserted): `PeriodicBKMIntegrability`, `metriplecticControlsEnstrophyL2`, `holographicNotAZFCBound`, `depletedStretching`, `stretchingIntegralFinite`, `criticalNormBounded`. Classical but not formalized here: `PeriodicMaximalSolutionWithBKM`, `czGivesBMONotLinf`, `spikeObstruction`, `cfAlignmentImpliesRegularity`. The legacy `dhyImpliesRegularity` is an abstract free-packet interface, not a faithful classical criterion: its exact equivalence to `PeriodicBKMIntegrability` is proved by `abstract_dhy_criterion_iff_periodicBKMIntegrability`. The former `True`/`opaque` placeholders in `MissingInputs.lean` have been removed (git history keeps them); all five gap statements are non-trivial Props. New: `TwoDPlanar.curl_planar` (proved): a planar field $v=(v_1(x_1,x_2),v_2(x_1,x_2),0)$ has vorticity parallel to $e_3$; `TwoDClock.lean` is labelled a schematic `rfl` model. `Tether.lean` is labelled schematic beyond $\Pi_u u=0$. Audit: `lean/AxiomAudit.lean` (headline theorems) and `lean/AxiomReport.lean` (every theorem; output in `AXIOMS.md`).

- `lean/Clay/Gaps/TwoDClock.lean` — the 2D fact: constant direction, so Constantin–Fefferman holds, and the history integral still grows like $m^2 t$ wherever $M\ge m>0$. Steady Euler equality case $\|\phi(t)\|_\infty=M_0^2 t$.
- `lean/Clay/Gaps/MissingInputs.lean` — BKM integral, metriplectic/$L^2$ gap, CZ/BMO gap, spike obstruction, holographic ceiling, depleted stretching, each now a precise Prop. None closes Statement (B).
- `latex/two_d_fact.tex` — the same inputs in LaTeX.
- `COMPARATOR.md` — `FormalConjectures/Millennium/NavierStokes.lean`. Not a dependency.

See `STATUS.md` for the Section 10 finding.

## Note: Clay-CD folded in

See `docs/note_clay_cd_not_certified.md` and `lean/Clay/Notes/NotBlowup.lean` (two definitional identities, illustration only).

## Status summary

**Proved** (kernel-checked, standard axioms only; full list in `AXIOMS.md`):
the reduction `feffermanStatementB_of_bkm`; `bkmIntegralFinite_of_vortSup_le`; `bkmIntegralFinite_of_holographic`;
`tetherProj_self`; `historyIntegralNotUniform_holds`; `clock_fails_on_aligned_2d_solutions`; and `conditional_riccati` (as a conditional statement).

**Conditional on** (named `Prop` hypotheses, never `axiom`):
- `PeriodicMaximalSolutionWithBKM`: classical local existence plus the Beale–Kato–Majda criterion; standard in the literature, **not formalized** here.
- `PeriodicBKMIntegrability`: finiteness of the BKM integral for every smooth periodic datum. This is **open**; it is the core of the Clay problem.
- `CorrectedMaxRate` is an integer inequality `rate ≤ M(C M − κ M²)`.
  `conditional_riccati` only rewrites this as `rate ≤ C M² − κ M³`.
  No trajectory, differential max-rate law, or Navier–Stokes bridge is proved.
  Pointwise stretching retains the factor `||grad u||_infty`; it is not bounded
  by a universal constant times `M²` merely by citing Calderón–Zygmund.


**Open** (stated, not asserted): `PeriodicBKMIntegrability`, `metriplecticControlsEnstrophyL2`, `holographicNotAZFCBound`,
`depletedStretching`, `stretchingIntegralFinite`, `criticalNormBounded`. Classical but not formalized: `czGivesBMONotLinf`, `spikeObstruction`,
`cfAlignmentImpliesRegularity`. The old DHY free-packet proposition is covered by the abstract-interface diagnostic, not imported as an actual geometric theorem.

`FeffermanStatementB` itself is **not proved**. Nothing here is a Clay resolution, and nothing here has been peer reviewed.

## Solution-linked vortex-line implementation

[The new module](lean/Clay/Depletion/SolutionLinkedVortexLines.lean) binds its
packet to actual `u`, `curl u`, moving endpoints, unit-speed vortex curves and
measurable actual endpoint/control quantities. A zero-length profile forces
actual curl to vanish everywhere; the actual zero NS solution is still admitted.
The old abstract diagnostic is retained unchanged.

The proved BKM consequence takes BOTH spatial endpoint comparison and finite
endpoint integral as explicit hypotheses. Neither is inferred merely from packet
existence. `SpatialBridgeObligation` is an **unproved Prop**, not an axiom or a
proved sufficient geometric criterion. This implements a nondegenerate spatial
specialization of DHY Theorem 1; it does **not** transfer Euler-only Theorem 2
to viscous NS. See [proved/unproved scope](docs/SOLUTION_LINKED_VORTEX_LINES.md).

## Build

```
cd lean
lake exe cache get
lake build
lake env lean AxiomReport.lean
lake env lean SolutionLinkedRegression.lean
```
CI (`.github/workflows/lean.yml`) runs these on every push and fails on `sorryAx` or any non-standard axiom.


---
## Archival DOI & Cryptographic Provenance

- **Zenodo DOI (all versions):** [10.5281/zenodo.23653012](https://doi.org/10.5281/zenodo.23653012). This concept DOI resolves to the latest archived version. A previously archived paper version has DOI [10.5281/zenodo.23940667](https://doi.org/10.5281/zenodo.23940667). Current repository changes are not automatically a new Zenodo publication. The v1.0.0 snapshot (commit `00fee0f`) has its own version DOI, 10.5281/zenodo.23653013.
- **Author:** Frohman, Benjamin Stanley (ORCID: [0009-0006-7068-3718](https://orcid.org/0009-0006-7068-3718))
- **License:** Apache License, Version 2.0 (`Copyright (c) 2026 Benjamin Stanley Frohman`)
- **Earliest Commit Provenance:** `9e61806681bfce3f0edee28293d22a6a711f0780` (2026-10-07 06:16:45 AM CDT (UTC-5))
- **Provenance hashes:** SHA-256 Merkle root `a8352277015c4827030f0b4bf6d8793a63fec3bc5855735713c8d646171c2d5f` (`provenance/PROVENANCE_MERKLE_ROOT.json`) and per-file hashes (`provenance/PROVENANCE_HASHES.json`, signed with Ed25519 key `b428fb72676f1c52`). These are file-integrity fingerprints only; they are not a certificate of correctness or review. See `provenance/README.md`.
- **Scope & Scientific Boundary:** Explicitly titled and structured as a boundary and gap ledger (`STATUS.md: not a Clay resolution`), isolating the open analytic obligations (unforced BKM stretching integral finiteness) without using `sorry`.

See [`NAMING.md`](NAMING.md) for the canonical names (Frohmanian Tether Hypothesis, symbol 𝔉𝕋) and the old-name glossary.

**Final status:** Statement (B) is precisely stated and reduced, kernel-checked, to the open Prop `PeriodicBKMIntegrability` plus the classical local theory; it is not proved. Not a Clay resolution.


**PDF note:** the main monograph PDF is rebuilt from its updated `.tex` source for the solution-linked implementation. Other historical PDFs retain their own source/version scope.

## Reproducibility bundles and project policies

After installing the pinned toolchain and fetching the dependency cache:

```sh
python3 scripts/build_lean_certificate.py --source-base <reviewed-base-commit>
```

This freshly typechecks every project library module plus the explicit regression
file, runs the per-theorem axiom audit, and packages sources, exact pins, logs,
project `.olean` artifacts, dependency-license copies and SHA-256 manifest.
Dependencies themselves must be obtained at the pinned revisions. These are
reproducibility/evidence bundles, **not standalone independently trusted proof
certificates**. Hashes certify neither mathematical meaning nor novelty.
See [AUTHORS.md](AUTHORS.md), [NOTICE](NOTICE), [LICENSE](LICENSE) and
[SECURITY.md](SECURITY.md). The existing Apache-2.0 grant is unchanged; dependency
licenses and third-party notices remain applicable.
