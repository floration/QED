# QED-E092 — Geodesic squares on convex surfaces

You are an AI model helping someone attack this open problem. Read all of this before working.

## The problem
Extended set · Grade B · QED Extension · Geometry

**Plain words:** On a smooth convex surface, measure distance by the length of the shortest path on the surface. Every smooth simple closed curve on the surface should contain four points that form a 'square' in this sense: four equal sides and two equal diagonals.

**Math:** Let $S=\partial K$ for a convex body $K\subset\mathbb R^3$ with smooth boundary and positive Gaussian curvature, and let $d$ be the intrinsic distance on $S$. Prove that every smooth simple closed curve $\gamma\subset S$ contains four distinct points $p_1,p_2,p_3,p_4$, in this cyclic order along $\gamma$, with $d(p_1,p_2)=d(p_2,p_3)=d(p_3,p_4)=d(p_4,p_1)>0$ and $d(p_1,p_3)=d(p_2,p_4)$.

**Credit:** Toeplitz 1911 (square peg problem); Schnirelmann 1944 (smooth case); constant-curvature surfaces: arXiv:2507.07945 (Naseri Sadr 2025)

**Rests on recent unrefereed work. Check these premises first:**
- arXiv:2507.07945 (2025 preprint, refereeing unclear): results for spheres and the hyperbolic plane; context only, Claim does not depend on it.

**References:**
- https://arxiv.org/abs/2507.07945
- https://arxiv.org/abs/1001.0186
- https://arxiv.org/abs/2103.13848
- https://arxiv.org/html/2507.07945v1

Difficulty estimate: 3.0/10 (calibrated: Collatz ≈ 5.5, twin primes ≈ 5.0). It is believed open; do not assume a quick answer exists, and say so plainly if you cannot make progress. Never present a heuristic, numerical evidence, or a partial result as a solution.

## What counts as an answer
Either a proof of `OpenProblems.QEDE092.Claim` or a proof of `¬ OpenProblems.QEDE092.Claim` (a disproof), in Lean 4 + Mathlib, using the exact statement in `problems/QED-E092/Statement.lean`. Read its "Formalization notes" first. If that file still says `def Claim : Prop := sorry`, the problem must first be formalized (see CONTRIBUTING.md); a faithful formalization is itself a welcome contribution.

If you think the Lean statement does not match the informal problem (it is trivially true or false, or it says something else), report that in an issue instead of exploiting it: such solutions are not credited.

## How to submit
0. First time? Solve a test problem (QED-Q1, the 2-line one, at minimum) and submit it, to confirm your Lean setup and the submission pipeline work before spending effort here. Skip this step if this IS a test problem.
1. Claim it (optional but encouraged): open an issue titled `Claim QED-E092` at https://github.com/floration/qed/issues/new?template=claim.yml. Comment on it at least once a week or the claim lapses.
2. Add `solutions/QED-E092/<github-username>/Solution.lean`:
```lean
import Mathlib
-- do NOT redefine Claim: CI prepends problems/QED-E092/Statement.lean to your file
theorem solution : OpenProblems.QEDE092.Claim := by   -- or ¬ OpenProblems.QEDE092.Claim
  ...
```
3. Add `solutions/QED-E092/<github-username>/meta.json`: `{"model": "<AI model used, or none>", "kind": "proof" | "disproof"}`. Optionally a `README.md` explaining the idea.
4. Open a pull request. CI checks: it compiles, no `sorry`/`admit`/new `axiom`/`set_option` tricks, and `#print axioms solution` shows only `propext`, `Classical.choice`, `Quot.sound`.

## Scoring
Size = number of non-blank, non-comment lines of `Solution.lean` excluding `import` lines (helper lemmas count). First verified solution is credited permanently; any later, strictly smaller verified solution becomes the "smallest solution".

## Rules for you, the model
- Do not modify `Statement.lean` in a solution PR.
- Be honest about uncertainty; if a step is unproven, leave it out rather than sneak in `sorry`.
- Test locally: `lake exe cache get && lake env lean solutions/QED-E092/<user>/Solution.lean`.
