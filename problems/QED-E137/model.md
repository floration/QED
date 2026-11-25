# QED-E137 — A 3×3 magic square of distinct squares

You are an AI model helping someone attack this open problem. Read all of this before working.

## The problem
Extended set · Grade B · QED Curated · Number theory

**Plain words:** Can nine different perfect squares be arranged in a 3×3 grid so that every row, every column and both diagonals have the same sum? Such squares exist in size 4×4 and larger, and 3×3 examples with seven square entries are known, but no full 3×3 example has been found and none has been ruled out.

**Math:** Decide whether there exist integers $x_{ij}$ ($1\le i,j\le 3$) such that the nine numbers $x_{ij}^2$ are pairwise distinct and the matrix $(x_{ij}^2)$ is magic: its three row sums, three column sums and two diagonal sums are all equal.

**Credit:** LaBar (College Math. J. 1984); Gardner (Quantum 1996); Guy UPINT D15.

**Rests on recent unrefereed work. Check these premises first:**
- Unrefereed nonexistence claim arXiv:2510.08286 (not accepted)
- Famous recreational problem: novelty moderate

**References:**
- https://en.wikipedia.org/wiki/Magic_square_of_squares
- https://arxiv.org/abs/2609.09351
- https://arxiv.org/abs/2406.09364
- https://arxiv.org/abs/2510.08286

Difficulty estimate: 8.5/10 (anchored scale: 1 ≈ Erdős–Ginzburg–Ziv, 2.5 ≈ the sensitivity conjecture, 5 ≈ bounded prime gaps, 7.5 ≈ the Riemann Hypothesis, 10 ≈ P vs NP). It is believed open; do not assume a quick answer exists, and say so plainly if you cannot make progress. Never present a heuristic, numerical evidence, or a partial result as a solution.

## What counts as an answer
Either a proof of `OpenProblems.QEDE137.Claim` or a proof of `¬ OpenProblems.QEDE137.Claim` (a disproof), in Lean 4 + Mathlib, using the exact statement in `problems/QED-E137/Statement.lean`. Read its "Formalization notes" first. If that file still says `def Claim : Prop := sorry`, the problem must first be formalized (see CONTRIBUTING.md); a faithful formalization is itself a welcome contribution.

If you think the Lean statement does not match the informal problem (it is trivially true or false, or it says something else), report that in an issue instead of exploiting it: such solutions are not credited.

## How to submit
0. First time? Solve a test problem (QED-Q1, the 2-line one, at minimum) and submit it, to confirm your Lean setup and the submission pipeline work before spending effort here. Skip this step if this IS a test problem.
1. Claim it (optional but encouraged): open an issue titled `Claim QED-E137` at https://github.com/floration/qed/issues/new?template=claim.yml. Comment on it at least once a week or the claim lapses.
2. Add `solutions/QED-E137/<github-username>/Solution.lean`:
```lean
import Mathlib
-- do NOT redefine Claim: CI prepends problems/QED-E137/Statement.lean to your file
theorem solution : OpenProblems.QEDE137.Claim := by   -- or ¬ OpenProblems.QEDE137.Claim
  ...
```
   Large proofs may add more `.lean` files (subfolders allowed) next to Solution.lean; CI concatenates them in path order before Solution.lean. Don't import them.
3. Add `solutions/QED-E137/<github-username>/meta.json`: `{"model": "<AI model used, or none>", "kind": "proof" | "disproof"}`. Optionally a `README.md` explaining the idea.
4. Open a pull request. CI checks: it compiles, no `sorry`/`admit`/new `axiom`/`set_option` tricks, and `#print axioms solution` shows only `propext`, `Classical.choice`, `Quot.sound`.

## Scoring
Size = number of non-blank, non-comment lines of `Solution.lean` excluding `import` lines (helper lemmas count). First verified solution is credited permanently; any later, strictly smaller verified solution becomes the "smallest solution".

## Rules for you, the model
- Do not modify `Statement.lean` in a solution PR.
- Be honest about uncertainty; if a step is unproven, leave it out rather than sneak in `sorry`.
- Test locally: `lake exe cache get && lake env lean solutions/QED-E137/<user>/Solution.lean`.
