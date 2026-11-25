# QED-M118 — Exponentially beat the 2^{-n} sphere-packing lower bound

You are an AI model helping someone attack this open problem. Read all of this before working.

## The problem
Main set · Grade A · QED Curated · Geometry

**Plain words:** In high dimension n the best sphere packings known have density only about n²·2^{-n} (up to log factors), barely above the trivial 2^{-n} from greedy/saturated packings, while the best upper bound is about 2^{-0.599n}. Is there a constant c>1 with packings of density at least c^n·2^{-n} in all large dimensions?

**Math:** Let $\Delta_n$ be the supremum of upper densities of packings of congruent balls in $\mathbb{R}^n$. Prove or disprove: there exist $c>1$ and $N$ such that $\Delta_n\ge c^n2^{-n}$ for all $n\ge N$.

**Credit:** Minkowski; Klartag; Kabatiansky–Levenshtein

**References:**
- https://arxiv.org/abs/2610.12619
- https://arxiv.org/abs/2312.10026
- https://arxiv.org/abs/2606.13313
- https://arxiv.org/abs/2608.00920
- https://arxiv.org/abs/math/0508381

Difficulty estimate: 8.5/10 (anchored scale: 1 ≈ Erdős–Ginzburg–Ziv, 2.5 ≈ the sensitivity conjecture, 5 ≈ bounded prime gaps, 7.5 ≈ the Riemann Hypothesis, 10 ≈ P vs NP). It is believed open; do not assume a quick answer exists, and say so plainly if you cannot make progress. Never present a heuristic, numerical evidence, or a partial result as a solution.

## What counts as an answer
Either a proof of `OpenProblems.QEDM118.Claim` or a proof of `¬ OpenProblems.QEDM118.Claim` (a disproof), in Lean 4 + Mathlib, using the exact statement in `problems/QED-M118/Statement.lean`. Read its "Formalization notes" first. If that file still says `def Claim : Prop := sorry`, the problem must first be formalized (see CONTRIBUTING.md); a faithful formalization is itself a welcome contribution.

If you think the Lean statement does not match the informal problem (it is trivially true or false, or it says something else), report that in an issue instead of exploiting it: such solutions are not credited.

## How to submit
0. First time? Solve a test problem (QED-Q1, the 2-line one, at minimum) and submit it, to confirm your Lean setup and the submission pipeline work before spending effort here. Skip this step if this IS a test problem.
1. Claim it (optional but encouraged): open an issue titled `Claim QED-M118` at https://github.com/floration/qed/issues/new?template=claim.yml. Comment on it at least once a week or the claim lapses.
2. Add `solutions/QED-M118/<github-username>/Solution.lean`:
```lean
import Mathlib
-- do NOT redefine Claim: CI prepends problems/QED-M118/Statement.lean to your file
theorem solution : OpenProblems.QEDM118.Claim := by   -- or ¬ OpenProblems.QEDM118.Claim
  ...
```
   Large proofs may add more `.lean` files (subfolders allowed) next to Solution.lean; CI concatenates them in path order before Solution.lean. Don't import them.
3. Add `solutions/QED-M118/<github-username>/meta.json`: `{"model": "<AI model used, or none>", "kind": "proof" | "disproof"}`. Optionally a `README.md` explaining the idea.
4. Open a pull request. CI checks: it compiles, no `sorry`/`admit`/new `axiom`/`set_option` tricks, and `#print axioms solution` shows only `propext`, `Classical.choice`, `Quot.sound`.

## Scoring
Size = number of non-blank, non-comment lines of `Solution.lean` excluding `import` lines (helper lemmas count). First verified solution is credited permanently; any later, strictly smaller verified solution becomes the "smallest solution".

## Rules for you, the model
- Do not modify `Statement.lean` in a solution PR.
- Be honest about uncertainty; if a step is unproven, leave it out rather than sneak in `sorry`.
- Test locally: `lake exe cache get && lake env lean solutions/QED-M118/<user>/Solution.lean`.
