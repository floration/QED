import Mathlib
/-! QED-E035: Pin down the Schur–Siegel–Smyth trace constant
Take algebraic integers all of whose conjugates are positive real numbers, and look at the average of their conjugates (trace divided by degree). Apart from finitely many exceptions this average cannot be small, and the threshold where infinitely many examples start is a constant lambda. For decades people believed lambda = 2; Smith disproved this, and now lambda is known only to lie between 1.80220 and 1.8216. Narrow this window.
Informal statement: Let $\lambda_{\mathrm{SSS}}$ be the smallest limit point of
$\{\operatorname{tr}(\alpha)/\deg(\alpha)\}$ over totally positive algebraic integers $\alpha$
(equivalently $\liminf\operatorname{tr}(\alpha)/\deg(\alpha)$ as $\deg\alpha\to\infty$). Known:
$1.80220\le\lambda_{\mathrm{SSS}}\le 1.8216$; the lower bound is stated non-strictly
("λ_SSS ≥ 1.80220", arXiv:2609.29298, unrefereed; previous refereed-track bound 1.80203 by
Orloski–Sardari–Smith). Formal target (strict improvement of the LOWER bound): prove
$\lambda_{\mathrm{SSS}} > 1.80220$.
Formalization notes:
* Totally positive algebraic integers up to conjugacy ↔ their minimal polynomials: monic
  polynomials `P ∈ ℤ[X]` that are irreducible (over ℤ, equivalently over ℚ by Gauss's lemma for
  monic polynomials) and all of whose complex roots are real and positive. For such `P` of degree
  d, tr(α)/deg(α) = (sum of the d complex roots)/d; `mean P` computes this from the multiset of
  complex roots of `P` (which has exactly d elements since ℂ is algebraically closed; roots are
  simple by irreducibility/separability). Conjugate α's have the same ratio, so working with
  minimal polynomials loses nothing.
* For each degree and each bound on the trace there are only finitely many such `P` (all roots
  lie in (0, trace]), so "the ratio is < t for infinitely many α (up to conjugacy)" is the same
  as "for α of arbitrarily large degree". Hence λ_SSS = liminf ratio satisfies
  λ_SSS > L  ⇔  ∃ t > L such that only finitely many admissible `P` have `mean P < t`.
  `Claim` states the right-hand side with L = 1.80220.
* Proving `Claim` = λ_SSS > 1.80220 (strictly beating the 2026 bound). Proving `¬Claim` =
  λ_SSS ≤ 1.80220, which together with the 2026 bound means λ_SSS = 1.80220 exactly (if that
  bound is correct; if it fails, ¬Claim just says λ_SSS ≤ 1.80220).
-/
namespace OpenProblems.QEDE035
noncomputable section
open Polynomial

/-- `P` is the minimal polynomial of a totally positive algebraic integer. -/
def IsTotPosMinpoly (P : ℤ[X]) : Prop :=
  P.Monic ∧ Irreducible P ∧
    ∀ z ∈ (P.map (Int.castRingHom ℂ)).roots, z.im = 0 ∧ 0 < z.re

/-- Trace over degree: the average of the (complex) roots of `P`. -/
def mean (P : ℤ[X]) : ℝ :=
  (((P.map (Int.castRingHom ℂ)).roots.map Complex.re).sum) / (P.natDegree : ℝ)

/-- `λ_SSS > 1.80220`. -/
def Claim : Prop :=
  ∃ t : ℝ, (180220 / 100000 : ℝ) < t ∧
    {P : ℤ[X] | IsTotPosMinpoly P ∧ mean P < t}.Finite

end
end OpenProblems.QEDE035
