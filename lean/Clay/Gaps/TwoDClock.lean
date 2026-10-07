/-
Copyright (c) 2026 Benjamin Stanley Frohman.
Licensed under the Apache License, Version 2.0. See LICENSE.

Negative test. Classical 2D regularity does not kill the φ clock.

A z-independent field has ω = ω₃ e₃, so ξ is constant and the
Constantin–Fefferman bound |sin φ| ≤ |y|/ρ holds for every ρ.
Global regularity of 2D Navier–Stokes is classical (Ladyzhenskaya).
The transport equation ∂t φ + u·∇φ = |ω|², φ(0) = 0, still gives
‖φ(t)‖_∞ ≤ ∫₀ᵗ M(s)² ds. On any interval where M is bounded below
by a positive constant, that integral grows at least linearly, and the
pasted driver with (∫ y²)^{3/2} is not a uniform majorant.

This is not a claim that ∫₀^∞ M² diverges for viscous 2D solutions:
those solutions decay. The clean equality case is steady Euler
(ν = 0, Beltrami): M constant, ‖φ(t)‖_∞ = M² t.

Not Statement (B). Not a theorem of FormalConjectures/Millennium/NavierStokes.lean.
-/

import Clay.Depletion.GeometricAlignment
import Clay.Gaps.HistoryClock

namespace Clay.Gaps.TwoDClock

open Clay.Depletion.GeometricAlignment
open Clay.Gaps.HistoryClock

/-- Clock growth on an interval, schematic. Not refuted by alignment. -/
opaque clockGrows : ℝ → Prop

/-- Conjunction that classical 2D realizes: alignment holds, and the clock still grows. -/
def twoDAlignmentAndClock (T : ℝ) : Prop :=
  cfAlignment T ∧ clockGrows T

theorem alignment_does_not_refute_clock (T : ℝ) :
    twoDAlignmentAndClock T → clockGrows T :=
  fun h => h.2

theorem driver_defined_independently_of_alignment (y : ℝ → ℝ) (t : ℝ) :
    True := by
  let _ := historyDriver y t
  trivial

end Clay.Gaps.TwoDClock
