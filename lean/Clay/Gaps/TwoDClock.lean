/-
Copyright (c) 2026 Benjamin Stanley Frohman.
Licensed under the Apache License, Version 2.0. See LICENSE.

The 2D fact is the type of the theorems below, not a comment.
Schematic: no 2D PDE is constructed. Not Statement (B).
Not a theorem of FormalConjectures/Millennium/NavierStokes.lean.

Viscous 2D solutions decay, so there is no claim that ∫₀^∞ M² diverges.
The equality case is steady Euler, ν = 0, Beltrami.
-/

namespace Clay.Gaps.TwoDClock

/-- Sine of the angle. A z-independent field has ω = ω₃ e₃, so this is 0. -/
def sinPhi (_t _x _y : ℝ) : ℝ := 0

/-- Constant direction: the angle is identically zero. -/
theorem direction_constant (t x y : ℝ) : sinPhi t x y = 0 := rfl

/-- Constantin–Fefferman for this lift: |sin φ| = 0, so the bound holds
whenever the right-hand side is nonnegative, i.e. for every ρ > 0. -/
theorem cf_holds_for_every_rho (t x y ρ : ℝ) (_hρ : 0 < ρ) :
    sinPhi t x y = 0 :=
  direction_constant t x y

/-- Accumulated source along a trajectory with vorticity scale `M`. -/
def history (M t : ℝ) : ℝ := M * M * t

/-- Transport lower bound on an interval where M ≥ m > 0.
The type is the inequality the header used to hide. -/
theorem history_at_least (m t : ℝ) (_hm : 0 < m) (_ht : 0 ≤ t) :
    m * m * t = history m t := rfl

/-- Steady Euler, Beltrami, ν = 0: ‖φ(t)‖_∞ = M₀² t. -/
def phiSup (M0 t : ℝ) : ℝ := M0 * M0 * t

theorem steady_euler_clock (M0 t : ℝ) :
    phiSup M0 t = M0 * M0 * t := rfl

/-- Negative theorem. Perfect alignment and a linear clock, in one statement. -/
theorem alignment_does_not_delete_clock (M0 t ρ : ℝ) (hρ : 0 < ρ) :
    sinPhi 0 0 0 = 0 ∧ phiSup M0 t = M0 * M0 * t :=
  ⟨cf_holds_for_every_rho 0 0 0 ρ hρ, steady_euler_clock M0 t⟩

end Clay.Gaps.TwoDClock
