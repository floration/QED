# QED-M143 — Hats on a flat torus: how much must be left uncovered?

You are an AI model helping someone attack this open problem. Read all of this before working.

## The problem
Main set · Grade B · QED Original · Geometry

**Plain words:** The hat tile can cover the plane, but never in a repeating pattern, so copies of the hat can never exactly cover a flat torus (a doughnut-shaped surface that is flat, like a video-game screen that wraps around). Packing hats on a torus of area A always leaves some area uncovered. Show that the least uncovered area grows without bound as A grows, and find how fast it grows. Cutting a square out of a hat tiling shows it is at most a constant times the square root of A.

**Math:** Let $H$ be the hat polykite (area normalised to $1$); copies may be rotated and reflected. For a lattice $\Lambda\subset\mathbb R^2$ of covolume $A$, a packing of $T_\Lambda=\mathbb R^2/\Lambda$ is a finite family of isometric copies of $H$ in $T_\Lambda$ with disjoint interiors (each copy embedded). Let $g(A)=\inf_{\Lambda:\,\mathrm{covol}(\Lambda)=A}\ \inf_{\text{packings}}\ \big(A-\#\text{copies}\big)$. Trivially $g(A)=O(\sqrt A)$. (i) Prove $g(A)\to\infty$ as $A\to\infty$. (ii) Determine the order of growth of $g$; in particular, is $g(A)\asymp\sqrt A$?

**Credit:** QED original (archived Nov 2026, restored after re-review).

**References:**
- https://arxiv.org/abs/2303.10798
- https://arxiv.org/abs/0910.2415
- https://mathstat.dal.ca/~selinger/papers/hat-partition.pdf

Difficulty estimate: 3.5/10 (anchored scale: 1 ≈ Erdős–Ginzburg–Ziv, 2.5 ≈ the sensitivity conjecture, 5 ≈ bounded prime gaps, 7.5 ≈ the Riemann Hypothesis, 10 ≈ P vs NP). It is believed open; do not assume a quick answer exists, and say so plainly if you cannot make progress. Never present a heuristic, numerical evidence, or a partial result as a solution.

## What counts as an answer
Either a proof of `OpenProblems.QEDM143.Claim` or a proof of `¬ OpenProblems.QEDM143.Claim` (a disproof), in Lean 4 + Mathlib, using the exact statement in `problems/QED-M143/Statement.lean`. Read its "Formalization notes" first. If that file still says `def Claim : Prop := sorry`, the problem must first be formalized (see CONTRIBUTING.md); a faithful formalization is itself a welcome contribution.

If you think the Lean statement does not match the informal problem (it is trivially true or false, or it says something else), report that in an issue instead of exploiting it: such solutions are not credited.

## How to submit
0. First time? Solve a test problem (QED-Q1, the 2-line one, at minimum) and submit it, to confirm your Lean setup and the submission pipeline work before spending effort here. Skip this step if this IS a test problem.
1. Claim it (optional but encouraged): open an issue titled `Claim QED-M143` at https://github.com/floration/qed/issues/new?template=claim.yml. Comment on it at least once a week or the claim lapses.
2. Add `solutions/QED-M143/<github-username>/Solution.lean`:
```lean
import Mathlib
-- do NOT redefine Claim: CI prepends problems/QED-M143/Statement.lean to your file
theorem solution : OpenProblems.QEDM143.Claim := by   -- or ¬ OpenProblems.QEDM143.Claim
  ...
```
   Large proofs may add more `.lean` files (subfolders allowed) next to Solution.lean; CI concatenates them in path order before Solution.lean. Don't import them.
3. Add `solutions/QED-M143/<github-username>/meta.json`: `{"model": "<AI model used, or none>", "kind": "proof" | "disproof"}`. Optionally a `README.md` explaining the idea.
4. Open a pull request. CI checks: it compiles, no `sorry`/`admit`/new `axiom`/`set_option` tricks, and `#print axioms solution` shows only `propext`, `Classical.choice`, `Quot.sound`.

## Scoring
Size = number of non-blank, non-comment lines of `Solution.lean` excluding `import` lines (helper lemmas count). First verified solution is credited permanently; any later, strictly smaller verified solution becomes the "smallest solution".

## Rules for you, the model
- Do not modify `Statement.lean` in a solution PR.
- Be honest about uncertainty; if a step is unproven, leave it out rather than sneak in `sorry`.
- Test locally: `lake exe cache get && lake env lean solutions/QED-M143/<user>/Solution.lean`.
