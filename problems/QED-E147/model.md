# QED-E147 — How many faces can a convex space-filler have?

You are an AI model helping someone attack this open problem. Read all of this before working.

## The problem
Extended set · Grade A · QED Curated · Geometry

**Plain words:** A convex polyhedron is a space-filler if congruent copies of it fill all of 3-space with no gaps or overlaps. In the plane a convex tile has at most 6 sides, but in space the record is 38 faces (Engel, 1981). Is there any finite upper bound at all on the number of faces of a convex space-filler?

**Math:** Call a convex polytope $P\subset\mathbb{R}^3$ with nonempty interior a monohedral prototile if there are isometries $g_1,g_2,\dots$ of $\mathbb{R}^3$ with $\bigcup_i g_iP=\mathbb{R}^3$ and $\operatorname{int}(g_iP)\cap\operatorname{int}(g_jP)=\emptyset$ for $i\neq j$ (the tiling need not be face-to-face, isohedral or periodic). Decide whether there is $N<\infty$ such that every monohedral prototile in $\mathbb{R}^3$ has at most $N$ facets.

**Credit:** Grunbaum and Shephard, 'Tilings with congruent tiles', Bull. AMS 1980, Problem (G)

**Rests on recent unrefereed work. Check these premises first:**
- The 54-faced Wolfram 'space-filling polyhedron' must be confirmed non-convex (if convex and genuine it would only beat the record, not settle boundedness)
- Possible unlocated progress in crystallographic literature on non-isohedral convex tiles

**References:**
- https://www.ams.org/journals/bull/1980-03-03/S0273-0979-1980-14827-2/S0273-0979-1980-14827-2.pdf
- https://en.wikipedia.org/wiki/Plesiohedron
- https://mathworld.wolfram.com/EngelPolyhedra.html
- https://arxiv.org/pdf/0708.2114

Difficulty estimate: 6.5/10 (anchored scale: 1 ≈ Erdős–Ginzburg–Ziv, 2.5 ≈ the sensitivity conjecture, 5 ≈ bounded prime gaps, 7.5 ≈ the Riemann Hypothesis, 10 ≈ P vs NP). It is believed open; do not assume a quick answer exists, and say so plainly if you cannot make progress. Never present a heuristic, numerical evidence, or a partial result as a solution.

## What counts as an answer
Either a proof of `OpenProblems.QEDE147.Claim` or a proof of `¬ OpenProblems.QEDE147.Claim` (a disproof), in Lean 4 + Mathlib, using the exact statement in `problems/QED-E147/Statement.lean`. Read its "Formalization notes" first. If that file still says `def Claim : Prop := sorry`, the problem must first be formalized (see CONTRIBUTING.md); a faithful formalization is itself a welcome contribution.

If you think the Lean statement does not match the informal problem (it is trivially true or false, or it says something else), report that in an issue instead of exploiting it: such solutions are not credited.

## How to submit
0. First time? Solve a test problem (QED-Q1, the 2-line one, at minimum) and submit it, to confirm your Lean setup and the submission pipeline work before spending effort here. Skip this step if this IS a test problem.
1. Claim it (optional but encouraged): open an issue titled `Claim QED-E147` at https://github.com/floration/qed/issues/new?template=claim.yml. Comment on it at least once a week or the claim lapses.
2. Add `solutions/QED-E147/<github-username>/Solution.lean`:
```lean
import Mathlib
-- do NOT redefine Claim: CI prepends problems/QED-E147/Statement.lean to your file
theorem solution : OpenProblems.QEDE147.Claim := by   -- or ¬ OpenProblems.QEDE147.Claim
  ...
```
   Large proofs may add more `.lean` files (subfolders allowed) next to Solution.lean; CI concatenates them in path order before Solution.lean. Don't import them.
3. Add `solutions/QED-E147/<github-username>/meta.json`: `{"model": "<AI model used, or none>", "kind": "proof" | "disproof"}`. Optionally a `README.md` explaining the idea.
4. Open a pull request. CI checks: it compiles, no `sorry`/`admit`/new `axiom`/`set_option` tricks, and `#print axioms solution` shows only `propext`, `Classical.choice`, `Quot.sound`.

## Scoring
Size = number of non-blank, non-comment lines of `Solution.lean` excluding `import` lines (helper lemmas count). First verified solution is credited permanently; any later, strictly smaller verified solution becomes the "smallest solution".

## Rules for you, the model
- Do not modify `Statement.lean` in a solution PR.
- Be honest about uncertainty; if a step is unproven, leave it out rather than sneak in `sorry`.
- Test locally: `lake exe cache get && lake env lean solutions/QED-E147/<user>/Solution.lean`.
