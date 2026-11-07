/- Copyright (c) 2026 Benjamin Stanley Frohman. Apache-2.0.
Authors: Frohman, Benjamin Stanley -/
import Clay.Depletion.SolutionLinkedVortexLines

noncomputable section
namespace Clay.Depletion.SolutionLinkedVortexLines
open Clay.StatementB MeasureTheory Set
open scoped ENNReal NNReal

/-- Equality of actual mixed spatial partial derivatives under C2 regularity. -/
theorem pd_pd_comm (f : E3 → ℝ) (hf : ContDiff ℝ 2 f)
    (i j : Fin 3) (x : E3) : pd (pd f j) i x = pd (pd f i) j x := by
  have hd : DifferentiableAt ℝ (fderiv ℝ f) x :=
    (hf.contDiffAt.fderiv_right (m := 1) (by norm_num)).differentiableAt (by norm_num)
  have he (a : Fin 3) : fderiv ℝ (fun y => fderiv ℝ f y (e a)) x =
      (fderiv ℝ (fderiv ℝ f) x).flip (e a) := by
    simpa using fderiv_clm_apply hd (differentiableAt_const (e a))
  unfold pd
  rw [he j, he i]
  exact hf.contDiffAt.isSymmSndFDerivAt (by norm_num) (e i) (e j)

/-- Actual divergence of curl vanishes under componentwise C2 smoothness.
No incompressibility or evolution equation is assumed. -/
theorem div_curl_eq_zero (v : E3 → E3)
    (hv : ∀ a : Fin 3, ContDiff ℝ 2 (fun y => v y a)) : DivFree (curl v) := by
  intro x
  have hd (a j : Fin 3) : DifferentiableAt ℝ (pd (fun y => v y a) j) x := by
    exact ((hv a).contDiffAt.fderiv_right (m := 1) (by norm_num)).differentiableAt
      (by norm_num) |>.clm_apply (differentiableAt_const (e j))
  have subpd (f g : E3 → ℝ) (hf : DifferentiableAt ℝ f x)
      (hg : DifferentiableAt ℝ g x) (j : Fin 3) :
      pd (fun y => f y - g y) j x = pd f j x - pd g j x := by
    simp only [pd, fderiv_sub hf hg, ContinuousLinearMap.sub_apply]
  simp only [Fin.sum_univ_three]
  change pd (fun y => pd (fun z => v z 2) 1 y - pd (fun z => v z 1) 2 y) 0 x +
    pd (fun y => pd (fun z => v z 0) 2 y - pd (fun z => v z 2) 0 y) 1 x +
    pd (fun y => pd (fun z => v z 1) 0 y - pd (fun z => v z 0) 1 y) 2 x = 0
  rw [subpd _ _ (hd 2 1) (hd 1 2), subpd _ _ (hd 0 2) (hd 2 0),
    subpd _ _ (hd 1 0) (hd 0 1)]
  rw [pd_pd_comm _ (hv 2) 0 1 x, pd_pd_comm _ (hv 1) 0 2 x,
    pd_pd_comm _ (hv 0) 1 2 x]
  ring

/-- C2 velocity components give a differentiable actual vorticity field. -/
theorem curl_differentiable_of_C2 (v : E3 → E3)
    (hv : ∀ a : Fin 3, ContDiff ℝ 2 (fun y => v y a)) : Differentiable ℝ (curl v) := by
  intro x
  have hd (a j : Fin 3) : DifferentiableAt ℝ (pd (fun y => v y a) j) x := by
    exact ((hv a).contDiffAt.fderiv_right (m := 1) (by norm_num)).differentiableAt
      (by norm_num) |>.clm_apply (differentiableAt_const (e j))
  apply (differentiableAt_piLp 2).mpr
  intro a
  fin_cases a
  · exact (hd 2 1).sub (hd 1 2)
  · exact (hd 0 2).sub (hd 2 0)
  · exact (hd 1 0).sub (hd 0 1)

