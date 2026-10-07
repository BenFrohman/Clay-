/-
Copyright (c) 2026 Benjamin Stanley Frohman. Apache-2.0.
The 2D fact is the type of the theorems. Schematic, not a constructed Beltrami field.
-/

import Mathlib.Data.Real.Basic

namespace Clay.Gaps.TwoDClock

def sinPhi (_t _x _y : ℝ) : ℝ := 0

theorem direction_constant (t x y : ℝ) : sinPhi t x y = 0 := rfl

theorem cf_holds_for_every_rho (t x y ρ : ℝ) (_hρ : 0 < ρ) :
    sinPhi t x y = 0 :=
  direction_constant t x y

def history (M t : ℝ) : ℝ := M * M * t

theorem history_at_least (m t : ℝ) (_hm : 0 < m) (_ht : 0 ≤ t) :
    m * m * t = history m t := rfl

def phiSup (M0 t : ℝ) : ℝ := M0 * M0 * t

theorem steady_euler_clock (M0 t : ℝ) :
    phiSup M0 t = M0 * M0 * t := rfl

theorem alignment_does_not_delete_clock (M0 t ρ : ℝ) (hρ : 0 < ρ) :
    sinPhi 0 0 0 = 0 ∧ phiSup M0 t = M0 * M0 * t :=
  ⟨cf_holds_for_every_rho 0 0 0 ρ hρ, steady_euler_clock M0 t⟩

end Clay.Gaps.TwoDClock
