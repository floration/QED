# QED-E091 — Cross-polytopes in 4D

You are an AI model helping someone attack this open problem. Read all of this before working.

## The problem
Extended set · Grade B · QED Curated · Geometry

**Plain words:** Every smooth convex body in 4-space should have the eight corners of a regular cross-polytope lying on its boundary.

**Math:** Prove that for every smooth convex body $K\subset\mathbb{R}^4$ there is a regular cross-polytope (a similar copy of $\mathrm{conv}\{\pm e_1,\dots,\pm e_4\}$) all of whose 8 vertices lie on $\partial K$.

**Credit:** Klee & Wagon, Old and New Unsolved Problems in Plane Geometry and Number Theory (1991), Problem 11.5; V. V. Makeev (d = 3); R. Karasev, arXiv:0905.2671 (2009).

**References:**
- https://arxiv.org/abs/0905.2671
- https://ar5iv.arxiv.org/html/1107.4428
- https://mathnet.ru/eng/znsl3565
- https://ar5iv.labs.arxiv.org/html/1107.4428

Difficulty estimate: 3.5/10 (calibrated: Collatz ≈ 5.5, twin primes ≈ 5.0). It is believed open; do not assume a quick answer exists, and say so plainly if you cannot make progress. Never present a heuristic, numerical evidence, or a partial result as a solution.

## What counts as an answer
Either a proof of `OpenProblems.QEDE091.Claim` or a proof of `¬ OpenProblems.QEDE091.Claim` (a disproof), in Lean 4 + Mathlib, using the exact statement in `problems/QED-E091/Statement.lean`. Read its "Formalization notes" first. If that file still says `def Claim : Prop := sorry`, the problem must first be formalized (see CONTRIBUTING.md); a faithful formalization is itself a welcome contribution.

If you think the Lean statement does not match the informal problem (it is trivially true or false, or it says something else), report that in an issue instead of exploiting it: such solutions are not credited.

## How to submit
0. First time? Solve a test problem (QED-Q1, the 2-line one, at minimum) and submit it, to confirm your Lean setup and the submission pipeline work before spending effort here. Skip this step if this IS a test problem.
1. Claim it (optional but encouraged): open an issue titled `Claim QED-E091` at https://github.com/floration/qed/issues/new?template=claim.yml. Comment on it at least once a week or the claim lapses.
2. Add `solutions/QED-E091/<github-username>/Solution.lean`:
```lean
import Mathlib
-- do NOT redefine Claim: CI prepends problems/QED-E091/Statement.lean to your file
theorem solution : OpenProblems.QEDE091.Claim := by   -- or ¬ OpenProblems.QEDE091.Claim
  ...
```
3. Add `solutions/QED-E091/<github-username>/meta.json`: `{"model": "<AI model used, or none>", "kind": "proof" | "disproof"}`. Optionally a `README.md` explaining the idea.
4. Open a pull request. CI checks: it compiles, no `sorry`/`admit`/new `axiom`/`set_option` tricks, and `#print axioms solution` shows only `propext`, `Classical.choice`, `Quot.sound`.

## Scoring
Size = number of non-blank, non-comment lines of `Solution.lean` excluding `import` lines (helper lemmas count). First verified solution is credited permanently; any later, strictly smaller verified solution becomes the "smallest solution".

## Rules for you, the model
- Do not modify `Statement.lean` in a solution PR.
- Be honest about uncertainty; if a step is unproven, leave it out rather than sneak in `sorry`.
- Test locally: `lake exe cache get && lake env lean solutions/QED-E091/<user>/Solution.lean`.
