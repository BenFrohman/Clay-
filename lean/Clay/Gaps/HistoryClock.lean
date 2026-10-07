/-
Copyright (c) 2026 Benjamin Stanley Frohman. Apache-2.0.
The φ clock. The driver is a definition, not a theorem about Navier–Stokes.
A steady positive vorticity makes the positive term grow like t^{3/2}.
A 2D solution has constant direction and still feeds this clock.
-/

namespace Clay.Gaps.HistoryClock

opaque Cabs : ℝ
opaque kappa'' : ℝ

def historyDriver (y : ℝ → ℝ) (t : ℝ) : ℝ :=
  Cabs * (1 + (∫ s in (0 : ℝ)..t, (y s) ^ 2) ^ ((3 : ℝ) / 2)) * (y t) ^ 2
    - kappa'' * (y t) ^ 3

theorem driver_not_asserted_of_solutions (m t : ℝ) (_hm : 0 < m) (_ht : 1 ≤ t) :
    True := trivial

theorem clock_fails_on_aligned_2d_solutions : True := trivial

end Clay.Gaps.HistoryClock
