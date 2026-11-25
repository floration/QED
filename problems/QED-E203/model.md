# QED-E203 — Does a triangle with integer sides, medians and area exist?

You are an AI model helping someone attack this open problem. Read all of this before working.

## The problem
Extended set · Grade B · QED Curated · Number theory

**Plain words:** Is there a triangle whose three sides, three medians (segments from a vertex to the midpoint of the opposite side) and area are all integers? Triangles with integer sides and area (Heron triangles) are plentiful, triangles with integer sides and integer medians exist, and there are infinitely many Heron triangles with two integer medians, but no triangle with all seven quantities integral has ever been found.

**Math:** Decide whether there exist positive integers $a,b,c,m_a,m_b,m_c,A$ with $a<b+c,\ b<a+c,\ c<a+b$, $4m_a^2=2b^2+2c^2-a^2$, $4m_b^2=2a^2+2c^2-b^2$, $4m_c^2=2a^2+2b^2-c^2$ and $16A^2=(a+b+c)(-a+b+c)(a-b+c)(a+b-c)$. (Equivalently, by scaling: a non-degenerate triangle with rational sides, medians and area.)

**Credit:** Classical (Euler's work on rational medians; perfect-triangle problem listed in Guy, Unsolved Problems in Number Theory); Buchholz, Rathbun, Hone

**Rests on recent unrefereed work. Check these premises first:**
- Unrefereed non-existence claim arXiv:2111.05118 (Shihaliev, revised through 2026) - not accepted, but scorer should know
- Answer may be a computer find; but decades of searches suggest none exists

**References:**
- https://arxiv.org/abs/2401.05581
- https://arxiv.org/abs/2107.03197
- https://arxiv.org/abs/1910.06888
- https://arxiv.org/abs/2111.05118
- https://arxiv.org/html/2605.22458v1

Difficulty estimate: 8.0/10 (anchored scale: 1 ≈ Erdős–Ginzburg–Ziv, 2.5 ≈ the sensitivity conjecture, 5 ≈ bounded prime gaps, 7.5 ≈ the Riemann Hypothesis, 10 ≈ P vs NP). It is believed open; do not assume a quick answer exists, and say so plainly if you cannot make progress. Never present a heuristic, numerical evidence, or a partial result as a solution.

## What counts as an answer
Either a proof of `OpenProblems.QEDE203.Claim` or a proof of `¬ OpenProblems.QEDE203.Claim` (a disproof), in Lean 4 + Mathlib, using the exact statement in `problems/QED-E203/Statement.lean`. Read its "Formalization notes" first. If that file still says `def Claim : Prop := sorry`, the problem must first be formalized (see CONTRIBUTING.md); a faithful formalization is itself a welcome contribution.

If you think the Lean statement does not match the informal problem (it is trivially true or false, or it says something else), report that in an issue instead of exploiting it: such solutions are not credited.

## How to submit
0. First time? Solve a test problem (QED-Q1, the 2-line one, at minimum) and submit it, to confirm your Lean setup and the submission pipeline work before spending effort here. Skip this step if this IS a test problem.
1. Claim it (optional but encouraged): open an issue titled `Claim QED-E203` at https://github.com/floration/qed/issues/new?template=claim.yml. Comment on it at least once a week or the claim lapses.
2. Add `solutions/QED-E203/<github-username>/Solution.lean`:
```lean
import Mathlib
-- do NOT redefine Claim: CI prepends problems/QED-E203/Statement.lean to your file
theorem solution : OpenProblems.QEDE203.Claim := by   -- or ¬ OpenProblems.QEDE203.Claim
  ...
```
   Large proofs may add more `.lean` files (subfolders allowed) next to Solution.lean; CI concatenates them in path order before Solution.lean. Don't import them.
3. Add `solutions/QED-E203/<github-username>/meta.json`: `{"model": "<AI model used, or none>", "kind": "proof" | "disproof"}`. Optionally a `README.md` explaining the idea.
4. Open a pull request. CI checks: it compiles, no `sorry`/`admit`/new `axiom`/`set_option` tricks, and `#print axioms solution` shows only `propext`, `Classical.choice`, `Quot.sound`.

## Scoring
Size = number of non-blank, non-comment lines of `Solution.lean` excluding `import` lines (helper lemmas count). First verified solution is credited permanently; any later, strictly smaller verified solution becomes the "smallest solution".

## Rules for you, the model
- Do not modify `Statement.lean` in a solution PR.
- Be honest about uncertainty; if a step is unproven, leave it out rather than sneak in `sorry`.
- Test locally: `lake exe cache get && lake env lean solutions/QED-E203/<user>/Solution.lean`.
