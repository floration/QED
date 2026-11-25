# QED-E186 — Are the real multilinear Bohnenblust–Hille constants bounded?

You are an AI model helping someone attack this open problem. Read all of this before working.

## The problem
Extended set · Grade B · QED Curated · Analysis

**Plain words:** Take an m-linear form T on n-dimensional real space with the max norm, and look at its coefficients T(e_{j1},...,e_{jm}). The Bohnenblust–Hille inequality says that the l^{2m/(m+1)}-norm of these coefficients is at most B_m times the supremum of |T| over the unit cube, with B_m not depending on n. For m=2 the best constant is sqrt 2 (Littlewood's 4/3 inequality). Do the best constants B_m stay bounded as m grows, as conjectured (B_m = 2^{1-1/m}, tending to 2), or do they go to infinity?

**Math:** For real $m$-linear $T:(\mathbb R^n)^m\to\mathbb R$ let $\|T\|=\sup\{|T(x^{(1)},\dots,x^{(m)})|:\|x^{(i)}\|_\infty\le1\}$ and let $B_{\mathbb R,m}=\sup_{n\ge1}\sup_{T\ne0}\big(\sum_{j\in[n]^m}|T(e_{j_1},\dots,e_{j_m})|^{\frac{2m}{m+1}}\big)^{\frac{m+1}{2m}}/\|T\|$. Prove or disprove: $\sup_{m\ge1}B_{\mathbb R,m}<\infty$. (Known: $2^{1-1/m}\le B_{\mathbb R,m}<1.3\,m^{0.365}$ for $m\ge14$; conjecturally $B_{\mathbb R,m}=2^{1-1/m}$.)

**Credit:** Bohnenblust–Hille (1931); boundedness/universality question Pellegrino–Teixeira (2016), Diniz et al. (2014).

**Rests on recent unrefereed work. Check these premises first:**
- Appears on Tao's optimization-constants list (26b), so the problem is known; it is not actively moving there
- Real and complex constants differ; this candidate is for real scalars

**References:**
- https://teorth.github.io/optimizationproblems/constants/26b.html
- https://arxiv.org/abs/1604.07595
- https://arxiv.org/pdf/1111.3253
- https://arxiv.org/pdf/1712.03263

Difficulty estimate: 5.5/10 (anchored scale: 1 ≈ Erdős–Ginzburg–Ziv, 2.5 ≈ the sensitivity conjecture, 5 ≈ bounded prime gaps, 7.5 ≈ the Riemann Hypothesis, 10 ≈ P vs NP). It is believed open; do not assume a quick answer exists, and say so plainly if you cannot make progress. Never present a heuristic, numerical evidence, or a partial result as a solution.

## What counts as an answer
Either a proof of `OpenProblems.QEDE186.Claim` or a proof of `¬ OpenProblems.QEDE186.Claim` (a disproof), in Lean 4 + Mathlib, using the exact statement in `problems/QED-E186/Statement.lean`. Read its "Formalization notes" first. If that file still says `def Claim : Prop := sorry`, the problem must first be formalized (see CONTRIBUTING.md); a faithful formalization is itself a welcome contribution.

If you think the Lean statement does not match the informal problem (it is trivially true or false, or it says something else), report that in an issue instead of exploiting it: such solutions are not credited.

## How to submit
0. First time? Solve a test problem (QED-Q1, the 2-line one, at minimum) and submit it, to confirm your Lean setup and the submission pipeline work before spending effort here. Skip this step if this IS a test problem.
1. Claim it (optional but encouraged): open an issue titled `Claim QED-E186` at https://github.com/floration/qed/issues/new?template=claim.yml. Comment on it at least once a week or the claim lapses.
2. Add `solutions/QED-E186/<github-username>/Solution.lean`:
```lean
import Mathlib
-- do NOT redefine Claim: CI prepends problems/QED-E186/Statement.lean to your file
theorem solution : OpenProblems.QEDE186.Claim := by   -- or ¬ OpenProblems.QEDE186.Claim
  ...
```
   Large proofs may add more `.lean` files (subfolders allowed) next to Solution.lean; CI concatenates them in path order before Solution.lean. Don't import them.
3. Add `solutions/QED-E186/<github-username>/meta.json`: `{"model": "<AI model used, or none>", "kind": "proof" | "disproof"}`. Optionally a `README.md` explaining the idea.
4. Open a pull request. CI checks: it compiles, no `sorry`/`admit`/new `axiom`/`set_option` tricks, and `#print axioms solution` shows only `propext`, `Classical.choice`, `Quot.sound`.

## Scoring
Size = number of non-blank, non-comment lines of `Solution.lean` excluding `import` lines (helper lemmas count). First verified solution is credited permanently; any later, strictly smaller verified solution becomes the "smallest solution".

## Rules for you, the model
- Do not modify `Statement.lean` in a solution PR.
- Be honest about uncertainty; if a step is unproven, leave it out rather than sneak in `sorry`.
- Test locally: `lake exe cache get && lake env lean solutions/QED-E186/<user>/Solution.lean`.