/-- NSOn already supplies the required spatial C2 regularity: restrict its
joint smoothness to the time slice. No regularity supplement is assumed. -/
theorem spatialC2_of_NSOn {ν : ℝ} {S : Set ℝ} {u0 : E3 → E3}
    {u : ℝ → E3 → E3} {p : ℝ → E3 → ℝ} (hsol : NSOn ν S u0 u p)
    {t : ℝ} (ht : t ∈ S) : ∀ a : Fin 3, ContDiff ℝ 2 (fun y => u t y a) := by
  have hs : ContDiff ℝ ⊤ (u t) := by
    have hemb : ContDiff ℝ ⊤ (fun x : E3 => (t, x)) := contDiff_const.prod contDiff_id
    have h := hsol.1.comp hemb.contDiffOn (s := univ)
      (fun x _ => show (t,x) ∈ S ×ˢ (univ : Set E3) from ⟨ht, mem_univ x⟩)
    simpa only [Function.comp_def, contDiffOn_univ] using h
  intro a
  exact ((contDiff_piLp 2).mp hs a).of_le (by simp)

/-- Product-rule identity for the actual norm and actual normalized curl. -/
theorem norm_direction_derivative (v : E3 → E3) (x : E3)
    (hw : DifferentiableAt ℝ (curl v) x) (h0 : curl v x ≠ 0)
    (hdiv : ∑ i, pd (fun y => curl v y i) i x = 0) :
    fderiv ℝ (fun y => ‖curl v y‖) x (direction v x) =
      -‖curl v x‖ * directionDivergence v x := by
  have hn := hw.norm ℝ h0
  have hxi : DifferentiableAt ℝ (direction v) x :=
    (hn.inv (norm_ne_zero_iff.mpr h0)).smul hw
  have hcoord (i : Fin 3) : DifferentiableAt ℝ (fun y => direction v y i) x :=
    (differentiableAt_piLp 2).mp hxi i
  have hfactor (i : Fin 3) : (fun y => curl v y i) =
      (fun y => ‖curl v y‖ * direction v y i) := by
    funext y
    by_cases hy : curl v y = 0
    · simp [hy, direction]
    · simp [direction, mul_assoc, norm_ne_zero_iff.mpr hy]
  have hprod (i : Fin 3) : pd (fun y => curl v y i) i x =
      ‖curl v x‖ * pd (fun y => direction v y i) i x +
        direction v x i * pd (fun y => ‖curl v y‖) i x := by
    rw [hfactor i]
    simp only [pd, fderiv_mul hn (hcoord i), ContinuousLinearMap.add_apply,
      ContinuousLinearMap.smul_apply, smul_eq_mul]
  have hexpand (z : E3) : z = z 0 • e 0 + z 1 • e 1 + z 2 • e 2 := by
    ext j; fin_cases j <;> simp [e]
  have hsum : ∑ i, direction v x i * pd (fun y => ‖curl v y‖) i x =
      fderiv ℝ (fun y => ‖curl v y‖) x (direction v x) := by
    conv_rhs => rw [hexpand (direction v x)]
    simp only [Fin.sum_univ_three, pd, map_add, _root_.map_smul, smul_eq_mul]
  simp_rw [hprod] at hdiv
  rw [Finset.sum_add_distrib, ← Finset.mul_sum, hsum] at hdiv
  change ‖curl v x‖ * directionDivergence v x + _ = 0 at hdiv
  linarith

/-- The actual log-vorticity differential equation is a local calculus premise,
not an endpoint comparison or a temporal integrability assumption. -/
def LogDerivativeAlong {u : ℝ → E3 → E3} {T : ℝ≥0∞} (P : Packet u T) : Prop :=
  ∀ t ∈ lifespanSet T, curl (u t) (P.peak t) ≠ 0 →
    ∀ s ∈ Icc 0 (P.length t),
      HasDerivWithinAt (fun r => Real.log ‖curl (u t) (P.curve t r)‖)
        (-directionDivergence (u t) (P.curve t s)) (Icc 0 (P.length t)) s

/-- Actual log-vorticity chain rule derived from actual C2 velocity,
div(curl)=0, nonvanishing and the supplied unit tangent. -/
theorem logDerivativeAlong_of_spatialC2
    {u : ℝ → E3 → E3} {T : ℝ≥0∞} (P : Packet u T)
    (hC2 : ∀ t ∈ lifespanSet T, ∀ a : Fin 3, ContDiff ℝ 2 (fun y => u t y a)) :
    LogDerivativeAlong P := by
  intro t ht hp s hs
  have hz := P.line_nonzero t ht hp s hs
  have hw := curl_differentiable_of_C2 (u t) (hC2 t ht) (P.curve t s)
  have hn := hw.norm ℝ hz
  have hc := hn.hasFDerivAt.comp_hasDerivWithinAt s (P.line_tangent t ht hp s hs)
  have hl := hc.log (norm_ne_zero_iff.mpr hz)
  have hd := norm_direction_derivative (u t) (P.curve t s) hw hz
    (div_curl_eq_zero (u t) (hC2 t ht) (P.curve t s))
  convert hl using 1
  rw [hd]
  field_simp [norm_ne_zero_iff.mpr hz]
  <;> ring

