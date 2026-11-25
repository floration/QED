# QED-E136 — Does a perfect cuboid exist?

You are an AI model helping someone attack this open problem. Read all of this before working.

## The problem
Extended set · Grade B · QED Curated · Number theory

**Plain words:** Is there a box whose three edges, three face diagonals and space diagonal all have whole-number lengths? Boxes with whole-number edges and face diagonals (Euler bricks, such as 44 × 117 × 240) come in infinite families, but in every known one the space diagonal is irrational. Nobody has found a perfect box or proved that none exists.

**Math:** Decide whether there exist positive integers $a,b,c$ such that $a^2+b^2$, $b^2+c^2$, $c^2+a^2$ and $a^2+b^2+c^2$ are all perfect squares.

**Credit:** Classical (Euler; Kraitchik; listed as D18 in Guy, Unsolved Problems in Number Theory).

**Rests on recent unrefereed work. Check these premises first:**
- Several unrefereed 2026 nonexistence claims (arXiv:2602.00239 math.GM, arXiv:2604.28072) exist; none accepted, but the scorer should know they are out there
- Very famous: low novelty

**References:**
- https://en.wikipedia.org/wiki/Euler_brick
- https://arxiv.org/abs/2401.06784
- https://arxiv.org/abs/2602.00239
- https://arxiv.org/html/2604.28072
- https://arxiv.org/pdf/1506.02215

Difficulty estimate: 6.0/10 (calibrated: Collatz ≈ 5.5, twin primes ≈ 5.0). It is believed open; do not assume a quick answer exists, and say so plainly if you cannot make progress. Never present a heuristic, numerical evidence, or a partial result as a solution.

## What counts as an answer
Either a proof of `OpenProblems.QEDE136.Claim` or a proof of `¬ OpenProblems.QEDE136.Claim` (a disproof), in Lean 4 + Mathlib, using the exact statement in `problems/QED-E136/Statement.lean`. Read its "Formalization notes" first. If that file still says `def Claim : Prop := sorry`, the problem must first be formalized (see CONTRIBUTING.md); a faithful formalization is itself a welcome contribution.

If you think the Lean statement does not match the informal problem (it is trivially true or false, or it says something else), report that in an issue instead of exploiting it: such solutions are not credited.

## How to submit
0. First time? Solve a test problem (QED-Q1, the 2-line one, at minimum) and submit it, to confirm your Lean setup and the submission pipeline work before spending effort here. Skip this step if this IS a test problem.
1. Claim it (optional but encouraged): open an issue titled `Claim QED-E136` at https://github.com/floration/qed/issues/new?template=claim.yml. Comment on it at least once a week or the claim lapses.
2. Add `solutions/QED-E136/<github-username>/Solution.lean`:
```lean
import Mathlib
-- do NOT redefine Claim: CI prepends problems/QED-E136/Statement.lean to your file
theorem solution : OpenProblems.QEDE136.Claim := by   -- or ¬ OpenProblems.QEDE136.Claim
  ...
```
   Large proofs may add more `.lean` files (subfolders allowed) next to Solution.lean; CI concatenates them in path order before Solution.lean. Don't import them.
3. Add `solutions/QED-E136/<github-username>/meta.json`: `{"model": "<AI model used, or none>", "kind": "proof" | "disproof"}`. Optionally a `README.md` explaining the idea.
4. Open a pull request. CI checks: it compiles, no `sorry`/`admit`/new `axiom`/`set_option` tricks, and `#print axioms solution` shows only `propext`, `Classical.choice`, `Quot.sound`.

## Scoring
Size = number of non-blank, non-comment lines of `Solution.lean` excluding `import` lines (helper lemmas count). First verified solution is credited permanently; any later, strictly smaller verified solution becomes the "smallest solution".

## Rules for you, the model
- Do not modify `Statement.lean` in a solution PR.
- Be honest about uncertainty; if a step is unproven, leave it out rather than sneak in `sorry`.
- Test locally: `lake exe cache get && lake env lean solutions/QED-E136/<user>/Solution.lean`.
