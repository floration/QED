# QED-E146 — Eight points with integer distances in general position

You are an AI model helping someone attack this open problem. Read all of this before working.

## The problem
Extended set · Grade B · QED Curated · Geometry

**Plain words:** Can you place eight points in the plane so that every pair is an integer distance apart, no three points lie on a line, and no four lie on a circle? Seven such points were found by computer in 2008. Nobody has found eight or shown that eight is impossible.

**Math:** Decide whether there exist pairwise distinct $p_1,\dots,p_8\in\mathbb{R}^2$ such that $|p_i-p_j|\in\mathbb{Z}$ for all $i,j$, no three of the $p_i$ are collinear, and no four of the $p_i$ are concyclic.

**Credit:** Question posed by Kreisel and Kurz (2008), in the line of Erdos's question on integral point sets in general position

**Rests on recent unrefereed work. Check these premises first:**
- Could be resolved by a large computer search (it is a recognised open problem with refereed literature, but a positive answer might be pure computation)
- Erdos's broader question is attributed to a person, but this specific 8-point question is unnamed

**References:**
- https://arxiv.org/abs/0804.1303
- https://arxiv.org/abs/2401.10821
- https://arxiv.org/html/2407.08121v1
- https://www.emergentmind.com/open-problems/arbitrarily-large-integer-distance-plane-sets-no-3-collinear-no-4-concyclic

Difficulty estimate: 3.5/10 (calibrated: Collatz ≈ 5.5, twin primes ≈ 5.0). It is believed open; do not assume a quick answer exists, and say so plainly if you cannot make progress. Never present a heuristic, numerical evidence, or a partial result as a solution.

## What counts as an answer
Either a proof of `OpenProblems.QEDE146.Claim` or a proof of `¬ OpenProblems.QEDE146.Claim` (a disproof), in Lean 4 + Mathlib, using the exact statement in `problems/QED-E146/Statement.lean`. Read its "Formalization notes" first. If that file still says `def Claim : Prop := sorry`, the problem must first be formalized (see CONTRIBUTING.md); a faithful formalization is itself a welcome contribution.

If you think the Lean statement does not match the informal problem (it is trivially true or false, or it says something else), report that in an issue instead of exploiting it: such solutions are not credited.

## How to submit
0. First time? Solve a test problem (QED-Q1, the 2-line one, at minimum) and submit it, to confirm your Lean setup and the submission pipeline work before spending effort here. Skip this step if this IS a test problem.
1. Claim it (optional but encouraged): open an issue titled `Claim QED-E146` at https://github.com/floration/qed/issues/new?template=claim.yml. Comment on it at least once a week or the claim lapses.
2. Add `solutions/QED-E146/<github-username>/Solution.lean`:
```lean
import Mathlib
-- do NOT redefine Claim: CI prepends problems/QED-E146/Statement.lean to your file
theorem solution : OpenProblems.QEDE146.Claim := by   -- or ¬ OpenProblems.QEDE146.Claim
  ...
```
   Large proofs may add more `.lean` files (subfolders allowed) next to Solution.lean; CI concatenates them in path order before Solution.lean. Don't import them.
3. Add `solutions/QED-E146/<github-username>/meta.json`: `{"model": "<AI model used, or none>", "kind": "proof" | "disproof"}`. Optionally a `README.md` explaining the idea.
4. Open a pull request. CI checks: it compiles, no `sorry`/`admit`/new `axiom`/`set_option` tricks, and `#print axioms solution` shows only `propext`, `Classical.choice`, `Quot.sound`.

## Scoring
Size = number of non-blank, non-comment lines of `Solution.lean` excluding `import` lines (helper lemmas count). First verified solution is credited permanently; any later, strictly smaller verified solution becomes the "smallest solution".

## Rules for you, the model
- Do not modify `Statement.lean` in a solution PR.
- Be honest about uncertainty; if a step is unproven, leave it out rather than sneak in `sorry`.
- Test locally: `lake exe cache get && lake env lean solutions/QED-E146/<user>/Solution.lean`.
