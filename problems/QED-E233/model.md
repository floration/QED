# QED-E233 — Largest prime factor of 2^n + n

You are an AI model helping someone attack this open problem. Read all of this before working.

## The problem
Extended set · Grade C · QED Original · Number theory

**Plain words:** Show the largest prime factor of 2^n + n grows faster than any fixed multiple of n.

**Math:** Let $P(m)$ be the largest prime factor of $m$. Prove $P(2^n+n)/n\to\infty$ as $n\to\infty$. (Intermediate target: $P(2^n+n)\ge n$ for all large $n$.)

**Credit:** QED original (archived Nov 2026, restored after re-review).

**References:**
- https://arxiv.org/abs/0704.1327
- https://uwaterloo.ca/pure-mathematics/sites/default/files/uploads/documents/rmj-1985-15-2-599.pdf
- https://www.impan.pl/en/publishing-house/journals-and-series/acta-arithmetica/all/206/3/114963/uniform-explicit-stewart-s-theorem-on-prime-factors-of-linear-recurrences

Difficulty estimate: 7.5/10 (calibrated: Collatz ≈ 5.5, twin primes ≈ 5.0). It is believed open; do not assume a quick answer exists, and say so plainly if you cannot make progress. Never present a heuristic, numerical evidence, or a partial result as a solution.

## What counts as an answer
Either a proof of `OpenProblems.QEDE233.Claim` or a proof of `¬ OpenProblems.QEDE233.Claim` (a disproof), in Lean 4 + Mathlib, using the exact statement in `problems/QED-E233/Statement.lean`. Read its "Formalization notes" first. If that file still says `def Claim : Prop := sorry`, the problem must first be formalized (see CONTRIBUTING.md); a faithful formalization is itself a welcome contribution.

If you think the Lean statement does not match the informal problem (it is trivially true or false, or it says something else), report that in an issue instead of exploiting it: such solutions are not credited.

## How to submit
0. First time? Solve a test problem (QED-Q1, the 2-line one, at minimum) and submit it, to confirm your Lean setup and the submission pipeline work before spending effort here. Skip this step if this IS a test problem.
1. Claim it (optional but encouraged): open an issue titled `Claim QED-E233` at https://github.com/floration/qed/issues/new?template=claim.yml. Comment on it at least once a week or the claim lapses.
2. Add `solutions/QED-E233/<github-username>/Solution.lean`:
```lean
import Mathlib
-- do NOT redefine Claim: CI prepends problems/QED-E233/Statement.lean to your file
theorem solution : OpenProblems.QEDE233.Claim := by   -- or ¬ OpenProblems.QEDE233.Claim
  ...
```
   Large proofs may add more `.lean` files (subfolders allowed) next to Solution.lean; CI concatenates them in path order before Solution.lean. Don't import them.
3. Add `solutions/QED-E233/<github-username>/meta.json`: `{"model": "<AI model used, or none>", "kind": "proof" | "disproof"}`. Optionally a `README.md` explaining the idea.
4. Open a pull request. CI checks: it compiles, no `sorry`/`admit`/new `axiom`/`set_option` tricks, and `#print axioms solution` shows only `propext`, `Classical.choice`, `Quot.sound`.

## Scoring
Size = number of non-blank, non-comment lines of `Solution.lean` excluding `import` lines (helper lemmas count). First verified solution is credited permanently; any later, strictly smaller verified solution becomes the "smallest solution".

## Rules for you, the model
- Do not modify `Statement.lean` in a solution PR.
- Be honest about uncertainty; if a step is unproven, leave it out rather than sneak in `sorry`.
- Test locally: `lake exe cache get && lake env lean solutions/QED-E233/<user>/Solution.lean`.
