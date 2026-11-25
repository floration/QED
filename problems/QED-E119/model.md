# QED-E119 — Maker-Breaker 7-in-a-row on the infinite grid

You are an AI model helping someone attack this open problem. Read all of this before working.

## The problem
Extended set · Grade B · QED Curated · Games

**Plain words:** Two players take turns claiming cells of the infinite square grid. Maker wins if she ever owns k consecutive cells in a row, column or diagonal, and Breaker wins if he stops this forever. Maker wins for k <= 5, and Breaker wins for k >= 8 with a pairing strategy. Does Breaker win for k = 7?

**Math:** Maker and Breaker alternately claim one unclaimed cell of $\mathbb Z^2$, Maker first. A winning line is a set $\{p+i d:0\le i<7\}$ with $p\in\mathbb Z^2$ and $d\in\{(1,0),(0,1),(1,1),(1,-1)\}$. Decide whether Breaker has a strategy such that, against every Maker strategy, Maker never owns all cells of any winning line. (The analogous question for $k=6$ is also open.)

**Credit:** Positional game folklore; Beck, Combinatorial Games: Tic-Tac-Toe Theory; Hollósi–Pluhár (2021)

**Rests on recent unrefereed work. Check these premises first:**
- Answer could plausibly need a large computer search over strip games
- Infinite-board game: formal statement needs strategies on histories

**References:**
- https://arxiv.org/abs/2107.05363
- https://arxiv.org/abs/1004.2460
- https://arxiv.org/abs/1005.5469
- https://arxiv.org/abs/1501.01467

Difficulty estimate: 4.5/10 (calibrated: Collatz ≈ 5.5, twin primes ≈ 5.0). It is believed open; do not assume a quick answer exists, and say so plainly if you cannot make progress. Never present a heuristic, numerical evidence, or a partial result as a solution.

## What counts as an answer
Either a proof of `OpenProblems.QEDE119.Claim` or a proof of `¬ OpenProblems.QEDE119.Claim` (a disproof), in Lean 4 + Mathlib, using the exact statement in `problems/QED-E119/Statement.lean`. Read its "Formalization notes" first. If that file still says `def Claim : Prop := sorry`, the problem must first be formalized (see CONTRIBUTING.md); a faithful formalization is itself a welcome contribution.

If you think the Lean statement does not match the informal problem (it is trivially true or false, or it says something else), report that in an issue instead of exploiting it: such solutions are not credited.

## How to submit
0. First time? Solve a test problem (QED-Q1, the 2-line one, at minimum) and submit it, to confirm your Lean setup and the submission pipeline work before spending effort here. Skip this step if this IS a test problem.
1. Claim it (optional but encouraged): open an issue titled `Claim QED-E119` at https://github.com/floration/qed/issues/new?template=claim.yml. Comment on it at least once a week or the claim lapses.
2. Add `solutions/QED-E119/<github-username>/Solution.lean`:
```lean
import Mathlib
-- do NOT redefine Claim: CI prepends problems/QED-E119/Statement.lean to your file
theorem solution : OpenProblems.QEDE119.Claim := by   -- or ¬ OpenProblems.QEDE119.Claim
  ...
```
   Large proofs may add more `.lean` files (subfolders allowed) next to Solution.lean; CI concatenates them in path order before Solution.lean. Don't import them.
3. Add `solutions/QED-E119/<github-username>/meta.json`: `{"model": "<AI model used, or none>", "kind": "proof" | "disproof"}`. Optionally a `README.md` explaining the idea.
4. Open a pull request. CI checks: it compiles, no `sorry`/`admit`/new `axiom`/`set_option` tricks, and `#print axioms solution` shows only `propext`, `Classical.choice`, `Quot.sound`.

## Scoring
Size = number of non-blank, non-comment lines of `Solution.lean` excluding `import` lines (helper lemmas count). First verified solution is credited permanently; any later, strictly smaller verified solution becomes the "smallest solution".

## Rules for you, the model
- Do not modify `Statement.lean` in a solution PR.
- Be honest about uncertainty; if a step is unproven, leave it out rather than sneak in `sorry`.
- Test locally: `lake exe cache get && lake env lean solutions/QED-E119/<user>/Solution.lean`.
