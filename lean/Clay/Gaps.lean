/-
Copyright (c) 2026 Benjamin Stanley Frohman.
Skeleton only. These declarations are not theorems of Navier--Stokes.
-/

-- Intentionally free of `import Mathlib` so the file states the open obligations
-- without pretending to elaborate against a toolchain in this scaffold.

namespace Clay.Gaps

/-- Gap A: the history integral of a positive equilibrium is not uniformly bounded. -/
theorem history_integral_not_uniform
    (y : Real → Real) (y_star : Real)
    (hpos : 0 < y_star)
    (hlim : ∀ ε > 0, ∃ T, ∀ t ≥ T, |y t - y_star| < ε) :
    ¬ (∃ C, ∀ t ≥ 0, ∫ s in Set.Icc 0 t, (y s) ^ 2 ≤ C) := by
  sorry

/-- Gap B: an L^6 integral does not control L^∞ without a measure lower bound. -/
theorem l6_does_not_control_linfty :
    ¬ (∀ (M : Real) (vol : Real),
        0 < M → 0 < vol → vol ≤ 1 →
        M ^ 6 * vol ≥ M ^ 4) := by
  sorry

/-- Statement (B) is not asserted here. -/
theorem statement_B_open : True := trivial

end Clay.Gaps
