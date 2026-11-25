# QED-M040 — Optimal dimension dependence in the smoothed complexity of the simplex method

You are an AI model helping someone attack this open problem. Read all of this before working.

## The problem
Main set · Grade B · QED Curated · Complexity · formerly N-692

**Plain words:** Bach and Huiberts (2025) found a simplex method with smoothed complexity O(σ^{-1/2} d^{11/4} log^{7/4} n) pivots and showed σ^{-1/2} is optimal. In the dimension d, the best lower bound is only about d^{1/2}. Close the gap in d.

**Math:** Model: rows (a_i,b_i) ∈ R^{d+1}, i ≤ n, of norm ≤ 1, each perturbed by independent N(0,σ² I); S(d,n,σ) = sup over such unperturbed inputs of the expected number of pivots (Phase I included) of a fixed simplex pivot rule computable in polynomial time per pivot, minimised over such rules. Known (Bach-Huiberts): S = O(σ^{-1/2} d^{11/4} log^{7/4} n), and the expected combinatorial diameter is Ω(σ^{-1/2} d^{1/2} (ln 4/σ)^{-1/4}) at n = ⌊(4/σ)^d⌋. Question (regime σ ≤ 1/d, n ≤ 2^{poly(d)}): is there a pivot rule with S = O(σ^{-1/2} d^{a} (log n)^{O(1)}) for some a < 11/4? Dually, is the expected diameter Ω(σ^{-1/2} d^{b}) for some b > 1/2 in that regime?

**Credit:** Bach, Huiberts, Optimal smoothed analysis of the simplex method, arXiv:2504.04197 (2025; v2 May 2026).

**Rests on recent unrefereed work. Check these premises first:**
- arXiv:2504.04197 (Bach-Huiberts; v2 May 2026, refereed status not verified): source of both the upper bound σ^{-1/2} d^{11/4} log^{7/4} n and the diameter lower bound.

**References:**
- https://arxiv.org/abs/2504.04197
- https://arxiv.org/abs/2211.11860
- arXiv:2504.04197
- arXiv:2211.11860
- arXiv:2510.21613

Difficulty estimate: 4.0/10 (calibrated: Collatz ≈ 5.5, twin primes ≈ 5.0). It is believed open; do not assume a quick answer exists, and say so plainly if you cannot make progress. Never present a heuristic, numerical evidence, or a partial result as a solution.

## What counts as an answer
Either a proof of `OpenProblems.QEDM040.Claim` or a proof of `¬ OpenProblems.QEDM040.Claim` (a disproof), in Lean 4 + Mathlib, using the exact statement in `problems/QED-M040/Statement.lean`. Read its "Formalization notes" first. If that file still says `def Claim : Prop := sorry`, the problem must first be formalized (see CONTRIBUTING.md); a faithful formalization is itself a welcome contribution. What is missing: Statement left as sorry by design. Note: an assumptions-on-trial label is odd here (reviewer: smoothed analysis is a framework, not an assumption).

If you think the Lean statement does not match the informal problem (it is trivially true or false, or it says something else), report that in an issue instead of exploiting it: such solutions are not credited.

## How to submit
1. Claim it (optional but encouraged): open an issue titled `Claim QED-M040` at https://github.com/floration/qed/issues/new?template=claim.yml. Comment on it at least once a week or the claim lapses.
2. Add `solutions/QED-M040/<github-username>/Solution.lean`:
```lean
import Mathlib
-- do NOT redefine Claim: CI prepends problems/QED-M040/Statement.lean to your file
theorem solution : OpenProblems.QEDM040.Claim := by   -- or ¬ OpenProblems.QEDM040.Claim
  ...
```
3. Add `solutions/QED-M040/<github-username>/meta.json`: `{"model": "<AI model used, or none>", "kind": "proof" | "disproof"}`. Optionally a `README.md` explaining the idea.
4. Open a pull request. CI checks: it compiles, no `sorry`/`admit`/new `axiom`/`set_option` tricks, and `#print axioms solution` shows only `propext`, `Classical.choice`, `Quot.sound`.

## Scoring
Size = number of non-blank, non-comment lines of `Solution.lean` excluding `import` lines (helper lemmas count). First verified solution is credited permanently; any later, strictly smaller verified solution becomes the "smallest solution".

## Rules for you, the model
- Do not modify `Statement.lean` in a solution PR.
- Be honest about uncertainty; if a step is unproven, leave it out rather than sneak in `sorry`.
- Test locally: `lake exe cache get && lake env lean solutions/QED-M040/<user>/Solution.lean`.
