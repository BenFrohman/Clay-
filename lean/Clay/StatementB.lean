/-
Copyright (c) 2026 Benjamin Stanley Frohman. All rights reserved.
Released under Apache 2.0 license as described in the file LICENSE.
Authors: Benjamin Stanley Frohman

Fefferman's Statement (B), stated precisely. NOT PROVED HERE.

Source: C. L. Fefferman, "Existence and smoothness of the Navier–Stokes
equation", official Clay Mathematics Institute problem description (2000),
Statement (B): "(Existence and smoothness of Navier–Stokes solutions in ℝ³/ℤ³.)
Take ν > 0 and n = 3. Let u°(x) be any smooth, divergence-free vector field
satisfying (8); we take f(x,t) to be identically zero. Then there exist smooth
functions p(x,t), uᵢ(x,t) on ℝ³ × [0,∞) that satisfy (1), (2), (3), (10), (11)."
Here (1) is the momentum equation, (2) incompressibility, (3) the initial
condition, (8)/(10) periodicity with period 1 in each coordinate, and (11)
smoothness on ℝ³ × [0,∞).

What is proved in this file is only a reduction: Statement (B) follows from two
named Props, the classical local theory with the Beale–Kato–Majda (1984)
continuation criterion (`PeriodicMaximalSolutionWithBKM`, not formalized here)
and the open Clay core `PeriodicBKMIntegrability`. Mirrors the chain in
BenFrohman/periodic-ns-classical-continuation.
-/

import Mathlib

noncomputable section

namespace Clay.StatementB

open MeasureTheory Set
open scoped ENNReal NNReal ContDiff

/-- Euclidean ℝ³. -/
abbrev E3 := EuclideanSpace ℝ (Fin 3)

/-- Standard basis vector `e_j`. -/
def e (j : Fin 3) : E3 := EuclideanSpace.single j 1

/-- Partial derivative `∂_j f`. -/
def pd (f : E3 → ℝ) (j : Fin 3) (x : E3) : ℝ := fderiv ℝ f x (e j)

/-- Laplacian `Δ f = Σ_j ∂_j ∂_j f`. -/
def lap (f : E3 → ℝ) (x : E3) : ℝ := ∑ j, pd (pd f j) j x

/-- Periodicity with period 1 in each coordinate (Fefferman (8), (10)). -/
def IsPeriodic {α : Type*} (f : E3 → α) : Prop := ∀ x j, f (x + e j) = f x

/-- Divergence-free: `Σ_i ∂_i v_i = 0` (Fefferman (2)). -/
def DivFree (v : E3 → E3) : Prop := ∀ x, ∑ i, pd (fun y => v y i) i x = 0

/-- Vorticity `ω = curl v`. -/
def curl (v : E3 → E3) (x : E3) : E3 :=
  (WithLp.equiv 2 (Fin 3 → ℝ)).symm
    ![pd (fun y => v y 2) 1 x - pd (fun y => v y 1) 2 x,
      pd (fun y => v y 0) 2 x - pd (fun y => v y 2) 0 x,
      pd (fun y => v y 1) 0 x - pd (fun y => v y 0) 1 x]

/-- Admissible data for Statement (B): smooth, divergence-free, periodic. -/
def SmoothPeriodicData (u0 : E3 → E3) : Prop :=
  ContDiff ℝ ∞ u0 ∧ DivFree u0 ∧ IsPeriodic u0

/-- `(u,p)` is a smooth periodic unforced Navier–Stokes solution on the time set
`S` with data `u0`: Fefferman (1), (2), (3), (10), (11) with `f ≡ 0`. -/
def NSOn (ν : ℝ) (S : Set ℝ) (u0 : E3 → E3) (u : ℝ → E3 → E3) (p : ℝ → E3 → ℝ) :
    Prop :=
  ContDiffOn ℝ ∞ (fun z : ℝ × E3 => u z.1 z.2) (S ×ˢ univ) ∧
  ContDiffOn ℝ ∞ (fun z : ℝ × E3 => p z.1 z.2) (S ×ˢ univ) ∧
  (∀ t ∈ S, ∀ x i,
      derivWithin (fun s => u s x i) S t + ∑ j, u t x j * pd (fun y => u t y i) j x
        = ν * lap (fun y => u t y i) x - pd (p t) i x) ∧
  (∀ t ∈ S, DivFree (u t)) ∧
  (∀ x, u 0 x = u0 x) ∧
  (∀ t ∈ S, IsPeriodic (u t) ∧ IsPeriodic (p t))

/-- **Fefferman's Statement (B).** Open (Clay Millennium Problem). -/
def FeffermanStatementB : Prop :=
  ∀ ν : ℝ, 0 < ν → ∀ u0 : E3 → E3, SmoothPeriodicData u0 →
    ∃ (u : ℝ → E3 → E3) (p : ℝ → E3 → ℝ), NSOn ν (Ici 0) u0 u p