/-- FTC and exponentiation establish spatial comparison from the actual local
log-vorticity differential equation, derived above from smoothness, div(curl)=0
and the packet tangent equation. -/
theorem spatialComparison_of_logDerivativeAlong
    {u : ℝ → E3 → E3} {T : ℝ≥0∞} (P : Packet u T)
    (hlog : LogDerivativeAlong P) : SpatialComparison P := by
  intro t ht
  by_cases hp : curl (u t) (P.peak t) = 0
  · simp only [hp, nnnorm_zero, ENNReal.coe_zero, zero_le]
  have hp' : curl (u t) (P.peak t) ≠ 0 := hp
  have he := endpoint_nonzero_of_peak_nonzero P ht hp'
  have hL := P.active_length t ht hp'
  have hd := hlog t ht hp'
  have hc : ContinuousOn (fun r => Real.log ‖curl (u t) (P.curve t r)‖)
      (Icc 0 (P.length t)) := fun s hs => (hd s hs).continuousWithinAt
  have hi := intervalIntegral.integral_eq_sub_of_hasDerivAt_of_le hL.le hc
    (fun s hs => (hd s ⟨hs.1.le, hs.2.le⟩).hasDerivAt (Icc_mem_nhds hs.1 hs.2))
    (P.line_integrable t ht hp').neg
  simp only [intervalIntegral.integral_neg, P.curve_start t ht, P.curve_end t ht] at hi
  have hb := P.control_bound t ht
  simp only [lineControl, if_pos ht] at hb
  have hle : Real.log ‖curl (u t) (P.peak t)‖ ≤
      (P.distortionBound : ℝ) + Real.log ‖curl (u t) (P.endpoint t)‖ := by
    have habs := le_abs_self (∫ s in (0 : ℝ)..P.length t,
      directionDivergence (u t) (P.curve t s))
    linarith
  have hr := Real.exp_le_exp.mpr hle
  rw [Real.exp_log (norm_pos_iff.mpr hp'), Real.exp_add,
    Real.exp_log (norm_pos_iff.mpr he)] at hr
  have hext := ENNReal.ofReal_le_ofReal hr
  simpa [endpointMagnitude, ht, ENNReal.ofReal_mul (Real.exp_nonneg _)] using hext

/-- The previously unproved spatial bridge follows from the existing NSOn
representation, with no new smoothness, comparison, or integrability premise. -/
theorem spatialComparison_of_NSOn
    {ν : ℝ} {u0 : E3 → E3} {u : ℝ → E3 → E3} {p : ℝ → E3 → ℝ} {T : ℝ≥0∞}
    (hsol : NSOn ν (lifespanSet T) u0 u p) (P : Packet u T) : SpatialComparison P :=
  spatialComparison_of_logDerivativeAlong P
    (logDerivativeAlong_of_spatialC2 P (fun _ ht => spatialC2_of_NSOn hsol ht))

/-- Inhabitant of the exact original named obligation, not a replacement Prop. -/
theorem spatialBridgeObligation_proved : SpatialBridgeObligation := by
  intro ν hν u0 u p T hu0 hT hsol P
  exact spatialComparison_of_NSOn hsol P

/-- The actual geometric NS criterion now needs no assumed SpatialComparison.
The actual endpoint time integral remains a separate analytical hypothesis. -/
theorem bkmIntegralFinite_of_NSOn_and_endpoint
    {ν : ℝ} {u0 : E3 → E3} {u : ℝ → E3 → E3} {p : ℝ → E3 → ℝ} {T : ℝ≥0∞}
    (hsol : NSOn ν (lifespanSet T) u0 u p) (P : Packet u T)
    (hend : EndpointIntegralFinite P) : BKMIntegralFinite u T :=
  bkmIntegralFinite_of_spatialComparison_and_endpoint P (spatialComparison_of_NSOn hsol P) hend

end Clay.Depletion.SolutionLinkedVortexLines
