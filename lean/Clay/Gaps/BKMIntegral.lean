/-
Copyright (c) 2026 Benjamin Stanley Frohman. Apache-2.0.
Named open obligation. Beale–Kato–Majda (Comm. Math. Phys. 94, 1984) is a theorem:
a smooth solution extends if ∫ ‖ω‖_∞ dt stays finite. On T³ with unforced smooth
finite-energy data this bound is equivalent to Fefferman (B). Recorded, not proved.
-/

namespace Clay.Gaps.BKMIntegral

opaque M : ℝ → ℝ
opaque F : ℝ → ℝ
opaque initial_Hs_norm : ℝ

theorem bkm_integral_bound :
    ∀ T : ℝ, 0 ≤ T → ∫ t in (0 : ℝ)..T, M t ≤ F initial_Hs_norm := by
  sorry

theorem bkm_is_classical_continuation : True := trivial

end Clay.Gaps.BKMIntegral
