/-
Copyright (c) 2026 Benjamin Stanley Frohman. Apache-2.0.
Conditional depletion. Not a closure of Statement (B), and not implied by the tether.
Constantin-Fefferman, Indiana Univ. Math. J. 42 (1993), 775-789.
The implication is an uninhabited Prop. It is not closed by sorry.
-/

namespace Clay.Depletion.GeometricAlignment

opaque Omega : ℝ
opaque rho : ℝ
opaque sinPhi : ℝ → ℝ → ℝ → ℝ

def cfAlignment (T : ℝ) : Prop :=
  0 < Omega ∧ 0 < rho ∧
    ∀ t x y, 0 ≤ t ∧ t ≤ T → sinPhi t x y ≤ |y| / rho

/-- Not proved. Not sorry. Not a theorem of True. -/
opaque cfAlignmentImpliesRegularity : Prop

end Clay.Depletion.GeometricAlignment
