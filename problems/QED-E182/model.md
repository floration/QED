# QED-E182 — Can 3x3 matrices be multiplied with 22 multiplications over the complex numbers?

You are an AI model helping someone attack this open problem. Read all of this before working.

## The problem
Extended set · Grade A · QED Curated · Algebra

**Plain words:** Laderman (1976) multiplies two 3x3 matrices with 23 scalar multiplications in a bilinear algorithm, and nobody has beaten 23. Over the two-element field (and hence for integer coefficients) 23 has now been claimed optimal, but over the complex or rational numbers the best lower bound is still 19. Is there a 22-multiplication algorithm with complex coefficients, or is 23 optimal?

**Math:** Let $T=\langle3,3,3\rangle\in(\mathbb C^9)^{\otimes3}$ be the $3\times3$ matrix multiplication tensor and $R_{\mathbb C}(T)$ its tensor rank; known $19\le R_{\mathbb C}(T)\le23$. Is $R_{\mathbb C}(T)\le22$, i.e. do there exist $A_i,B_i,C_i\in M_3(\mathbb C)$, $i=1,\dots,22$, with $XY=\sum_{i=1}^{22}\operatorname{tr}(A_iX)\operatorname{tr}(B_iY)\,C_i$ for all $X,Y\in M_3(\mathbb C)$? (Partial target: prove $R_{\mathbb C}(T)\ge20$.)

**Credit:** Classical (Laderman 1976; Bläser 2003); framing after the 2026 F_2 resolution claims

**Rests on recent unrefereed work. Check these premises first:**
- F_2 = 23 and Z >= 22 claims are unrefereed Oct 2026 preprints; the C question does not depend on them
- OpenAI preprint 'Staggered-extraction-for-exact-matrix-multiplication-over-every-field' should be checked to ensure it is not a 3x3 rank result
- Could be viewed as computational; mitigated because over C no finite search exists

**References:**
- https://arxiv.org/abs/2610.11823
- https://arxiv.org/abs/2603.07280
- https://arxiv.org/abs/2609.18722
- https://arxiv.org/abs/2212.01175
- https://arxiv.org/abs/2601.05272

Difficulty estimate: 7.0/10 (anchored scale: 1 ≈ Erdős–Ginzburg–Ziv, 2.5 ≈ the sensitivity conjecture, 5 ≈ bounded prime gaps, 7.5 ≈ the Riemann Hypothesis, 10 ≈ P vs NP). It is believed open; do not assume a quick answer exists, and say so plainly if you cannot make progress. Never present a heuristic, numerical evidence, or a partial result as a solution.

## What counts as an answer
Either a proof of `OpenProblems.QEDE182.Claim` or a proof of `¬ OpenProblems.QEDE182.Claim` (a disproof), in Lean 4 + Mathlib, using the exact statement in `problems/QED-E182/Statement.lean`. Read its "Formalization notes" first. If that file still says `def Claim : Prop := sorry`, the problem must first be formalized (see CONTRIBUTING.md); a faithful formalization is itself a welcome contribution.

If you think the Lean statement does not match the informal problem (it is trivially true or false, or it says something else), report that in an issue instead of exploiting it: such solutions are not credited.

## How to submit
0. First time? Solve a test problem (QED-Q1, the 2-line one, at minimum) and submit it, to confirm your Lean setup and the submission pipeline work before spending effort here. Skip this step if this IS a test problem.
1. Claim it (optional but encouraged): open an issue titled `Claim QED-E182` at https://github.com/floration/qed/issues/new?template=claim.yml. Comment on it at least once a week or the claim lapses.
2. Add `solutions/QED-E182/<github-username>/Solution.lean`:
```lean
import Mathlib
-- do NOT redefine Claim: CI prepends problems/QED-E182/Statement.lean to your file
theorem solution : OpenProblems.QEDE182.Claim := by   -- or ¬ OpenProblems.QEDE182.Claim
  ...
```
   Large proofs may add more `.lean` files (subfolders allowed) next to Solution.lean; CI concatenates them in path order before Solution.lean. Don't import them.
3. Add `solutions/QED-E182/<github-username>/meta.json`: `{"model": "<AI model used, or none>", "kind": "proof" | "disproof"}`. Optionally a `README.md` explaining the idea.
4. Open a pull request. CI checks: it compiles, no `sorry`/`admit`/new `axiom`/`set_option` tricks, and `#print axioms solution` shows only `propext`, `Classical.choice`, `Quot.sound`.

## Scoring
Size = number of non-blank, non-comment lines of `Solution.lean` excluding `import` lines (helper lemmas count). First verified solution is credited permanently; any later, strictly smaller verified solution becomes the "smallest solution".

## Rules for you, the model
- Do not modify `Statement.lean` in a solution PR.
- Be honest about uncertainty; if a step is unproven, leave it out rather than sneak in `sorry`.
- Test locally: `lake exe cache get && lake env lean solutions/QED-E182/<user>/Solution.lean`.
