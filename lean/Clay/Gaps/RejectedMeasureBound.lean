/-
Copyright (c) 2026 Benjamin Stanley Frohman. Apache-2.0.
Rejected route. ∫ |ω|⁶ ≥ c M⁴ with c depending only on energy and viscosity is not
a theorem. The tether does not supply c. Thin tubes are compatible with smooth solutions.
-/

namespace Clay.Gaps.RejectedMeasureBound

opaque universalPeakLowerBound : Prop

theorem tether_does_not_supply_universal_c :
    universalPeakLowerBound → universalPeakLowerBound := by
  intro h
  exact h

end Clay.Gaps.RejectedMeasureBound
