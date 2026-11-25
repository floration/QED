# QED-M041 — Proof complexity of the sensitivity theorem

You are an AI model helping someone attack this open problem. Read all of this before working.

## The problem
Main set · Grade B · QED Original · Complexity

**Plain words:** Huang proved that any set of more than half the corners of the n-cube contains a corner with at least √n neighbours inside the set. Write this as a propositional formula with one variable per corner. Do polynomial-size proofs exist in resolution, cutting planes or sum-of-squares, measured against the 2^n variables?

**Math:** Let N = 2^n, K = 2^{n-1}+1, d = ⌈√n⌉ − 1. SENS_n is the CNF on main variables x_v (v ∈ {0,1}^n) and sequential-counter variables s_{i,j} (0 ≤ i ≤ N, 0 ≤ j ≤ K). It consists of (i) the counter clauses (s_{N,K}); (¬s_{0,j}) for 1 ≤ j ≤ K; (¬s_{i,j} ∨ s_{i−1,j} ∨ x_i) and (¬s_{i,j} ∨ s_{i−1,j} ∨ s_{i−1,j−1}) for 1 ≤ i ≤ N, 1 ≤ j ≤ K, with x_1,…,x_N the main variables in a fixed order; together these say ∑_v x_v ≥ K; and (ii) the clauses ¬x_v ∨ ⋁_{u∈U} ¬x_u for every v and every (d+1)-set U of neighbours of v. Its size is N^{O(1)}: Θ(N·K) counter clauses plus N^{1+o(1)} neighbourhood clauses. It is unsatisfiable by Huang's theorem. Does SENS_n have refutations of size N^{O(1)} in (a) resolution, (b) cutting planes (size counted in bits), or (c) sum-of-squares of degree O(log N)? Claim: at least one of (a), (b), (c) holds. Each part is also stated separately. Lower bounds 2^{N^{Ω(1)}} are equally of interest.

**References:**
- https://arxiv.org/abs/1907.00847
- https://arxiv.org/pdf/1912.05406

Difficulty estimate: 3.5/10 (calibrated: Collatz ≈ 5.5, twin primes ≈ 5.0). It is believed open; do not assume a quick answer exists, and say so plainly if you cannot make progress. Never present a heuristic, numerical evidence, or a partial result as a solution.

## What counts as an answer
Either a proof of `OpenProblems.QEDM041.Claim` or a proof of `¬ OpenProblems.QEDM041.Claim` (a disproof), in Lean 4 + Mathlib, using the exact statement in `problems/QED-M041/Statement.lean`. Read its "Formalization notes" first. If that file still says `def Claim : Prop := sorry`, the problem must first be formalized (see CONTRIBUTING.md); a faithful formalization is itself a welcome contribution.

If you think the Lean statement does not match the informal problem (it is trivially true or false, or it says something else), report that in an issue instead of exploiting it: such solutions are not credited.

## How to submit
0. First time? Solve a test problem (QED-Q1, the 2-line one, at minimum) and submit it, to confirm your Lean setup and the submission pipeline work before spending effort here. Skip this step if this IS a test problem.
1. Claim it (optional but encouraged): open an issue titled `Claim QED-M041` at https://github.com/floration/qed/issues/new?template=claim.yml. Comment on it at least once a week or the claim lapses.
2. Add `solutions/QED-M041/<github-username>/Solution.lean`:
```lean
import Mathlib
-- do NOT redefine Claim: CI prepends problems/QED-M041/Statement.lean to your file
theorem solution : OpenProblems.QEDM041.Claim := by   -- or ¬ OpenProblems.QEDM041.Claim
  ...
```
   Large proofs may add more `.lean` files (subfolders allowed) next to Solution.lean; CI concatenates them in path order before Solution.lean. Don't import them.
3. Add `solutions/QED-M041/<github-username>/meta.json`: `{"model": "<AI model used, or none>", "kind": "proof" | "disproof"}`. Optionally a `README.md` explaining the idea.
4. Open a pull request. CI checks: it compiles, no `sorry`/`admit`/new `axiom`/`set_option` tricks, and `#print axioms solution` shows only `propext`, `Classical.choice`, `Quot.sound`.

## Scoring
Size = number of non-blank, non-comment lines of `Solution.lean` excluding `import` lines (helper lemmas count). First verified solution is credited permanently; any later, strictly smaller verified solution becomes the "smallest solution".

## Rules for you, the model
- Do not modify `Statement.lean` in a solution PR.
- Be honest about uncertainty; if a step is unproven, leave it out rather than sneak in `sorry`.
- Test locally: `lake exe cache get && lake env lean solutions/QED-M041/<user>/Solution.lean`.
