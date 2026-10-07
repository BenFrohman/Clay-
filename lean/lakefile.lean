/-
Copyright (c) 2026 Benjamin Stanley Frohman. Apache-2.0.

Statement (B) workspace. Comparators are pins, not Lake dependencies.

Do not require these into this build:

* google-deepmind/formal-conjectures
  FormalConjectures/Millenium/NavierStokes.lean — statement comparator only.
* openai/NavierStokesAndEuler
  Forced breakdown, Fefferman (C) and (D). Different Lean pin.
  Compatible with unforced (B) staying open. Not a dependency.

Mathlib (ContDiff, MeasureTheory, Sobolev, ODE comparison) is the intended
dependency once a file actually imports it. These modules are Mathlib-free
so a false lemma cannot enter through sorry.
-/

import Lake
open Lake DSL

package «Clay-» where
  leanOptions := #[
    ⟨`autoImplicit, false⟩,
    ⟨`relaxedAutoImplicit, false⟩
  ]

@[default_target]
lean_lib Clay where
  roots := #[`Clay]
  globs := #[.submodules `Clay]
