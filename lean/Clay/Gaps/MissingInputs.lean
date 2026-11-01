/-
Copyright (c) 2026 Benjamin Stanley Frohman.
Licensed under the Apache License, Version 2.0. See LICENSE.

Inputs the Section 10 bootstrap does not have, stated as precise Props about
smooth periodic Navier–Stokes solutions on 𝕋³ (see `Clay.StatementB`).
Statement (B) is open. None of these Props is asserted.
Proved here: `holographicNotAZFCBound → bkmIntegralFinite`, and
`bkmIntegralFinite → (local theory) → Statement (B)`.
The former `:= True` placeholders survive as `*_placeholder` (deprecated).
-/

import Clay.StatementB

noncomputable section

namespace Clay.Gaps.MissingInputs

open MeasureTheory Set Clay.StatementB
open scoped ENNReal NNReal

/-- Former opaque `bkmIntegralFinite`, now concrete: the open Clay core
`PeriodicBKMIntegrability`. NOT PROVED. -/
def bkmIntegralFinite : Prop := PeriodicBKMIntegrability

/-- Unit cube, a fundamental domain of 𝕋³ = ℝ³/ℤ³. -/
def unitCube : Set E3 := {x | ∀ i, x i ∈ Icc (0 : ℝ) 1}

/-- Enstrophy `∫_{𝕋³} |ω|²`. -/
def enstrophy (u : ℝ → E3 → E3) (t : ℝ) : ℝ≥0∞ :=
  ∫⁻ x in unitCube, (‖curl (u t) x‖₊ : ℝ≥0∞) ^ 2

/-- OPEN. Enstrophy stays bounded on every finite interval of existence (the
control the metriplectic structure was hoped to give; it only controls
`∫∫ |∇u|²`). Equivalent to regularity by classical theory; not proved. -/
def metriplecticControlsEnstrophyL2 : Prop :=
  ForAllFiniteSolutions fun u _ T =>
    ∃ C : ℝ≥0∞, C ≠ ⊤ ∧ ∀ t ∈ lifespanSet T, enstrophy u t ≤ C

/-- Classical fact (Calderón–Zygmund maps `L^∞` to BMO, not to `L^∞`): no
constant bounds `‖∇v‖_∞` by `‖curl v‖_∞` for smooth periodic divergence-free
`v`. True in the literature; not formalized here (needs a log-type example). -/
def czGivesBMONotLinf : Prop :=
  ¬ ∃ C : ℝ≥0, ∀ v : E3 → E3, SmoothPeriodicData v →
    (⨆ x, (‖fderiv ℝ v x‖₊ : ℝ≥0∞)) ≤ C * ⨆ x, (‖curl v x‖₊ : ℝ≥0∞)

/-- Classical fact (spike obstruction): `L^6` does not control `L^∞` on 𝕋³;
a peak of height `M` on measure `δ` costs only `δ M⁶`. True; the smooth bump
construction is not formalized here. -/
def spikeObstruction : Prop :=
  ¬ ∃ C : ℝ≥0, ∀ f : E3 → ℝ, ContDiff ℝ ⊤ f → IsPeriodic f →
    (⨆ x, (‖f x‖₊ : ℝ≥0∞)) ≤ C * (∫⁻ x in unitCube, (‖f x‖₊ : ℝ≥0∞) ^ 6) ^ ((1 : ℝ) / 6)

/-- OPEN. The uniform vorticity ceiling the holographic heuristic asserts:
`‖ω(t)‖_∞` bounded on every finite interval. No ZFC proof is known. -/
def holographicNotAZFCBound : Prop :=
  ForAllFiniteSolutions fun u _ T =>
    ∃ C : ℝ≥0∞, C ≠ ⊤ ∧ ∀ t ∈ lifespanSet T, vortSup u t ≤ C

/-- Stretching rate `ω · (∇u) ω = ω · S ω`. -/
def stretching (v : E3 → E3) (x : E3) : ℝ :=
  ∑ i, ∑ j, curl v x i * pd (fun y => v y i) j x * curl v x j

/-- OPEN. Depleted stretching: `ω·Sω ≤ C |ω|²` uniformly on each finite
interval of existence. Not proved. -/
def depletedStretching : Prop :=
  ForAllFiniteSolutions fun u _ T =>
    ∃ C : ℝ, ∀ t ∈ lifespanSet T, ∀ x, stretching (u t) x ≤ C * ‖curl (u t) x‖ ^ 2

/-- **Proved.** The holographic ceiling would give the BKM integral. -/
theorem bkmIntegralFinite_of_holographic (h : holographicNotAZFCBound) :
    bkmIntegralFinite := by
  intro ν hν u0 u p T hu0 hT hsol
  obtain ⟨C, hC, hb⟩ := h ν hν u0 u p T hu0 hT hsol
  exact bkmIntegralFinite_of_vortSup_le u T hT C hC hb

/-- **Proved reduction.** `bkmIntegralFinite` plus the classical local theory
gives Statement (B). Both hypotheses are named; the first is open. -/
theorem statementB_of_bkmIntegralFinite (hloc : PeriodicMaximalSolutionWithBKM)
    (h : bkmIntegralFinite) : FeffermanStatementB :=
  feffermanStatementB_of_bkm hloc h

/-! Deprecated placeholders (kept, not deleted). They carry no content. -/

/-- Deprecated: old placeholder, `True`. Use `metriplecticControlsEnstrophyL2`. -/
def metriplecticControlsEnstrophyL2_placeholder : Prop := True
/-- Deprecated: old placeholder, `True`. Use `czGivesBMONotLinf`. -/
def czGivesBMONotLinf_placeholder : Prop := True
/-- Deprecated: old placeholder, `True`. Use `spikeObstruction`. -/
def spikeObstruction_placeholder : Prop := True
/-- Deprecated: old placeholder, `True`. Use `holographicNotAZFCBound`. -/
def holographicNotAZFCBound_placeholder : Prop := True
/-- Deprecated: old placeholder, `True`. Use `depletedStretching`. -/
def depletedStretching_placeholder : Prop := True

/-- Deprecated: records only that the old placeholders were `True`. -/
theorem missing_inputs_are_recorded :
    metriplecticControlsEnstrophyL2_placeholder ∧ czGivesBMONotLinf_placeholder ∧
      spikeObstruction_placeholder ∧ holographicNotAZFCBound_placeholder ∧
      depletedStretching_placeholder :=
  ⟨trivial, trivial, trivial, trivial, trivial⟩

end Clay.Gaps.MissingInputs
