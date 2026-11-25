# QED-M032 — Beyond the D <= N^{0.172} wall for thin matrix products

You are an AI model helping someone attack this open problem. Read all of this before working.

## The problem
Main set · Grade B · QED Curated · Complexity

**Plain words:** AVW's core subroutine computes requested entries of XY (N x D times D x N, D <= N^{eps}) in N^2/D^{c} operations; Majdoddin extends the regime to eps < ln4/(5 ln5) ~ 0.17227, matching Coppersmith's 1982 exponent for the same tensor. Either (a) extend the thin-product theorem to some eps > 0.17227 (e.g. via a different base identity, or settle Majdoddin's open thin product <34,2,35>), giving 3SUM/APSP exponents below 1.9945 / 2.9945; or (b) prove that every partial-product-tensor/Coppersmith-style scheme is limited to eps <= 0.17227.

**Math:** Call ε good if there is γ > 0 such that for every constant K some deterministic word-RAM algorithm, given 1 ≤ D ≤ N^ε, X ∈ ℤ^{N×D}, Y ∈ ℤ^{D×N} with |entries| ≤ N^K and a list of at most N²/√D index pairs, outputs those entries of XY in O(N²/D^γ) time. Let ε* = sup of good ε. Is ε* > ln4/(5 ln5)? (Barrier version (b) is a separate question.)

**Credit:** Majdoddin, Thin matrix products up to D ≤ N^0.172 and lossless reductions for 3SUM, Exact Triangle and APSP, arXiv:2610.17420 (Oct 2026); building on Alman–Vassilevska Williams arXiv:2610.06783.

**Rests on recent unrefereed work. Check these premises first:**
- arXiv:2610.06783 (Alman–Vassilevska Williams, Oct 2026 preprint): assumes the thin-product subroutine and the subquadratic 3SUM / subcubic APSP refutation.
- arXiv:2610.17420 (Majdoddin, Oct 2026 preprint): assumes ε* ≥ ln4/(5 ln5) and that ⟨34,2,35⟩ is open.
- arXiv:2610.42012 (Chan–Itakura–Ma–Yu, Nov 2026 preprint): makes the stated 3SUM payoff stale (3SUM already O(n^1.965)).
- github.com/shreshth-s/thin-matrix-results (unrefereed repository) in refs.

**References:**
- Alman, Vassilevska Williams, Truly Subquadratic 3SUM and Truly Subcubic APSP via Triangles in Sparse Lopsided Graphs, arXiv:2610.06783 (Oct 2026)
- Majdoddin, Thin matrix products up to D<=N^0.172 and lossless reductions for 3SUM, Exact Triangle and APSP, arXiv:2610.17420 (Oct 2026)
- Coppersmith, Rapid multiplication of rectangular matrices, SICOMP 1982
- arXiv:2610.06783
- arXiv:2610.17420
- arXiv:2610.42012 (Chan, Itakura, Ma, Yu, Nov 2026)
- github.com/shreshth-s/thin-matrix-results

Difficulty estimate: 4.0/10 (calibrated: Collatz ≈ 5.5, twin primes ≈ 5.0). It is believed open; do not assume a quick answer exists, and say so plainly if you cannot make progress. Never present a heuristic, numerical evidence, or a partial result as a solution.

## What counts as an answer
Either a proof of `OpenProblems.QEDM032.Claim` or a proof of `¬ OpenProblems.QEDM032.Claim` (a disproof), in Lean 4 + Mathlib, using the exact statement in `problems/QED-M032/Statement.lean`. Read its "Formalization notes" first. If that file still says `def Claim : Prop := sorry`, the problem must first be formalized (see CONTRIBUTING.md); a faithful formalization is itself a welcome contribution.

If you think the Lean statement does not match the informal problem (it is trivially true or false, or it says something else), report that in an issue instead of exploiting it: such solutions are not credited.

## How to submit
1. Claim it (optional but encouraged): open an issue titled `Claim QED-M032` at https://github.com/floration/qed/issues/new?template=claim.yml. Comment on it at least once a week or the claim lapses.
2. Add `solutions/QED-M032/<github-username>/Solution.lean`:
```lean
import Mathlib
-- do NOT redefine Claim: CI prepends problems/QED-M032/Statement.lean to your file
theorem solution : OpenProblems.QEDM032.Claim := by   -- or ¬ OpenProblems.QEDM032.Claim
  ...
```
   Large proofs may add more `.lean` files (subfolders allowed) next to Solution.lean; CI concatenates them in path order before Solution.lean. Don't import them.
3. Add `solutions/QED-M032/<github-username>/meta.json`: `{"model": "<AI model used, or none>", "kind": "proof" | "disproof"}`. Optionally a `README.md` explaining the idea.
4. Open a pull request. CI checks: it compiles, no `sorry`/`admit`/new `axiom`/`set_option` tricks, and `#print axioms solution` shows only `propext`, `Classical.choice`, `Quot.sound`.

## Scoring
Size = number of non-blank, non-comment lines of `Solution.lean` excluding `import` lines (helper lemmas count). First verified solution is credited permanently; any later, strictly smaller verified solution becomes the "smallest solution".

## Rules for you, the model
- Do not modify `Statement.lean` in a solution PR.
- Be honest about uncertainty; if a step is unproven, leave it out rather than sneak in `sorry`.
- Test locally: `lake exe cache get && lake env lean solutions/QED-M032/<user>/Solution.lean`.