/-- The time interval `[0, T)` for `T ∈ [0, ∞]`. -/
def lifespanSet (T : ℝ≥0∞) : Set ℝ := {t | 0 ≤ t ∧ ENNReal.ofReal t < T}

theorem lifespanSet_top : lifespanSet ⊤ = Ici 0 := by
  ext t; simp [lifespanSet, ENNReal.ofReal_lt_top]

theorem lifespanSet_subset_Icc (T : ℝ≥0∞) (hT : T ≠ ⊤) :
    lifespanSet T ⊆ Icc 0 T.toReal := by
  intro t ⟨h0, ht⟩
  refine ⟨h0, ?_⟩
  have := (ENNReal.ofReal_lt_iff_lt_toReal h0 hT).1 ht
  exact this.le

/-- `‖ω(t)‖_{L^∞}` as an extended real. -/
def vortSup (u : ℝ → E3 → E3) (t : ℝ) : ℝ≥0∞ := ⨆ x, (‖curl (u t) x‖₊ : ℝ≥0∞)

/-- The Beale–Kato–Majda integral `∫_0^T ‖ω(t)‖_∞ dt` is finite. -/
def BKMIntegralFinite (u : ℝ → E3 → E3) (T : ℝ≥0∞) : Prop :=
  ∫⁻ t in lifespanSet T, vortSup u t < ⊤

/-- Every smooth periodic solution on a finite interval `[0,T)`. -/
def ForAllFiniteSolutions (P : (ℝ → E3 → E3) → (ℝ → E3 → ℝ) → ℝ≥0∞ → Prop) : Prop :=
  ∀ ν : ℝ, 0 < ν → ∀ (u0 : E3 → E3) (u : ℝ → E3 → E3) (p : ℝ → E3 → ℝ) (T : ℝ≥0∞),
    SmoothPeriodicData u0 → T ≠ ⊤ → NSOn ν (lifespanSet T) u0 u p → P u p T

/-- Named classical Prop (Kato/Fujita–Kato local theory + Beale–Kato–Majda 1984):
a maximal smooth solution exists, and a finite lifespan forces the BKM integral
to diverge. Classical, but NOT formalized here. -/
def PeriodicMaximalSolutionWithBKM : Prop :=
  ∀ ν : ℝ, 0 < ν → ∀ u0 : E3 → E3, SmoothPeriodicData u0 →
    ∃ T : ℝ≥0∞, 0 < T ∧ ∃ (u : ℝ → E3 → E3) (p : ℝ → E3 → ℝ),
      NSOn ν (lifespanSet T) u0 u p ∧ (T ≠ ⊤ → ¬ BKMIntegralFinite u T)

/-- Named OPEN Prop (the Clay core): the BKM integral is finite on every finite
interval of existence. Equivalent in strength to Statement (B) given the local
theory. NOT PROVED. -/
def PeriodicBKMIntegrability : Prop :=
  ForAllFiniteSolutions fun u _ T => BKMIntegralFinite u T

/-- **Proved reduction.** Statement (B) follows from the classical local theory
with the BKM criterion and the open Prop `PeriodicBKMIntegrability`. -/
theorem feffermanStatementB_of_bkm (hloc : PeriodicMaximalSolutionWithBKM)
    (hbkm : PeriodicBKMIntegrability) : FeffermanStatementB := by
  intro ν hν u0 hu0
  obtain ⟨T, _hT, u, p, hsol, hcrit⟩ := hloc ν hν u0 hu0
  by_cases hTop : T = ⊤
  · subst hTop
    rw [lifespanSet_top] at hsol
    exact ⟨u, p, hsol⟩
  · exact absurd (hbkm ν hν u0 u p T hu0 hTop hsol) (hcrit hTop)

/-- **Proved.** A uniform `L^∞` vorticity bound on `[0,T)` with `T < ∞` makes the
BKM integral finite. -/
theorem bkmIntegralFinite_of_vortSup_le (u : ℝ → E3 → E3) (T : ℝ≥0∞) (hT : T ≠ ⊤)
    (C : ℝ≥0∞) (hC : C ≠ ⊤) (hb : ∀ t ∈ lifespanSet T, vortSup u t ≤ C) :
    BKMIntegralFinite u T := by
  unfold BKMIntegralFinite
  calc ∫⁻ t in lifespanSet T, vortSup u t
      ≤ ∫⁻ _t in lifespanSet T, C := setLIntegral_mono measurable_const hb
    _ = C * volume (lifespanSet T) := setLIntegral_const _ _
    _ ≤ C * volume (Icc (0 : ℝ) T.toReal) :=
        mul_le_mul_left' (measure_mono (lifespanSet_subset_Icc T hT)) _
    _ < ⊤ := ENNReal.mul_lt_top hC.lt_top (by simp)

end Clay.StatementB
