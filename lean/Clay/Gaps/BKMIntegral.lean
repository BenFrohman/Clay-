/-
Copyright (c) 2026 Benjamin Stanley Frohman. Apache-2.0.
Named open obligation. Not a theorem.
Beale–Kato–Majda (Comm. Math. Phys. 94, 1984) is a continuation theorem.
On T³, unforced, the bound below is equivalent to Fefferman (B).
A theorem := sorry would export Statement (B) under sorryAx.
-/

namespace Clay.Gaps.BKMIntegral

opaque M : ℝ → ℝ
opaque dataBound : ℝ → ℝ
opaque initialHs : ℝ

def unforcedBKMBound (T : ℝ) : Prop :=
  0 ≤ T ∧ ∫ t in (0 : ℝ)..T, M t ≤ dataBound initialHs

def StatementB : Prop :=
  ∀ T : ℝ, 0 ≤ T → unforcedBKMBound T

end Clay.Gaps.BKMIntegral
