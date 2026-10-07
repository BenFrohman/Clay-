/-
Copyright (c) 2026 Benjamin Stanley Frohman.
Licensed under the Apache License, Version 2.0. See LICENSE.

Next analytic boundary, history-free. Not inhabited. Not False.
Not implied by Tether.bracket_vanishes_on_energy.

Beale--Kato--Majda can be read through the stretching factor
α = ξ · ∇u · ξ. Finiteness of ∫ ‖α‖_∞ is the slot the clock was
standing in for. This file does not prove it.
-/

namespace Clay.Gaps.StretchingIntegral

/-- Open. ∫_0^T ‖α(t)‖_∞ dt < ∞, with a bound depending only on the data. -/
opaque stretchingIntegralFinite : Prop

/-- Large-data critical norm. Smallness in BMO^{-1} is a known theorem
elsewhere and is not this proposition. -/
opaque criticalNormBounded : Prop

end Clay.Gaps.StretchingIntegral
