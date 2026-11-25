# QED-M016 — Additive excess for sorting pattern-avoiding sequences

You are an AI model helping someone attack this open problem. Read all of this before working.

## The problem
Main set · Grade B · QED Extension · Combinatorics

**Plain words:** Sorting an array promised to avoid a fixed pattern needs at least log2 of the number of allowed orders comparisons, and Fredman's theorem says 2n more always suffice. How many extra comparisons per element are really needed? Show that fewer than 2n extra suffice for 1324-avoiding inputs, or show that a linear excess is necessary for some pattern.

**Math:** For a permutation τ let C_τ(n) be the minimum worst-case number of comparisons of a decision tree (knowing τ) that sorts a_1,…,a_n under the promise that their order pattern lies in Av_n(τ), and δ_τ = limsup_n (C_τ(n) − log_2|Av_n(τ)|)/n ∈ [0,2]. Prove or disprove: δ_τ = 0 for every permutation τ.

**Credit:** Fredman 1976 (sorting with partial information); Opler, arXiv:2409.07868 (ESA 2025), sorting pattern-avoiding permutations

**QED results so far (reviewer-derived; check before relying on them):** delta_tau >= 0: information-theoretic bound C_tau(n) >= log2|Av_n(tau)| (trivial). delta_tau <= 2: Fredman (1976), any set G of permutations can be sorted with log2|G| + 2n comparisons. Opler (arXiv 2409.07868) gives O((log c_tau +1)n), optimal only up to a constant factor. delta_tau = 0 is known for tau of length 3 in the 132-class (stack sorting, <=2n vs log2 C_n = 2n - O(log n)).

**References:**
- https://arxiv.org/abs/2409.07868
- https://drops.dagstuhl.de/storage/00lipics/lipics-vol351-esa2025/html/LIPIcs.ESA.2025.104/LIPIcs.ESA.2025.104.html

Difficulty estimate: 3.5/10 (calibrated: Collatz ≈ 5.5, twin primes ≈ 5.0). It is believed open; do not assume a quick answer exists, and say so plainly if you cannot make progress. Never present a heuristic, numerical evidence, or a partial result as a solution.

## What counts as an answer
Either a proof of `OpenProblems.QEDM016.Claim` or a proof of `¬ OpenProblems.QEDM016.Claim` (a disproof), in Lean 4 + Mathlib, using the exact statement in `problems/QED-M016/Statement.lean`. Read its "Formalization notes" first. If that file still says `def Claim : Prop := sorry`, the problem must first be formalized (see CONTRIBUTING.md); a faithful formalization is itself a welcome contribution.

If you think the Lean statement does not match the informal problem (it is trivially true or false, or it says something else), report that in an issue instead of exploiting it: such solutions are not credited.

## How to submit
0. First time? Solve a test problem (QED-Q1, the 2-line one, at minimum) and submit it, to confirm your Lean setup and the submission pipeline work before spending effort here. Skip this step if this IS a test problem.
1. Claim it (optional but encouraged): open an issue titled `Claim QED-M016` at https://github.com/floration/qed/issues/new?template=claim.yml. Comment on it at least once a week or the claim lapses.
2. Add `solutions/QED-M016/<github-username>/Solution.lean`:
```lean
import Mathlib
-- do NOT redefine Claim: CI prepends problems/QED-M016/Statement.lean to your file
theorem solution : OpenProblems.QEDM016.Claim := by   -- or ¬ OpenProblems.QEDM016.Claim
  ...
```
   Large proofs may add more `.lean` files (subfolders allowed) next to Solution.lean; CI concatenates them in path order before Solution.lean. Don't import them.
3. Add `solutions/QED-M016/<github-username>/meta.json`: `{"model": "<AI model used, or none>", "kind": "proof" | "disproof"}`. Optionally a `README.md` explaining the idea.
4. Open a pull request. CI checks: it compiles, no `sorry`/`admit`/new `axiom`/`set_option` tricks, and `#print axioms solution` shows only `propext`, `Classical.choice`, `Quot.sound`.

## Scoring
Size = number of non-blank, non-comment lines of `Solution.lean` excluding `import` lines (helper lemmas count). First verified solution is credited permanently; any later, strictly smaller verified solution becomes the "smallest solution".

## Rules for you, the model
- Do not modify `Statement.lean` in a solution PR.
- Be honest about uncertainty; if a step is unproven, leave it out rather than sneak in `sorry`.
- Test locally: `lake exe cache get && lake env lean solutions/QED-M016/<user>/Solution.lean`.
