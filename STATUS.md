# Status — not a Clay resolution

Author: Benjamin Stanley Frohman
Copyright (c) 2026 Benjamin Stanley Frohman
License: Apache License, Version 2.0

Private workspace. Statement (B) of Fefferman (unforced global smoothness on T^3) is not proved by the material in this repository.

## Module split

- `lean/Clay/Tether.lean` — `tether_degeneracy` is `P.kills u`, i.e. Π(u) = 0. `tether_bracket_preservation` is the structure field `B F KineticEnergy = 0`. Schematic. They do not bound M(t) or α = ξ·∇u·ξ, and they are not a derivation of the bilinear form on T^3.
- `lean/Clay/Gaps/TwoDClock.lean` — `sinPhi` is defined to be 0 and `phiSup` is defined to be `M0 * M0 * t`, closed by `rfl`. This models constant direction beside a linear clock. It does not construct a 2D solution or a Beltrami field.
- `lean/Clay/Gaps/BKMIntegral.lean` — `StatementB` is a `Prop`. `bkmIntegralFinite` is opaque, not `False`.

The `rfl` file does not rewrite the tether identities. `Tether.lean` does not import `TwoDClock`.

## What the clock does not say

On a finite interval, a constant M gives ∫_0^T M dt = M T < ∞ and ∫_0^T M^2 dt = M^2 T < ∞. Linear growth of the history is not a divergent Beale–Kato–Majda integral. It does disqualify a majorant whose positive term reads ∫_0^t M^2, because that coefficient grows on a solution already known to be regular.

Viscous 2D solutions decay (Ladyzhenskaya, cited, not re-proved). There is no claim that ∫_0^∞ M^2 diverges.

## What is not being added

No history-free weight is extracted from the tether. B(F,H) = 0 contributes nothing to the evolution of the energy, so it does not absorb α. The scale-critical field Z = |ω|^{-1/4} ω is not a corollary of Π(u) = 0.

## Referee finding (Section 10)

The bootstrap does not close. The auxiliary field satisfies ∂t φ + u·∇φ = |ω|^2, so ‖φ(t)‖_∞ ≤ ∫_0^t M(s)^2 ds. A positive equilibrium makes that integral grow like t, and the pasted driver like t^{3/2}. The autonomous ODE y' = C y^2 - κ'' y^3 is not a majorant. Hölder does not give ∫ |ω|^6 ≥ c M^4 without a lower bound on the measure of the peak set. Metriplectic decay controls ∫ |∇u|^2, not ∫ M. Cosmic censorship is not a ZFC theorem about these equations.

## External

`FormalConjectures/Millennium/NavierStokes.lean` is a URL pin, not a Lake dependency. `openai/NavierStokesAndEuler` is a forced (C)/(D) claim, not this argument. This repository does not adjudicate (C)/(D).
