/-
Copyright (c) 2026 Benjamin Stanley Frohman. Apache-2.0.
Named open obligation. Not a theorem.
-/

import Mathlib.MeasureTheory.Integral.IntervalIntegral

namespace Clay.Gaps.BKMIntegral

open MeasureTheory intervalIntegral

opaque M : ℝ → ℝ
opaque dataBound : ℝ → ℝ
opaque initialHs : ℝ

def unforcedBKMBound (T : ℝ) : Prop :=
  0 ≤ T ∧ ∫ t in (0 : ℝ)..T, M t ≤ dataBound initialHs

def StatementB : Prop :=
  ∀ T : ℝ, 0 ≤ T → unforcedBKMBound T

end Clay.Gaps.BKMIntegral
