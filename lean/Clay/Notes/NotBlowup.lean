/-
Copyright (c) 2026 Benjamin Stanley Frohman. Apache-2.0.

Two elementary arithmetic identities, used as a worked illustration (not a theorem about
Navier–Stokes solutions). If the vorticity sup-norm is a constant `M`, the BKM integral over
`[0,T]` is `M * T`, which is finite, while the quadratic history `∫₀ᵀ M² dt = M * M * T` still grows
linearly in `T`. So linear growth of the history does not, by itself, signal BKM blow-up.
Both statements hold by `rfl`; they are definitions unfolded, not analysis.
This does not prove or disprove Fefferman (C) or (D).
-/

import Mathlib.Data.Real.Basic

namespace Clay.Notes.NotBlowup

def bkmIntegral (M T : ℝ) : ℝ := M * T

def history (M T : ℝ) : ℝ := M * M * T

theorem bounded_M_keeps_bkm_finite (M T : ℝ) :
    bkmIntegral M T = M * T := rfl

theorem history_can_grow_while_bkm_stays_finite (M T : ℝ) :
    history M T = M * M * T ∧ bkmIntegral M T = M * T :=
  ⟨rfl, rfl⟩

end Clay.Notes.NotBlowup
