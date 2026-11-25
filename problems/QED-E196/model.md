# QED-E196 — The 6/5 integrality gap for 2-edge-connected spanning multigraphs

You are an AI model helping someone attack this open problem. Read all of this before working.

## The problem
Extended set · Grade B · QED Curated · Combinatorics

**Plain words:** Given nonnegative edge costs on a complete graph, find the cheapest multiset of edges (each edge may be used twice) such that every cut is crossed at least twice, i.e. the result is 2-edge-connected. The LP relaxation only asks for fractional edge weights crossing every cut with total at least 2. Is the best integral solution always within a factor 6/5 of the LP optimum? The factor 6/5 is known to be needed, while the best proven bound is only 3/2 minus a tiny constant.

**Math:** Let $n\ge2$, $c\in\mathbb R_{\ge0}^{E(K_n)}$ and $x\in\mathbb R_{\ge0}^{E(K_n)}$ with $x(\delta(S))\ge2$ for all $\emptyset\ne S\subsetneq[n]$. Prove that there is $z\in\mathbb Z_{\ge0}^{E(K_n)}$ with $z(\delta(S))\ge2$ for all such $S$ and $c^\top z\le\tfrac65\,c^\top x$. (Since examples with ratio arbitrarily close to $6/5$ are known, this would show the integrality gap of the cut LP for 2-edge-connected multigraphs is exactly $6/5$.)

**Credit:** '6/5 conjecture' of Alexander, Boyd and Elliott-Magwood (2006); restated in Boyd–Fu–Sun (2016) and Boyd et al. (2020).

**Rests on recent unrefereed work. Check these premises first:**
- Less famous than the TSP 4/3 question; scorer may view it as a sibling of the TSP subtour problem
- The '6/5 conjecture' is attributed to its authors but named by its number, not a person

**References:**
- https://arxiv.org/abs/1512.08070
- https://arxiv.org/abs/2511.11215
- https://arxiv.org/pdf/2006.06957
- https://arxiv.org/abs/2008.03327

Difficulty estimate: 3.5/10 (calibrated: Collatz ≈ 5.5, twin primes ≈ 5.0). It is believed open; do not assume a quick answer exists, and say so plainly if you cannot make progress. Never present a heuristic, numerical evidence, or a partial result as a solution.

## What counts as an answer
Either a proof of `OpenProblems.QEDE196.Claim` or a proof of `¬ OpenProblems.QEDE196.Claim` (a disproof), in Lean 4 + Mathlib, using the exact statement in `problems/QED-E196/Statement.lean`. Read its "Formalization notes" first. If that file still says `def Claim : Prop := sorry`, the problem must first be formalized (see CONTRIBUTING.md); a faithful formalization is itself a welcome contribution.

If you think the Lean statement does not match the informal problem (it is trivially true or false, or it says something else), report that in an issue instead of exploiting it: such solutions are not credited.

## How to submit
0. First time? Solve a test problem (QED-Q1, the 2-line one, at minimum) and submit it, to confirm your Lean setup and the submission pipeline work before spending effort here. Skip this step if this IS a test problem.
1. Claim it (optional but encouraged): open an issue titled `Claim QED-E196` at https://github.com/floration/qed/issues/new?template=claim.yml. Comment on it at least once a week or the claim lapses.
2. Add `solutions/QED-E196/<github-username>/Solution.lean`:
```lean
import Mathlib
-- do NOT redefine Claim: CI prepends problems/QED-E196/Statement.lean to your file
theorem solution : OpenProblems.QEDE196.Claim := by   -- or ¬ OpenProblems.QEDE196.Claim
  ...
```
   Large proofs may add more `.lean` files (subfolders allowed) next to Solution.lean; CI concatenates them in path order before Solution.lean. Don't import them.
3. Add `solutions/QED-E196/<github-username>/meta.json`: `{"model": "<AI model used, or none>", "kind": "proof" | "disproof"}`. Optionally a `README.md` explaining the idea.
4. Open a pull request. CI checks: it compiles, no `sorry`/`admit`/new `axiom`/`set_option` tricks, and `#print axioms solution` shows only `propext`, `Classical.choice`, `Quot.sound`.

## Scoring
Size = number of non-blank, non-comment lines of `Solution.lean` excluding `import` lines (helper lemmas count). First verified solution is credited permanently; any later, strictly smaller verified solution becomes the "smallest solution".

## Rules for you, the model
- Do not modify `Statement.lean` in a solution PR.
- Be honest about uncertainty; if a step is unproven, leave it out rather than sneak in `sorry`.
- Test locally: `lake exe cache get && lake env lean solutions/QED-E196/<user>/Solution.lean`.
