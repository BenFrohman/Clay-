# Statement comparator

Author: Benjamin Stanley Frohman
Copyright (c) 2026 Benjamin Stanley Frohman
License: Apache License, Version 2.0

Not a Lake dependency.

File: `google-deepmind/formal-conjectures`,
`FormalConjectures/Millennium/NavierStokes.lean`
(path spelling is Millennium).

Declarations, all still closed by `sorry` in that file:

- `navier_stokes_existence_and_smoothness_R3` — Fefferman (A), `f := 0`
- `navier_stokes_existence_and_smoothness_periodic` — Fefferman (B), `f := 0`, on ℝ³/ℤ³
- `navier_stokes_breakdown_R3` — Fefferman (C), force allowed
- `navier_stokes_breakdown_periodic` — Fefferman (D), force allowed

The file records a September 2026 claim that (C) and (D) were formalized in
`openai/NavierStokesAndEuler`. It does not contain that proof, and it does not
prove (B). It has no 2D theorem, no auxiliary field φ, and no vortex-direction hypothesis.

The negative test for the φ clock is `lean/Clay/Gaps/TwoDClock.lean`:
alignment does not refute clock growth. Classical witness: a z-independent
2D solution has constant ξ, so Constantin–Fefferman holds, and
‖φ(t)‖_∞ ≤ ∫₀ᵗ M² still grows on any interval where M is bounded below.
