/-
Copyright (c) 2026 Benjamin Stanley Frohman. All rights reserved.
Released under Apache 2.0 license as described in the file LICENSE.
Authors: Benjamin Stanley Frohman
-/

import Mathlib.Tactic.Ring

/-!
# lean.Clay.Gaps.ConditionalRiccati

Algebraic rearrangement on Int (closed by `ring`).
The minus sign is a hypothesis. Does not inhabit StatementB. No sorry.
`CorrectedMaxRate` is an integer inequality, not a differential max-rate law.
`rate` is an Int variable; no trajectory or PDE interpretation is constructed.
Any link to an analytical vorticity estimate is an additional, unproved input.
-/

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
