/-
Copyright (c) 2026 Benjamin Stanley Frohman. Apache-2.0.
Skeleton. The two sorry theorems are open obligations, not Navier-Stokes theorems.
-/

import Mathlib.MeasureTheory.Integral.IntervalIntegral
import Mathlib.Data.Real.Basic

namespace Clay.Gaps

open MeasureTheory Set

theorem history_integral_not_uniform
    (y : ℝ → ℝ) (y_star : ℝ)
    (hpos : 0 < y_star)
    (hlim : ∀ ε > 0, ∃ T, ∀ t ≥ T, |y t - y_star| < ε) :
    ¬ (∃ C, ∀ t ≥ 0, ∫ s in Icc 0 t, (y s) ^ 2 ≤ C) := by
  sorry

theorem l6_does_not_control_linfty :
    ¬ (∀ (M : ℝ) (vol : ℝ),
        0 < M → 0 < vol → vol ≤ 1 →
        M ^ 6 * vol ≥ M ^ 4) := by
  sorry

theorem statement_B_open : True := trivial

end Clay.Gaps
