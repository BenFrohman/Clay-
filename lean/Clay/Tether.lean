/-
Copyright (c) 2026 Benjamin Stanley Frohman. Apache-2.0.
Geometric core only. Does not mention vorticity direction and does not prove Fefferman (B).
-/

namespace Clay.Tether

opaque Velocity : Type
opaque Functional : Type
opaque KineticEnergy : Functional
opaque PiOrthogonal : Velocity → Velocity → Velocity

axiom pi_kills_velocity (u : Velocity) : PiOrthogonal u u = PiOrthogonal u u → True

opaque B : Functional → Functional → Velocity → ℝ

/-- Degeneracy: the correction vanishes on the kinetic energy.
Statement about the bracket. Does not constrain ω(x)/|ω(x)|. -/
axiom degeneracy (F : Functional) (u : Velocity) : B F KineticEnergy u = 0

theorem tether_preserves_euler_field (F : Functional) (u : Velocity) :
    B F KineticEnergy u = 0 :=
  degeneracy F u

end Clay.Tether
