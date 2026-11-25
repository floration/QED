# QED-M061 — Gromov width of the 4D l^4 ball

You are an AI model helping someone attack this open problem. Read all of this before working.

## The problem
Main set · Grade B · QED Original · Geometry

**Plain words:** The 4D superball x1^4+y1^4+x2^4+y2^4 <= 1 contains the round unit ball, so it holds a symplectic ball of capacity pi. Its cylindrical capacity is about 3.708, and no symplectic ball can be bigger than that. Narrow the gap: embed a bigger ball, or show that no ball of capacity close to 3.708 fits.

**Math:** Let U = {x1^4+y1^4+x2^4+y2^4 <= 1} ⊂ (R^4, ω0) and c_G(U) = sup{πr^2 : B^4(r) embeds symplectically in U}. Known: π <= c_G(U) <= c0 := 4Γ(5/4)^2/Γ(3/2) ≈ 3.7081 (= c_Z(U) = c_EHZ(U)). Prove or disprove: c_G(U) = c0 (i.e. U satisfies the strong Viterbo equality between Gromov width and cylindrical capacity).

**QED results so far (reviewer-derived; check before relying on them):** c_G(U) >= pi: U contains the Euclidean unit ball, since sum x_i^4 <= (sum x_i^2)^2. (Trivial.) c_G(U) <= c_Z(U) = c_EHZ(U) = c0 = 4Gamma(5/4)^2/Gamma(3/2) ~ 3.7081 (arXiv 2609.37794, Thm 2 with n=2, p=4, B=D=I). Gromov width is <= every normalized capacity. The volume bound sqrt(2 Vol U) ~ 4.65 is weaker.

**Rests on recent unrefereed work. Check these premises first:**
- arXiv:2609.37794 (2026, unrefereed): Thm 2 giving c_Z(U) = c_EHZ(U) = 4Γ(5/4)^2/Γ(3/2); the Claim's target value c0 comes from it. If that value is wrong, Claim may be false for a trivial reason.

**References:**
- https://arxiv.org/pdf/2609.37794
- https://arxiv.org/pdf/2405.16513
- https://arxiv.org/pdf/2402.07709
- https://arxiv.org/pdf/2203.02294
- https://arxiv.org/pdf/2610.31906

Difficulty estimate: 4.5/10 (anchored scale: 1 ≈ Erdős–Ginzburg–Ziv, 2.5 ≈ the sensitivity conjecture, 5 ≈ bounded prime gaps, 7.5 ≈ the Riemann Hypothesis, 10 ≈ P vs NP). It is believed open; do not assume a quick answer exists, and say so plainly if you cannot make progress. Never present a heuristic, numerical evidence, or a partial result as a solution.

## What counts as an answer
Either a proof of `OpenProblems.QEDM061.Claim` or a proof of `¬ OpenProblems.QEDM061.Claim` (a disproof), in Lean 4 + Mathlib, using the exact statement in `problems/QED-M061/Statement.lean`. Read its "Formalization notes" first. If that file still says `def Claim : Prop := sorry`, the problem must first be formalized (see CONTRIBUTING.md); a faithful formalization is itself a welcome contribution.

If you think the Lean statement does not match the informal problem (it is trivially true or false, or it says something else), report that in an issue instead of exploiting it: such solutions are not credited.

## How to submit
0. First time? Solve a test problem (QED-Q1, the 2-line one, at minimum) and submit it, to confirm your Lean setup and the submission pipeline work before spending effort here. Skip this step if this IS a test problem.
1. Claim it (optional but encouraged): open an issue titled `Claim QED-M061` at https://github.com/floration/qed/issues/new?template=claim.yml. Comment on it at least once a week or the claim lapses.
2. Add `solutions/QED-M061/<github-username>/Solution.lean`:
```lean
import Mathlib
-- do NOT redefine Claim: CI prepends problems/QED-M061/Statement.lean to your file
theorem solution : OpenProblems.QEDM061.Claim := by   -- or ¬ OpenProblems.QEDM061.Claim
  ...
```
   Large proofs may add more `.lean` files (subfolders allowed) next to Solution.lean; CI concatenates them in path order before Solution.lean. Don't import them.
3. Add `solutions/QED-M061/<github-username>/meta.json`: `{"model": "<AI model used, or none>", "kind": "proof" | "disproof"}`. Optionally a `README.md` explaining the idea.
4. Open a pull request. CI checks: it compiles, no `sorry`/`admit`/new `axiom`/`set_option` tricks, and `#print axioms solution` shows only `propext`, `Classical.choice`, `Quot.sound`.

## Scoring
Size = number of non-blank, non-comment lines of `Solution.lean` excluding `import` lines (helper lemmas count). First verified solution is credited permanently; any later, strictly smaller verified solution becomes the "smallest solution".

## Rules for you, the model
- Do not modify `Statement.lean` in a solution PR.
- Be honest about uncertainty; if a step is unproven, leave it out rather than sneak in `sorry`.
- Test locally: `lake exe cache get && lake env lean solutions/QED-M061/<user>/Solution.lean`.
