# QED-E035 — Pin down the Schur–Siegel–Smyth trace constant

You are an AI model helping someone attack this open problem. Read all of this before working.

## The problem
Extended set · Grade B- · QED Curated · Number theory

**Plain words:** Take algebraic integers all of whose conjugates are positive real numbers, and look at the average of their conjugates (trace divided by degree). Apart from finitely many exceptions this average cannot be small, and the threshold where infinitely many examples start is a constant lambda. For decades people believed lambda = 2; Smith disproved this, and now lambda is known only to lie between 1.80220 and 1.8216. Narrow this window.

**Math:** Let $\lambda_{\mathrm{SSS}}$ be the smallest limit point of $\{\operatorname{tr}(\alpha)/\deg(\alpha)\}$ over totally positive algebraic integers $\alpha$ (equivalently $\liminf\operatorname{tr}(\alpha)/\deg(\alpha)$ as $\deg\alpha\to\infty$). Known: $1.80220\le\lambda_{\mathrm{SSS}}\le 1.8216$. Improve either bound (ultimately, determine $\lambda_{\mathrm{SSS}}$).

**Reviewer note:** Known: Lower: Schur 1.6487, Siegel 1.7336, Smyth 1.7719, …, Orloski–Talebizadeh Sardari–Smith 1.80203 (arXiv:2401.03252), Niedbala Giraudin 1.80220 (arXiv:2609.29298, Sept 2026, unrefereed, computer-verified certificate). Upper: Smith, 'Algebraic numbers with small trace' (2021) $<1.8984$ (disproving $\lambda=2$); Orloski–Talebizadeh Sardari, 'A quantitative converse of Fekete's theorem', arXiv:2304.10021: $1.8216$.

**Credit:** Schur, Siegel, Smyth; A. Smith; Orloski–Talebizadeh Sardari–Smith; Niedbala Giraudin

**Rests on recent unrefereed work. Check these premises first:**
- lower bound 1.80220 is a single-author Sept 2026 preprint, unrefereed (fall back to 1.80203 if it fails)
- active area: small incremental improvements are likely, so 'improve either bound' is a moving target

**References:**
- https://arxiv.org/abs/2609.29298
- https://arxiv.org/abs/2401.03252
- https://arxiv.org/abs/2304.10021

Difficulty estimate: 5.0/10 (calibrated: Collatz ≈ 5.5, twin primes ≈ 5.0). It is believed open; do not assume a quick answer exists, and say so plainly if you cannot make progress. Never present a heuristic, numerical evidence, or a partial result as a solution.

## What counts as an answer
Either a proof of `OpenProblems.QEDE035.Claim` or a proof of `¬ OpenProblems.QEDE035.Claim` (a disproof), in Lean 4 + Mathlib, using the exact statement in `problems/QED-E035/Statement.lean`. Read its "Formalization notes" first. If that file still says `def Claim : Prop := sorry`, the problem must first be formalized (see CONTRIBUTING.md); a faithful formalization is itself a welcome contribution. What is missing: The constant is expressible with Mathlib (IsIntegral, minpoly, Polynomial.roots), but the problem is open-ended (improve a bound, determine a constant) and has no single yes/no Claim. Any fixed threshold, such as lambda ≤ 1.82, would be arbitrary.

If you think the Lean statement does not match the informal problem (it is trivially true or false, or it says something else), report that in an issue instead of exploiting it: such solutions are not credited.

## How to submit
1. Claim it (optional but encouraged): open an issue titled `Claim QED-E035` at https://github.com/floration/qed/issues/new?template=claim.yml. Comment on it at least once a week or the claim lapses.
2. Add `solutions/QED-E035/<github-username>/Solution.lean`:
```lean
import Mathlib
-- do NOT redefine Claim: CI prepends problems/QED-E035/Statement.lean to your file
theorem solution : OpenProblems.QEDE035.Claim := by   -- or ¬ OpenProblems.QEDE035.Claim
  ...
```
3. Add `solutions/QED-E035/<github-username>/meta.json`: `{"model": "<AI model used, or none>", "kind": "proof" | "disproof"}`. Optionally a `README.md` explaining the idea.
4. Open a pull request. CI checks: it compiles, no `sorry`/`admit`/new `axiom`/`set_option` tricks, and `#print axioms solution` shows only `propext`, `Classical.choice`, `Quot.sound`.

## Scoring
Size = number of non-blank, non-comment lines of `Solution.lean` excluding `import` lines (helper lemmas count). First verified solution is credited permanently; any later, strictly smaller verified solution becomes the "smallest solution".

## Rules for you, the model
- Do not modify `Statement.lean` in a solution PR.
- Be honest about uncertainty; if a step is unproven, leave it out rather than sneak in `sorry`.
- Test locally: `lake exe cache get && lake env lean solutions/QED-E035/<user>/Solution.lean`.
