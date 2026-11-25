# QED-M089 — Derivative loss in L4 Strichartz on the cube surface

You are an AI model helping someone attack this open problem. Read all of this before working.

## The problem
Main set · Grade B · QED Extension · PDE

**Plain words:** On the flat torus, the L4 space-time estimate for Schrodinger waves loses only epsilon derivatives (Bourgain). On the surface of a cube, which has eight cone points that diffract waves, only a loss of 1/4 derivative is known. Find the true loss: prove any loss below 1/4, or show some loss is necessary.

**Math:** Let $S$ be the unit cube surface, $\Delta$ the Friedrichs extension from $C_c^\infty(S\setminus\text{vertices})$, and $s^*=\inf\{s\ge0:\|e^{it\Delta}f\|_{L^4([0,1]\times S)}\le C_s\|f\|_{H^s(S)}\}$. Known: $0\le s^*\le\tfrac14$ (Blair–Ford–Marzuola). Prove $s^*<\tfrac14$, or $s^*>0$; ideally determine $s^*$ (conjecturally $0$). The board's target (Claim) is $s^*<\tfrac14$.

**Credit:** Blair, Ford, Marzuola, Strichartz estimates for the wave equation on flat cones / Euclidean surfaces with conical singularities, arXiv:1003.0666.

**QED results so far (reviewer-derived; check before relying on them):** s* >= 0 (trivial). No positive lower bound known. s* <= 1/4: Blair-Ford-Herr-Marzuola, Thm 1.5 (arXiv 1003.0666), loss 1/p for compact Euclidean surfaces with conical singularities, p=q=4; the authors believe the loss is an artifact of the method (Remark 1.3).

**References:**
- https://arxiv.org/abs/1003.0666
- https://arxiv.org/abs/1809.09909
- https://arxiv.org/pdf/0910.1795
- https://arxiv.org/pdf/1105.5410
- https://arxiv.org/pdf/1003.0666

Difficulty estimate: 4.0/10 (anchored scale: 1 ≈ Erdős–Ginzburg–Ziv, 2.5 ≈ the sensitivity conjecture, 5 ≈ bounded prime gaps, 7.5 ≈ the Riemann Hypothesis, 10 ≈ P vs NP). It is believed open; do not assume a quick answer exists, and say so plainly if you cannot make progress. Never present a heuristic, numerical evidence, or a partial result as a solution.

## What counts as an answer
Either a proof of `OpenProblems.QEDM089.Claim` or a proof of `¬ OpenProblems.QEDM089.Claim` (a disproof), in Lean 4 + Mathlib, using the exact statement in `problems/QED-M089/Statement.lean`. Read its "Formalization notes" first. If that file still says `def Claim : Prop := sorry`, the problem must first be formalized (see CONTRIBUTING.md); a faithful formalization is itself a welcome contribution.

If you think the Lean statement does not match the informal problem (it is trivially true or false, or it says something else), report that in an issue instead of exploiting it: such solutions are not credited.

## How to submit
0. First time? Solve a test problem (QED-Q1, the 2-line one, at minimum) and submit it, to confirm your Lean setup and the submission pipeline work before spending effort here. Skip this step if this IS a test problem.
1. Claim it (optional but encouraged): open an issue titled `Claim QED-M089` at https://github.com/floration/qed/issues/new?template=claim.yml. Comment on it at least once a week or the claim lapses.
2. Add `solutions/QED-M089/<github-username>/Solution.lean`:
```lean
import Mathlib
-- do NOT redefine Claim: CI prepends problems/QED-M089/Statement.lean to your file
theorem solution : OpenProblems.QEDM089.Claim := by   -- or ¬ OpenProblems.QEDM089.Claim
  ...
```
   Large proofs may add more `.lean` files (subfolders allowed) next to Solution.lean; CI concatenates them in path order before Solution.lean. Don't import them.
3. Add `solutions/QED-M089/<github-username>/meta.json`: `{"model": "<AI model used, or none>", "kind": "proof" | "disproof"}`. Optionally a `README.md` explaining the idea.
4. Open a pull request. CI checks: it compiles, no `sorry`/`admit`/new `axiom`/`set_option` tricks, and `#print axioms solution` shows only `propext`, `Classical.choice`, `Quot.sound`.

## Scoring
Size = number of non-blank, non-comment lines of `Solution.lean` excluding `import` lines (helper lemmas count). First verified solution is credited permanently; any later, strictly smaller verified solution becomes the "smallest solution".

## Rules for you, the model
- Do not modify `Statement.lean` in a solution PR.
- Be honest about uncertainty; if a step is unproven, leave it out rather than sneak in `sorry`.
- Test locally: `lake exe cache get && lake env lean solutions/QED-M089/<user>/Solution.lean`.
