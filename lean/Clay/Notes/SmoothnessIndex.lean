/-
Copyright (c) 2026 Benjamin Stanley Frohman. Apache-2.0.
Authors: Frohman, Benjamin Stanley

Smoothness index used in `Clay.StatementB` (correction of 2026-11-09).

At the pinned Mathlib the index of `ContDiff`/`ContDiffOn` has type `WithTop ℕ∞`.
Mathlib's scoped notation (`open scoped ContDiff`) is
* `∞ = ((⊤ : ℕ∞) : WithTop ℕ∞)`: infinitely differentiable (C^∞);
* `ω = (⊤ : WithTop ℕ∞)`: real-analytic (C^ω).
Earlier versions of this repository wrote a bare `⊤` in `SmoothPeriodicData`,
`NSOn`, `reversedHolderClaim` and `spikeObstruction`. That `⊤` elaborates to `ω`,
so those statements were analytic-regularity statements, not Fefferman's C^∞
statement. They now use `∞`. This file kernel-checks that the definitions use
`∞`, and that `∞` is a genuinely weaker requirement than `ω`.
-/

import Clay.StatementB
import Clay.Gaps.MissingInputs
import Clay.Gaps.RejectedMeasureBound

noncomputable section

namespace Clay.Notes.SmoothnessIndex

open Filter Set Clay.StatementB
open scoped ContDiff Topology

/-- The two indices are different. -/
theorem infty_ne_omega : (∞ : WithTop ℕ∞) ≠ ω := WithTop.coe_ne_top

/-- `SmoothPeriodicData` asks for C^∞ data (definitional check). -/
theorem smoothPeriodicData_iff (u0 : E3 → E3) :
    SmoothPeriodicData u0 ↔ ContDiff ℝ ∞ u0 ∧ DivFree u0 ∧ IsPeriodic u0 := Iff.rfl

/-- `NSOn` asks for C^∞ velocity and pressure (definitional check). -/
theorem NSOn_smooth {ν : ℝ} {S : Set ℝ} {u0 : E3 → E3} {u : ℝ → E3 → E3}
    {p : ℝ → E3 → ℝ} (h : NSOn ν S u0 u p) :
    ContDiffOn ℝ ∞ (fun z : ℝ × E3 => u z.1 z.2) (S ×ˢ univ) ∧
      ContDiffOn ℝ ∞ (fun z : ℝ × E3 => p z.1 z.2) (S ×ˢ univ) :=
  ⟨h.1, h.2.1⟩

/-- Analytic data is still admissible: the old (analytic) data class is
contained in the corrected (C^∞) one. -/
theorem smoothPeriodicData_of_analytic {u0 : E3 → E3} (h : ContDiff ℝ ω u0)
    (hdiv : DivFree u0) (hper : IsPeriodic u0) : SmoothPeriodicData u0 :=
  ⟨h.of_le le_top, hdiv, hper⟩

/-- The standard C^∞ glue function `x ↦ exp (-1/x)` (for `x > 0`, else `0`). -/
theorem expNegInvGlue_contDiff_infty : ContDiff ℝ ∞ expNegInvGlue := expNegInvGlue.contDiff

/-- It is not analytic at `0`: it vanishes on `(-∞, 0]` but is positive on
`(0, ∞)`, which contradicts the isolated-zeros principle. -/
theorem expNegInvGlue_not_analyticAt_zero : ¬ AnalyticAt ℝ expNegInvGlue 0 := by
  intro h
  rcases h.eventually_eq_zero_or_eventually_ne_zero with h0 | hne
  · obtain ⟨ε, hε, hball⟩ := Metric.eventually_nhds_iff.mp h0
    have hx : dist (ε / 2) 0 < ε := by
      rw [Real.dist_eq, sub_zero, abs_of_pos (half_pos hε)]; exact half_lt_self hε
    exact (expNegInvGlue.pos_of_pos (half_pos hε)).ne' (hball hx)
  · have hfreq : ∃ᶠ x in 𝓝[≠] (0:ℝ), expNegInvGlue x = 0 := by
      have : ∀ᶠ x in 𝓝[<] (0:ℝ), expNegInvGlue x = 0 :=
        eventually_nhdsWithin_of_forall fun x hx => expNegInvGlue.zero_of_nonpos (le_of_lt hx)
      exact (this.frequently).filter_mono (nhdsWithin_mono _ fun x hx => ne_of_lt hx)
    exact hfreq (hne.mono fun x hx h' => hx h')

/-- So C^∞ does not imply C^ω on `ℝ`: the bare `⊤` (= `ω`) was a strictly
stronger regularity requirement than Fefferman's "smooth". -/
theorem not_contDiff_omega_expNegInvGlue : ¬ ContDiff ℝ ω expNegInvGlue := fun h =>
  expNegInvGlue_not_analyticAt_zero h.contDiffAt.analyticAt

theorem exists_contDiff_infty_not_omega :
    ∃ f : ℝ → ℝ, ContDiff ℝ ∞ f ∧ ¬ ContDiff ℝ ω f :=
  ⟨expNegInvGlue, expNegInvGlue_contDiff_infty, not_contDiff_omega_expNegInvGlue⟩

end Clay.Notes.SmoothnessIndex
