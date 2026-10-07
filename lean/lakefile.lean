/-
Copyright (c) 2026 Benjamin Stanley Frohman. Apache-2.0.

Statement (B) workspace. Comparators are pins, not Lake dependencies.
Mathlib is required so that ℝ and interval integrals elaborate.
It does not discharge StatementB.

Do not require these into this build:

* google-deepmind/formal-conjectures
  FormalConjectures/Millennium/NavierStokes.lean — statement comparator only.
* openai/NavierStokesAndEuler
  Forced breakdown, Fefferman (C) and (D). Different Lean pin.
  Compatible with unforced (B) staying open. Not a dependency.
-/

import Lake
open Lake DSL

package «Clay-» where
  leanOptions := #[
    ⟨`autoImplicit, false⟩,
    ⟨`relaxedAutoImplicit, false⟩
  ]

require "leanprover-community" / "mathlib" @ git "v4.16.0"

@[default_target]
lean_lib Clay where
  roots := #[`Clay]
  globs := #[.submodules `Clay]
