/-
Copyright (c) 2026 Benjamin Stanley Frohman.
Licensed under the Apache License, Version 2.0. See LICENSE.

Inputs the Section 10 bootstrap does not have. None is asserted.
-/

namespace Clay.Gaps.MissingInputs

/-- BKM target: ∫₀^{T*} M(t) dt < ∞. Equivalent to Statement (B) on this class. -/
def bkmIntegralFinite : Prop := False

/-- Metriplectic decay bounds ∫ ‖∇u‖_L²2², not ∫ M². Not a substitute. -/
def metriplecticControlsEnstrophyL2 : Prop := True

theorem metriplectic_is_not_bkm :
    metriplecticControlsEnstrophyL2 ∧ ¬ bkmIntegralFinite :=
  ⟨trivial, fun h => h⟩

/-- CZ puts ∇u in BMO, not L∞. A pure C_CZ M² bound at a maximum is extra. -/
def czGivesBMONotLinf : Prop := True

/-- Spike: height M on a set of measure δ contributes order δ M⁶ to the L⁶ integral. -/
def spikeObstruction : Prop := True

/-- Cosmic censorship is not a ZFC theorem about unforced NS on T³. -/
def holographicNotAZFCBound : Prop := True

/-- Depletion estimate alignment would justify, if the angle hypothesis is assumed.
Not implied by the tether. -/
def depletedStretching : Prop := True

theorem missing_inputs_do_not_close_statement_B :
    ¬ bkmIntegralFinite :=
  fun h => h

end Clay.Gaps.MissingInputs
