/-
Copyright (c) 2026 Benjamin Stanley Frohman. Apache-2.0.

Mathlib v4.16.0. The scope/name slash form does not parse on Lake 5.0.0
(unexpected token '/'). The git URL form does.
formal-conjectures and openai/NavierStokesAndEuler stay URL pins.
-/

import Lake
open Lake DSL

package «Clay-» where
  leanOptions := #[
    ⟨`autoImplicit, false⟩,
    ⟨`relaxedAutoImplicit, false⟩
  ]

require mathlib from git
  "https://github.com/leanprover-community/mathlib4" @ "v4.16.0"

@[default_target]
lean_lib Clay where
  roots := #[`Clay]
  globs := #[.submodules `Clay]
