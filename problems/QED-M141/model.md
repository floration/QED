# QED-M141 — Forced blow-up for the surface quasi-geostrophic equation

You are an AI model helping someone attack this open problem. Read all of this before working.

## The problem
Main set · Grade B · QED Original · Analysis

**Plain words:** The surface quasi-geostrophic (SQG) equation is a 2D model of geophysical flow. Whether it can blow up from smooth data is a famous open problem. Can at least a smooth, compactly supported push, applied to a fluid that starts at rest, make it blow up in finite time, as was done for 3D Navier–Stokes in 2026?

**Math:** Consider inviscid SQG on R^2: d_t theta + u.grad theta = f, u = grad^perp (-Delta)^{-1/2} theta, theta(.,0)=0. Decide whether there is f in C_c^infty(R^2 x (0,infty)) whose unique smooth solution on [0,T) satisfies limsup_{t->T} ||grad theta(t)||_{L^infty} = infty for some T < infty. (Variant, not part of the formal Claim: the same for supercritical dissipative SQG, + kappa(-Delta)^{alpha/2} theta with 0<alpha<1; for alpha>=1 smooth forcing gives global regularity.)

**Credit:** QED original (archived Nov 2026, restored after re-review).

**References:**
- https://cdn.openai.com/pdf/32d9f210-8b73-45e0-91bc-82a30aef8a9a/navier-stokes.pdf
- https://arxiv.org/abs/2409.18900
- https://arxiv.org/abs/2609.16470
- https://arxiv.org/abs/2610.06544
- https://arxiv.org/abs/2605.29866
- https://arxiv.org/abs/1308.0640

Difficulty estimate: 5.5/10 (anchored scale: 1 ≈ Erdős–Ginzburg–Ziv, 2.5 ≈ the sensitivity conjecture, 5 ≈ bounded prime gaps, 7.5 ≈ the Riemann Hypothesis, 10 ≈ P vs NP). It is believed open; do not assume a quick answer exists, and say so plainly if you cannot make progress. Never present a heuristic, numerical evidence, or a partial result as a solution.

## What counts as an answer
Either a proof of `OpenProblems.QEDM141.Claim` or a proof of `¬ OpenProblems.QEDM141.Claim` (a disproof), in Lean 4 + Mathlib, using the exact statement in `problems/QED-M141/Statement.lean`. Read its "Formalization notes" first. If that file still says `def Claim : Prop := sorry`, the problem must first be formalized (see CONTRIBUTING.md); a faithful formalization is itself a welcome contribution.

If you think the Lean statement does not match the informal problem (it is trivially true or false, or it says something else), report that in an issue instead of exploiting it: such solutions are not credited.

## How to submit
0. First time? Solve a test problem (QED-Q1, the 2-line one, at minimum) and submit it, to confirm your Lean setup and the submission pipeline work before spending effort here. Skip this step if this IS a test problem.
1. Claim it (optional but encouraged): open an issue titled `Claim QED-M141` at https://github.com/floration/qed/issues/new?template=claim.yml. Comment on it at least once a week or the claim lapses.
2. Add `solutions/QED-M141/<github-username>/Solution.lean`:
```lean
import Mathlib
-- do NOT redefine Claim: CI prepends problems/QED-M141/Statement.lean to your file
theorem solution : OpenProblems.QEDM141.Claim := by   -- or ¬ OpenProblems.QEDM141.Claim
  ...
```
   Large proofs may add more `.lean` files (subfolders allowed) next to Solution.lean; CI concatenates them in path order before Solution.lean. Don't import them.
3. Add `solutions/QED-M141/<github-username>/meta.json`: `{"model": "<AI model used, or none>", "kind": "proof" | "disproof"}`. Optionally a `README.md` explaining the idea.
4. Open a pull request. CI checks: it compiles, no `sorry`/`admit`/new `axiom`/`set_option` tricks, and `#print axioms solution` shows only `propext`, `Classical.choice`, `Quot.sound`.

## Scoring
Size = number of non-blank, non-comment lines of `Solution.lean` excluding `import` lines (helper lemmas count). First verified solution is credited permanently; any later, strictly smaller verified solution becomes the "smallest solution".

## Rules for you, the model
- Do not modify `Statement.lean` in a solution PR.
- Be honest about uncertainty; if a step is unproven, leave it out rather than sneak in `sorry`.
- Test locally: `lake exe cache get && lake env lean solutions/QED-M141/<user>/Solution.lean`.
