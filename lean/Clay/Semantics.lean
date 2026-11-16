/-
Copyright (c) 2026 Benjamin Stanley Frohman. All rights reserved.
Released under Apache 2.0 license as described in the file LICENSE.
Authors: Benjamin Stanley Frohman
-/

import Clay.StatementB

/-!
# Truth Gate: semantics lock (see `TRUTH_GATE.md`)

PAPER_PATH: ../paper/Clay_Technical_Monograph_2026.tex
PAPER_SECTION: Section "Statement (B)" and Section "The proved reduction" (theorem feffermanStatementB_of_bkm, the two hypotheses as defined in prose, and the scope sentence)
PAPER_SHA256: b6c6fe6a0715d1db63848211bd076199112cd100ac49d4d221e36c7d46d798b0

Locked paper claim, quoted verbatim (Statement (B), the prose definitions of the two hypotheses,
the reduction theorem, and its scope):

PAPER_QUOTE_BEGIN
Following the official problem description of Fefferman~\cite{Fef}, fix $\nu>0$ and let $u^\circ$ be a smooth, divergence-free vector field on $\mathbb{R}^3$ with $u^\circ(x+e_j)=u^\circ(x)$ for $j=1,2,3$. Take $f\equiv 0$.

\begin{quote}
\textbf{Statement (B).} There exist smooth functions $p(x,t)$, $u_i(x,t)$ on $\mathbb{R}^3\times[0,\infty)$ such that
\[
\partial_t u_i+\sum_{j=1}^3 u_j\,\partial_j u_i = \nu\,\Delta u_i-\partial_i p,\qquad \operatorname{div}u=0,\qquad u(x,0)=u^\circ(x),
\]
and $u$, $p$ are $1$-periodic in each spatial coordinate.
\end{quote}
PAPER_QUOTE_END

PAPER_QUOTE_BEGIN
Write $\omega=\operatorname{curl}u$. Consider the propositions
PAPER_QUOTE_END

PAPER_QUOTE_BEGIN
  \item \lean{PeriodicMaximalSolutionWithBKM} (classical; Kato, Fujita--Kato, Beale--Kato--Majda~\cite{BKM}; not yet formalized): for all admissible data there are $T^\ast\in(0,\infty]$ and a smooth solution on $[0,T^\ast)$ such that $T^\ast<\infty$ implies $\int_0^{T^\ast}\|\omega(t)\|_{L^\infty}\,dt=\infty$;
  \item \lean{PeriodicBKMIntegrability} (\textbf{open}; the Clay core): every smooth solution on a finite interval $[0,T)$ satisfies $\int_0^{T}\|\omega(t)\|_{L^\infty}\,dt<\infty$.
PAPER_QUOTE_END

PAPER_QUOTE_BEGIN
\lean{PeriodicMaximalSolutionWithBKM} and \lean{PeriodicBKMIntegrability} together imply Statement~(B).
PAPER_QUOTE_END

PAPER_QUOTE_BEGIN
The second hypothesis of the first theorem is open and is equivalent in strength to Statement~(B) itself. Consequently the reduction does not prove Statement~(B).
PAPER_QUOTE_END

Reading of the paper's terms (transcribed from the paper's English, not from the repository):
* space is `ℝ³ = EuclideanSpace ℝ (Fin 3)`; `∂ⱼ` is the Fréchet derivative along the standard
  basis vector `eⱼ = EuclideanSpace.single j 1`; `Δ = Σⱼ ∂ⱼ∂ⱼ`; `∂ₜ` on a time set `S` is the
  derivative within `S`; "smooth" is `C^∞` (`ContDiffOn ℝ ∞` on `S × ℝ³`, `∞` the `C^∞` index);
* "admissible data" (Section "Statement (B)"): `u°` is `C^∞`, divergence free, and
  `u°(x + eⱼ) = u°(x)`;
* "a smooth solution on `S` with data `u°`": `(u, p)` smooth on `S × ℝ³`, the momentum equation
  `∂ₜuᵢ + Σⱼ uⱼ ∂ⱼuᵢ = ν Δuᵢ - ∂ᵢp` and `div u = 0` for `t ∈ S`, `u(x,0) = u°(x)`, and `u`, `p`
  `1`-periodic in each coordinate for `t ∈ S` (`f ≡ 0`);
* `ω = curl u`; `‖ω(t)‖_{L^∞}` is read as the supremum `sup_x |ω(t,x)|` in `[0,∞]` (the solution
  is continuous, so this is the `L^∞` norm); `∫_0^{T}` is the Lebesgue integral in `[0,∞]` over
  `[0,T)`;
