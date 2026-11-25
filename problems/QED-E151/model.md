# QED-E151 — Rational 6-cycles of z^2+c

You are an AI model helping someone attack this open problem. Read all of this before working.

## The problem
Extended set · Grade A · QED Curated · Dynamics

**Plain words:** Iterate the map x ↦ x² + c with c and the starting point x rational. A rational starting point can return to itself after exactly 1, 2 or 3 steps (for example c = −29/16, x = −1/4 gives a 3-cycle), and it is proved that exact periods 4 and 5 are impossible. Show, without assuming unproved conjectures, that exact period 6 is impossible too.

**Math:** Prove that there are no $c,x\in\mathbb{Q}$ such that $x$ has exact (minimal) period $6$ under $f_c(z)=z^2+c$.

**Credit:** Stoll (2008); open case of the Morton-Silverman / Flynn-Poonen-Schaefer programme

**Rests on recent unrefereed work. Check these premises first:**
- The full statement 'no period > 3' is the named Flynn-Poonen-Schaefer conjecture. This candidate is only its unnamed period-6 case, which the naming rule allows.
- An unconditional rank computation for J_1(6) could be within reach of modern class-group methods (as in Fu-Stoll 2024), so difficulty may be lower than it looks.

**References:**
- https://arxiv.org/abs/0803.2836
- https://arxiv.org/abs/2206.12154
- https://arxiv.org/abs/2609.13431
- https://arxiv.org/pdf/math/9508211

Difficulty estimate: 6.0/10 (anchored scale: 1 ≈ Erdős–Ginzburg–Ziv, 2.5 ≈ the sensitivity conjecture, 5 ≈ bounded prime gaps, 7.5 ≈ the Riemann Hypothesis, 10 ≈ P vs NP). It is believed open; do not assume a quick answer exists, and say so plainly if you cannot make progress. Never present a heuristic, numerical evidence, or a partial result as a solution.

## What counts as an answer
Either a proof of `OpenProblems.QEDE151.Claim` or a proof of `¬ OpenProblems.QEDE151.Claim` (a disproof), in Lean 4 + Mathlib, using the exact statement in `problems/QED-E151/Statement.lean`. Read its "Formalization notes" first. If that file still says `def Claim : Prop := sorry`, the problem must first be formalized (see CONTRIBUTING.md); a faithful formalization is itself a welcome contribution.

If you think the Lean statement does not match the informal problem (it is trivially true or false, or it says something else), report that in an issue instead of exploiting it: such solutions are not credited.

## How to submit
0. First time? Solve a test problem (QED-Q1, the 2-line one, at minimum) and submit it, to confirm your Lean setup and the submission pipeline work before spending effort here. Skip this step if this IS a test problem.
1. Claim it (optional but encouraged): open an issue titled `Claim QED-E151` at https://github.com/floration/qed/issues/new?template=claim.yml. Comment on it at least once a week or the claim lapses.
2. Add `solutions/QED-E151/<github-username>/Solution.lean`:
```lean
import Mathlib
-- do NOT redefine Claim: CI prepends problems/QED-E151/Statement.lean to your file
theorem solution : OpenProblems.QEDE151.Claim := by   -- or ¬ OpenProblems.QEDE151.Claim
  ...
```
   Large proofs may add more `.lean` files (subfolders allowed) next to Solution.lean; CI concatenates them in path order before Solution.lean. Don't import them.
3. Add `solutions/QED-E151/<github-username>/meta.json`: `{"model": "<AI model used, or none>", "kind": "proof" | "disproof"}`. Optionally a `README.md` explaining the idea.
4. Open a pull request. CI checks: it compiles, no `sorry`/`admit`/new `axiom`/`set_option` tricks, and `#print axioms solution` shows only `propext`, `Classical.choice`, `Quot.sound`.

## Scoring
Size = number of non-blank, non-comment lines of `Solution.lean` excluding `import` lines (helper lemmas count). First verified solution is credited permanently; any later, strictly smaller verified solution becomes the "smallest solution".

## Rules for you, the model
- Do not modify `Statement.lean` in a solution PR.
- Be honest about uncertainty; if a step is unproven, leave it out rather than sneak in `sorry`.
- Test locally: `lake exe cache get && lake env lean solutions/QED-E151/<user>/Solution.lean`.
