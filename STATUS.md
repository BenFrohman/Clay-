# Status — not a Clay resolution

Private workspace. Statement (B) of Fefferman (unforced global smoothness on T^3) is not proved by the material in this repository.

## What was requested

Typecheck the Frohmanian Tether manuscript, produce a Lean build, reuse modules, and scaffold a repo for a claimed resolution of the Clay Navier–Stokes problem.

## Referee finding

The Section 10 bootstrap does not close. Two gaps are mathematical, not editorial.

1. History integral. The auxiliary field satisfies
   \partial_t \phi + u \cdot \nabla\phi = |\omega|^2, \phi(0)=0,
   so \|\phi(t)\|_\infty \le \int_0^t \|\omega(s)\|_\infty^2 ds along characteristics (on T^3, no boundary). If a comparison function y stays at a positive equilibrium y_*, then \int_0^t y(s)^2 ds \sim y_*^2 t. The coefficient in
   dS_\epsilon/dt \le C_abs (1 + M_\epsilon^3 \|\phi_\epsilon\|_\infty^{3/2}) - \kappa' \int |\omega_\epsilon|^6
   is then time-dependent and grows like t^{3/2}. The ODE y' = C y^2 - \kappa'' y^3 with constant C is not a majorant.

2. Sup-norm from an integral. On a domain of finite measure, Hölder gives upper bounds of lower norms by higher norms, not the reverse. The relation \int |\omega_\epsilon|^6 \ge c M_\epsilon^4 is false without a positive lower bound on the measure of the near-maximum set. A peak of height M on a set of measure \epsilon contributes about M^6 \epsilon to the L^6 integral, which can stay finite while M \to \infty.

Energy decay from the metriplectic bracket controls \int |\nabla u|^2, not \int \|\omega\|_\infty^2 dt. The latter is the Beale–Kato–Majda quantity. Cosmic censorship is not a theorem of ZFC about the Navier–Stokes equations and cannot supply the missing volume bound.

## External context (September 2026)

OpenAI announced a Lean formalization of Fefferman (C) and (D): finite-time breakdown with a smooth external force. Clay (11 September 2026) said the problem has apparently been settled; the prize process is unhurried and the problem page remained Active. Forced breakdown is compatible with unforced (A)/(B) still being open. This repository does not adjudicate (C)/(D).

## Existing corpus

- BenFrohman/NS_Millennium_Proof — Lean 4 pin mathlib v4.30.0-rc1. `global_regularity_for_NS` still ends in `sorry` (uniqueness). Local existence, BKM, Calderón–Zygmund, and Jacobi arithmetic remain cited `sorry`s. `#print axioms` reports `sorryAx`.
- BenFrohman/ns-i11-conditional-criterion — explicitly not a Clay claim.
- BenFrohman/global-from-local-restart — conditional continuation, not unconditional.
- BenFrohman/two-point-strain-coercivity — intermediate-axis counterexample; CZ remainder is not free.

## Reusable imports (not a proof)

- Mathlib: `Mathlib.Analysis.Calculus.ContDiff.Basic`, `MeasureTheory`, Sobolev, ODE comparison.
- Comparator statements only: `google-deepmind/formal-conjectures` file `FormalConjectures/Millenium/NavierStokes.lean`.
- Forced-breakdown formalization (different statement): `openai/NavierStokesAndEuler`.

Do not treat a blue InfoView banner on a theorem that depends on `sorry` as verification.
