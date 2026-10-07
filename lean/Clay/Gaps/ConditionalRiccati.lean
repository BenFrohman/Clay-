/-
Copyright (c) 2026 Benjamin Stanley Frohman. Apache-2.0.
Algebraic rearrangement on Int, so it elaborates without Mathlib.
The minus sign is a hypothesis. Does not inhabit StatementB. No sorry.
-/

namespace Clay.Gaps.ConditionalRiccati

def CorrectedMaxRate (rate C kappa M : Int) : Prop :=
  rate ≤ M * (C * M - kappa * M * M)

theorem poly_eq (C kappa M : Int) :
    M * (C * M - kappa * M * M) = C * M * M - kappa * M * M * M := by
  omega

theorem conditional_riccati (rate C kappa M : Int)
    (h : CorrectedMaxRate rate C kappa M) :
    rate ≤ C * M * M - kappa * M * M * M := by
  unfold CorrectedMaxRate at h
  rw [← poly_eq] at h
  exact h

end Clay.Gaps.ConditionalRiccati
