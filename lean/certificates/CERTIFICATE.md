# Kernel certificate: Clay-

This file records a reproducible machine check of the Lean 4 development in this repository. Lean does not issue a signed "official" certificate. What is recorded here is the exact commit and toolchain, the complete `lake build` log, a scan for `sorry`/`admit`/`native_decide`/`axiom`, the `#print axioms` result for every theorem the build produces, and a replay of every module through Lean's kernel with the toolchain's `leanchecker`. Each check can be rerun with the command at the end.

| Item | Value |
|---|---|
| Repository | https://github.com/BenFrohman/Clay- |
| Certified commit | `2c1dc357f3ea52e245b9e28c2219f058c68bf18d` (branch `certs/kernel-certificate-378b2e2`) |
| Lean sources | identical to `main` at `378b2e2d2968bd60a65eb694c7004fa691db4f6d`: no `.lean`, lakefile, manifest or toolchain file differs; the certified commit only adds CI and the scripts in `lean/certificates/tools/` |
| lean-toolchain | `leanprover/lean4:v4.16.0` |
| Lean | Lean (version 4.16.0, x86_64-unknown-linux-gnu, commit 128a1e6b0a82, Release) |
| Mathlib | `a6276f4c6097675b1cf5ebd49b1146b735f38c02` (lake-manifest.json; inputRev `v4.16.0`) |
| Date (UTC) | 2026-11-17T02:16:45Z |
| CI run | https://github.com/BenFrohman/Clay-/actions/runs/44001431257 |
| `lake build` | `Build completed successfully.` ([build.log](build.log)) |
| sorry / admit / native_decide / axiom scan | `RESULT: 0 hits` ([sorry-scan.txt](sorry-scan.txt)) |
| `#print axioms` | `AUDIT PASS: 144 theorems in 16 modules depend only on propext, Classical.choice, Quot.sound (or on no axioms)` ([axioms.txt](axioms.txt)) |
| Kernel replay (leanchecker) | `RESULT: 19 of 19 modules replayed through the kernel, 0 failures` ([leanchecker.txt](leanchecker.txt)) |

## What each check means

- **Build.** `lake build` of the default targets with the pinned toolchain. Mathlib comes from `lake exe cache get` (it is never rebuilt from source). The build elaborates every proof and sends each declaration to Lean's kernel.
- **Scan.** `certificates/tools/sorry_scan.py` strips comments and strings from every tracked `.lean` file and reports any `sorry`, `admit`, `native_decide` or `axiom` declaration. Result: RESULT: 0 hits.
- **Axioms.** `certificates/tools/gen_audit.py` imports all 19 built modules ([modules.txt](modules.txt)) and calls `Lean.collectAxioms`, the function behind `#print axioms`, on every theorem declared in them (144 theorems, auto-generated internal names excluded). `check_audit.py` fails unless each depends only on `propext`, `Classical.choice` and `Quot.sound`, or on no axioms. Raw output: [axioms.raw.txt](axioms.raw.txt); generated Lean file: [KernelCertificateAudit.lean.txt](KernelCertificateAudit.lean.txt).
- **Kernel replay.** checker: lean4checker tag v4.16.0 (803320ef4a0948d44e56927b2d1c60c3e8c6e4e4), Main.lean prefix match -> exact match. For each module, the checker loads the module's imports from their `.olean` files and replays every declaration of that module through the kernel. The stock checker treats its argument as a module-name prefix and replays all matching modules in parallel, which runs out of memory on a root module, so it is run once per module with exact matching (the one-line patch is printed in [leanchecker.txt](leanchecker.txt)). The checker's own documentation describes it as a tool to detect environment hacking, not an independent external verifier; imported Mathlib and core declarations are trusted from their `.olean` files.

## Scope

The axiom result says the listed theorems are proved from Lean's standard axioms. It does not by itself say what the theorems mean; read the statements in the sources. Conditional theorems remain conditional on their hypotheses.

Full `#print axioms` output (verbatim from `axioms.txt`):

