# Axiom report: Clay-

Generated after freshly checking the complete Clay source library and the
solution-linked regression file with pinned Lean/Mathlib v4.16.0, then running
`AxiomReport.lean` against the freshly compiled library modules. CI runs
`lake build`, this full-library audit, and `SolutionLinkedRegression.lean`.

This checks dependencies of the Lean statements, not that geometric/PDE
interpretations are justified. In particular SpatialBridgeObligation is a
Prop declaration with no proof supplied, and endpoint integrability remains
an explicit separate hypothesis of the conditional BKM consequence.

**Summary:** 113 theorems, 223 declarations in Clay; nonstandard: 0. Theorems using `sorryAx`: 0.

| Module | Theorems |
|---|---:|
| `Clay.Depletion.SolutionLinkedVortexLines` | 50 |
| `Clay.Gaps.ConditionalRiccati` | 2 |
| `Clay.Gaps.DirectionAlignment` | 5 |
| `Clay.Gaps.HistoryClock` | 5 |
| `Clay.Gaps.MissingInputs` | 8 |
| `Clay.Gaps.RejectedMeasureBound` | 3 |
| `Clay.Gaps.StretchingIntegral` | 2 |
| `Clay.Gaps.TwoDClock` | 5 |
| `Clay.Gaps.TwoDPlanar` | 5 |
| `Clay.Gaps` | 1 |
| `Clay.Notes.NotBlowup` | 2 |
| `Clay.StatementB` | 7 |
| `Clay.Tether` | 18 |

## Every theorem

