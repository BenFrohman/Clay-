/- Copyright (c) 2026 Benjamin Stanley Frohman. Apache-2.0. -/
import Clay

open Clay.StatementB Clay.Depletion.SolutionLinkedVortexLines
open scoped ENNReal NNReal

-- The old free-packet diagnostic remains available unchanged.
#check Clay.Gaps.DirectionAlignment.abstract_dhy_criterion_iff_periodicBKMIntegrability

-- An all-zero length profile cannot certify ANY nonzero-vorticity field.
example {u : ℝ → E3 → E3} {T : ℝ≥0∞} (P : Packet u T)
    (hL : ∀ t, P.length t = 0) {t : ℝ} (ht : t ∈ lifespanSet T) (x : E3) :
    curl (u t) x = 0 :=
  curl_eq_zero_of_length_eq_zero P ht (hL t) x

-- Yet the actual zero NS solution and its packet are admitted.
example (T : ℝ≥0∞) : Packet (fun _ _ => 0) T := zeroPacket T
example (ν : ℝ) (T : ℝ≥0∞) :
    NSOn ν (lifespanSet T) (fun _ => 0) (fun _ _ => 0) (fun _ _ => 0) :=
  zero_NSOn ν (lifespanSet T)
example (T : ℝ≥0∞) : BKMIntegralFinite (fun _ _ => (0 : E3)) T :=
  zeroPacket_BKMIntegralFinite T

#print axioms bkmIntegralFinite_of_spatialComparison_and_endpoint
#print axioms zeroPacket_BKMIntegralFinite
-- A Prop declaration only: no proof of this bridge has been supplied.
#check SpatialBridgeObligation
