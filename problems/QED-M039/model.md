# QED-M039 — Matching lower bound for OMv on low-VC-dimension matrices

You are an AI model helping someone attack this open problem. Read all of this before working.

## The problem
Main set · Grade B · QED Curated · Complexity

**Plain words:** Anand-van den Brand-McCarty give O~(n^2) preprocessing and O~(n^{2-1/d}) query time for Boolean Mv when M has VC-dimension d. Show, assuming OMv (or unconditionally in the cell-probe model), that n^{2-c/d} query time is necessary for some constant c, for d up to some omega(1) function; or improve the upper bound to n^{2-f(d)} with f(d) >> 1/d.

**Math:** Assume the OMv conjecture (no randomized word-RAM algorithm solves OMv in total time O(n^{3-ε}) for any ε > 0). Prove there are c > 0 and D(n) → ∞ such that for every d(n) with 1 ≤ d(n) ≤ D(n), every ε > 0 and every p, no randomized algorithm with O(n^p) preprocessing answers the n online Boolean matrix-vector queries for n×n matrices of VC-dimension ≤ d(n) in total query time O(n^{3-c/d(n)-ε}) (amortized n^{2-c/d(n)-ε} per query). (Positive alternative is a separate question.)

**Credit:** Anand, van den Brand, McCarty, 'The Structural Complexity of Matrix-Vector Multiplication', NeurIPS 2025, arXiv:2502.21240; OMv conjecture: Henzinger, Krinninger, Nanongkai, Saranurak (STOC 2015).

**References:**
- Anand, van den Brand, McCarty, The Structural Complexity of Matrix-Vector Multiplication, NeurIPS 2025, arXiv:2502.21240
- Henzinger, Krinninger, Nanongkai, Saranurak, Unifying and strengthening hardness for dynamic problems via the OMv conjecture, STOC 2015

Difficulty estimate: 4.5/10 (calibrated: Collatz ≈ 5.5, twin primes ≈ 5.0). It is believed open; do not assume a quick answer exists, and say so plainly if you cannot make progress. Never present a heuristic, numerical evidence, or a partial result as a solution.

## What counts as an answer
Either a proof of `OpenProblems.QEDM039.Claim` or a proof of `¬ OpenProblems.QEDM039.Claim` (a disproof), in Lean 4 + Mathlib, using the exact statement in `problems/QED-M039/Statement.lean`. Read its "Formalization notes" first. If that file still says `def Claim : Prop := sorry`, the problem must first be formalized (see CONTRIBUTING.md); a faithful formalization is itself a welcome contribution.

If you think the Lean statement does not match the informal problem (it is trivially true or false, or it says something else), report that in an issue instead of exploiting it: such solutions are not credited.

## How to submit
1. Claim it (optional but encouraged): open an issue titled `Claim QED-M039` at https://github.com/floration/qed/issues/new?template=claim.yml. Comment on it at least once a week or the claim lapses.
2. Add `solutions/QED-M039/<github-username>/Solution.lean`:
```lean
import Mathlib
-- do NOT redefine Claim: CI prepends problems/QED-M039/Statement.lean to your file
theorem solution : OpenProblems.QEDM039.Claim := by   -- or ¬ OpenProblems.QEDM039.Claim
  ...
```
   Large proofs may add more `.lean` files (subfolders allowed) next to Solution.lean; CI concatenates them in path order before Solution.lean. Don't import them.
3. Add `solutions/QED-M039/<github-username>/meta.json`: `{"model": "<AI model used, or none>", "kind": "proof" | "disproof"}`. Optionally a `README.md` explaining the idea.
4. Open a pull request. CI checks: it compiles, no `sorry`/`admit`/new `axiom`/`set_option` tricks, and `#print axioms solution` shows only `propext`, `Classical.choice`, `Quot.sound`.

## Scoring
Size = number of non-blank, non-comment lines of `Solution.lean` excluding `import` lines (helper lemmas count). First verified solution is credited permanently; any later, strictly smaller verified solution becomes the "smallest solution".

## Rules for you, the model
- Do not modify `Statement.lean` in a solution PR.
- Be honest about uncertainty; if a step is unproven, leave it out rather than sneak in `sorry`.
- Test locally: `lake exe cache get && lake env lean solutions/QED-M039/<user>/Solution.lean`.
