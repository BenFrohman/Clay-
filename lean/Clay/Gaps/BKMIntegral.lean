/-
Copyright (c) 2026 Benjamin Stanley Frohman. All rights reserved.
Released under Apache 2.0 license as described in the file LICENSE.
Authors: Benjamin Stanley Frohman
-/

import Clay.StatementB

/-!
# lean.Clay.Gaps.BKMIntegral

Named open obligation, now concrete (formerly opaque `M`, `dataBound`,
`initialHs`). Not a theorem.
-/

noncomputable section

namespace Clay.Gaps.BKMIntegral

open Clay.StatementB

/-- `M(t) = ‖ω(t)‖_∞` for a velocity field `u`. -/
def M (u : ℝ → E3 → E3) (t : ℝ) : ENNReal := vortSup u t

/-- The BKM integral of `u` on `[0,T)` is finite. -/
def unforcedBKMBound (u : ℝ → E3 → E3) (T : ENNReal) : Prop := BKMIntegralFinite u T

/-- Statement (B) of Fefferman, precisely (see `Clay.StatementB`). Open. -/
def StatementB : Prop := FeffermanStatementB

end Clay.Gaps.BKMIntegral
