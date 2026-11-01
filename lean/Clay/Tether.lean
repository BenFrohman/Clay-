/-
Copyright (c) 2026 Benjamin Stanley Frohman. Apache-2.0.
Geometric core, concrete. Π_u(u) = 0 is proved for the pointwise projection
perpendicular to the local velocity (the Aug 10 "Frohmanian Symplectic Tether"
form). Not an a priori estimate on the vorticity maximum. Does not mention
vortex direction. Strictly geometric; no regularity claim.
-/

import Clay.StatementB

noncomputable section

namespace Clay.Tether

open MeasureTheory Clay.StatementB

/-- Velocity fields on ℝ³ (periodicity is imposed where used). -/
abbrev Velocity : Type := E3 → E3

def zeroVel : Velocity := 0

/-- Functionals of the velocity. -/
abbrev Functional : Type := Velocity → ℝ

/-- Kinetic energy `½ ∫_{[0,1]³} |u|²`. -/
def KineticEnergy : Functional := fun u =>
  (1 / 2 : ℝ) * ∫ x in {x : E3 | ∀ i, x i ∈ Set.Icc (0 : ℝ) 1}, ‖u x‖ ^ 2

/-- Pointwise projection perpendicular to `a`: `Π_a v = v - (a·v/|a|²) a`. -/
def perpProj (a v : E3) : E3 := v - (inner a v / ‖a‖ ^ 2 : ℝ) • a

/-- **Proved.** `Π_a a = 0`. -/
theorem perpProj_self (a : E3) : perpProj a a = 0 := by
  unfold perpProj
  by_cases h : a = 0
  · simp [h]
  · have : (‖a‖ ^ 2 : ℝ) ≠ 0 := by positivity
    rw [real_inner_self_eq_norm_sq, div_self this, one_smul, sub_self]

/-- The field-level tether projection `(Π_u v)(x) = Π_{u(x)} v(x)`. -/
def tetherProj (u v : Velocity) : Velocity := fun x => perpProj (u x) (v x)

/-- **Proved.** `Π_u(u) = 0`. -/
theorem tetherProj_self (u : Velocity) : tetherProj u u = zeroVel := by
  funext x; simp [tetherProj, perpProj_self, zeroVel]

structure OrthProj where
  apply : Velocity → Velocity
  kills : ∀ u : Velocity, apply u = zeroVel

/-- The diagonal tether `u ↦ Π_u u` is an `OrthProj`. -/
def diagonalTether : OrthProj := ⟨fun u => tetherProj u u, tetherProj_self⟩

theorem tether_degeneracy (P : OrthProj) (u : Velocity) : P.apply u = zeroVel :=
  P.kills u

/-- A tether: a projection and a bracket on functionals for which the energy is
a Casimir. The bracket is data, not a derived Navier–Stokes structure. -/
structure Tether where
  proj : OrthProj
  B : Functional → Functional → ℝ
  bracket_vanishes_on_energy : ∀ F : Functional, B F KineticEnergy = 0

theorem tether_bracket_preservation (T : Tether) (F : Functional) :
    T.B F KineticEnergy = 0 :=
  T.bracket_vanishes_on_energy F

end Clay.Tether