* first hypothesis: for every `ν > 0` and admissible `u°` there are `T* ∈ (0,∞]` and a smooth
  solution on `[0,T*)` with `T* < ∞ → ∫_0^{T*} ‖ω(t)‖_{L^∞} dt = ∞`;
* second hypothesis: for every `ν > 0`, admissible `u°`, real `T` and smooth solution on the
  finite interval `[0,T)`, `∫_0^T ‖ω(t)‖_{L^∞} dt < ∞`;
* conclusion: Statement (B) for every `ν > 0` and admissible `u°`, on `[0,∞) × ℝ³`.

`formal_claim` is the statement of `Clay.StatementB.feffermanStatementB_of_bkm`. `paper_claim`
spells out both hypotheses and Statement (B) with its own definitions (`pPart`, `pData`,
`pSolution`, `pVortSup`), takes the finite interval as `Set.Ico 0 T` for a real `T` (the
repository uses `T : ℝ≥0∞`, `T ≠ ⊤`), states the blow-up alternative with `T* < ⊤` and `= ⊤`,
and writes periodicity coordinatewise. The correspondence proves these readings agree.

Scope: CONDITIONAL on both hypotheses. The second one (`PeriodicBKMIntegrability`) is OPEN and
is equivalent in strength to Statement (B); the first is classical but not formalized here.
Nothing here proves Statement (B); the Clay Millennium problem remains open.
-/

noncomputable section

namespace TruthGate

open MeasureTheory Set
open scoped ENNReal ContDiff

-- TRUTH-GATE LOCK BEGIN
/-- The repository's statement (`feffermanStatementB_of_bkm`). -/
def formal_claim : Prop :=
  Clay.StatementB.PeriodicMaximalSolutionWithBKM → Clay.StatementB.PeriodicBKMIntegrability →
    Clay.StatementB.FeffermanStatementB

/-- Paper: `∂ⱼ f`, the Fréchet derivative along the standard basis vector `eⱼ`. -/
def pPart (f : EuclideanSpace ℝ (Fin 3) → ℝ) (j : Fin 3) (x : EuclideanSpace ℝ (Fin 3)) : ℝ :=
  fderiv ℝ f x (EuclideanSpace.single j 1)

/-- Paper: admissible data, smooth, divergence free, `u°(x + eⱼ) = u°(x)`. -/
def pData (u0 : EuclideanSpace ℝ (Fin 3) → EuclideanSpace ℝ (Fin 3)) : Prop :=
  ContDiff ℝ ∞ u0 ∧ (∀ x, ∑ i : Fin 3, pPart (fun y => u0 y i) i x = 0) ∧
    ∀ x (j : Fin 3), u0 (x + EuclideanSpace.single j 1) = u0 x

/-- Paper: `(u,p)` is a smooth periodic solution on the time set `S` with data `u°`. -/
def pSolution (ν : ℝ) (S : Set ℝ) (u0 : EuclideanSpace ℝ (Fin 3) → EuclideanSpace ℝ (Fin 3))
    (u : ℝ → EuclideanSpace ℝ (Fin 3) → EuclideanSpace ℝ (Fin 3))
    (p : ℝ → EuclideanSpace ℝ (Fin 3) → ℝ) : Prop :=
  ContDiffOn ℝ ∞ (fun z : ℝ × EuclideanSpace ℝ (Fin 3) => u z.1 z.2) (S ×ˢ univ) ∧
  ContDiffOn ℝ ∞ (fun z : ℝ × EuclideanSpace ℝ (Fin 3) => p z.1 z.2) (S ×ˢ univ) ∧
  (∀ t ∈ S, ∀ x (i : Fin 3),
      derivWithin (fun s => u s x i) S t + ∑ j : Fin 3, u t x j * pPart (fun y => u t y i) j x
        = ν * ∑ j : Fin 3, pPart (pPart (fun y => u t y i) j) j x - pPart (p t) i x) ∧
  (∀ t ∈ S, ∀ x, ∑ i : Fin 3, pPart (fun y => u t y i) i x = 0) ∧
  (∀ x, u 0 x = u0 x) ∧
  (∀ t ∈ S, ∀ x (j : Fin 3),
      u t (x + EuclideanSpace.single j 1) = u t x ∧ p t (x + EuclideanSpace.single j 1) = p t x)

