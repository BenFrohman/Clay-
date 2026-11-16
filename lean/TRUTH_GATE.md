# TRUTH GATE — the GOD gate. Read this first.

Author: Benjamin Stanley Frohman. This file is the root instruction for every person and every
automated agent (every bot) that touches this repository. Load it before any other file.

**Only truth and honest, kernel-proved theorems pass this gate. Nothing from this repository is
published, released, deposited on Zenodo, cited or claimed unless the `truth-gate` check is green
on the exact commit being cited.** That is why it is the GOD gate: it sits above every other
check, and no other green check can stand in for it.

## The issue this gate fixes

A paper states its claim in English. Lean can only prove `formal_claim ↔ paper_claim` once
`paper_claim` is itself written in Lean. If `paper_claim` were simply *defined to be*
`formal_claim` (or an alias of it, or something that unfolds to it), the theorem
`intended_correspondence` would be `Iff.rfl`: it would be empty and prove nothing about the
paper. A green certificate could then "certify" a statement different from the one the paper
makes (drift), whether by accident or by an injected instruction.

## The fix rule (binding, permanent)

1. `paper_claim` is an **independent Lean transcription of the paper's exact claim**, written in
   the paper's own terms, with every hypothesis the paper states. The verbatim English quote,
   the paper path, its sha256 and the section are recorded in the doc comment of
   `Semantics.lean` **and** in this file (below).
2. `paper_claim` must **not** be defined as, reference, or trivially alias `formal_claim`.
3. `intended_correspondence : formal_claim ↔ paper_claim` must have a **substantive proof**. It
   may not be `Iff.rfl`, `rfl`, `exact Iff.rfl` or similar, and it may not use the main theorem
   (it is a statement-level equivalence, not "both sides happen to be provable").
4. `formal_claim` is exactly the statement of the repository's main theorem, and
   `paper_claim_holds` is the main theorem transported across the correspondence.
5. Only `propext`, `Classical.choice` and `Quot.sound`. No `sorry`, `admit`, `native_decide` or
   new `axiom` anywhere outside the draft directories in `TRUTH_GATE.lock`.
6. If the paper's English claim cannot be faithfully transcribed, or is not what Lean proves,
   the gate stays **red** and the mismatch is reported. Never patch over it: never weaken
   `paper_claim`, drop a hypothesis, or redefine it to match the formal side. If the
   formalization drifted, rewrite the formalization so it transports across the lock again.
7. Open problems stay hypotheses. No Millennium Prize problem is claimed solved; the gate only
   ensures the certificate proves precisely the locked claim and nothing else.
8. The locked region of `Semantics.lean`, the quote and `TRUTH_GATE.lock` change only with the
   author's explicit sign-off, as a PR that says "new lock" in its title.
9. Commits are authored by Benjamin Stanley Frohman only, with no AI co-author trailers. No
   force-push and no history rewriting.

## What `scripts/verify-lock.sh` checks mechanically

* `lake build` succeeds, with no `sorry` warning outside the draft directories;
* no `sorry` / `admit` / `native_decide` / `axiom` token outside the draft directories
  (comments and strings excluded);
* `Semantics.lean` has `PAPER_PATH`, `PAPER_SHA256`, `PAPER_SECTION` and a verbatim
  `PAPER_QUOTE`; the hash matches the paper file and the quote occurs in it; this file carries
  the same path, hash and quote;
* the lock region hash matches `TRUTH_GATE.lock`;
* `paper_claim`'s body does not mention `formal_claim`; the correspondence is not proved by
  `Iff.rfl`/`rfl`;
* in Lean: the bodies of `formal_claim` and `paper_claim` differ, the two are not
  definitionally equal, the correspondence proof does not reach the main theorem, the main
  theorem's statement is `formal_claim`, `paper_claim_holds` goes through the correspondence,
  and `#print axioms` shows only the three standard axioms.

What it cannot check: whether the transcription is the right reading of the English. That
reading is fixed once, in writing, below and in `Semantics.lean`, and is the author's sign-off.

