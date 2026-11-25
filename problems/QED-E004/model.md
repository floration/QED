# QED-E004 — Closed-form Euler blow-up

You are an AI model helping someone attack this open problem. Read all of this before working.

## The problem
Extended set · Grade C · Analysis

**Plain words:** Smooth compactly supported starting data for the 3D Euler equations that blow up in finite time are now known to exist, but the construction is an infinite iterative series. Give such data as an explicit formula.

**Math:** Find an explicit divergence-free $u_0=\nabla\times\big(P(x)e^{-|x|^2}\big)$ with $P\in\mathbb{Q}[x_1,x_2,x_3]^3$ (or another explicitly specified finite closed-form class) such that the unforced 3D incompressible Euler solution on $\mathbb{R}^3$ with $u(0)=u_0$ has finite maximal smooth lifespan.

**Reviewer note:** T

**References:**
- https://cdn.openai.com/pdf/315b36cd-ec98-4023-8342-93345194ece1/euler.pdf
- https://arxiv.org/abs/2610.02509
- https://raw.githubusercontent.com/openai/NavierStokesAndEuler/main/README.md
- https://arxiv.org/abs/2308.12197

Difficulty estimate: 5.1/10 (calibrated: Collatz ≈ 5.5, twin primes ≈ 5.0). It is believed open; do not assume a quick answer exists, and say so plainly if you cannot make progress. Never present a heuristic, numerical evidence, or a partial result as a solution.

## What counts as an answer
Either a proof of `OpenProblems.QEDE004.Claim` or a proof of `¬ OpenProblems.QEDE004.Claim` (a disproof), in Lean 4 + Mathlib, using the exact statement in `problems/QED-E004/Statement.lean`. Read its "Formalization notes" first. If that file still says `def Claim : Prop := sorry`, the problem must first be formalized (see CONTRIBUTING.md); a faithful formalization is itself a welcome contribution.

If you think the Lean statement does not match the informal problem (it is trivially true or false, or it says something else), report that in an issue instead of exploiting it: such solutions are not credited.

## How to submit
1. Claim it (optional but encouraged): open an issue titled `Claim QED-E004` at https://github.com/floration/qed/issues/new?template=claim.yml. Comment on it at least once a week or the claim lapses.
2. Add `solutions/QED-E004/<github-username>/Solution.lean`:
```lean
import Mathlib
-- do NOT redefine Claim: CI prepends problems/QED-E004/Statement.lean to your file
theorem solution : OpenProblems.QEDE004.Claim := by   -- or ¬ OpenProblems.QEDE004.Claim
  ...
```
   Large proofs may add more `.lean` files (subfolders allowed) next to Solution.lean; CI concatenates them in path order before Solution.lean. Don't import them.
3. Add `solutions/QED-E004/<github-username>/meta.json`: `{"model": "<AI model used, or none>", "kind": "proof" | "disproof"}`. Optionally a `README.md` explaining the idea.
4. Open a pull request. CI checks: it compiles, no `sorry`/`admit`/new `axiom`/`set_option` tricks, and `#print axioms solution` shows only `propext`, `Classical.choice`, `Quot.sound`.

## Scoring
Size = number of non-blank, non-comment lines of `Solution.lean` excluding `import` lines (helper lemmas count). First verified solution is credited permanently; any later, strictly smaller verified solution becomes the "smallest solution".

## Rules for you, the model
- Do not modify `Statement.lean` in a solution PR.
- Be honest about uncertainty; if a step is unproven, leave it out rather than sneak in `sorry`.
- Test locally: `lake exe cache get && lake env lean solutions/QED-E004/<user>/Solution.lean`.
