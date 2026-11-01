/-
Copyright (c) 2026 Benjamin Stanley Frohman. Apache-2.0.
Conditional depletion, concrete. Not a closure of Statement (B).
Same content as `Clay.Gaps.DirectionAlignment`; kept as its own namespace.
-/

import Clay.Gaps.DirectionAlignment

noncomputable section

namespace Clay.Depletion.GeometricAlignment

open Clay.StatementB

def sinPhi (u : ℝ → E3 → E3) (t : ℝ) (x y : E3) : ℝ :=
  Clay.Gaps.DirectionAlignment.sinPhi u t x y

def cfAlignment (u : ℝ → E3 → E3) (Omega rho T : ℝ) : Prop :=
  Clay.Gaps.DirectionAlignment.cfAlignment u Omega rho T

/-- Named classical theorem (Constantin–Fefferman 1993), not formalized. -/
def cfAlignmentImpliesRegularity : Prop :=
  Clay.Gaps.DirectionAlignment.cfAlignmentImpliesRegularity

end Clay.Depletion.GeometricAlignment
