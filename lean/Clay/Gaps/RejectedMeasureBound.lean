/-
Copyright (c) 2026 Benjamin Stanley Frohman. Apache-2.0.
Rejected route. The inequality ∫|ω|⁶ ≥ c M⁴ with c depending only on energy
and viscosity is not asserted. A lemma := sorry of that type would be
sorryAx of a false statement.
Spike: a peak of height M on a set of measure δ contributes order δ M⁶.
-/

import Clay.Gaps.MissingInputs

noncomputable section

namespace Clay.Gaps.RejectedMeasureBound

open Clay.StatementB Clay.Gaps.MissingInputs
open scoped ENNReal NNReal

/-- The rejected reversed-Hölder claim, stated concretely: a constant `c > 0`
with `c ‖f‖_∞⁴ ≤ ∫_{𝕋³} |f|⁶` for all smooth periodic `f`. False (scaling
`f ↦ λ f`, `λ → 0`); the refutation is not formalized here, so it is not used. -/
def reversedHolderClaim : Prop :=
  ∃ c : ℝ≥0, 0 < c ∧ ∀ f : E3 → ℝ, ContDiff ℝ ⊤ f → IsPeriodic f →
    c * (⨆ x, (‖f x‖₊ : ℝ≥0∞)) ^ 4 ≤ ∫⁻ x in unitCube, (‖f x‖₊ : ℝ≥0∞) ^ 6

/-- Deprecated: the old placeholder, literally `False`. -/
def reversedHolderClaim_placeholder : Prop := False

theorem reversed_holder_not_asserted : reversedHolderClaim_placeholder → False :=
  fun h => h

end Clay.Gaps.RejectedMeasureBound
