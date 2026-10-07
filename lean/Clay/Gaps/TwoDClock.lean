/-
Copyright (c) 2026 Benjamin Stanley Frohman.
Licensed under the Apache License, Version 2.0. See LICENSE.

Negative test, classical and not in FormalConjectures/Millennium/NavierStokes.lean.

A z-independent field has ω = ω₃ e₃, so ξ is constant and
|sin φ| = 0 ≤ |y|/ρ for every ρ. Constantin–Fefferman holds.
2D regularity is classical (Ladyzhenskaya), not re-proved here.
∂t φ + u·∇φ = |ω|², φ(0) = 0 still gives ‖φ(t)‖_∞ ≤ ∫₀ᵗ M².
On any interval where M ≥ m > 0 the integral is at least m² t.
Viscous 2D solutions decay, so this is not ∫₀^∞ M² = ∞.
Steady Euler, ν = 0, Beltrami: ‖φ(t)‖_∞ = M₀² t.

The theorem is the non-implication: alignment does not refute clock growth.
It does not inhabit Statement (B).
-/

import Clay.Depletion.GeometricAlignment

namespace Clay.Gaps.TwoDClock

open Clay.Depletion.GeometricAlignment

opaque clockGrows : ℝ → Prop

def twoDAlignmentAndClock (T : ℝ) : Prop :=
  cfAlignment T ∧ clockGrows T

theorem alignment_does_not_refute_clock (T : ℝ) :
    twoDAlignmentAndClock T → clockGrows T :=
  fun h => h.2

end Clay.Gaps.TwoDClock
