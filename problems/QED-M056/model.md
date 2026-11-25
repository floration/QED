# QED-M056 — A monotile that forces quasicrystalline symmetry

You are an AI model helping someone attack this open problem. Read all of this before working.

## The problem
Main set · Grade A · QED Extension · Geometry

**Plain words:** Every aperiodic monotile known (Socolar-Taylor, the hat, the spectre, and the 3D examples) has tilings with only crystallographic rotational structure: 2-, 3-, 4- or 6-fold. Is there a single tile in the plane whose tilings are all forced to be quasicrystalline with fivefold symmetry, as Penrose tilings are? Or is non-crystallographic symmetry something only two or more tiles can enforce?

**Math:** Call a compact set T ⊂ ℝ² homeomorphic to a closed disc a monotile if it tiles ℝ² by isometric copies, reflections allowed. Does there exist a monotile T such that (i) every tiling by copies of T uses only finitely many orientations of T (up to translation), and (ii) for every such tiling 𝒯 the translation hull Ω(𝒯), the closure of {𝒯 + v} in the standard local topology (agreement on B(0,1/ε) after a translation of size < ε), is invariant under rotation by 2π/5? (Equivalently, the rotated tiling R𝒯 lies in Ω(𝒯).) The R³ icosahedral analogue is a secondary target.

**Credit:** Einstein problem: Socolar-Taylor (2011, arXiv:1009.1419); Smith-Myers-Kaplan-Goodman-Strauss (2023, arXiv:2303.10798); Gummelt decagon covering (1996); Steinhardt-Jeong quasi-unit-cell model

**References:**
- https://arxiv.org/pdf/2303.10798
- https://arxiv.org/pdf/1009.1419
- https://arxiv.org/abs/2609.19214
- https://arxiv.org/pdf/1003.4909
- https://collaborate.princeton.edu/en/publications/constructing-penrose-like-tilings-from-a-single-prototile-and-the/
- https://en.wikipedia.org/wiki/Einstein_problem
- https://arxiv.org/pdf/1604.06280
- https://arxiv.org/pdf/2409.15880
- https://arxiv.org/abs/1907.10139
- https://arxiv.org/abs/2106.08155
- https://arxiv.org/abs/2609.19214
- https://arxiv.org/pdf/1009.1419

Difficulty estimate: 6.0/10 (anchored scale: 1 ≈ Erdős–Ginzburg–Ziv, 2.5 ≈ the sensitivity conjecture, 5 ≈ bounded prime gaps, 7.5 ≈ the Riemann Hypothesis, 10 ≈ P vs NP). It is believed open; do not assume a quick answer exists, and say so plainly if you cannot make progress. Never present a heuristic, numerical evidence, or a partial result as a solution.

## What counts as an answer
Either a proof of `OpenProblems.QEDM056.Claim` or a proof of `¬ OpenProblems.QEDM056.Claim` (a disproof), in Lean 4 + Mathlib, using the exact statement in `problems/QED-M056/Statement.lean`. Read its "Formalization notes" first. If that file still says `def Claim : Prop := sorry`, the problem must first be formalized (see CONTRIBUTING.md); a faithful formalization is itself a welcome contribution.

If you think the Lean statement does not match the informal problem (it is trivially true or false, or it says something else), report that in an issue instead of exploiting it: such solutions are not credited.

## How to submit
0. First time? Solve a test problem (QED-Q1, the 2-line one, at minimum) and submit it, to confirm your Lean setup and the submission pipeline work before spending effort here. Skip this step if this IS a test problem.
1. Claim it (optional but encouraged): open an issue titled `Claim QED-M056` at https://github.com/floration/qed/issues/new?template=claim.yml. Comment on it at least once a week or the claim lapses.
2. Add `solutions/QED-M056/<github-username>/Solution.lean`:
```lean
import Mathlib
-- do NOT redefine Claim: CI prepends problems/QED-M056/Statement.lean to your file
theorem solution : OpenProblems.QEDM056.Claim := by   -- or ¬ OpenProblems.QEDM056.Claim
  ...
```
   Large proofs may add more `.lean` files (subfolders allowed) next to Solution.lean; CI concatenates them in path order before Solution.lean. Don't import them.
3. Add `solutions/QED-M056/<github-username>/meta.json`: `{"model": "<AI model used, or none>", "kind": "proof" | "disproof"}`. Optionally a `README.md` explaining the idea.
4. Open a pull request. CI checks: it compiles, no `sorry`/`admit`/new `axiom`/`set_option` tricks, and `#print axioms solution` shows only `propext`, `Classical.choice`, `Quot.sound`.

## Scoring
Size = number of non-blank, non-comment lines of `Solution.lean` excluding `import` lines (helper lemmas count). First verified solution is credited permanently; any later, strictly smaller verified solution becomes the "smallest solution".

## Rules for you, the model
- Do not modify `Statement.lean` in a solution PR.
- Be honest about uncertainty; if a step is unproven, leave it out rather than sneak in `sorry`.
- Test locally: `lake exe cache get && lake env lean solutions/QED-M056/<user>/Solution.lean`.
