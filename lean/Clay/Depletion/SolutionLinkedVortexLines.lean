/-
Copyright (c) 2026 Benjamin Stanley Frohman. Apache-2.0.
Authors: Frohman, Benjamin Stanley
-/
import Clay.StatementB

/-!
# Solution-linked, nondegenerate vortex-line data

This implements geometric data tied to the actual `curl (u t)`, unlike the
legacy free `DHYPacket`. It specializes the spatial setting of Theorem 1 in
Deng--Hou--Yu, arXiv:math-ph/0402032, to nondegenerate segments at nonzero
near-maximal vorticity. The endpoint-integrability hypothesis is separate.
The geometric-to-spatial-comparison bridge is proved in `ActualSpatialBridge`.
The paper's moving-segment Theorem 2 is Euler-only and is NOT imported here.
-/

noncomputable section
namespace Clay.Depletion.SolutionLinkedVortexLines
open Clay.StatementB MeasureTheory Set
open scoped ENNReal NNReal

/-- Actual normalized vorticity, with value zero at a zero of vorticity. -/
def direction (v : E3 → E3) (x : E3) : E3 :=
  (‖curl v x‖)⁻¹ • curl v x

/-- On the active line the supplied tangent is genuinely of unit length. -/
theorem norm_direction_of_nonzero (v : E3 → E3) (x : E3) (h : curl v x ≠ 0) :
    ‖direction v x‖ = 1 := by
  rw [direction, norm_smul, Real.norm_of_nonneg (inv_nonneg.mpr (norm_nonneg _))]
  exact inv_mul_cancel₀ (norm_ne_zero_iff.mpr h)

/-- Actual spatial divergence of normalized vorticity. -/
def directionDivergence (v : E3 → E3) (x : E3) : ℝ :=
  ∑ i, pd (fun y => direction v y i) i x

/-- The observed endpoint magnitude, extended by zero outside the lifespan.
There is no arbitrary magnitude field to fill independently of the solution. -/
def endpointMagnitude (u : ℝ → E3 → E3) (T : ℝ≥0∞) (endpoint : ℝ → E3)
    (t : ℝ) : ℝ≥0∞ := by
  classical
  exact if t ∈ lifespanSet T then (‖curl (u t) (endpoint t)‖₊ : ℝ≥0∞) else 0

/-- Actual integrated direction divergence along the parameterized line.
On active packets the parameter is arc length by the tangent equation. -/
def lineControl (u : ℝ → E3 → E3) (T : ℝ≥0∞)
    (curve : ℝ → ℝ → E3) (length : ℝ → ℝ) (t : ℝ) : ℝ := by
  classical
  exact if t ∈ lifespanSet T then
    |∫ s in (0 : ℝ)..length t, directionDivergence (u t) (curve t s)| else 0

/-- Actual solution-linked geometry; no BKM or endpoint-integrability premise
is hidden in these fields. At zero vorticity the nondegenerate-line requirements
are inactive, so the zero solution is allowed. `peakFactor` is the reciprocal
of the positive near-maximum fraction in DHY Theorem 1. -/
structure Packet (u : ℝ → E3 → E3) (T : ℝ≥0∞) where
  peak : ℝ → E3
  endpoint : ℝ → E3
  curve : ℝ → ℝ → E3
  length : ℝ → ℝ
  peakFactor : ℝ≥0
  peakFactor_ge_one : 1 ≤ peakFactor
  distortionBound : ℝ≥0
  length_nonneg : ∀ t ∈ lifespanSet T, 0 ≤ length t
  curve_start : ∀ t ∈ lifespanSet T, curve t 0 = peak t
  curve_end : ∀ t ∈ lifespanSet T, curve t (length t) = endpoint t
  near_maximum : ∀ t ∈ lifespanSet T,
    vortSup u t ≤ (peakFactor : ℝ≥0∞) * (‖curl (u t) (peak t)‖₊ : ℝ≥0∞)
  active_length : ∀ t ∈ lifespanSet T, curl (u t) (peak t) ≠ 0 → 0 < length t
  line_nonzero : ∀ t ∈ lifespanSet T, curl (u t) (peak t) ≠ 0 →
    ∀ s ∈ Icc 0 (length t), curl (u t) (curve t s) ≠ 0
  line_tangent : ∀ t ∈ lifespanSet T, curl (u t) (peak t) ≠ 0 →
    ∀ s ∈ Icc 0 (length t),
      HasDerivWithinAt (curve t) (direction (u t) (curve t s)) (Icc 0 (length t)) s
  line_integrable : ∀ t ∈ lifespanSet T, curl (u t) (peak t) ≠ 0 →
    IntervalIntegrable (fun s => directionDivergence (u t) (curve t s)) volume 0 (length t)
  control_bound : ∀ t ∈ lifespanSet T,
    lineControl u T curve length t ≤ distortionBound
  peak_measurable : Measurable peak
  endpoint_measurable : Measurable endpoint
  length_measurable : Measurable length
  endpointMagnitude_measurable : Measurable (endpointMagnitude u T endpoint)
  control_measurable : Measurable (lineControl u T curve length)

