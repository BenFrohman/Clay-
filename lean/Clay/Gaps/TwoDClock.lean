/-
Copyright (c) 2026 Benjamin Stanley Frohman.
Licensed under the Apache License, Version 2.0. See LICENSE.

The 2D fact is the structure below, not a comment.
Classical (Ladyzhenskaya; steady Euler). Not re-proved.
Not a theorem of FormalConjectures/Millennium/NavierStokes.lean.
Does not inhabit Statement (B).
-/

import Clay.Depletion.GeometricAlignment

namespace Clay.Gaps.TwoDClock

open Clay.Depletion.GeometricAlignment

opaque clockGrows : ℝ → Prop
opaque phiNorm : ℝ → ℝ
opaque M : ℝ → ℝ
opaque nu : ℝ

/-- Classical 2D / z-independent witness. Fields are the fact.
`directionConstant` is ω = ω₃ e₃, so |sin φ| = 0.
`historyLower` is ‖φ(t)‖_∞ ≥ m² t when M ≥ m > 0.
`viscousNotInfinite` records that decay blocks ∫₀^∞ M² = ∞.
`beltramiEquality` is ν = 0 and ‖φ(t)‖_∞ = M₀² t. -/
structure TwoDWitness (T : ℝ) where
  directionConstant : cfAlignment T
  historyLower : ∀ m t, 0 < m → 0 ≤ t → t ≤ T → m ≤ M t → m ^ 2 * t ≤ phiNorm t
  viscousNotInfinite : 0 < nu → ¬ clockGrows T
  beltramiEquality : nu = 0 → ∀ t, 0 ≤ t → phiNorm t = (M 0) ^ 2 * t

def twoDAlignmentAndClock (T : ℝ) : Prop :=
  cfAlignment T ∧ clockGrows T

/-- Alignment does not refute clock growth. Projection, not a PDE proof. -/
theorem alignment_does_not_refute_clock (T : ℝ) :
    twoDAlignmentAndClock T → clockGrows T :=
  fun h => h.2

/-- The 2D fact, as a statement: constant direction and a linear clock can hold together.
Inhabited only by a supplied witness. This file does not construct one. -/
theorem two_d_fact (T : ℝ) (w : TwoDWitness T) (_hnu : nu = 0) :
    w.directionConstant ∧ (∀ t, 0 ≤ t → phiNorm t = (M 0) ^ 2 * t) :=
  ⟨w.directionConstant, w.beltramiEquality _hnu⟩

end Clay.Gaps.TwoDClock
