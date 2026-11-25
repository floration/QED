# QED-M043 — Three collinear points after the fall of 3SUM

You are an AI model helping someone attack this open problem. Read all of this before working.

## The problem
Main set · Grade A · QED Curated · Complexity

**Plain words:** Given n points in the plane (integer coordinates poly(n), or real RAM), decide whether three are collinear in O(n^{2-eps}) time for some eps>0; or give a fine-grained reduction showing Collinearity is hard under a hypothesis not refuted by Alman-Vassilevska Williams (e.g. 4SUM, 3SUM-Indexing, or a new geometric hypothesis).

**Math:** Prove or disprove: for every constant c ≥ 1 there are ε > 0 and a deterministic word-RAM algorithm (word size Θ(log n)) deciding in O(n^{2-ε}) time whether n distinct points of ℤ² ∩ [−n^c, n^c]² contain three collinear points. (The real-RAM variant is a separate question.)

**Credit:** Alman & Vassilevska Williams, 'Truly Subquadratic 3SUM and Truly Subcubic APSP via Triangles in Sparse Lopsided Graphs', arXiv:2610.06783 (2026), Sec. 1 and Sec. 6.

**Rests on recent unrefereed work. Check these premises first:**
- AVW arXiv:2610.06783 (2026 preprint): truly subquadratic 3SUM, the premise that removes the 3SUM-based lower bound for collinearity.
- Majdoddin arXiv:2610.17420 (2026 preprint): improved thin-matrix-product reductions for 3SUM/APSP; supporting background.
- Chan–Itakura–Ma–Yu arXiv:2610.42012 (2026 preprint): derandomization of real 3SUM; supporting background.
- Fischer arXiv:2610.32162 (2026 preprint): k-AP-based GeomBase lower bounds explicitly not covering collinearity; used to argue the question is still open.

**References:**
- Alman, Vassilevska Williams, Truly Subquadratic 3SUM and Truly Subcubic APSP via Triangles in Sparse Lopsided Graphs, arXiv:2610.06783 (Oct 2026)
- Majdoddin, Thin matrix products up to D<=N^0.172 and lossless reductions for 3SUM, Exact Triangle and APSP, arXiv:2610.17420 (Oct 2026)
- Gajentaan, Overmars, On a class of O(n^2) problems in computational geometry, CGTA 1995
- arXiv:2610.06783
- arXiv:2610.17420
- arXiv:2610.32162
- arXiv:2610.42012

Difficulty estimate: 3.5/10 (calibrated: Collatz ≈ 5.5, twin primes ≈ 5.0). It is believed open; do not assume a quick answer exists, and say so plainly if you cannot make progress. Never present a heuristic, numerical evidence, or a partial result as a solution.

## What counts as an answer
Either a proof of `OpenProblems.QEDM043.Claim` or a proof of `¬ OpenProblems.QEDM043.Claim` (a disproof), in Lean 4 + Mathlib, using the exact statement in `problems/QED-M043/Statement.lean`. Read its "Formalization notes" first. If that file still says `def Claim : Prop := sorry`, the problem must first be formalized (see CONTRIBUTING.md); a faithful formalization is itself a welcome contribution.

If you think the Lean statement does not match the informal problem (it is trivially true or false, or it says something else), report that in an issue instead of exploiting it: such solutions are not credited.

## How to submit
0. First time? Solve a test problem (QED-Q1, the 2-line one, at minimum) and submit it, to confirm your Lean setup and the submission pipeline work before spending effort here. Skip this step if this IS a test problem.
1. Claim it (optional but encouraged): open an issue titled `Claim QED-M043` at https://github.com/floration/qed/issues/new?template=claim.yml. Comment on it at least once a week or the claim lapses.
2. Add `solutions/QED-M043/<github-username>/Solution.lean`:
```lean
import Mathlib
-- do NOT redefine Claim: CI prepends problems/QED-M043/Statement.lean to your file
theorem solution : OpenProblems.QEDM043.Claim := by   -- or ¬ OpenProblems.QEDM043.Claim
  ...
```
   Large proofs may add more `.lean` files (subfolders allowed) next to Solution.lean; CI concatenates them in path order before Solution.lean. Don't import them.
3. Add `solutions/QED-M043/<github-username>/meta.json`: `{"model": "<AI model used, or none>", "kind": "proof" | "disproof"}`. Optionally a `README.md` explaining the idea.
4. Open a pull request. CI checks: it compiles, no `sorry`/`admit`/new `axiom`/`set_option` tricks, and `#print axioms solution` shows only `propext`, `Classical.choice`, `Quot.sound`.

## Scoring
Size = number of non-blank, non-comment lines of `Solution.lean` excluding `import` lines (helper lemmas count). First verified solution is credited permanently; any later, strictly smaller verified solution becomes the "smallest solution".

## Rules for you, the model
- Do not modify `Statement.lean` in a solution PR.
- Be honest about uncertainty; if a step is unproven, leave it out rather than sneak in `sorry`.
- Test locally: `lake exe cache get && lake env lean solutions/QED-M043/<user>/Solution.lean`.
