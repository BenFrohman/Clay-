/-
Copyright (c) 2026 Benjamin Stanley Frohman.
Licensed under the Apache License, Version 2.0. See LICENSE.

Inputs the Section 10 bootstrap does not have.
bkmIntegralFinite is opaque. It is not False: that would be a breakdown claim.
Statement (B) is open.
-/

namespace Clay.Gaps.MissingInputs

opaque bkmIntegralFinite : Prop

def metriplecticControlsEnstrophyL2 : Prop := True
def czGivesBMONotLinf : Prop := True
def spikeObstruction : Prop := True
def holographicNotAZFCBound : Prop := True
def depletedStretching : Prop := True

theorem missing_inputs_are_recorded :
    metriplecticControlsEnstrophyL2 ∧ czGivesBMONotLinf ∧ spikeObstruction ∧
      holographicNotAZFCBound ∧ depletedStretching :=
  ⟨trivial, trivial, trivial, trivial, trivial⟩

end Clay.Gaps.MissingInputs