/-- A separate analytical hypothesis: endpoint vorticity is integrable in time.
This is not part of the geometry packet and is not established for arbitrary data. -/
def EndpointIntegralFinite {u : ℝ → E3 → E3} {T : ℝ≥0∞} (P : Packet u T) : Prop :=
  ∫⁻ t in lifespanSet T, endpointMagnitude u T P.endpoint t < ⊤

/-- The spatial conclusion of the divergence-along-a-vortex-line argument.
It contains no temporal integral or regularity conclusion. -/
def SpatialComparison {u : ℝ → E3 → E3} {T : ℝ≥0∞} (P : Packet u T) : Prop :=
  ∀ t ∈ lifespanSet T,
    (‖curl (u t) (P.peak t)‖₊ : ℝ≥0∞) ≤
      ENNReal.ofReal (Real.exp P.distortionBound) * endpointMagnitude u T P.endpoint t

/-- Named spatial bridge target, proved without additional hypotheses by
`spatialBridgeObligation_proved` in `ActualSpatialBridge`. This declaration is
a proposition, not an axiom. It is the spatial Lemma 1 / equation (3.2) component
of DHY Theorem 1, NOT Euler Theorem 2. -/
def SpatialBridgeObligation : Prop :=
  ForAllFiniteSolutions fun u _ T => ∀ P : Packet u T, SpatialComparison P

/-- Nonvacuity regression: zero-length data cannot track nonzero vorticity. -/
theorem vortSup_eq_zero_of_length_eq_zero {u : ℝ → E3 → E3} {T : ℝ≥0∞}
    (P : Packet u T) {t : ℝ} (ht : t ∈ lifespanSet T) (hL : P.length t = 0) :
    vortSup u t = 0 := by
  have hz : curl (u t) (P.peak t) = 0 := by
    by_contra h
    have hp := P.active_length t ht h
    rw [hL] at hp
    exact (lt_irrefl 0) hp
  apply le_antisymm _ (zero_le _)
  simpa [hz] using P.near_maximum t ht

/-- The preceding regression applies to every spatial point of the actual field. -/
theorem curl_eq_zero_of_length_eq_zero {u : ℝ → E3 → E3} {T : ℝ≥0∞}
    (P : Packet u T) {t : ℝ} (ht : t ∈ lifespanSet T) (hL : P.length t = 0) (x : E3) :
    curl (u t) x = 0 := by
  have h := le_iSup (fun y => (‖curl (u t) y‖₊ : ℝ≥0∞)) x
  change (‖curl (u t) x‖₊ : ℝ≥0∞) ≤ vortSup u t at h
  rw [vortSup_eq_zero_of_length_eq_zero P ht hL] at h
  have hn : (‖curl (u t) x‖₊ : ℝ≥0∞) = 0 := le_antisymm h (zero_le _)
  simpa using hn

/-- Both endpoints really lie on the same nonzero-vorticity segment when active. -/
theorem endpoint_nonzero_of_peak_nonzero {u : ℝ → E3 → E3} {T : ℝ≥0∞}
    (P : Packet u T) {t : ℝ} (ht : t ∈ lifespanSet T)
    (hp : curl (u t) (P.peak t) ≠ 0) : curl (u t) (P.endpoint t) ≠ 0 := by
  have h := P.line_nonzero t ht hp (P.length t) ⟨P.length_nonneg t ht, le_refl _⟩
  simpa only [P.curve_end t ht] using h

/-- Available conditional analytical consequence. The spatial bridge and the
endpoint integral are explicit arguments, not inferred from existence of a packet. -/
theorem bkmIntegralFinite_of_spatialComparison_and_endpoint
    {u : ℝ → E3 → E3} {T : ℝ≥0∞} (P : Packet u T)
    (hspatial : SpatialComparison P) (hend : EndpointIntegralFinite P) :
    BKMIntegralFinite u T := by
  let K : ℝ≥0∞ := (P.peakFactor : ℝ≥0∞) * ENNReal.ofReal (Real.exp P.distortionBound)
  have hK : K ≠ ⊤ := by dsimp [K]; finiteness
  have hbound : ∀ t ∈ lifespanSet T,
      vortSup u t ≤ K * endpointMagnitude u T P.endpoint t := by
    intro t ht
    calc vortSup u t
        ≤ (P.peakFactor : ℝ≥0∞) * (‖curl (u t) (P.peak t)‖₊ : ℝ≥0∞) := P.near_maximum t ht
      _ ≤ (P.peakFactor : ℝ≥0∞) *
          (ENNReal.ofReal (Real.exp P.distortionBound) * endpointMagnitude u T P.endpoint t) :=
        mul_le_mul_left' (hspatial t ht) _
      _ = K * endpointMagnitude u T P.endpoint t := by simp [K, mul_assoc]
  unfold BKMIntegralFinite
  calc ∫⁻ t in lifespanSet T, vortSup u t
      ≤ ∫⁻ t in lifespanSet T, K * endpointMagnitude u T P.endpoint t :=
        setLIntegral_mono (measurable_const.mul P.endpointMagnitude_measurable) hbound
    _ = K * ∫⁻ t in lifespanSet T, endpointMagnitude u T P.endpoint t :=
        lintegral_const_mul K P.endpointMagnitude_measurable
    _ < ⊤ := ENNReal.mul_lt_top hK.lt_top hend

