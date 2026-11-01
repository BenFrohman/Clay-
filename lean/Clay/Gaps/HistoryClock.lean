/-
Copyright (c) 2026 Benjamin Stanley Frohman. Apache-2.0.
The driver is a definition, not a theorem about Navier-Stokes solutions.
-/

import Mathlib.MeasureTheory.Integral.IntervalIntegral

noncomputable section

namespace Clay.Gaps.HistoryClock

open MeasureTheory intervalIntegral

/-- The Section 10 history driver with constants `Cabs`, `kappa''`. -/
def historyDriver (Cabs kappa'' : ℝ) (y : ℝ → ℝ) (t : ℝ) : ℝ :=
  Cabs * (1 + (∫ s in (0 : ℝ)..t, (y s) ^ 2) ^ ((3 : ℝ) / 2)) * (y t) ^ 2
    - kappa'' * (y t) ^ 3

/-- **Proved.** On a constant profile `y ≡ m` the history integral is `m² t`. -/
theorem history_of_const (m t : ℝ) :
    (∫ s in (0 : ℝ)..t, (fun _ => m) s ^ 2) = m ^ 2 * t := by
  simp [mul_comm]

/-- **Proved.** On `y ≡ m > 0`, the history integral exceeds every bound for
large `t` (the clock is not a uniform majorant). -/
theorem driver_not_asserted_of_solutions (m : ℝ) (hm : 0 < m) (B : ℝ) :
    ∃ t, 1 ≤ t ∧ B < ∫ s in (0 : ℝ)..t, (fun _ => m) s ^ 2 := by
  refine ⟨|B| / m ^ 2 + 1, by have : 0 ≤ |B| / m ^ 2 := by positivity
                              linarith, ?_⟩
  rw [history_of_const]
  have hm2 : 0 < m ^ 2 := by positivity
  rw [mul_add, mul_div_cancel₀ _ hm2.ne', mul_one]
  linarith [le_abs_self B]

/-- **Proved.** Aligned (constant-direction) steady profiles still have an
unbounded clock. -/
theorem clock_fails_on_aligned_2d_solutions (m : ℝ) (hm : 0 < m) :
    ¬ ∃ C, ∀ t, 0 ≤ t → (∫ s in (0 : ℝ)..t, (fun _ => m) s ^ 2) ≤ C := by
  rintro ⟨C, hC⟩
  obtain ⟨t, ht, hlt⟩ := driver_not_asserted_of_solutions m hm C
  linarith [hC t (by linarith)]

end Clay.Gaps.HistoryClock