## Running the gate locally

```
lake exe cache get
bash scripts/verify-lock.sh
```

Reports are written to `truth-gate-report/`.

## The locked claim of this repository

* Paper: `../paper/Clay_Technical_Monograph_2026.tex`
* sha256: `b6c6fe6a0715d1db63848211bd076199112cd100ac49d4d221e36c7d46d798b0`
* Section: Section "Statement (B)" and Section "The proved reduction" (theorem feffermanStatementB_of_bkm, the two hypotheses as defined in prose, and the scope sentence)
* Main theorem(s): `Clay.StatementB.feffermanStatementB_of_bkm`
* Lock file: `TRUTH_GATE.lock`; semantics: `Clay/Semantics.lean`

Verbatim quote:

```
Following the official problem description of Fefferman~\cite{Fef}, fix $\nu>0$ and let $u^\circ$ be a smooth, divergence-free vector field on $\mathbb{R}^3$ with $u^\circ(x+e_j)=u^\circ(x)$ for $j=1,2,3$. Take $f\equiv 0$.

\begin{quote}
\textbf{Statement (B).} There exist smooth functions $p(x,t)$, $u_i(x,t)$ on $\mathbb{R}^3\times[0,\infty)$ such that
\[
\partial_t u_i+\sum_{j=1}^3 u_j\,\partial_j u_i = \nu\,\Delta u_i-\partial_i p,\qquad \operatorname{div}u=0,\qquad u(x,0)=u^\circ(x),
\]
and $u$, $p$ are $1$-periodic in each spatial coordinate.
\end{quote}

Write $\omega=\operatorname{curl}u$. Consider the propositions

  \item \lean{PeriodicMaximalSolutionWithBKM} (classical; Kato, Fujita--Kato, Beale--Kato--Majda~\cite{BKM}; not yet formalized): for all admissible data there are $T^\ast\in(0,\infty]$ and a smooth solution on $[0,T^\ast)$ such that $T^\ast<\infty$ implies $\int_0^{T^\ast}\|\omega(t)\|_{L^\infty}\,dt=\infty$;
  \item \lean{PeriodicBKMIntegrability} (\textbf{open}; the Clay core): every smooth solution on a finite interval $[0,T)$ satisfies $\int_0^{T}\|\omega(t)\|_{L^\infty}\,dt<\infty$.

\lean{PeriodicMaximalSolutionWithBKM} and \lean{PeriodicBKMIntegrability} together imply Statement~(B).

The second hypothesis of the first theorem is open and is equivalent in strength to Statement~(B) itself. Consequently the reduction does not prove Statement~(B).
```

```lean
def formal_claim : Prop :=
  Clay.StatementB.PeriodicMaximalSolutionWithBKM → Clay.StatementB.PeriodicBKMIntegrability →
    Clay.StatementB.FeffermanStatementB

def paper_claim : Prop :=
  (∀ ν : ℝ, 0 < ν → ∀ u0, pData u0 →
      ∃ Tstar : ℝ≥0∞, 0 < Tstar ∧ ∃ u p,
        pSolution ν {t : ℝ | 0 ≤ t ∧ ENNReal.ofReal t < Tstar} u0 u p ∧
        (Tstar < ⊤ → ∫⁻ t in {t : ℝ | 0 ≤ t ∧ ENNReal.ofReal t < Tstar}, pVortSup u t = ⊤)) →
  (∀ ν : ℝ, 0 < ν → ∀ u0 u p (T : ℝ), pData u0 → pSolution ν (Ico 0 T) u0 u p →
      ∫⁻ t in Ico 0 T, pVortSup u t < ⊤) →
  ∀ ν : ℝ, 0 < ν → ∀ u0, pData u0 → ∃ u p, pSolution ν (Ici 0) u0 u p
```

See the doc comment of `Clay/Semantics.lean` for the fixed reading of the paper's terms and the scope.
