# N-638 — Minimal-mass blow-up with reflection

You are an AI model helping someone attack this open problem. Read all of this before working.

## The problem
**Plain words:** In the 2D Schrödinger equation where each point feels the density at its mirror point, blow-up needs at least the ground-state mass. Classify the solutions that blow up with exactly that mass.

**Math:** For $i u_t+\Delta u+|u(-x,t)|^2u=0$ on $\mathbb R^2$ with $\|u_0\|_{L^2}=\|Q\|_{L^2}$ ($Q$ the cubic ground state), prove that every $H^1$ solution blowing up in finite time equals, up to phase and scaling, the pseudo-conformal transform of $Q$ centred at the origin.

Difficulty estimate: 2.5/10 (calibrated: Collatz ≈ 5.5, twin primes ≈ 5.0). It is believed open; do not assume a quick answer exists, and say so plainly if you cannot make progress. Never present a heuristic, numerical evidence, or a partial result as a solution.

## What counts as an answer
Either a proof of `OpenProblems.N638.Claim` or a proof of `¬ OpenProblems.N638.Claim` (a disproof), in Lean 4 + Mathlib, using the exact statement in `problems/N-638/Statement.lean`. If that file still says `def Claim : Prop := sorry`, the problem must first be formalized (see CONTRIBUTING.md); a faithful formalization is itself a welcome contribution.

## How to submit
1. Claim it (optional but encouraged): open an issue titled `Claim N-638` at https://github.com/floration/qed/issues/new?template=claim.yml. Comment on it at least once a week or the claim lapses.
2. Add `solutions/N-638/<github-username>/Solution.lean`:
```lean
import Mathlib
-- do NOT redefine Claim: CI prepends problems/N-638/Statement.lean to your file
theorem solution : OpenProblems.N638.Claim := by   -- or ¬ OpenProblems.N638.Claim
  ...
```
3. Add `solutions/N-638/<github-username>/meta.json`: `{"model": "<AI model used, or none>", "kind": "proof" | "disproof"}`. Optionally a `README.md` explaining the idea.
4. Open a pull request. CI checks: it compiles, no `sorry`/`admit`/new `axiom`/`set_option` tricks, and `#print axioms solution` shows only `propext`, `Classical.choice`, `Quot.sound`.

## Scoring
Size = number of non-blank, non-comment lines of `Solution.lean` excluding `import` lines (helper lemmas count). First verified solution is credited permanently; any later, strictly smaller verified solution becomes the "smallest solution".

## Rules for you, the model
- Do not modify `Statement.lean` in a solution PR.
- Be honest about uncertainty; if a step is unproven, leave it out rather than sneak in `sorry`.
- Test locally: `lake exe cache get && lake env lean solutions/N-638/<user>/Solution.lean`.
