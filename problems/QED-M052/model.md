# QED-M052 — Outer billiards around analytic tables with flat points

You are an AI model helping someone attack this open problem. Read all of this before working.

## The problem
Main set · Grade A · QED Extension · Dynamics

**Plain words:** Outer billiards around a smooth convex shape with positive curvature has only bounded orbits (Moser-Douady). Polygons, semicircles and generic C^1 shapes can have orbits that escape to infinity. What if the table is analytic and strictly convex, but its curvature vanishes at a few points, like the superellipse x^4+y^4 ≤ 1? Decide whether every orbit stays bounded.

**Math:** Let $K\subset\mathbb R^2$ be a strictly convex body whose boundary is a real-analytic closed curve with curvature vanishing at at least one point (hence, by analyticity, at finitely many). For $p\in\mathbb R^2\setminus K$, let $T(p)=2q-p$, where $q\in\partial K$ is the tangency point of the tangent line from $p$ that has $K$ on its left. Is every $T$-orbit bounded, for every such $K$? If not, characterize the $K$ with unbounded orbits, e.g. by the vanishing orders of the curvature or by symmetry. First test case: $K=\{x^4+y^4\le1\}$.

**Credit:** Moser's boundedness question (J. Moser, Stable and Random Motions, 1973); Douady (thesis, 1982); Sorrentino arXiv:2610.06418 (2026) for the C^1-generic case.

**QED results so far (reviewer-derived; check before relying on them):** I checked the singularity claim. At a flat point of order k the radius of curvature satisfies rho(theta)~|theta|^{-k/(k+1)} (|theta|^{-2/3} for x^4+y^4), and the tangency point q(p) is only C^{1/(k+1)} across the tangent lines at the flat points. So T and the limiting map at infinity are genuinely non-smooth, and KAM does not apply directly. The claim is correct.

**Rests on recent unrefereed work. Check these premises first:**
- arXiv:2610.06418 (Sorrentino, 2026 preprint): cited for C^1-generic unbounded orbits (centrally symmetric tables only); motivation only, the statement does not depend on it.

**References:**
- https://arxiv.org/pdf/2610.06418
- https://www.math.umd.edu/~dolgop/outer15.pdf
- https://arxiv.org/abs/math/0702073
- https://arxiv.org/pdf/math/9408216
- https://arxiv.org/abs/2610.06418
- https://www.math.umd.edu/~dolgop/outer15.pdf
- https://arxiv.org/abs/math/9408216
- https://arxiv.org/html/2508.15142v1
- https://cedar.wwu.edu/math_facpubs/14

Difficulty estimate: 4.5/10 (calibrated: Collatz ≈ 5.5, twin primes ≈ 5.0). It is believed open; do not assume a quick answer exists, and say so plainly if you cannot make progress. Never present a heuristic, numerical evidence, or a partial result as a solution.

## What counts as an answer
Either a proof of `OpenProblems.QEDM052.Claim` or a proof of `¬ OpenProblems.QEDM052.Claim` (a disproof), in Lean 4 + Mathlib, using the exact statement in `problems/QED-M052/Statement.lean`. Read its "Formalization notes" first. If that file still says `def Claim : Prop := sorry`, the problem must first be formalized (see CONTRIBUTING.md); a faithful formalization is itself a welcome contribution.

If you think the Lean statement does not match the informal problem (it is trivially true or false, or it says something else), report that in an issue instead of exploiting it: such solutions are not credited.

## How to submit
0. First time? Solve a test problem (QED-Q1, the 2-line one, at minimum) and submit it, to confirm your Lean setup and the submission pipeline work before spending effort here. Skip this step if this IS a test problem.
1. Claim it (optional but encouraged): open an issue titled `Claim QED-M052` at https://github.com/floration/qed/issues/new?template=claim.yml. Comment on it at least once a week or the claim lapses.
2. Add `solutions/QED-M052/<github-username>/Solution.lean`:
```lean
import Mathlib
-- do NOT redefine Claim: CI prepends problems/QED-M052/Statement.lean to your file
theorem solution : OpenProblems.QEDM052.Claim := by   -- or ¬ OpenProblems.QEDM052.Claim
  ...
```
   Large proofs may add more `.lean` files (subfolders allowed) next to Solution.lean; CI concatenates them in path order before Solution.lean. Don't import them.
3. Add `solutions/QED-M052/<github-username>/meta.json`: `{"model": "<AI model used, or none>", "kind": "proof" | "disproof"}`. Optionally a `README.md` explaining the idea.
4. Open a pull request. CI checks: it compiles, no `sorry`/`admit`/new `axiom`/`set_option` tricks, and `#print axioms solution` shows only `propext`, `Classical.choice`, `Quot.sound`.

## Scoring
Size = number of non-blank, non-comment lines of `Solution.lean` excluding `import` lines (helper lemmas count). First verified solution is credited permanently; any later, strictly smaller verified solution becomes the "smallest solution".

## Rules for you, the model
- Do not modify `Statement.lean` in a solution PR.
- Be honest about uncertainty; if a step is unproven, leave it out rather than sneak in `sorry`.
- Test locally: `lake exe cache get && lake env lean solutions/QED-M052/<user>/Solution.lean`.
