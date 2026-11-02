/-
Copyright (c) 2026 Benjamin Stanley Frohman. Apache-2.0.
Algebraic rearrangement on Int (closed by `ring`).
The minus sign is a hypothesis. Does not inhabit StatementB. No sorry.
`CorrectedMaxRate` is an OPEN hypothesis (a Riccati / kappa-matching max-rate law,
dM/dt <= C M - kappa M^2), not a classical result. The argument proposed for it is refuted:
stretching at the maximum is quadratic, <= C_CZ M^2, so the coefficient matching fails.
-/

import Mathlib.Tactic.Ring

namespace Clay.Gaps.ConditionalRiccati

def CorrectedMaxRate (rate C kappa M : Int) : Prop :=
  rate ≤ M * (C * M - kappa * M * M)

theorem poly_eq (C kappa M : Int) :
    M * (C * M - kappa * M * M) = C * M * M - kappa * M * M * M := by
  ring

theorem conditional_riccati (rate C kappa M : Int)
    (h : CorrectedMaxRate rate C kappa M) :
    rate ≤ C * M * M - kappa * M * M * M := by
  unfold CorrectedMaxRate at h
  rw [poly_eq] at h
  exact h

end Clay.Gaps.ConditionalRiccati
