/-
Copyright (c) 2026 Benjamin Stanley Frohman. Apache-2.0.
Conditional geometric depletion, concrete. No sorry.
-/

import Clay.StatementB

noncomputable section

namespace Clay.Gaps.DirectionAlignment

open Clay.StatementB

/-- `sin` of the angle between `ω(t,x)` and `ω(t,x+y)`: `|ξ(x) × ξ(x+y)|`. -/
def sinPhi (u : ℝ → E3 → E3) (t : ℝ) (x y : E3) : ℝ :=
  let a := curl (u t) x
  let b := curl (u t) (x + y)
  Real.sqrt (max 0 (1 - (inner a b / (‖a‖ * ‖b‖)) ^ 2))

/-- Constantin–Fefferman alignment on `[0,T]` where `|ω| > Ω`, with scale `ρ`. -/
def cfAlignment (u : ℝ → E3 → E3) (Omega rho T : ℝ) : Prop :=
  0 < Omega ∧ 0 < rho ∧
    ∀ t x y, 0 ≤ t ∧ t ≤ T → Omega < ‖curl (u t) x‖ → Omega < ‖curl (u t) (x + y)‖ →
      sinPhi u t x y ≤ ‖y‖ / rho

/-- Deng–Hou–Yu data along a vortex line (length, curvature, direction
gradient, velocity scale). -/
structure DHYPacket where
  length : ℝ → ℝ
  curvature : ℝ → ℝ
  dirGrad : ℝ → ℝ
  velocityScale : ℝ → ℝ

/-- Named classical theorem (Constantin–Fefferman 1993), NOT formalized here:
Lipschitz direction alignment on a finite interval gives BKM finiteness. -/
def cfAlignmentImpliesRegularity : Prop :=
  ForAllFiniteSolutions fun u _ T =>
    T ≠ ⊤ → (∃ Omega rho, cfAlignment u Omega rho T.toReal) → BKMIntegralFinite u T

/-- Named classical criterion (Deng–Hou–Yu 2005), NOT formalized here, in a
simplified form: a bounded direction-gradient profile along the packet gives
BKM finiteness. -/
def dhyImpliesRegularity : Prop :=
  ForAllFiniteSolutions fun u _ T =>
    (∃ (P : DHYPacket) (C : ℝ), ∀ t, 0 ≤ t → P.dirGrad t * P.length t ≤ C ∧
        P.velocityScale t * P.curvature t * P.length t ≤ C) → BKMIntegralFinite u T


/-- Semantic regression for the existing abstract packet interface, not a DHY PDE
criterion: the packet is unrelated to `u`, so its four functions can all be zero.
Consequently the current named proposition repackages the entire open BKM input.
A genuine geometric criterion needs solution-linked vortex lines and estimates. -/
theorem abstract_dhy_criterion_iff_periodicBKMIntegrability :
    dhyImpliesRegularity ↔ PeriodicBKMIntegrability := by
  constructor
  · intro h ν hν u0 u p T hu0 hT hsol
    apply h ν hν u0 u p T hu0 hT hsol
    refine ⟨⟨fun _ => 0, fun _ => 0, fun _ => 0, fun _ => 0⟩, 0, ?_⟩
    intro t ht
    constructor <;> simp
  · intro h ν hν u0 u p T hu0 hT hsol _
    exact h ν hν u0 u p T hu0 hT hsol

end Clay.Gaps.DirectionAlignment
