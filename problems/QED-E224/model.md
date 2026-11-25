# QED-E224 — Infinitely many prime losing positions in subtract-a-square

You are an AI model helping someone attack this open problem. Read all of this before working.

## The problem
Extended set · Grade C · QED Original · Games

**Plain words:** In subtract-a-square, players alternately remove a positive square number of tokens from a pile, and whoever cannot move loses. Show that infinitely many prime pile sizes are losing positions for the player to move.

**Math:** Let $\mathcal P\subset\mathbb N_0$ be the P-positions of subtract-a-square: $0\in\mathcal P$, and $n\in\mathcal P$ iff $n-k^2\notin\mathcal P$ for all $1\le k\le\sqrt n$. Prove that $\mathcal P$ contains infinitely many primes.

**Credit:** QED original (archived Nov 2026, restored after re-review).

**References:**
- https://en.wikipedia.org/wiki/Subtract_a_square
- https://11011110.github.io/blog/2016/11/16/better-behaved-subtraction-game.html

Difficulty estimate: 7.0/10 (calibrated: Collatz ≈ 5.5, twin primes ≈ 5.0). It is believed open; do not assume a quick answer exists, and say so plainly if you cannot make progress. Never present a heuristic, numerical evidence, or a partial result as a solution.

## What counts as an answer
Either a proof of `OpenProblems.QEDE224.Claim` or a proof of `¬ OpenProblems.QEDE224.Claim` (a disproof), in Lean 4 + Mathlib, using the exact statement in `problems/QED-E224/Statement.lean`. Read its "Formalization notes" first. If that file still says `def Claim : Prop := sorry`, the problem must first be formalized (see CONTRIBUTING.md); a faithful formalization is itself a welcome contribution.

If you think the Lean statement does not match the informal problem (it is trivially true or false, or it says something else), report that in an issue instead of exploiting it: such solutions are not credited.

## How to submit
0. First time? Solve a test problem (QED-Q1, the 2-line one, at minimum) and submit it, to confirm your Lean setup and the submission pipeline work before spending effort here. Skip this step if this IS a test problem.
1. Claim it (optional but encouraged): open an issue titled `Claim QED-E224` at https://github.com/floration/qed/issues/new?template=claim.yml. Comment on it at least once a week or the claim lapses.
2. Add `solutions/QED-E224/<github-username>/Solution.lean`:
```lean
import Mathlib
-- do NOT redefine Claim: CI prepends problems/QED-E224/Statement.lean to your file
theorem solution : OpenProblems.QEDE224.Claim := by   -- or ¬ OpenProblems.QEDE224.Claim
  ...
```
   Large proofs may add more `.lean` files (subfolders allowed) next to Solution.lean; CI concatenates them in path order before Solution.lean. Don't import them.
3. Add `solutions/QED-E224/<github-username>/meta.json`: `{"model": "<AI model used, or none>", "kind": "proof" | "disproof"}`. Optionally a `README.md` explaining the idea.
4. Open a pull request. CI checks: it compiles, no `sorry`/`admit`/new `axiom`/`set_option` tricks, and `#print axioms solution` shows only `propext`, `Classical.choice`, `Quot.sound`.

## Scoring
Size = number of non-blank, non-comment lines of `Solution.lean` excluding `import` lines (helper lemmas count). First verified solution is credited permanently; any later, strictly smaller verified solution becomes the "smallest solution".

## Rules for you, the model
- Do not modify `Statement.lean` in a solution PR.
- Be honest about uncertainty; if a step is unproven, leave it out rather than sneak in `sorry`.
- Test locally: `lake exe cache get && lake env lean solutions/QED-E224/<user>/Solution.lean`.
