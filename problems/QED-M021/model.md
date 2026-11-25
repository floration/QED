# QED-M021 — Distinct character degrees of the symmetric group

You are an AI model helping someone attack this open problem. Read all of this before working.

## The problem
Main set · Grade B · QED Curated · Combinatorics

**Plain words:** Conjugate partitions always give representations of S_n of the same dimension, so at most about half of the p(n) irreducible representations can have distinct dimensions. Decide whether the fraction of distinct dimensions tends to a limit, and whether that limit is positive.

**Math:** Let d(n) = #{f^λ : λ ⊢ n} be the number of distinct irreducible character degrees of S_n and p(n) the number of partitions of n. Prove or disprove: d(n)/p(n) converges to a positive limit L as n → ∞.

**Credit:** On the irreducible character degrees of symmetric groups and their multiplicities, arXiv:2410.01726 (2024)

**Rests on recent unrefereed work. Check these premises first:**
- arXiv:2410.01726 (preprint, refereeing status unclear): the numerical data for n <= 129 and the suggested limit near 2.5 are context only; Claim does not depend on them.

**References:**
- https://arxiv.org/abs/2410.01726v3
- https://arxiv.org/html/2410.01726v3

Difficulty estimate: 3.0/10 (calibrated: Collatz ≈ 5.5, twin primes ≈ 5.0). It is believed open; do not assume a quick answer exists, and say so plainly if you cannot make progress. Never present a heuristic, numerical evidence, or a partial result as a solution.

## What counts as an answer
Either a proof of `OpenProblems.QEDM021.Claim` or a proof of `¬ OpenProblems.QEDM021.Claim` (a disproof), in Lean 4 + Mathlib, using the exact statement in `problems/QED-M021/Statement.lean`. Read its "Formalization notes" first. If that file still says `def Claim : Prop := sorry`, the problem must first be formalized (see CONTRIBUTING.md); a faithful formalization is itself a welcome contribution.

If you think the Lean statement does not match the informal problem (it is trivially true or false, or it says something else), report that in an issue instead of exploiting it: such solutions are not credited.

## How to submit
1. Claim it (optional but encouraged): open an issue titled `Claim QED-M021` at https://github.com/floration/qed/issues/new?template=claim.yml. Comment on it at least once a week or the claim lapses.
2. Add `solutions/QED-M021/<github-username>/Solution.lean`:
```lean
import Mathlib
-- do NOT redefine Claim: CI prepends problems/QED-M021/Statement.lean to your file
theorem solution : OpenProblems.QEDM021.Claim := by   -- or ¬ OpenProblems.QEDM021.Claim
  ...
```
   Large proofs may add more `.lean` files (subfolders allowed) next to Solution.lean; CI concatenates them in path order before Solution.lean. Don't import them.
3. Add `solutions/QED-M021/<github-username>/meta.json`: `{"model": "<AI model used, or none>", "kind": "proof" | "disproof"}`. Optionally a `README.md` explaining the idea.
4. Open a pull request. CI checks: it compiles, no `sorry`/`admit`/new `axiom`/`set_option` tricks, and `#print axioms solution` shows only `propext`, `Classical.choice`, `Quot.sound`.

## Scoring
Size = number of non-blank, non-comment lines of `Solution.lean` excluding `import` lines (helper lemmas count). First verified solution is credited permanently; any later, strictly smaller verified solution becomes the "smallest solution".

## Rules for you, the model
- Do not modify `Statement.lean` in a solution PR.
- Be honest about uncertainty; if a step is unproven, leave it out rather than sneak in `sorry`.
- Test locally: `lake exe cache get && lake env lean solutions/QED-M021/<user>/Solution.lean`.
