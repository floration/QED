# QED-E223 — Sudoku resolution bounds

You are an AI model helping someone attack this open problem. Read all of this before working.

## The problem
Extended set · Grade C · QED Original · Computation

**Plain words:** Find an explicit family of large unsolvable Sudoku puzzles (n^2 by n^2 grids with some givens) for which any resolution proof that the puzzle has no solution must be exponentially long.

**Math:** For n ≥ 2 and a partial assignment A of symbols [n²] to cells of the n²×n² grid, let SUD_n(A) be the CNF in variables x_{c,v} (cell c holds v) consisting of: unit clauses for A; for every cell c, ⋁_v x_{c,v} and ¬x_{c,v} ∨ ¬x_{c,w} (v ≠ w); for every row, column and n×n box U, every v and distinct c,c' ∈ U, ¬x_{c,v} ∨ ¬x_{c',v}; and for every U and v, ⋁_{c∈U} x_{c,v}. Give a family (A_n), computable from n (in unary) in polynomial time, and ε > 0 such that for all sufficiently large n, SUD_n(A_n) is unsatisfiable and every resolution refutation of SUD_n(A_n) has at least 2^{n^ε} clauses.

**Credit:** QED original (archived Nov 2026, restored after re-review).

**References:**
- https://www.csc.kth.se/~jakobn/research/ProofComplexityChapter.pdf
- https://arxiv.org/abs/1202.5074

Difficulty estimate: 1.5/10 (anchored scale: 1 ≈ Erdős–Ginzburg–Ziv, 2.5 ≈ the sensitivity conjecture, 5 ≈ bounded prime gaps, 7.5 ≈ the Riemann Hypothesis, 10 ≈ P vs NP). It is believed open; do not assume a quick answer exists, and say so plainly if you cannot make progress. Never present a heuristic, numerical evidence, or a partial result as a solution.

## What counts as an answer
Either a proof of `OpenProblems.QEDE223.Claim` or a proof of `¬ OpenProblems.QEDE223.Claim` (a disproof), in Lean 4 + Mathlib, using the exact statement in `problems/QED-E223/Statement.lean`. Read its "Formalization notes" first. If that file still says `def Claim : Prop := sorry`, the problem must first be formalized (see CONTRIBUTING.md); a faithful formalization is itself a welcome contribution.

If you think the Lean statement does not match the informal problem (it is trivially true or false, or it says something else), report that in an issue instead of exploiting it: such solutions are not credited.

## How to submit
0. First time? Solve a test problem (QED-Q1, the 2-line one, at minimum) and submit it, to confirm your Lean setup and the submission pipeline work before spending effort here. Skip this step if this IS a test problem.
1. Claim it (optional but encouraged): open an issue titled `Claim QED-E223` at https://github.com/floration/qed/issues/new?template=claim.yml. Comment on it at least once a week or the claim lapses.
2. Add `solutions/QED-E223/<github-username>/Solution.lean`:
```lean
import Mathlib
-- do NOT redefine Claim: CI prepends problems/QED-E223/Statement.lean to your file
theorem solution : OpenProblems.QEDE223.Claim := by   -- or ¬ OpenProblems.QEDE223.Claim
  ...
```
   Large proofs may add more `.lean` files (subfolders allowed) next to Solution.lean; CI concatenates them in path order before Solution.lean. Don't import them.
3. Add `solutions/QED-E223/<github-username>/meta.json`: `{"model": "<AI model used, or none>", "kind": "proof" | "disproof"}`. Optionally a `README.md` explaining the idea.
4. Open a pull request. CI checks: it compiles, no `sorry`/`admit`/new `axiom`/`set_option` tricks, and `#print axioms solution` shows only `propext`, `Classical.choice`, `Quot.sound`.

## Scoring
Size = number of non-blank, non-comment lines of `Solution.lean` excluding `import` lines (helper lemmas count). First verified solution is credited permanently; any later, strictly smaller verified solution becomes the "smallest solution".

## Rules for you, the model
- Do not modify `Statement.lean` in a solution PR.
- Be honest about uncertainty; if a step is unproven, leave it out rather than sneak in `sorry`.
- Test locally: `lake exe cache get && lake env lean solutions/QED-E223/<user>/Solution.lean`.