```
'Clay.Depletion.SolutionLinkedVortexLines.LogDerivativeAlong.proof_1' depends on axioms: [Quot.sound, propext, Classical.choice]
'Clay.Depletion.SolutionLinkedVortexLines.bkmIntegralFinite_of_NSOn_and_endpoint' depends on axioms: [propext, Classical.choice, Quot.sound]
'Clay.Depletion.SolutionLinkedVortexLines.curl_differentiable_of_C2' depends on axioms: [propext, Classical.choice, Quot.sound]
'Clay.Depletion.SolutionLinkedVortexLines.div_curl_eq_zero' depends on axioms: [propext, Classical.choice, Quot.sound]
'Clay.Depletion.SolutionLinkedVortexLines.logDerivativeAlong_of_spatialC2' depends on axioms: [propext, Classical.choice, Quot.sound]
'Clay.Depletion.SolutionLinkedVortexLines.norm_direction_derivative' depends on axioms: [propext, Classical.choice, Quot.sound]
'Clay.Depletion.SolutionLinkedVortexLines.pd_pd_comm' depends on axioms: [propext, Classical.choice, Quot.sound]
'Clay.Depletion.SolutionLinkedVortexLines.spatialBridgeObligation_proved' depends on axioms: [propext, Classical.choice, Quot.sound]
'Clay.Depletion.SolutionLinkedVortexLines.spatialC2_of_NSOn' depends on axioms: [propext, Classical.choice, Quot.sound]
'Clay.Depletion.SolutionLinkedVortexLines.spatialComparison_of_NSOn' depends on axioms: [propext, Classical.choice, Quot.sound]
'Clay.Depletion.SolutionLinkedVortexLines.spatialComparison_of_logDerivativeAlong' depends on axioms: [propext, Classical.choice, Quot.sound]
'Clay.StatementB.e.eq_1' depends on axioms: [propext, Classical.choice, Quot.sound]
'Clay.Depletion.SolutionLinkedVortexLines.Packet.active_length' depends on axioms: [propext, Classical.choice, Quot.sound]
'Clay.Depletion.SolutionLinkedVortexLines.Packet.control_bound' depends on axioms: [propext, Classical.choice, Quot.sound]
'Clay.Depletion.SolutionLinkedVortexLines.Packet.control_measurable' depends on axioms: [propext, Classical.choice, Quot.sound]
'Clay.Depletion.SolutionLinkedVortexLines.Packet.curve_end' depends on axioms: [propext, Classical.choice, Quot.sound]
'Clay.Depletion.SolutionLinkedVortexLines.Packet.curve_start' depends on axioms: [propext, Classical.choice, Quot.sound]
'Clay.Depletion.SolutionLinkedVortexLines.Packet.endpointMagnitude_measurable' depends on axioms: [propext, Classical.choice, Quot.sound]
'Clay.Depletion.SolutionLinkedVortexLines.Packet.endpoint_measurable' depends on axioms: [propext, Classical.choice, Quot.sound]
'Clay.Depletion.SolutionLinkedVortexLines.Packet.length_measurable' depends on axioms: [propext, Classical.choice, Quot.sound]
'Clay.Depletion.SolutionLinkedVortexLines.Packet.length_nonneg' depends on axioms: [propext, Classical.choice, Quot.sound]
'Clay.Depletion.SolutionLinkedVortexLines.Packet.line_integrable' depends on axioms: [propext, Classical.choice, Quot.sound]
'Clay.Depletion.SolutionLinkedVortexLines.Packet.line_nonzero' depends on axioms: [propext, Classical.choice, Quot.sound]
'Clay.Depletion.SolutionLinkedVortexLines.Packet.line_tangent' depends on axioms: [propext, Classical.choice, Quot.sound]
'Clay.Depletion.SolutionLinkedVortexLines.Packet.mk.inj' depends on axioms: [propext, Classical.choice, Quot.sound]
'Clay.Depletion.SolutionLinkedVortexLines.Packet.mk.injEq' depends on axioms: [propext, Classical.choice, Quot.sound]
'Clay.Depletion.SolutionLinkedVortexLines.Packet.mk.sizeOf_spec' depends on axioms: [propext, Classical.choice, Quot.sound]
'Clay.Depletion.SolutionLinkedVortexLines.Packet.near_maximum' depends on axioms: [propext, Classical.choice, Quot.sound]
'Clay.Depletion.SolutionLinkedVortexLines.Packet.peakFactor_ge_one' depends on axioms: [propext, Classical.choice, Quot.sound]
'Clay.Depletion.SolutionLinkedVortexLines.Packet.peak_measurable' depends on axioms: [propext, Classical.choice, Quot.sound]
'Clay.Depletion.SolutionLinkedVortexLines.bkmIntegralFinite_of_spatialComparison_and_endpoint' depends on axioms: [propext, Classical.choice, Quot.sound]
'Clay.Depletion.SolutionLinkedVortexLines.curl_eq_zero_of_length_eq_zero' depends on axioms: [propext, Classical.choice, Quot.sound]
'Clay.Depletion.SolutionLinkedVortexLines.curl_zero' depends on axioms: [propext, Classical.choice, Quot.sound]
'Clay.Depletion.SolutionLinkedVortexLines.direction.eq_1' depends on axioms: [propext, Classical.choice, Quot.sound]
'Clay.Depletion.SolutionLinkedVortexLines.endpointMagnitude.eq_1' depends on axioms: [propext, Classical.choice, Quot.sound]
'Clay.Depletion.SolutionLinkedVortexLines.endpoint_nonzero_of_peak_nonzero' depends on axioms: [propext, Classical.choice, Quot.sound]
'Clay.Depletion.SolutionLinkedVortexLines.length_pos_of_nonzero_vorticity' depends on axioms: [propext, Classical.choice, Quot.sound]
'Clay.Depletion.SolutionLinkedVortexLines.lineControl.eq_1' depends on axioms: [propext, Classical.choice, Quot.sound]
'Clay.Depletion.SolutionLinkedVortexLines.norm_direction_of_nonzero' depends on axioms: [propext, Classical.choice, Quot.sound]
'Clay.Depletion.SolutionLinkedVortexLines.vortSup_eq_zero_of_length_eq_zero' depends on axioms: [propext, Classical.choice, Quot.sound]
'Clay.Depletion.SolutionLinkedVortexLines.zeroPacket.proof_1' depends on axioms: [propext, Classical.choice, Quot.sound]
'Clay.Depletion.SolutionLinkedVortexLines.zeroPacket.proof_10' depends on axioms: [propext, Classical.choice, Quot.sound]
'Clay.Depletion.SolutionLinkedVortexLines.zeroPacket.proof_11' depends on axioms: [propext, Classical.choice, Quot.sound]
'Clay.Depletion.SolutionLinkedVortexLines.zeroPacket.proof_12' depends on axioms: [propext, Classical.choice, Quot.sound]
'Clay.Depletion.SolutionLinkedVortexLines.zeroPacket.proof_13' depends on axioms: [propext, Classical.choice, Quot.sound]
'Clay.Depletion.SolutionLinkedVortexLines.zeroPacket.proof_14' depends on axioms: [propext, Classical.choice, Quot.sound]
'Clay.Depletion.SolutionLinkedVortexLines.zeroPacket.proof_2' depends on axioms: [propext, Classical.choice, Quot.sound]
'Clay.Depletion.SolutionLinkedVortexLines.zeroPacket.proof_3' depends on axioms: [propext, Classical.choice, Quot.sound]
'Clay.Depletion.SolutionLinkedVortexLines.zeroPacket.proof_4' depends on axioms: [propext, Classical.choice, Quot.sound]
'Clay.Depletion.SolutionLinkedVortexLines.zeroPacket.proof_5' depends on axioms: [propext, Classical.choice, Quot.sound]
'Clay.Depletion.SolutionLinkedVortexLines.zeroPacket.proof_6' depends on axioms: [propext, Classical.choice, Quot.sound]
'Clay.Depletion.SolutionLinkedVortexLines.zeroPacket.proof_7' depends on axioms: [propext, Classical.choice, Quot.sound]
'Clay.Depletion.SolutionLinkedVortexLines.zeroPacket.proof_8' depends on axioms: [propext, Classical.choice, Quot.sound]
'Clay.Depletion.SolutionLinkedVortexLines.zeroPacket.proof_9' depends on axioms: [propext, Classical.choice, Quot.sound]
'Clay.Depletion.SolutionLinkedVortexLines.zeroPacket_BKMIntegralFinite' depends on axioms: [propext, Classical.choice, Quot.sound]
'Clay.Depletion.SolutionLinkedVortexLines.zeroPacket_endpointIntegralFinite' depends on axioms: [propext, Classical.choice, Quot.sound]
'Clay.Depletion.SolutionLinkedVortexLines.zeroPacket_spatialComparison' depends on axioms: [propext, Classical.choice, Quot.sound]
'Clay.Depletion.SolutionLinkedVortexLines.zero_NSOn' depends on axioms: [propext, Classical.choice, Quot.sound]
'Clay.StatementB.DivFree.eq_1' depends on axioms: [propext, Classical.choice, Quot.sound]
'Clay.StatementB.IsPeriodic.eq_1' depends on axioms: [propext, Classical.choice, Quot.sound]
'Clay.StatementB.curl.eq_1' depends on axioms: [propext, Classical.choice, Quot.sound]
'Clay.StatementB.lap.eq_1' depends on axioms: [propext, Classical.choice, Quot.sound]
'Clay.StatementB.pd.eq_1' depends on axioms: [propext, Classical.choice, Quot.sound]
'Clay.StatementB.vortSup.eq_1' depends on axioms: [propext, Classical.choice, Quot.sound]
'Clay.Gaps.historyIntegralNotUniform_holds' depends on axioms: [propext, Classical.choice, Quot.sound]
'Clay.Gaps.ConditionalRiccati.conditional_riccati' depends on axioms: [propext, Quot.sound]
'Clay.Gaps.ConditionalRiccati.poly_eq' depends on axioms: [propext, Quot.sound]
'Clay.Gaps.DirectionAlignment.DHYPacket.mk.inj' depends on axioms: [propext, Classical.choice, Quot.sound]
'Clay.Gaps.DirectionAlignment.DHYPacket.mk.injEq' depends on axioms: [propext, Classical.choice, Quot.sound]
'Clay.Gaps.DirectionAlignment.DHYPacket.mk.sizeOf_spec' depends on axioms: [propext, Classical.choice, Quot.sound]
'Clay.Gaps.DirectionAlignment.abstract_dhy_criterion_iff_periodicBKMIntegrability' depends on axioms: [propext, Classical.choice, Quot.sound]
'Clay.Gaps.DirectionAlignment.sinPhi.proof_1' does not depend on any axioms
'Clay.Gaps.HistoryClock.clock_fails_on_aligned_2d_solutions' depends on axioms: [propext, Classical.choice, Quot.sound]
'Clay.Gaps.HistoryClock.driver_not_asserted_of_solutions' depends on axioms: [propext, Classical.choice, Quot.sound]
'Clay.Gaps.HistoryClock.historyDriver.proof_1' does not depend on any axioms
'Clay.Gaps.HistoryClock.historyDriver.proof_2' does not depend on any axioms
'Clay.Gaps.HistoryClock.history_of_const' depends on axioms: [propext, Classical.choice, Quot.sound]
'Clay.Gaps.MissingInputs.bkmIntegralFinite_of_holographic' depends on axioms: [propext, Classical.choice, Quot.sound]
'Clay.Gaps.MissingInputs.czGivesBMONotLinf.proof_1' depends on axioms: [propext, Classical.choice, Quot.sound]
'Clay.Gaps.MissingInputs.enstrophy.proof_1' depends on axioms: [propext, Quot.sound, Classical.choice]
'Clay.Gaps.MissingInputs.enstrophy.proof_2' depends on axioms: [propext, Classical.choice, Quot.sound]
'Clay.Gaps.MissingInputs.spikeObstruction.proof_1' depends on axioms: [propext, Quot.sound, Classical.choice]
'Clay.Gaps.MissingInputs.spikeObstruction.proof_2' depends on axioms: [propext, Classical.choice, Quot.sound]
'Clay.Gaps.MissingInputs.spikeObstruction.proof_3' does not depend on any axioms
'Clay.Gaps.MissingInputs.statementB_of_bkmIntegralFinite' depends on axioms: [propext, Classical.choice, Quot.sound]
'Clay.Gaps.RejectedMeasureBound.reversedHolderClaim.proof_1' depends on axioms: [propext, Quot.sound, Classical.choice]
'Clay.Gaps.RejectedMeasureBound.reversedHolderClaim.proof_2' depends on axioms: [propext, Classical.choice, Quot.sound]
'Clay.Gaps.RejectedMeasureBound.reversed_holder_not_asserted' does not depend on any axioms
'Clay.Gaps.StretchingIntegral.l3Cubed.proof_1' depends on axioms: [propext, Quot.sound, Classical.choice]
'Clay.Gaps.StretchingIntegral.l3Cubed.proof_2' depends on axioms: [propext, Classical.choice, Quot.sound]
'Clay.Gaps.TwoDClock.alignment_does_not_delete_clock' depends on axioms: [propext, Classical.choice, Quot.sound]
'Clay.Gaps.TwoDClock.cf_holds_for_every_rho' depends on axioms: [propext, Classical.choice, Quot.sound]
'Clay.Gaps.TwoDClock.direction_constant' depends on axioms: [propext, Classical.choice, Quot.sound]
'Clay.Gaps.TwoDClock.history_at_least' depends on axioms: [propext, Classical.choice, Quot.sound]
'Clay.Gaps.TwoDClock.steady_euler_clock' depends on axioms: [propext, Classical.choice, Quot.sound]
'Clay.Gaps.TwoDPlanar.IsPlanar.proof_1' depends on axioms: [propext]
'Clay.Gaps.TwoDPlanar.curl_planar' depends on axioms: [propext, Classical.choice, Quot.sound]
'Clay.Gaps.TwoDPlanar.fderiv_dir_eq_zero' depends on axioms: [propext, Classical.choice, Quot.sound]
'Clay.StatementB.curl.eq_1' depends on axioms: [propext, Classical.choice, Quot.sound]
'Clay.StatementB.pd.eq_1' depends on axioms: [propext, Classical.choice, Quot.sound]
'Clay.Notes.NotBlowup.bounded_M_keeps_bkm_finite' depends on axioms: [propext, Classical.choice, Quot.sound]
'Clay.Notes.NotBlowup.history_can_grow_while_bkm_stays_finite' depends on axioms: [propext, Classical.choice, Quot.sound]
'Clay.Notes.SmoothnessIndex.NSOn_smooth' depends on axioms: [propext, Classical.choice, Quot.sound]
'Clay.Notes.SmoothnessIndex.exists_contDiff_infty_not_omega' depends on axioms: [propext, Classical.choice, Quot.sound]
'Clay.Notes.SmoothnessIndex.expNegInvGlue_contDiff_infty' depends on axioms: [propext, Classical.choice, Quot.sound]
'Clay.Notes.SmoothnessIndex.expNegInvGlue_not_analyticAt_zero' depends on axioms: [propext, Classical.choice, Quot.sound]
'Clay.Notes.SmoothnessIndex.infty_ne_omega' does not depend on any axioms
'Clay.Notes.SmoothnessIndex.not_contDiff_omega_expNegInvGlue' depends on axioms: [propext, Classical.choice, Quot.sound]
'Clay.Notes.SmoothnessIndex.smoothPeriodicData_iff' depends on axioms: [propext, Classical.choice, Quot.sound]
'Clay.Notes.SmoothnessIndex.smoothPeriodicData_of_analytic' depends on axioms: [propext, Classical.choice, Quot.sound]
'TruthGate.data_iff' depends on axioms: [propext, Classical.choice, Quot.sound]
'TruthGate.formal_claim_holds' depends on axioms: [propext, Classical.choice, Quot.sound]
'TruthGate.intended_correspondence' depends on axioms: [propext, Classical.choice, Quot.sound]
'TruthGate.interval_ofReal' depends on axioms: [propext, Classical.choice, Quot.sound]
'TruthGate.interval_toReal' depends on axioms: [propext, Classical.choice, Quot.sound]
'TruthGate.pVortSup.proof_1' does not depend on any axioms
'TruthGate.pVortSup.proof_2' depends on axioms: [propext]
'TruthGate.paper_claim_holds' depends on axioms: [propext, Classical.choice, Quot.sound]
'TruthGate.sol_iff' depends on axioms: [propext, Classical.choice, Quot.sound]
'Clay.StatementB.bkmIntegralFinite_of_vortSup_le' depends on axioms: [propext, Classical.choice, Quot.sound]
'Clay.StatementB.curl.proof_1' does not depend on any axioms
'Clay.StatementB.curl.proof_2' depends on axioms: [propext]
'Clay.StatementB.feffermanStatementB_of_bkm' depends on axioms: [propext, Classical.choice, Quot.sound]
'Clay.StatementB.lifespanSet.eq_1' depends on axioms: [propext, Classical.choice, Quot.sound]
'Clay.StatementB.lifespanSet_subset_Icc' depends on axioms: [propext, Classical.choice, Quot.sound]
'Clay.StatementB.lifespanSet_top' depends on axioms: [propext, Classical.choice, Quot.sound]
'Clay.Tether.KineticEnergy.proof_1' does not depend on any axioms
'Clay.Tether.KineticEnergy.proof_2' depends on axioms: [propext, Quot.sound, Classical.choice]
'Clay.Tether.KineticEnergy.proof_3' depends on axioms: [propext, Classical.choice, Quot.sound]
'Clay.Tether.OrthProj.kills' depends on axioms: [propext, Classical.choice, Quot.sound]
'Clay.Tether.OrthProj.mk.inj' depends on axioms: [propext, Classical.choice, Quot.sound]
'Clay.Tether.OrthProj.mk.injEq' depends on axioms: [propext, Classical.choice, Quot.sound]
'Clay.Tether.OrthProj.mk.sizeOf_spec' depends on axioms: [propext, Classical.choice, Quot.sound]
'Clay.Tether.Tether.bracket_vanishes_on_energy' depends on axioms: [propext, Classical.choice, Quot.sound]
'Clay.Tether.Tether.mk.inj' depends on axioms: [propext, Classical.choice, Quot.sound]
'Clay.Tether.Tether.mk.injEq' depends on axioms: [propext, Classical.choice, Quot.sound]
'Clay.Tether.Tether.mk.sizeOf_spec' depends on axioms: [propext, Classical.choice, Quot.sound]
'Clay.Tether.perpProj.proof_1' does not depend on any axioms
'Clay.Tether.perpProj_self' depends on axioms: [propext, Classical.choice, Quot.sound]
'Clay.Tether.tetherProj.eq_1' depends on axioms: [propext, Classical.choice, Quot.sound]
'Clay.Tether.tetherProj_self' depends on axioms: [propext, Classical.choice, Quot.sound]
'Clay.Tether.tether_bracket_preservation' depends on axioms: [propext, Classical.choice, Quot.sound]
'Clay.Tether.tether_degeneracy' depends on axioms: [propext, Classical.choice, Quot.sound]
'Clay.Tether.zeroVel.eq_1' depends on axioms: [propext, Classical.choice, Quot.sound]
```

## Rebuild

```
git clone https://github.com/BenFrohman/Clay-.git && cd Clay- && git checkout 2c1dc357f3ea52e245b9e28c2219f058c68bf18d && cd lean && lake exe cache get && lake build && python3 certificates/tools/sorry_scan.py && python3 certificates/tools/gen_audit.py /tmp/KernelCertificateAudit.lean /tmp/modules.txt && lake env lean /tmp/KernelCertificateAudit.lean > /tmp/axioms.raw.txt && python3 certificates/tools/check_audit.py /tmp/axioms.raw.txt | tail -n 1
```
