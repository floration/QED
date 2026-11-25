# QED-E132 — Optimal sphere packing in dimension 5, 6 or 7

You are an AI model helping someone attack this open problem. Read all of this before working.

## The problem
Extended set · Grade C · QED Curated · Geometry

**Plain words:** In dimensions 5, 6 and 7 the densest known ball packings come from the lattices D5, E6 and E7, which are known to be the best lattice packings. Prove that at least one of them is optimal among all packings.

**Math:** Let $\Delta_n$ be the supremum of upper densities of packings of congruent balls in $\mathbb{R}^n$. Prove that at least one of $\Delta_5=\pi^2/(15\sqrt2)$ (density of $D_5$), $\Delta_6=\pi^3/(48\sqrt3)$ (density of $E_6$), $\Delta_7=\pi^3/105$ (density of $E_7$) holds.

**Credit:** Classical

**References:**
- https://arxiv.org/abs/1712.04099
- https://www.ams.org/notices/201602/rnoti-p102.pdf

Difficulty estimate: 8.5/10 (anchored scale: 1 ≈ Erdős–Ginzburg–Ziv, 2.5 ≈ the sensitivity conjecture, 5 ≈ bounded prime gaps, 7.5 ≈ the Riemann Hypothesis, 10 ≈ P vs NP). It is believed open; do not assume a quick answer exists, and say so plainly if you cannot make progress. Never present a heuristic, numerical evidence, or a partial result as a solution.

## What counts as an answer
Either a proof of `OpenProblems.QEDE132.Claim` or a proof of `¬ OpenProblems.QEDE132.Claim` (a disproof), in Lean 4 + Mathlib, using the exact statement in `problems/QED-E132/Statement.lean`. Read its "Formalization notes" first. If that file still says `def Claim : Prop := sorry`, the problem must first be formalized (see CONTRIBUTING.md); a faithful formalization is itself a welcome contribution.

If you think the Lean statement does not match the informal problem (it is trivially true or false, or it says something else), report that in an issue instead of exploiting it: such solutions are not credited.

## How to submit
0. First time? Solve a test problem (QED-Q1, the 2-line one, at minimum) and submit it, to confirm your Lean setup and the submission pipeline work before spending effort here. Skip this step if this IS a test problem.
1. Claim it (optional but encouraged): open an issue titled `Claim QED-E132` at https://github.com/floration/qed/issues/new?template=claim.yml. Comment on it at least once a week or the claim lapses.
2. Add `solutions/QED-E132/<github-username>/Solution.lean`:
```lean
import Mathlib
-- do NOT redefine Claim: CI prepends problems/QED-E132/Statement.lean to your file
theorem solution : OpenProblems.QEDE132.Claim := by   -- or ¬ OpenProblems.QEDE132.Claim
  ...
```
   Large proofs may add more `.lean` files (subfolders allowed) next to Solution.lean; CI concatenates them in path order before Solution.lean. Don't import them.
3. Add `solutions/QED-E132/<github-username>/meta.json`: `{"model": "<AI model used, or none>", "kind": "proof" | "disproof"}`. Optionally a `README.md` explaining the idea.
4. Open a pull request. CI checks: it compiles, no `sorry`/`admit`/new `axiom`/`set_option` tricks, and `#print axioms solution` shows only `propext`, `Classical.choice`, `Quot.sound`.

## Scoring
Size = number of non-blank, non-comment lines of `Solution.lean` excluding `import` lines (helper lemmas count). First verified solution is credited permanently; any later, strictly smaller verified solution becomes the "smallest solution".

## Rules for you, the model
- Do not modify `Statement.lean` in a solution PR.
- Be honest about uncertainty; if a step is unproven, leave it out rather than sneak in `sorry`.
- Test locally: `lake exe cache get && lake env lean solutions/QED-E132/<user>/Solution.lean`.
