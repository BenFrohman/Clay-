# Spatial-bridge paper

`spatial_bridge.tex` (with `spatial_bridge.bib`, `leanlisting.tex`) and the
compiled `spatial_bridge.pdf`:

> Frohman, Benjamin Stanley. *A Kernel-Checked Spatial Bridge for Vortex-Line
> Comparison: Lean 4 Formalization of the Deng–Hou–Yu Spatial Identity for
> Smooth Periodic Navier–Stokes Fields.* Preprint, November 9, 2026. Not peer
> reviewed.

It documents the library theorems merged in pull request #9
(`lean/Clay/Depletion/ActualSpatialBridge.lean`, library commit
`43653aab3b51269a71a713ccbc4d892869bbe497`). **It is not a proof of the Clay
Navier–Stokes problem.** Read the paper's Section 6 ("Ledger") for exactly what is
proved, what is assumed and what remains open.

The paper also records a statement-fidelity issue: at the pinned Mathlib
the bare `⊤` in `NSOn`/`SmoothPeriodicData` is `ω` (real-analytic), not
`∞` (C^∞). See Section 2.3 and `PaperChecks.lean`.

## Files

| File | Purpose |
|---|---|
| `spatial_bridge.tex`, `spatial_bridge.bib`, `leanlisting.tex` | LaTeX source |
| `spatial_bridge.pdf` | compiled paper (tectonic) |
| `PaperChecks.lean` | kernel checks for the paper's extra claims (Section 2.3, Corollary 4.10, Proposition 5.1) and `#print axioms` for every cited theorem; not part of the `Clay` library audit |
| `check_refs.py` | verifies every `file:line` reference in the paper declares the cited Lean name |

## Reproduce

```bash
cd lean
lake exe cache get && lake build
lake env lean AxiomReport.lean | grep AXSUMMARY   # 125 theorems, 236 declarations; nonstandard: 0
lake env lean ../papers/spatial-bridge/PaperChecks.lean
cd ../papers/spatial-bridge
python3 check_refs.py
tectonic spatial_bridge.tex
```

CI: `.github/workflows/lean.yml` (step "Paper checks") and
`.github/workflows/paper-spatial-bridge.yml` (reference check and LaTeX build).

Copyright (c) 2026 Benjamin Stanley Frohman. Apache License 2.0.
