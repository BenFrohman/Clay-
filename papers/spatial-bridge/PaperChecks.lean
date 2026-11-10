/-
Copyright (c) 2026 Benjamin Stanley Frohman. Apache-2.0.
Authors: Frohman, Benjamin Stanley

Kernel checks for the claims made in
`papers/spatial-bridge/spatial_bridge.tex`. Run from `lean/`:

    lake env lean ../papers/spatial-bridge/PaperChecks.lean

This file adds no declaration to the `Clay` library and is not part of the
library axiom audit; it only re-checks statements the paper relies on and
prints their axioms. Every `example`/`theorem` below must elaborate without
`sorry`.
-/
import Clay

noncomputable section
namespace Clay.PaperChecks.SpatialBridge
open Clay.StatementB Clay.Depletion.SolutionLinkedVortexLines MeasureTheory Set
open scoped ENNReal NNReal ContDiff

/-! ## 1. Regularity class actually required by `NSOn` (paper, Section 2.3)

At the pinned Mathlib, the smoothness index of `ContDiffOn` has type
`WithTop ℕ∞`; `ω = (⊤ : WithTop ℕ∞)` is real-analytic and
`∞ = ((⊤ : ℕ∞) : WithTop ℕ∞)` is C^∞. Versions of the library before the
2026-11-09 correction wrote a bare `⊤` (that is, `ω`) in `NSOn` and
`SmoothPeriodicData`. They now use `∞`, as Fefferman's statement requires.
The checks below confirm the corrected index and that it is strictly weaker
than `ω`. -/

example : (∞ : WithTop ℕ∞) ≠ ω := WithTop.coe_ne_top

/-- `NSOn` requires joint C^∞ regularity of velocity and pressure. -/
theorem NSOn_velocity_contDiffOn_infty {ν : ℝ} {S : Set ℝ} {u0 : E3 → E3}
    {u : ℝ → E3 → E3} {p : ℝ → E3 → ℝ} (h : NSOn ν S u0 u p) :
    ContDiffOn ℝ ∞ (fun z : ℝ × E3 => u z.1 z.2) (S ×ˢ univ) :=
  h.1

/-- `SmoothPeriodicData` requires C^∞ (not analytic) initial data. -/
theorem smoothPeriodicData_contDiff_infty {u0 : E3 → E3} (h : SmoothPeriodicData u0) :
    ContDiff ℝ ∞ u0 :=
  h.1

/-- C^∞ is strictly weaker than C^ω on `ℝ` (library witness). -/
theorem contDiff_infty_ne_omega : ∃ f : ℝ → ℝ, ContDiff ℝ ∞ f ∧ ¬ ContDiff ℝ ω f :=
  Clay.Notes.SmoothnessIndex.exists_contDiff_infty_not_omega

/-! ## 2. The bridge needs only spatial C²  (paper, Corollary 4.4)

Composition of two library theorems: the comparison holds for every packet
over any velocity field whose time slices are C² on the lifespan. Neither the
momentum equation, nor viscosity, nor incompressibility of `u` is used. -/

theorem spatialComparison_of_spatialC2 {u : ℝ → E3 → E3} {T : ℝ≥0∞} (P : Packet u T)
    (hC2 : ∀ t ∈ lifespanSet T, ∀ a : Fin 3, ContDiff ℝ 2 (fun y => u t y a)) :
    SpatialComparison P :=
  spatialComparison_of_logDerivativeAlong P (logDerivativeAlong_of_spatialC2 P hC2)

/-! ## 3. The endpoint hypothesis is exactly as strong as BKM (paper, Prop. 5.1)

Endpoint vorticity never exceeds the supremum, so BKM finiteness implies the
endpoint hypothesis for every packet; with the library theorem, under `NSOn`
the two are equivalent. The criterion relocates, and does not remove, the
analytic difficulty. -/

theorem endpointIntegralFinite_of_bkm {u : ℝ → E3 → E3} {T : ℝ≥0∞} (P : Packet u T)
    (h : BKMIntegralFinite u T) : EndpointIntegralFinite P := by
  unfold EndpointIntegralFinite
  unfold BKMIntegralFinite at h
  refine lt_of_le_of_lt (lintegral_mono fun t => ?_) h
  unfold endpointMagnitude
  split_ifs with ht
  · exact le_iSup (fun x => (‖curl (u t) x‖₊ : ℝ≥0∞)) (P.endpoint t)
  · exact zero_le _

theorem endpointIntegralFinite_iff_bkm
    {ν : ℝ} {u0 : E3 → E3} {u : ℝ → E3 → E3} {p : ℝ → E3 → ℝ} {T : ℝ≥0∞}
    (hsol : NSOn ν (lifespanSet T) u0 u p) (P : Packet u T) :
    EndpointIntegralFinite P ↔ BKMIntegralFinite u T :=
  ⟨bkmIntegralFinite_of_NSOn_and_endpoint hsol P, endpointIntegralFinite_of_bkm P⟩

end Clay.PaperChecks.SpatialBridge

/-! ## 4. Statements and axioms of the cited library declarations -/
open Clay.StatementB Clay.Depletion.SolutionLinkedVortexLines

#check @pd_pd_comm
#check @div_curl_eq_zero
#check @curl_differentiable_of_C2
#check @spatialC2_of_NSOn
#check @norm_direction_derivative
#check @logDerivativeAlong_of_spatialC2
#check @spatialComparison_of_logDerivativeAlong
#check @spatialComparison_of_NSOn
#check @spatialBridgeObligation_proved
#check @bkmIntegralFinite_of_NSOn_and_endpoint
#check @bkmIntegralFinite_of_spatialComparison_and_endpoint

#print axioms pd_pd_comm
#print axioms div_curl_eq_zero
#print axioms curl_differentiable_of_C2
#print axioms spatialC2_of_NSOn
#print axioms norm_direction_derivative
#print axioms logDerivativeAlong_of_spatialC2
#print axioms spatialComparison_of_logDerivativeAlong
#print axioms spatialComparison_of_NSOn
#print axioms spatialBridgeObligation_proved
#print axioms bkmIntegralFinite_of_NSOn_and_endpoint
#print axioms bkmIntegralFinite_of_spatialComparison_and_endpoint
#print axioms Clay.PaperChecks.SpatialBridge.NSOn_velocity_contDiffOn_infty
#print axioms Clay.PaperChecks.SpatialBridge.smoothPeriodicData_contDiff_infty
#print axioms Clay.PaperChecks.SpatialBridge.contDiff_infty_ne_omega
#print axioms Clay.PaperChecks.SpatialBridge.spatialComparison_of_spatialC2
#print axioms Clay.PaperChecks.SpatialBridge.endpointIntegralFinite_of_bkm
#print axioms Clay.PaperChecks.SpatialBridge.endpointIntegralFinite_iff_bkm