@[simp] theorem curl_zero (x : E3) : curl (fun _ : E3 => (0 : E3)) x = 0 := by
  ext i
  fin_cases i <;> simp [curl, pd]

/-- The zero field admits actual solution-linked data; the nonvacuity test does
not impose a positive vorticity assumption or exclude the zero solution. -/
def zeroPacket (T : ℝ≥0∞) : Packet (fun _ _ => 0) T where
  peak := fun _ => 0
  endpoint := fun _ => 0
  curve := fun _ _ => 0
  length := fun _ => 0
  peakFactor := 1
  peakFactor_ge_one := le_refl 1
  distortionBound := 0
  length_nonneg := by intros; exact le_refl 0
  curve_start := by intros; rfl
  curve_end := by intros; rfl
  near_maximum := by intros; simp [vortSup]
  active_length := by intros t ht hn; exact (hn (curl_zero 0)).elim
  line_nonzero := by intros t ht hn; exact (hn (curl_zero 0)).elim
  line_tangent := by intros t ht hn; exact (hn (curl_zero 0)).elim
  line_integrable := by intros t ht hn; exact (hn (curl_zero 0)).elim
  control_bound := by intros; simp [lineControl]
  peak_measurable := measurable_const
  endpoint_measurable := measurable_const
  length_measurable := measurable_const
  endpointMagnitude_measurable := by
    have h : endpointMagnitude (fun _ _ => 0) T (fun _ => 0) = fun _ => 0 := by
      funext t; simp [endpointMagnitude]
    rw [h]; exact measurable_const
  control_measurable := by
    have h : lineControl (fun _ _ => 0) T (fun _ _ => 0) (fun _ => 0) = fun _ => 0 := by
      funext t; simp [lineControl]
    rw [h]; exact measurable_const

/-- Explicit nonzero-field regression: every linked packet must have positive
line length whenever the actual field has nonzero vorticity anywhere. -/
theorem length_pos_of_nonzero_vorticity {u : ℝ → E3 → E3} {T : ℝ≥0∞}
    (P : Packet u T) {t : ℝ} (ht : t ∈ lifespanSet T) {x : E3}
    (hx : curl (u t) x ≠ 0) : 0 < P.length t := by
  by_contra h
  have hz : P.length t = 0 := le_antisymm (le_of_not_gt h) (P.length_nonneg t ht)
  exact hx (curl_eq_zero_of_length_eq_zero P ht hz x)

/-- The admitted zero field is an actual unforced periodic NS solution in the
repository's solution representation, for every viscosity and time set. -/
theorem zero_NSOn (ν : ℝ) (S : Set ℝ) :
    NSOn ν S (fun _ => 0) (fun _ _ => 0) (fun _ _ => 0) := by
  have hpd : ∀ j : Fin 3, pd (fun _ : E3 => (0 : ℝ)) j = fun _ => 0 := by
    intro j; funext x; simp [pd]
  refine ⟨contDiffOn_const, contDiffOn_const, ?_, ?_, ?_, ?_⟩
  · intros; simp [lap, hpd, pd]
  · intros; simp [DivFree, pd]
  · intros; rfl
  · intros; simp [IsPeriodic]

/-- The zero solution satisfies the spatial comparison, not just the packet type. -/
theorem zeroPacket_spatialComparison (T : ℝ≥0∞) : SpatialComparison (zeroPacket T) := by
  intro t ht
  simp [curl_zero]

/-- The separate endpoint-integrability hypothesis holds for the zero solution. -/
theorem zeroPacket_endpointIntegralFinite (T : ℝ≥0∞) :
    EndpointIntegralFinite (zeroPacket T) := by
  unfold EndpointIntegralFinite
  have hz : endpointMagnitude (fun _ _ => 0) T (zeroPacket T).endpoint = fun _ => 0 := by
    funext t; simp [endpointMagnitude]
  rw [hz]
  simp

/-- A complete zero-solution regression for the proved conditional route. -/
theorem zeroPacket_BKMIntegralFinite (T : ℝ≥0∞) :
    BKMIntegralFinite (fun _ _ => (0 : E3)) T :=
  bkmIntegralFinite_of_spatialComparison_and_endpoint (zeroPacket T)
    (zeroPacket_spatialComparison T) (zeroPacket_endpointIntegralFinite T)

end Clay.Depletion.SolutionLinkedVortexLines
