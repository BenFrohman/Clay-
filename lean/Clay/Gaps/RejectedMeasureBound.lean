/-
Copyright (c) 2026 Benjamin Stanley Frohman. All rights reserved.
Released under Apache 2.0 license as described in the file LICENSE.
Authors: Benjamin Stanley Frohman
-/

import Clay.Gaps.MissingInputs

/-!
# lean.Clay.Gaps.RejectedMeasureBound

Rejected route. The inequality ∫|ω|⁶ ≥ c M⁴ with c depending only on energy
and viscosity is not asserted. A lemma := sorry of that type would be
sorryAx of a false statement.
Spike: a peak of height M on a set of measure δ contributes order δ M⁶.
-/

noncomputable section

namespace Clay.Gaps.RejectedMeasureBound

open Clay.StatementB Clay.Gaps.MissingInputs
open scoped ENNReal NNReal ContDiff

/-- The rejected reversed-Hölder claim, stated concretely: a constant `c > 0`
with `c ‖f‖_∞⁴ ≤ ∫_{𝕋³} |f|⁶` for all smooth periodic `f`. False (scaling
`f ↦ λ f`, `λ → 0`); the refutation is not formalized here, so it is not used. -/
def reversedHolderClaim : Prop :=
  ∃ c : ℝ≥0, 0 < c ∧ ∀ f : E3 → ℝ, ContDiff ℝ ∞ f → IsPeriodic f →
    c * (⨆ x, (‖f x‖₊ : ℝ≥0∞)) ^ 4 ≤ ∫⁻ x in unitCube, (‖f x‖₊ : ℝ≥0∞) ^ 6

/-- Deprecated: the old placeholder, literally `False`. -/
def reversedHolderClaim_placeholder : Prop := False

theorem reversed_holder_not_asserted : reversedHolderClaim_placeholder → False :=
  fun h => h

end Clay.Gaps.RejectedMeasureBound