| Theorem | Module | Axioms |
|---|---|---|
| `Clay.Depletion.SolutionLinkedVortexLines.Packet.active_length` | `Clay.Depletion.SolutionLinkedVortexLines` | Classical.choice, Quot.sound, propext |
| `Clay.Depletion.SolutionLinkedVortexLines.Packet.control_bound` | `Clay.Depletion.SolutionLinkedVortexLines` | Classical.choice, Quot.sound, propext |
| `Clay.Depletion.SolutionLinkedVortexLines.Packet.control_measurable` | `Clay.Depletion.SolutionLinkedVortexLines` | Classical.choice, Quot.sound, propext |
| `Clay.Depletion.SolutionLinkedVortexLines.Packet.curve_end` | `Clay.Depletion.SolutionLinkedVortexLines` | Classical.choice, Quot.sound, propext |
| `Clay.Depletion.SolutionLinkedVortexLines.Packet.curve_start` | `Clay.Depletion.SolutionLinkedVortexLines` | Classical.choice, Quot.sound, propext |
| `Clay.Depletion.SolutionLinkedVortexLines.Packet.endpointMagnitude_measurable` | `Clay.Depletion.SolutionLinkedVortexLines` | Classical.choice, Quot.sound, propext |
| `Clay.Depletion.SolutionLinkedVortexLines.Packet.endpoint_measurable` | `Clay.Depletion.SolutionLinkedVortexLines` | Classical.choice, Quot.sound, propext |
| `Clay.Depletion.SolutionLinkedVortexLines.Packet.length_measurable` | `Clay.Depletion.SolutionLinkedVortexLines` | Classical.choice, Quot.sound, propext |
| `Clay.Depletion.SolutionLinkedVortexLines.Packet.length_nonneg` | `Clay.Depletion.SolutionLinkedVortexLines` | Classical.choice, Quot.sound, propext |
| `Clay.Depletion.SolutionLinkedVortexLines.Packet.line_integrable` | `Clay.Depletion.SolutionLinkedVortexLines` | Classical.choice, Quot.sound, propext |
| `Clay.Depletion.SolutionLinkedVortexLines.Packet.line_nonzero` | `Clay.Depletion.SolutionLinkedVortexLines` | Classical.choice, Quot.sound, propext |
| `Clay.Depletion.SolutionLinkedVortexLines.Packet.line_tangent` | `Clay.Depletion.SolutionLinkedVortexLines` | Classical.choice, Quot.sound, propext |
| `Clay.Depletion.SolutionLinkedVortexLines.Packet.mk.injEq` | `Clay.Depletion.SolutionLinkedVortexLines` | Classical.choice, Quot.sound, propext |
| `Clay.Depletion.SolutionLinkedVortexLines.Packet.mk.inj` | `Clay.Depletion.SolutionLinkedVortexLines` | Classical.choice, Quot.sound, propext |
| `Clay.Depletion.SolutionLinkedVortexLines.Packet.mk.sizeOf_spec` | `Clay.Depletion.SolutionLinkedVortexLines` | Classical.choice, Quot.sound, propext |
| `Clay.Depletion.SolutionLinkedVortexLines.Packet.near_maximum` | `Clay.Depletion.SolutionLinkedVortexLines` | Classical.choice, Quot.sound, propext |
| `Clay.Depletion.SolutionLinkedVortexLines.Packet.peakFactor_ge_one` | `Clay.Depletion.SolutionLinkedVortexLines` | Classical.choice, Quot.sound, propext |
| `Clay.Depletion.SolutionLinkedVortexLines.Packet.peak_measurable` | `Clay.Depletion.SolutionLinkedVortexLines` | Classical.choice, Quot.sound, propext |
| `Clay.Depletion.SolutionLinkedVortexLines.bkmIntegralFinite_of_spatialComparison_and_endpoint` | `Clay.Depletion.SolutionLinkedVortexLines` | Classical.choice, Quot.sound, propext |
| `Clay.Depletion.SolutionLinkedVortexLines.curl_eq_zero_of_length_eq_zero` | `Clay.Depletion.SolutionLinkedVortexLines` | Classical.choice, Quot.sound, propext |
| `Clay.Depletion.SolutionLinkedVortexLines.curl_zero` | `Clay.Depletion.SolutionLinkedVortexLines` | Classical.choice, Quot.sound, propext |
| `Clay.Depletion.SolutionLinkedVortexLines.direction.eq_1` | `Clay.Depletion.SolutionLinkedVortexLines` | Classical.choice, Quot.sound, propext |
| `Clay.Depletion.SolutionLinkedVortexLines.endpointMagnitude.eq_1` | `Clay.Depletion.SolutionLinkedVortexLines` | Classical.choice, Quot.sound, propext |
| `Clay.Depletion.SolutionLinkedVortexLines.endpoint_nonzero_of_peak_nonzero` | `Clay.Depletion.SolutionLinkedVortexLines` | Classical.choice, Quot.sound, propext |
| `Clay.Depletion.SolutionLinkedVortexLines.length_pos_of_nonzero_vorticity` | `Clay.Depletion.SolutionLinkedVortexLines` | Classical.choice, Quot.sound, propext |
| `Clay.Depletion.SolutionLinkedVortexLines.lineControl.eq_1` | `Clay.Depletion.SolutionLinkedVortexLines` | Classical.choice, Quot.sound, propext |
| `Clay.Depletion.SolutionLinkedVortexLines.norm_direction_of_nonzero` | `Clay.Depletion.SolutionLinkedVortexLines` | Classical.choice, Quot.sound, propext |
| `Clay.Depletion.SolutionLinkedVortexLines.vortSup_eq_zero_of_length_eq_zero` | `Clay.Depletion.SolutionLinkedVortexLines` | Classical.choice, Quot.sound, propext |
| `Clay.Depletion.SolutionLinkedVortexLines.zeroPacket.proof_10` | `Clay.Depletion.SolutionLinkedVortexLines` | Classical.choice, Quot.sound, propext |
| `Clay.Depletion.SolutionLinkedVortexLines.zeroPacket.proof_11` | `Clay.Depletion.SolutionLinkedVortexLines` | Classical.choice, Quot.sound, propext |
| `Clay.Depletion.SolutionLinkedVortexLines.zeroPacket.proof_12` | `Clay.Depletion.SolutionLinkedVortexLines` | Classical.choice, Quot.sound, propext |
| `Clay.Depletion.SolutionLinkedVortexLines.zeroPacket.proof_13` | `Clay.Depletion.SolutionLinkedVortexLines` | Classical.choice, Quot.sound, propext |
| `Clay.Depletion.SolutionLinkedVortexLines.zeroPacket.proof_14` | `Clay.Depletion.SolutionLinkedVortexLines` | Classical.choice, Quot.sound, propext |
| `Clay.Depletion.SolutionLinkedVortexLines.zeroPacket.proof_1` | `Clay.Depletion.SolutionLinkedVortexLines` | Classical.choice, Quot.sound, propext |
| `Clay.Depletion.SolutionLinkedVortexLines.zeroPacket.proof_2` | `Clay.Depletion.SolutionLinkedVortexLines` | Classical.choice, Quot.sound, propext |
| `Clay.Depletion.SolutionLinkedVortexLines.zeroPacket.proof_3` | `Clay.Depletion.SolutionLinkedVortexLines` | Classical.choice, Quot.sound, propext |
| `Clay.Depletion.SolutionLinkedVortexLines.zeroPacket.proof_4` | `Clay.Depletion.SolutionLinkedVortexLines` | Classical.choice, Quot.sound, propext |
| `Clay.Depletion.SolutionLinkedVortexLines.zeroPacket.proof_5` | `Clay.Depletion.SolutionLinkedVortexLines` | Classical.choice, Quot.sound, propext |
| `Clay.Depletion.SolutionLinkedVortexLines.zeroPacket.proof_6` | `Clay.Depletion.SolutionLinkedVortexLines` | Classical.choice, Quot.sound, propext |
| `Clay.Depletion.SolutionLinkedVortexLines.zeroPacket.proof_7` | `Clay.Depletion.SolutionLinkedVortexLines` | Classical.choice, Quot.sound, propext |
| `Clay.Depletion.SolutionLinkedVortexLines.zeroPacket.proof_8` | `Clay.Depletion.SolutionLinkedVortexLines` | Classical.choice, Quot.sound, propext |
| `Clay.Depletion.SolutionLinkedVortexLines.zeroPacket.proof_9` | `Clay.Depletion.SolutionLinkedVortexLines` | Classical.choice, Quot.sound, propext |
| `Clay.Depletion.SolutionLinkedVortexLines.zeroPacket_BKMIntegralFinite` | `Clay.Depletion.SolutionLinkedVortexLines` | Classical.choice, Quot.sound, propext |
| `Clay.Depletion.SolutionLinkedVortexLines.zeroPacket_endpointIntegralFinite` | `Clay.Depletion.SolutionLinkedVortexLines` | Classical.choice, Quot.sound, propext |
| `Clay.Depletion.SolutionLinkedVortexLines.zeroPacket_spatialComparison` | `Clay.Depletion.SolutionLinkedVortexLines` | Classical.choice, Quot.sound, propext |
| `Clay.Depletion.SolutionLinkedVortexLines.zero_NSOn` | `Clay.Depletion.SolutionLinkedVortexLines` | Classical.choice, Quot.sound, propext |
| `Clay.Gaps.ConditionalRiccati.conditional_riccati` | `Clay.Gaps.ConditionalRiccati` | Quot.sound, propext |
| `Clay.Gaps.ConditionalRiccati.poly_eq` | `Clay.Gaps.ConditionalRiccati` | Quot.sound, propext |
| `Clay.Gaps.DirectionAlignment.DHYPacket.mk.injEq` | `Clay.Gaps.DirectionAlignment` | Classical.choice, Quot.sound, propext |
| `Clay.Gaps.DirectionAlignment.DHYPacket.mk.inj` | `Clay.Gaps.DirectionAlignment` | Classical.choice, Quot.sound, propext |
| `Clay.Gaps.DirectionAlignment.DHYPacket.mk.sizeOf_spec` | `Clay.Gaps.DirectionAlignment` | Classical.choice, Quot.sound, propext |
| `Clay.Gaps.DirectionAlignment.abstract_dhy_criterion_iff_periodicBKMIntegrability` | `Clay.Gaps.DirectionAlignment` | Classical.choice, Quot.sound, propext |
| `Clay.Gaps.DirectionAlignment.sinPhi.proof_1` | `Clay.Gaps.DirectionAlignment` | (none) |
| `Clay.Gaps.HistoryClock.clock_fails_on_aligned_2d_solutions` | `Clay.Gaps.HistoryClock` | Classical.choice, Quot.sound, propext |
| `Clay.Gaps.HistoryClock.driver_not_asserted_of_solutions` | `Clay.Gaps.HistoryClock` | Classical.choice, Quot.sound, propext |
| `Clay.Gaps.HistoryClock.historyDriver.proof_1` | `Clay.Gaps.HistoryClock` | (none) |
| `Clay.Gaps.HistoryClock.historyDriver.proof_2` | `Clay.Gaps.HistoryClock` | (none) |
| `Clay.Gaps.HistoryClock.history_of_const` | `Clay.Gaps.HistoryClock` | Classical.choice, Quot.sound, propext |
| `Clay.Gaps.MissingInputs.bkmIntegralFinite_of_holographic` | `Clay.Gaps.MissingInputs` | Classical.choice, Quot.sound, propext |
| `Clay.Gaps.MissingInputs.czGivesBMONotLinf.proof_1` | `Clay.Gaps.MissingInputs` | Classical.choice, Quot.sound, propext |
| `Clay.Gaps.MissingInputs.enstrophy.proof_1` | `Clay.Gaps.MissingInputs` | Classical.choice, Quot.sound, propext |
| `Clay.Gaps.MissingInputs.enstrophy.proof_2` | `Clay.Gaps.MissingInputs` | Classical.choice, Quot.sound, propext |
| `Clay.Gaps.MissingInputs.spikeObstruction.proof_1` | `Clay.Gaps.MissingInputs` | Classical.choice, Quot.sound, propext |
| `Clay.Gaps.MissingInputs.spikeObstruction.proof_2` | `Clay.Gaps.MissingInputs` | Classical.choice, Quot.sound, propext |
| `Clay.Gaps.MissingInputs.spikeObstruction.proof_3` | `Clay.Gaps.MissingInputs` | (none) |
| `Clay.Gaps.MissingInputs.statementB_of_bkmIntegralFinite` | `Clay.Gaps.MissingInputs` | Classical.choice, Quot.sound, propext |
| `Clay.Gaps.RejectedMeasureBound.reversedHolderClaim.proof_1` | `Clay.Gaps.RejectedMeasureBound` | Classical.choice, Quot.sound, propext |
| `Clay.Gaps.RejectedMeasureBound.reversedHolderClaim.proof_2` | `Clay.Gaps.RejectedMeasureBound` | Classical.choice, Quot.sound, propext |
| `Clay.Gaps.RejectedMeasureBound.reversed_holder_not_asserted` | `Clay.Gaps.RejectedMeasureBound` | (none) |
| `Clay.Gaps.StretchingIntegral.l3Cubed.proof_1` | `Clay.Gaps.StretchingIntegral` | Classical.choice, Quot.sound, propext |
| `Clay.Gaps.StretchingIntegral.l3Cubed.proof_2` | `Clay.Gaps.StretchingIntegral` | Classical.choice, Quot.sound, propext |
| `Clay.Gaps.TwoDClock.alignment_does_not_delete_clock` | `Clay.Gaps.TwoDClock` | Classical.choice, Quot.sound, propext |
| `Clay.Gaps.TwoDClock.cf_holds_for_every_rho` | `Clay.Gaps.TwoDClock` | Classical.choice, Quot.sound, propext |
| `Clay.Gaps.TwoDClock.direction_constant` | `Clay.Gaps.TwoDClock` | Classical.choice, Quot.sound, propext |
| `Clay.Gaps.TwoDClock.history_at_least` | `Clay.Gaps.TwoDClock` | Classical.choice, Quot.sound, propext |
| `Clay.Gaps.TwoDClock.steady_euler_clock` | `Clay.Gaps.TwoDClock` | Classical.choice, Quot.sound, propext |
| `Clay.Gaps.TwoDPlanar.IsPlanar.proof_1` | `Clay.Gaps.TwoDPlanar` | propext |
| `Clay.Gaps.TwoDPlanar.curl_planar` | `Clay.Gaps.TwoDPlanar` | Classical.choice, Quot.sound, propext |
| `Clay.Gaps.TwoDPlanar.fderiv_dir_eq_zero` | `Clay.Gaps.TwoDPlanar` | Classical.choice, Quot.sound, propext |
| `Clay.Gaps.historyIntegralNotUniform_holds` | `Clay.Gaps` | Classical.choice, Quot.sound, propext |
| `Clay.Notes.NotBlowup.bounded_M_keeps_bkm_finite` | `Clay.Notes.NotBlowup` | Classical.choice, Quot.sound, propext |
| `Clay.Notes.NotBlowup.history_can_grow_while_bkm_stays_finite` | `Clay.Notes.NotBlowup` | Classical.choice, Quot.sound, propext |
| `Clay.StatementB.DivFree.eq_1` | `Clay.Depletion.SolutionLinkedVortexLines` | Classical.choice, Quot.sound, propext |
| `Clay.StatementB.IsPeriodic.eq_1` | `Clay.Depletion.SolutionLinkedVortexLines` | Classical.choice, Quot.sound, propext |
| `Clay.StatementB.bkmIntegralFinite_of_vortSup_le` | `Clay.StatementB` | Classical.choice, Quot.sound, propext |
| `Clay.StatementB.curl.eq_1` | `Clay.Gaps.TwoDPlanar` | Classical.choice, Quot.sound, propext |
| `Clay.StatementB.curl.proof_1` | `Clay.StatementB` | (none) |
| `Clay.StatementB.curl.proof_2` | `Clay.StatementB` | propext |
| `Clay.StatementB.feffermanStatementB_of_bkm` | `Clay.StatementB` | Classical.choice, Quot.sound, propext |
| `Clay.StatementB.lap.eq_1` | `Clay.Depletion.SolutionLinkedVortexLines` | Classical.choice, Quot.sound, propext |
| `Clay.StatementB.lifespanSet.eq_1` | `Clay.StatementB` | Classical.choice, Quot.sound, propext |
| `Clay.StatementB.lifespanSet_subset_Icc` | `Clay.StatementB` | Classical.choice, Quot.sound, propext |
| `Clay.StatementB.lifespanSet_top` | `Clay.StatementB` | Classical.choice, Quot.sound, propext |
| `Clay.StatementB.pd.eq_1` | `Clay.Gaps.TwoDPlanar` | Classical.choice, Quot.sound, propext |
| `Clay.StatementB.vortSup.eq_1` | `Clay.Depletion.SolutionLinkedVortexLines` | Classical.choice, Quot.sound, propext |
| `Clay.Tether.KineticEnergy.proof_1` | `Clay.Tether` | (none) |
| `Clay.Tether.KineticEnergy.proof_2` | `Clay.Tether` | Classical.choice, Quot.sound, propext |
| `Clay.Tether.KineticEnergy.proof_3` | `Clay.Tether` | Classical.choice, Quot.sound, propext |
| `Clay.Tether.OrthProj.kills` | `Clay.Tether` | Classical.choice, Quot.sound, propext |
| `Clay.Tether.OrthProj.mk.injEq` | `Clay.Tether` | Classical.choice, Quot.sound, propext |
| `Clay.Tether.OrthProj.mk.inj` | `Clay.Tether` | Classical.choice, Quot.sound, propext |
| `Clay.Tether.OrthProj.mk.sizeOf_spec` | `Clay.Tether` | Classical.choice, Quot.sound, propext |
| `Clay.Tether.Tether.bracket_vanishes_on_energy` | `Clay.Tether` | Classical.choice, Quot.sound, propext |
| `Clay.Tether.Tether.mk.injEq` | `Clay.Tether` | Classical.choice, Quot.sound, propext |
| `Clay.Tether.Tether.mk.inj` | `Clay.Tether` | Classical.choice, Quot.sound, propext |
| `Clay.Tether.Tether.mk.sizeOf_spec` | `Clay.Tether` | Classical.choice, Quot.sound, propext |
| `Clay.Tether.perpProj.proof_1` | `Clay.Tether` | (none) |
| `Clay.Tether.perpProj_self` | `Clay.Tether` | Classical.choice, Quot.sound, propext |
| `Clay.Tether.tetherProj.eq_1` | `Clay.Tether` | Classical.choice, Quot.sound, propext |
| `Clay.Tether.tetherProj_self` | `Clay.Tether` | Classical.choice, Quot.sound, propext |
| `Clay.Tether.tether_bracket_preservation` | `Clay.Tether` | Classical.choice, Quot.sound, propext |
| `Clay.Tether.tether_degeneracy` | `Clay.Tether` | Classical.choice, Quot.sound, propext |
| `Clay.Tether.zeroVel.eq_1` | `Clay.Tether` | Classical.choice, Quot.sound, propext |
