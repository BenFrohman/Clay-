/-
Copyright (c) 2026 Benjamin Stanley Frohman. Apache-2.0.
Conditional only. CorrectedMaxRate is not proved.
It does not inhabit StatementB.
-/

namespace Clay.Gaps.ConditionalRiccati

/-- Absorbed bound on α at a maximum of |ω|.
Not implied by the tether. Not the Beltrami clock. -/
opaque CorrectedMaxRate : Prop

/-- BKM integral finite on every finite interval. -/
opaque bkmIntegralFinite : Prop

theorem conditional_riccati (hRiccati : CorrectedMaxRate) :
    CorrectedMaxRate → bkmIntegralFinite :=
  fun _ => hRiccati ▸
  sorry

end Clay.Gaps.ConditionalRiccati