/-- Paper: `‖ω(t)‖_{L^∞} = sup_x |curl u(t,x)|` in `[0,∞]`. -/
def pVortSup (u : ℝ → EuclideanSpace ℝ (Fin 3) → EuclideanSpace ℝ (Fin 3)) (t : ℝ) : ℝ≥0∞ :=
  ⨆ x, (‖(WithLp.equiv 2 (Fin 3 → ℝ)).symm
      ![pPart (fun y => u t y 2) 1 x - pPart (fun y => u t y 1) 2 x,
        pPart (fun y => u t y 0) 2 x - pPart (fun y => u t y 2) 0 x,
        pPart (fun y => u t y 1) 0 x - pPart (fun y => u t y 0) 1 x]‖₊ : ℝ≥0∞)

/-- Paper: the two hypotheses together imply Statement (B). -/
def paper_claim : Prop :=
  (∀ ν : ℝ, 0 < ν → ∀ u0, pData u0 →
      ∃ Tstar : ℝ≥0∞, 0 < Tstar ∧ ∃ u p,
        pSolution ν {t : ℝ | 0 ≤ t ∧ ENNReal.ofReal t < Tstar} u0 u p ∧
        (Tstar < ⊤ → ∫⁻ t in {t : ℝ | 0 ≤ t ∧ ENNReal.ofReal t < Tstar}, pVortSup u t = ⊤)) →
  (∀ ν : ℝ, 0 < ν → ∀ u0 u p (T : ℝ), pData u0 → pSolution ν (Ico 0 T) u0 u p →
      ∫⁻ t in Ico 0 T, pVortSup u t < ⊤) →
  ∀ ν : ℝ, 0 < ν → ∀ u0, pData u0 → ∃ u p, pSolution ν (Ici 0) u0 u p

theorem sol_iff (ν : ℝ) (S : Set ℝ) (u0 : EuclideanSpace ℝ (Fin 3) → EuclideanSpace ℝ (Fin 3))
    (u : ℝ → EuclideanSpace ℝ (Fin 3) → EuclideanSpace ℝ (Fin 3))
    (p : ℝ → EuclideanSpace ℝ (Fin 3) → ℝ) :
    Clay.StatementB.NSOn ν S u0 u p ↔ pSolution ν S u0 u p := by
  constructor
  · rintro ⟨h1, h2, h3, h4, h5, h6⟩
    exact ⟨h1, h2, h3, h4, h5, fun t ht x j => ⟨(h6 t ht).1 x j, (h6 t ht).2 x j⟩⟩
  · rintro ⟨h1, h2, h3, h4, h5, h6⟩
    exact ⟨h1, h2, h3, h4, h5,
      fun t ht => ⟨fun x j => (h6 t ht x j).1, fun x j => (h6 t ht x j).2⟩⟩

theorem data_iff (u0 : EuclideanSpace ℝ (Fin 3) → EuclideanSpace ℝ (Fin 3)) :
    Clay.StatementB.SmoothPeriodicData u0 ↔ pData u0 := by
  constructor
  · rintro ⟨h1, h2, h3⟩
    exact ⟨h1, h2, h3⟩
  · rintro ⟨h1, h2, h3⟩
    exact ⟨h1, h2, h3⟩

theorem interval_toReal (T : ℝ≥0∞) (hT : T ≠ ⊤) :
    {t : ℝ | 0 ≤ t ∧ ENNReal.ofReal t < T} = Ico 0 T.toReal := by
  ext t
  constructor
  · rintro ⟨h0, h⟩
    exact ⟨h0, (ENNReal.ofReal_lt_iff_lt_toReal h0 hT).1 h⟩
  · rintro ⟨h0, h⟩
    exact ⟨h0, (ENNReal.ofReal_lt_iff_lt_toReal h0 hT).2 h⟩

theorem interval_ofReal (T : ℝ) :
    {t : ℝ | 0 ≤ t ∧ ENNReal.ofReal t < ENNReal.ofReal T} = Ico 0 T := by
  ext t
  constructor
  · rintro ⟨h0, h⟩
    exact ⟨h0, (ENNReal.ofReal_lt_ofReal_iff_of_nonneg h0).1 h⟩
  · rintro ⟨h0, h⟩
    exact ⟨h0, (ENNReal.ofReal_lt_ofReal_iff_of_nonneg h0).2 h⟩

