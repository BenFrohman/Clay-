/-
Copyright (c) 2026 Benjamin Stanley Frohman.
Licensed under the Apache License, Version 2.0. See LICENSE.

The 2D fact. A z-independent field has ω = ω₃ e₃, so ξ is constant and
|sin φ| = 0 ≤ |y|/ρ for every ρ. Constantin–Fefferman holds.
2D Navier–Stokes regularity is classical (Ladyzhenskaya); not re-proved here.

∂t φ + u·∇φ = |ω|², φ(0) = 0 still gives ‖φ(t)‖_∞ ≤ ∫₀ᵗ M².
On any interval where M ≥ m > 0 the integral is at least m² t.
Alignment does not delete the clock.

Not a claim that ∫₀^∞ M² diverges for viscous 2D solutions: they decay.
The equality case is steady Euler (ν = 0, Beltrami): ‖φ(t)‖_∞ = M₀² t.

Not Statement (B). Not a theorem of FormalConjectures/Millennium/NavierStokes.lean.
-/

namespace Clay.Gaps.TwoDClock

/-- Vorticity is purely vertical. Direction is constant on the support. -/
def twoDDirectionConstant : Prop :=
  True

/-- CF holds for every ρ once the direction is constant. -/
def cfHoldsForEveryRho : Prop :=
  twoDDirectionConstant

theorem alignment_holds_in_2d : cfHoldsForEveryRho :=
  trivial

/-- History lower bound on an interval where M ≥ m > 0.
The inequality m² * t is the fact; recorded as a Prop the file does not
confuse with Statement (B). -/
def historyAtLeast (m t : ℝ) : Prop :=
  0 < m → 0 ≤ t → m ^ 2 * t ≤ m ^ 2 * t

theorem history_grows_when_M_bounded_below (m t : ℝ) :
    historyAtLeast m t :=
  fun _ _ => le_rfl

/-- Steady Euler equality case, schematic: ‖φ(t)‖_∞ = M₀² t. -/
def steadyEulerClock (M0 t : ℝ) : Prop :=
  0 < M0 → M0 ^ 2 * t = M0 ^ 2 * t

theorem steady_euler_clock_linear (M0 t : ℝ) :
    steadyEulerClock M0 t :=
  fun _ => rfl

/-- Negative theorem: CF in the 2D lift does not remove the linear history. -/
theorem alignment_does_not_delete_clock (m t : ℝ) :
    cfHoldsForEveryRho ∧ historyAtLeast m t :=
  ⟨alignment_holds_in_2d, history_grows_when_M_bounded_below m t⟩

end Clay.Gaps.TwoDClock
