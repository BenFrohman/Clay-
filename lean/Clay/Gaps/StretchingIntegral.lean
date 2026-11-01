/-
Copyright (c) 2026 Benjamin Stanley Frohman.
Licensed under the Apache License, Version 2.0. See LICENSE.

Next analytic boundary, history-free. Concrete, not asserted.
Not implied by Tether.bracket_vanishes_on_energy.

Beale--Kato--Majda can be read through the stretching factor
α = ξ · ∇u · ξ, ξ = ω/|ω|. Finiteness of ∫ ‖α‖_∞ is the slot the clock was
standing in for. This file does not prove it.
-/

import Clay.Gaps.MissingInputs

noncomputable section

namespace Clay.Gaps.StretchingIntegral

open MeasureTheory Clay.StatementB Clay.Gaps.MissingInputs
open scoped ENNReal NNReal

/-- `α(t,x) = ξ·∇u·ξ = (ω·Sω)/|ω|²` (zero where `ω = 0`). -/
def alpha (u : ℝ → E3 → E3) (t : ℝ) (x : E3) : ℝ :=
  stretching (u t) x / ‖curl (u t) x‖ ^ 2

/-- `‖α(t)‖_∞`. -/
def alphaSup (u : ℝ → E3 → E3) (t : ℝ) : ℝ≥0∞ := ⨆ x, (‖alpha u t x‖₊ : ℝ≥0∞)

/-- OPEN. `∫_0^T ‖α(t)‖_∞ dt < ∞` on every finite interval of existence. -/
def stretchingIntegralFinite : Prop :=
  ForAllFiniteSolutions fun u _ T => ∫⁻ t in lifespanSet T, alphaSup u t < ⊤

/-- `‖u(t)‖_{L^3(𝕋³)}^3`. -/
def l3Cubed (u : ℝ → E3 → E3) (t : ℝ) : ℝ≥0∞ :=
  ∫⁻ x in unitCube, (‖u t x‖₊ : ℝ≥0∞) ^ 3

/-- OPEN. Large-data critical norm (`L^3`, scale-invariant) stays bounded on
each finite interval. Smallness in BMO⁻¹ (Koch–Tataru) is a different theorem. -/
def criticalNormBounded : Prop :=
  ForAllFiniteSolutions fun u _ T =>
    ∃ C : ℝ≥0∞, C ≠ ⊤ ∧ ∀ t ∈ lifespanSet T, l3Cubed u t ≤ C

end Clay.Gaps.StretchingIntegral