/-- The fixed correspondence between the formal statement and the paper's claim. -/
theorem intended_correspondence : formal_claim ↔ paper_claim := by
  constructor
  · intro h hmax hint ν hν u0 hd
    have hloc : Clay.StatementB.PeriodicMaximalSolutionWithBKM := by
      intro ν hν u0 hd
      obtain ⟨T, hT, u, p, hs, hb⟩ := hmax ν hν u0 ((data_iff u0).1 hd)
      refine ⟨T, hT, u, p, (sol_iff ν _ u0 u p).2 hs, fun hne hfin => ?_⟩
      have h1 : (∫⁻ t in {t : ℝ | 0 ≤ t ∧ ENNReal.ofReal t < T}, pVortSup u t) < ⊤ := hfin
      rw [hb (lt_top_iff_ne_top.2 hne)] at h1
      exact lt_irrefl _ h1
    have hbkm : Clay.StatementB.PeriodicBKMIntegrability := by
      intro ν hν u0 u p T hd hT hs
      have hset : Clay.StatementB.lifespanSet T = Ico 0 T.toReal := interval_toReal T hT
      have hs' : Clay.StatementB.NSOn ν (Ico 0 T.toReal) u0 u p := by
        rw [← hset]
        exact hs
      have h1 := hint ν hν u0 u p T.toReal ((data_iff u0).1 hd) ((sol_iff ν _ u0 u p).1 hs')
      show (∫⁻ t in Clay.StatementB.lifespanSet T, Clay.StatementB.vortSup u t) < ⊤
      rw [hset]
      exact h1
    obtain ⟨u, p, hs⟩ := h hloc hbkm ν hν u0 ((data_iff u0).2 hd)
    exact ⟨u, p, (sol_iff ν _ u0 u p).1 hs⟩
  · intro h hloc hbkm ν hν u0 hd
    have hmax : ∀ ν : ℝ, 0 < ν → ∀ u0, pData u0 →
        ∃ Tstar : ℝ≥0∞, 0 < Tstar ∧ ∃ u p,
          pSolution ν {t : ℝ | 0 ≤ t ∧ ENNReal.ofReal t < Tstar} u0 u p ∧
          (Tstar < ⊤ →
            ∫⁻ t in {t : ℝ | 0 ≤ t ∧ ENNReal.ofReal t < Tstar}, pVortSup u t = ⊤) := by
      intro ν hν u0 hd
      obtain ⟨T, hT, u, p, hs, hb⟩ := hloc ν hν u0 ((data_iff u0).2 hd)
      refine ⟨T, hT, u, p, (sol_iff ν _ u0 u p).1 hs, fun hlt => ?_⟩
      have h1 := hb (lt_top_iff_ne_top.1 hlt)
      unfold Clay.StatementB.BKMIntegralFinite at h1
      exact not_lt_top_iff.1 h1
    have hint : ∀ ν : ℝ, 0 < ν → ∀ u0 u p (T : ℝ), pData u0 → pSolution ν (Ico 0 T) u0 u p →
        ∫⁻ t in Ico 0 T, pVortSup u t < ⊤ := by
      intro ν hν u0 u p T hd hs
      have hset : Clay.StatementB.lifespanSet (ENNReal.ofReal T) = Ico 0 T := interval_ofReal T
      have hs' : Clay.StatementB.NSOn ν (Clay.StatementB.lifespanSet (ENNReal.ofReal T)) u0 u p := by
        rw [hset]
        exact (sol_iff ν _ u0 u p).2 hs
      have h1 := hbkm ν hν u0 u p (ENNReal.ofReal T) ((data_iff u0).2 hd) ENNReal.ofReal_ne_top hs'
      have heq : (∫⁻ t in Ico 0 T, pVortSup u t) =
          ∫⁻ t in Clay.StatementB.lifespanSet (ENNReal.ofReal T), Clay.StatementB.vortSup u t := by
        rw [hset]
        rfl
      rw [heq]
      exact h1
    obtain ⟨u, p, hs⟩ := h hmax hint ν hν u0 ((data_iff u0).1 hd)
    exact ⟨u, p, (sol_iff ν _ u0 u p).2 hs⟩
-- TRUTH-GATE LOCK END

/-- The repository's theorem proves `formal_claim`. -/
theorem formal_claim_holds : formal_claim := by
  intro hloc hbkm
  exact Clay.StatementB.feffermanStatementB_of_bkm hloc hbkm

/-- The paper's claim, transported across the correspondence. -/
theorem paper_claim_holds : paper_claim :=
  intended_correspondence.mp formal_claim_holds

end TruthGate
