/-
Copyright (c) 2026 Benjamin Stanley Frohman. Apache-2.0.
Open obligations, concrete. Not sorry. Not theorems of Navier-Stokes.
-/

import Clay.StatementB
import Clay.Gaps.MissingInputs

noncomputable section

namespace Clay.Gaps

open Clay.StatementB

/-- The history integral `m² t` of a positive equilibrium is not uniformly
bounded in time. Proved below. -/
def historyIntegralNotUniform : Prop :=
  ∀ m : ℝ, 0 < m → ¬ ∃ C : ℝ, ∀ t : ℝ, 0 ≤ t → m * m * t ≤ C

theorem historyIntegralNotUniform_holds : historyIntegralNotUniform := by
  intro m hm ⟨C, hC⟩
  have hmm : 0 < m * m := mul_pos hm hm
  have h := hC ((|C| + 1) / (m * m)) (by positivity)
  rw [mul_div_cancel₀ _ hmm.ne'] at h
  linarith [le_abs_self C]

/-- `L^6` does not control `L^∞` without a measure lower bound (same content as
`MissingInputs.spikeObstruction`). Classical; not formalized. -/
def l6DoesNotControlLinfty : Prop := Clay.Gaps.MissingInputs.spikeObstruction

end Clay.Gaps
