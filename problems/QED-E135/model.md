# QED-E135 — Property B: beat the square-root exponent

You are an AI model helping someone attack this open problem. Read all of this before working.

## The problem
Extended set · Grade A · QED Curated · Combinatorics

**Plain words:** Let m(n) be the fewest sets of size n needed so that however you colour the points red and blue, some set is entirely one colour. A random construction shows m(n) is at most about n²·2ⁿ. The best lower bound, from 2000, is about √(n/log n)·2ⁿ. The task is to show that m(n) is at least n^{1/2+δ}·2ⁿ for some fixed δ > 0, a polynomial improvement over the square-root barrier.

**Math:** Let $m(n)$ be the minimum number of edges of an $n$-uniform hypergraph that is not 2-colourable (has no vertex 2-colouring without a monochromatic edge). Prove there exist $\delta>0$ and $c>0$ such that $m(n)\ge c\,n^{1/2+\delta}\,2^n$ for all $n\ge1$.

**Credit:** Classical problem (Property B, named for F. Bernstein's property; studied by Erdős and Hajnal). Bounds by Erdős, Beck, Radhakrishnan–Srinivasan, Cherkashin–Kozik.

**Rests on recent unrefereed work. Check these premises first:**
- 'Property B' is named after Bernstein (object name, not a named conjecture). It is sometimes called 'the Erdős–Hajnal property B problem', which is a mild naming risk.
- A well-known classical problem, so novelty is low.

**References:**
- https://arxiv.org/abs/2403.05674
- https://arxiv.org/abs/1602.00218

Difficulty estimate: 7.0/10 (anchored scale: 1 ≈ Erdős–Ginzburg–Ziv, 2.5 ≈ the sensitivity conjecture, 5 ≈ bounded prime gaps, 7.5 ≈ the Riemann Hypothesis, 10 ≈ P vs NP). It is believed open; do not assume a quick answer exists, and say so plainly if you cannot make progress. Never present a heuristic, numerical evidence, or a partial result as a solution.

## What counts as an answer
Either a proof of `OpenProblems.QEDE135.Claim` or a proof of `¬ OpenProblems.QEDE135.Claim` (a disproof), in Lean 4 + Mathlib, using the exact statement in `problems/QED-E135/Statement.lean`. Read its "Formalization notes" first. If that file still says `def Claim : Prop := sorry`, the problem must first be formalized (see CONTRIBUTING.md); a faithful formalization is itself a welcome contribution.

If you think the Lean statement does not match the informal problem (it is trivially true or false, or it says something else), report that in an issue instead of exploiting it: such solutions are not credited.

## How to submit
0. First time? Solve a test problem (QED-Q1, the 2-line one, at minimum) and submit it, to confirm your Lean setup and the submission pipeline work before spending effort here. Skip this step if this IS a test problem.
1. Claim it (optional but encouraged): open an issue titled `Claim QED-E135` at https://github.com/floration/qed/issues/new?template=claim.yml. Comment on it at least once a week or the claim lapses.
2. Add `solutions/QED-E135/<github-username>/Solution.lean`:
```lean
import Mathlib
-- do NOT redefine Claim: CI prepends problems/QED-E135/Statement.lean to your file
theorem solution : OpenProblems.QEDE135.Claim := by   -- or ¬ OpenProblems.QEDE135.Claim
  ...
```
   Large proofs may add more `.lean` files (subfolders allowed) next to Solution.lean; CI concatenates them in path order before Solution.lean. Don't import them.
3. Add `solutions/QED-E135/<github-username>/meta.json`: `{"model": "<AI model used, or none>", "kind": "proof" | "disproof"}`. Optionally a `README.md` explaining the idea.
4. Open a pull request. CI checks: it compiles, no `sorry`/`admit`/new `axiom`/`set_option` tricks, and `#print axioms solution` shows only `propext`, `Classical.choice`, `Quot.sound`.

## Scoring
Size = number of non-blank, non-comment lines of `Solution.lean` excluding `import` lines (helper lemmas count). First verified solution is credited permanently; any later, strictly smaller verified solution becomes the "smallest solution".

## Rules for you, the model
- Do not modify `Statement.lean` in a solution PR.
- Be honest about uncertainty; if a step is unproven, leave it out rather than sneak in `sorry`.
- Test locally: `lake exe cache get && lake env lean solutions/QED-E135/<user>/Solution.lean`.
