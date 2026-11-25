# N-670 — Three collinear points after the fall of 3SUM

You are an AI model helping someone attack this open problem. Read all of this before working.

## The problem
Grade A · QED Curated · Complexity

**Plain words:** Given n points in the plane (integer coordinates poly(n), or real RAM), decide whether three are collinear in O(n^{2-eps}) time for some eps>0; or give a fine-grained reduction showing Collinearity is hard under a hypothesis not refuted by Alman-Vassilevska Williams (e.g. 4SUM, 3SUM-Indexing, or a new geometric hypothesis).

**Math:** Prove or disprove: for every constant c >= 1 there exist eps > 0 and a word-RAM algorithm (word size Theta(log n)) deciding in O(n^{2-eps}) time whether n points of Z^2 ∩ [-n^c,n^c]^2 contain three collinear points (and the analogous real-RAM question for points of R^2).

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
Either a proof of `OpenProblems.N670.Claim` or a proof of `¬ OpenProblems.N670.Claim` (a disproof), in Lean 4 + Mathlib, using the exact statement in `problems/N-670/Statement.lean`. Read its "Formalization notes" first. If that file still says `def Claim : Prop := sorry`, the problem must first be formalized (see CONTRIBUTING.md); a faithful formalization is itself a welcome contribution. What is missing: Not formalized: requires a word-RAM/real-RAM time-complexity framework absent from Mathlib.

If you think the Lean statement does not match the informal problem (it is trivially true or false, or it says something else), report that in an issue instead of exploiting it: such solutions are not credited.

## How to submit
1. Claim it (optional but encouraged): open an issue titled `Claim N-670` at https://github.com/floration/qed/issues/new?template=claim.yml. Comment on it at least once a week or the claim lapses.
2. Add `solutions/N-670/<github-username>/Solution.lean`:
```lean
import Mathlib
-- do NOT redefine Claim: CI prepends problems/N-670/Statement.lean to your file
theorem solution : OpenProblems.N670.Claim := by   -- or ¬ OpenProblems.N670.Claim
  ...
```
3. Add `solutions/N-670/<github-username>/meta.json`: `{"model": "<AI model used, or none>", "kind": "proof" | "disproof"}`. Optionally a `README.md` explaining the idea.
4. Open a pull request. CI checks: it compiles, no `sorry`/`admit`/new `axiom`/`set_option` tricks, and `#print axioms solution` shows only `propext`, `Classical.choice`, `Quot.sound`.

## Scoring
Size = number of non-blank, non-comment lines of `Solution.lean` excluding `import` lines (helper lemmas count). First verified solution is credited permanently; any later, strictly smaller verified solution becomes the "smallest solution".

## Rules for you, the model
- Do not modify `Statement.lean` in a solution PR.
- Be honest about uncertainty; if a step is unproven, leave it out rather than sneak in `sorry`.
- Test locally: `lake exe cache get && lake env lean solutions/N-670/<user>/Solution.lean`.
