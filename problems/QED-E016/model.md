# QED-E016 — Shifted Fujita equation

You are an AI model helping someone attack this open problem. Read all of this before working.

## The problem
Extended set · Grade C · PDE

**Plain words:** In the plane, every positive solution of u_t = Delta u + u^2 blows up (u^2 is exactly Fujita-critical in dimension 2). Does this survive when u^2 is replaced by the product of the values of u one unit to the left and one unit to the right?

**Math:** Let $e=(1,0)$. Prove or disprove: for every $0\le u_0\in C_c(\mathbb R^2)$ with $u_0\not\equiv0$, the solution of $u_t=\Delta u+u(x-e,t)\,u(x+e,t)$ on $\mathbb R^2$ blows up in finite time.

**Reviewer note:** L

**References:**
- https://arxiv.org/abs/2509.07405

Difficulty estimate: 2.2/10 (calibrated: Collatz ≈ 5.5, twin primes ≈ 5.0). It is believed open; do not assume a quick answer exists, and say so plainly if you cannot make progress. Never present a heuristic, numerical evidence, or a partial result as a solution.

## What counts as an answer
Either a proof of `OpenProblems.QEDE016.Claim` or a proof of `¬ OpenProblems.QEDE016.Claim` (a disproof), in Lean 4 + Mathlib, using the exact statement in `problems/QED-E016/Statement.lean`. Read its "Formalization notes" first. If that file still says `def Claim : Prop := sorry`, the problem must first be formalized (see CONTRIBUTING.md); a faithful formalization is itself a welcome contribution.

If you think the Lean statement does not match the informal problem (it is trivially true or false, or it says something else), report that in an issue instead of exploiting it: such solutions are not credited.

## How to submit
1. Claim it (optional but encouraged): open an issue titled `Claim QED-E016` at https://github.com/floration/qed/issues/new?template=claim.yml. Comment on it at least once a week or the claim lapses.
2. Add `solutions/QED-E016/<github-username>/Solution.lean`:
```lean
import Mathlib
-- do NOT redefine Claim: CI prepends problems/QED-E016/Statement.lean to your file
theorem solution : OpenProblems.QEDE016.Claim := by   -- or ¬ OpenProblems.QEDE016.Claim
  ...
```
3. Add `solutions/QED-E016/<github-username>/meta.json`: `{"model": "<AI model used, or none>", "kind": "proof" | "disproof"}`. Optionally a `README.md` explaining the idea.
4. Open a pull request. CI checks: it compiles, no `sorry`/`admit`/new `axiom`/`set_option` tricks, and `#print axioms solution` shows only `propext`, `Classical.choice`, `Quot.sound`.

## Scoring
Size = number of non-blank, non-comment lines of `Solution.lean` excluding `import` lines (helper lemmas count). First verified solution is credited permanently; any later, strictly smaller verified solution becomes the "smallest solution".

## Rules for you, the model
- Do not modify `Statement.lean` in a solution PR.
- Be honest about uncertainty; if a step is unproven, leave it out rather than sneak in `sorry`.
- Test locally: `lake exe cache get && lake env lean solutions/QED-E016/<user>/Solution.lean`.
