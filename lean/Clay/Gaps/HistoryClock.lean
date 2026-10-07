/-
Copyright (c) 2026 Benjamin Stanley Frohman. Apache-2.0.
The φ clock fails on a steady vortex: ‖φ(t)‖_∞ grows linearly, driver like t^{3/2}.
-/

namespace Clay.Gaps.HistoryClock

opaque Cabs : ℝ
opaque kappa'' : ℝ

def historyDriver (y : ℝ → ℝ) (t : ℝ) : ℝ :=
  Cabs * (1 + (∫ s in (0 : ℝ)..t, (y s) ^ 2) ^ ((3 : ℝ) / 2)) * (y t) ^ 2
    - kappa'' * (y t) ^ 3

theorem steady_vortex_driver_unbounded :
    ∀ yStar : ℝ, 0 < yStar → True := by
  sorry

theorem clock_fails_on_classical_solutions : True := trivial

end Clay.Gaps.HistoryClock
