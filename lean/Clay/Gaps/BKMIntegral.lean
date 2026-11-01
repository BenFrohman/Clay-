/-
Copyright (c) 2026 Benjamin Stanley Frohman. Apache-2.0.
Named open obligation, now concrete (formerly opaque `M`, `dataBound`,
`initialHs`). Not a theorem.
-/

import Clay.StatementB

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
