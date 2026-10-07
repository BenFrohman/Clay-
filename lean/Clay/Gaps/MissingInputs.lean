/-
Copyright (c) 2026 Benjamin Stanley Frohman.
Licensed under the Apache License, Version 2.0. See LICENSE.

Inputs the Section 10 bootstrap does not have.
The BKM integral is not declared false: Statement (B) is open, not a breakdown claim.
-/

namespace Clay.Gaps.MissingInputs

/-- Named obligation. Not inhabited. Not set to False. -/
opaque bkmIntegralFinite : Prop

/-- Metriplectic decay is an L2 fact. It is not the BKM integral. -/
def metriplecticControlsEnstrophyL2 : Prop := True

theorem metriplectic_does_not_mention_bkm :
    metriplecticControlsEnstrophyL2 :=
  trivial

/-- CZ puts ∇u in BMO, not L∞. A pure C_CZ M² bound at a maximum is extra. -/
def czGivesBMONotLinf : Prop := True

/-- Spike: height M on a set of measure δ contributes order δ M⁶ to the L⁶ integral. -/
def spikeObstruction : Prop := True

/-- Cosmic censorship is not a ZFC theorem about unforced NS on T³. -/
def holographicNotAZFCBound : Prop := True

/-- Depletion estimate alignment would justify, if the angle hypothesis is assumed.
Not implied by the tether. -/
def depletedStretching : Prop := True

end Clay.Gaps.MissingInputs
