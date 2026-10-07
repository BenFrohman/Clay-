/-
Copyright (c) 2026 Benjamin Stanley Frohman. Apache-2.0.
Geometric core, schematic. Π(u) = 0 is the defining property of the projection.
Not an a priori estimate on ‖ω‖_∞. Does not mention vortex direction.
-/

import Mathlib.Data.Real.Basic

namespace Clay.Tether

opaque Velocity : Type
opaque zeroVel : Velocity
opaque Functional : Type
opaque KineticEnergy : Functional

structure OrthProj where
  apply : Velocity → Velocity
  kills : ∀ u : Velocity, apply u = zeroVel

theorem tether_degeneracy (P : OrthProj) (u : Velocity) : P.apply u = zeroVel :=
  P.kills u

opaque B : Functional → Functional → ℝ

structure Tether where
  proj : OrthProj
  bracket_vanishes_on_energy : ∀ F : Functional, B F KineticEnergy = 0

theorem tether_bracket_preservation (T : Tether) (F : Functional) :
    B F KineticEnergy = 0 :=
  T.bracket_vanishes_on_energy F

end Clay.Tether
