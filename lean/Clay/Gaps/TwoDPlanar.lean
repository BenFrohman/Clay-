/-
Copyright (c) 2026 Benjamin Stanley Frohman. Apache-2.0.
Real replacement for the `rfl` model in `TwoDClock.lean`: for a planar
(2½D-free) velocity field `v = (v₁(x₁,x₂), v₂(x₁,x₂), 0)` on ℝ³, the vorticity
is parallel to `e₃`, i.e. its direction is constant wherever `ω ≠ 0`.
No differentiability hypothesis is needed. Not a regularity statement.
-/

import Clay.StatementB

noncomputable section

namespace Clay.Gaps.TwoDPlanar

open Clay.StatementB

/-- Planar field: invariant along `e₃` and with zero third component. -/
def IsPlanar (v : E3 → E3) : Prop :=
  (∀ x (s : ℝ), v (x + s • e 2) = v x) ∧ ∀ x, v x 2 = 0

/-- A scalar function constant along the line `x + s v` has zero `fderiv` in direction `v`. -/
theorem fderiv_dir_eq_zero (f : E3 → ℝ) (w x : E3)
    (hf : ∀ y (s : ℝ), f (y + s • w) = f y) : fderiv ℝ f x w = 0 := by
  by_cases hd : DifferentiableAt ℝ f x
  · have h1 : HasDerivAt (fun s : ℝ => f (x + s • w)) (fderiv ℝ f x w) 0 := by
      have hl : HasDerivAt (fun s : ℝ => x + s • w) w 0 := by
        have h0 : HasDerivAt (fun s : ℝ => s • w) ((1:ℝ) • w) 0 :=
          (hasDerivAt_id (0:ℝ)).smul_const w
        simpa using h0.const_add x
      have hd' : HasFDerivAt f (fderiv ℝ f x) (x + (0:ℝ) • w) := by
        simpa using hd.hasFDerivAt
      have := hd'.comp_hasDerivAt (0:ℝ) hl
      simpa [Function.comp_def] using this
    have h2 : HasDerivAt (fun s : ℝ => f (x + s • w)) 0 0 := by
      have : (fun s : ℝ => f (x + s • w)) = fun _ => f x := funext fun s => hf x s
      rw [this]; exact hasDerivAt_const _ _
    exact h1.unique h2
  · simp [fderiv_zero_of_not_differentiableAt hd]

/-- **Proved.** For a planar field, `ω₁ = ω₂ = 0`: the vorticity is parallel to `e₃`. -/
theorem curl_planar (v : E3 → E3) (hv : IsPlanar v) (x : E3) :
    curl v x 0 = 0 ∧ curl v x 1 = 0 := by
  obtain ⟨hinv, h3⟩ := hv
  have hz : ∀ i, pd (fun y => v y i) 2 x = 0 := fun i =>
    fderiv_dir_eq_zero _ _ _ (fun y s => by simp only [hinv y s])
  have h3' : (fun y => v y 2) = fun _ => (0:ℝ) := funext h3
  have hp : ∀ j, pd (fun y => v y 2) j x = 0 := fun j => by
    simp [pd, h3']
  refine ⟨?_, ?_⟩
  · simp [curl, hz, hp]
  · simp [curl, hz, hp]

end Clay.Gaps.TwoDPlanar
