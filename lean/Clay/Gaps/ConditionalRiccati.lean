/-
Copyright (c) 2026 Benjamin Stanley Frohman. Apache-2.0.
Conditional only. The minus sign is in the hypothesis.
Does not inhabit StatementB. No sorry.
-/

import Mathlib.Tactic.Ring

namespace Clay.Gaps.ConditionalRiccati

/-- Rate already assumed to carry the strain subtraction. Not derived from the vorticity equation. -/
def CorrectedMaxRate (rate M C κ : ℝ) : Prop :=
  rate ≤ M * (C * M - κ * M ^ 2)

theorem cubic_sink_of_corrected_rate
    (rate M C κ : ℝ) (h : CorrectedMaxRate rate M C κ) :
    rate ≤ C * M ^ 2 - κ * M ^ 3 := by
  have hmul : M * (C * M - κ * M ^ 2) = C * M ^ 2 - κ * M ^ 3 := by ring
  simpa [CorrectedMaxRate, hmul] using h

theorem source_ne_sink_form (M C κ : ℝ) :
    C * M ^ 3 - (C * M ^ 2 - κ * M ^ 3) = κ * M ^ 3 := by ring

theorem cubic_field_factor (y C κ : ℝ) :
    C * y ^ 2 - κ * y ^ 3 = y ^ 2 * (C - κ * y) := by ring

end Clay.Gaps.ConditionalRiccati
