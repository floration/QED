# QED-E085 — How fast does eps_k vanish for k-OV in low dimension?

You are an AI model helping someone attack this open problem. Read all of this before working.

## The problem
Extended set · Grade B · QED Extension · Complexity

**Plain words:** Dürr-Kipouridis-Lampis-Węgrzycki show k-OV is solvable in O(2^{(1-eps_k)d} n) for every fixed k, and that eps_k -> 0 is forced by the Set Cover Conjecture. Determine the decay rate: prove eps_k >= c/log k (or c/k), or show that eps_k >= omega(1/k) would refute the Set Cover Conjecture.

**Math:** Prove or disprove: there are absolute constants c > 0 and p ∈ ℕ such that for every k ≥ 2, k-OV on k sets of n vectors in {0,1}^d is solvable by a deterministic word-RAM algorithm in time O_k(2^{(1 - c/ln k) d} · n^p). (The exponent p must not depend on k: otherwise brute force n^k·d makes the statement trivial. Companion SCC direction is separate.)

**Credit:** Dürr, Kipouridis, Lampis, Węgrzycki, 'Faster algorithms for k-Orthogonal Vectors in low dimension', ICALP 2026, arXiv:2507.11098; Björklund–Kaski, STOC 2024, arXiv:2310.11926.

**References:**
- Dürr, Kipouridis, Lampis, Węgrzycki, Faster algorithms for k-Orthogonal Vectors in low dimension, ICALP 2026, arXiv:2507.11098
- Björklund, Kaski, The Asymptotic Rank Conjecture and the Set Cover Conjecture are not both true, STOC 2024, arXiv:2310.11926

Difficulty estimate: 3.0/10 (calibrated: Collatz ≈ 5.5, twin primes ≈ 5.0). It is believed open; do not assume a quick answer exists, and say so plainly if you cannot make progress. Never present a heuristic, numerical evidence, or a partial result as a solution.

## What counts as an answer
Either a proof of `OpenProblems.QEDE085.Claim` or a proof of `¬ OpenProblems.QEDE085.Claim` (a disproof), in Lean 4 + Mathlib, using the exact statement in `problems/QED-E085/Statement.lean`. Read its "Formalization notes" first. If that file still says `def Claim : Prop := sorry`, the problem must first be formalized (see CONTRIBUTING.md); a faithful formalization is itself a welcome contribution.

If you think the Lean statement does not match the informal problem (it is trivially true or false, or it says something else), report that in an issue instead of exploiting it: such solutions are not credited.

## How to submit
0. First time? Solve a test problem (QED-Q1, the 2-line one, at minimum) and submit it, to confirm your Lean setup and the submission pipeline work before spending effort here. Skip this step if this IS a test problem.
1. Claim it (optional but encouraged): open an issue titled `Claim QED-E085` at https://github.com/floration/qed/issues/new?template=claim.yml. Comment on it at least once a week or the claim lapses.
2. Add `solutions/QED-E085/<github-username>/Solution.lean`:
```lean
import Mathlib
-- do NOT redefine Claim: CI prepends problems/QED-E085/Statement.lean to your file
theorem solution : OpenProblems.QEDE085.Claim := by   -- or ¬ OpenProblems.QEDE085.Claim
  ...
```
3. Add `solutions/QED-E085/<github-username>/meta.json`: `{"model": "<AI model used, or none>", "kind": "proof" | "disproof"}`. Optionally a `README.md` explaining the idea.
4. Open a pull request. CI checks: it compiles, no `sorry`/`admit`/new `axiom`/`set_option` tricks, and `#print axioms solution` shows only `propext`, `Classical.choice`, `Quot.sound`.

## Scoring
Size = number of non-blank, non-comment lines of `Solution.lean` excluding `import` lines (helper lemmas count). First verified solution is credited permanently; any later, strictly smaller verified solution becomes the "smallest solution".

## Rules for you, the model
- Do not modify `Statement.lean` in a solution PR.
- Be honest about uncertainty; if a step is unproven, leave it out rather than sneak in `sorry`.
- Test locally: `lake exe cache get && lake env lean solutions/QED-E085/<user>/Solution.lean`.
