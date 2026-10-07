/-
Copyright (c) 2026 Benjamin Stanley Frohman. Apache-2.0.

Mathlib is required at v4.16.0 so ℝ and interval integrals elaborate.
formal-conjectures and openai/NavierStokesAndEuler stay URL pins, not dependencies.
-/

import Lake
open Lake DSL

package «Clay-» where
  leanOptions := #[
    ⟨`autoImplicit, false⟩,
    ⟨`relaxedAutoImplicit, false⟩
  ]

require «leanprover-community» / «mathlib» @ git «v4.16.0»

@[default_target]
lean_lib Clay where
  roots := #[`Clay]
  globs := #[.submodules `Clay]
