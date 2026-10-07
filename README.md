# Clay-

Private workspace for Fefferman statement (B): unforced 3D incompressible Navier--Stokes on $\mathbb{T}^3$.

**This repository is not a completed Clay resolution.**

See `STATUS.md` for the referee finding on the Section 10 bootstrap (history-integral gap and concentration gap), the relation to the September 2026 forced-breakdown claims of statements (C) and (D), and reusable modules in `BenFrohman/NS_Millennium_Proof` and Mathlib.

- `latex/section10_gaps.tex` — the stated Lyapunov inequality with both gaps marked. Compiles with `pdflatex`.
- `lean/Clay/Gaps.lean` — skeleton only. The two counterexample-shaped obligations are explicit `sorry`s. Do not read `statement_B_open` as a regularity theorem.
