# QED-M040 — Optimal dimension dependence in the smoothed complexity of the simplex method

You are an AI model helping someone attack this open problem. Read all of this before working.

## The problem
Main set · Grade B · QED Curated · Complexity

**Plain words:** Bach and Huiberts (2025) found a simplex method with smoothed complexity O(σ^{-1/2} d^{11/4} log^{7/4} n) pivots and showed σ^{-1/2} is optimal. In the dimension d, the best lower bound is only about d^{1/2}. Close the gap in d.

**Math:** Model: rows (ā_i, b̄_i) ∈ ℝ^{d+1}, i ≤ n, of Euclidean norm ≤ 1, each perturbed by independent N(0, σ² I), giving P = {x : ⟨a_i,x⟩ ≤ b_i}. Let diam(P) be the combinatorial diameter of its vertex-edge graph. Known (Bach–Huiberts): E[diam] = Ω(σ^{-1/2} d^{1/2} (ln 4/σ)^{-1/4}) at n = ⌊(4/σ)^d⌋, and a simplex method with O(σ^{-1/2} d^{11/4} log^{7/4} n) pivots exists. Claim: there are b > 1/2, c > 0 and K such that for all large d and all 0 < σ ≤ 1/d, some n ≤ (4/σ)^{Kd} and some unperturbed rows of norm ≤ 1 give E[diam(P)] ≥ c σ^{-1/2} d^b (log 4/σ)^{-K}. (The companion algorithmic question, whether a polynomial-time-per-pivot rule with Phase I achieves O(σ^{-1/2} d^a (log n)^{O(1)}) for some a < 11/4, has no canonical formal model and is not part of Claim.)

**Credit:** Bach, Huiberts, Optimal smoothed analysis of the simplex method, arXiv:2504.04197 (2025; v2 May 2026).

**Rests on recent unrefereed work. Check these premises first:**
- arXiv:2504.04197 (Bach-Huiberts; v2 May 2026, refereed status not verified): source of both the upper bound σ^{-1/2} d^{11/4} log^{7/4} n and the diameter lower bound.

**References:**
- https://arxiv.org/abs/2504.04197
- https://arxiv.org/abs/2211.11860
- arXiv:2504.04197
- arXiv:2211.11860
- arXiv:2510.21613

Difficulty estimate: 4.5/10 (anchored scale: 1 ≈ Erdős–Ginzburg–Ziv, 2.5 ≈ the sensitivity conjecture, 5 ≈ bounded prime gaps, 7.5 ≈ the Riemann Hypothesis, 10 ≈ P vs NP). It is believed open; do not assume a quick answer exists, and say so plainly if you cannot make progress. Never present a heuristic, numerical evidence, or a partial result as a solution.

## What counts as an answer
Either a proof of `OpenProblems.QEDM040.Claim` or a proof of `¬ OpenProblems.QEDM040.Claim` (a disproof), in Lean 4 + Mathlib, using the exact statement in `problems/QED-M040/Statement.lean`. Read its "Formalization notes" first. If that file still says `def Claim : Prop := sorry`, the problem must first be formalized (see CONTRIBUTING.md); a faithful formalization is itself a welcome contribution.

If you think the Lean statement does not match the informal problem (it is trivially true or false, or it says something else), report that in an issue instead of exploiting it: such solutions are not credited.

## How to submit
0. First time? Solve a test problem (QED-Q1, the 2-line one, at minimum) and submit it, to confirm your Lean setup and the submission pipeline work before spending effort here. Skip this step if this IS a test problem.
1. Claim it (optional but encouraged): open an issue titled `Claim QED-M040` at https://github.com/floration/qed/issues/new?template=claim.yml. Comment on it at least once a week or the claim lapses.
2. Add `solutions/QED-M040/<github-username>/Solution.lean`:
```lean
import Mathlib
-- do NOT redefine Claim: CI prepends problems/QED-M040/Statement.lean to your file
theorem solution : OpenProblems.QEDM040.Claim := by   -- or ¬ OpenProblems.QEDM040.Claim
  ...
```
   Large proofs may add more `.lean` files (subfolders allowed) next to Solution.lean; CI concatenates them in path order before Solution.lean. Don't import them.
3. Add `solutions/QED-M040/<github-username>/meta.json`: `{"model": "<AI model used, or none>", "kind": "proof" | "disproof"}`. Optionally a `README.md` explaining the idea.
4. Open a pull request. CI checks: it compiles, no `sorry`/`admit`/new `axiom`/`set_option` tricks, and `#print axioms solution` shows only `propext`, `Classical.choice`, `Quot.sound`.

## Scoring
Size = number of non-blank, non-comment lines of `Solution.lean` excluding `import` lines (helper lemmas count). First verified solution is credited permanently; any later, strictly smaller verified solution becomes the "smallest solution".

## Rules for you, the model
- Do not modify `Statement.lean` in a solution PR.
- Be honest about uncertainty; if a step is unproven, leave it out rather than sneak in `sorry`.
- Test locally: `lake exe cache get && lake env lean solutions/QED-M040/<user>/Solution.lean`.
