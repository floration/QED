# QED-E002 — Keller maps injective on integer points

You are an AI model helping someone attack this open problem. Read all of this before working.

## The problem
Extended set · Grade C · Algebra · formerly N-397

**Plain words:** Take a polynomial map of 3-space with integer coefficients whose Jacobian determinant is identically 1 (a Keller map). Show that if it never sends two different integer points to the same point, then it is a polynomial automorphism.

**Math:** Let $F\in\mathbb{Z}[x,y,z]^3$ with $\det JF\equiv 1$. Prove that if $F|_{\mathbb{Z}^3}$ is injective, then $F$ has a polynomial inverse (equivalently, by Bia{\l}ynicki-Birula--Rosenlicht, $F$ is injective on $\mathbb{C}^3$).

**Reviewer note:** T

**References:**
- https://arxiv.org/abs/1502.00328
- https://arxiv.org/abs/1712.02113
- https://arxiv.org/abs/1705.10921

Difficulty estimate: 3.6/10 (calibrated: Collatz ≈ 5.5, twin primes ≈ 5.0). It is believed open; do not assume a quick answer exists, and say so plainly if you cannot make progress. Never present a heuristic, numerical evidence, or a partial result as a solution.

## What counts as an answer
Either a proof of `OpenProblems.QEDE002.Claim` or a proof of `¬ OpenProblems.QEDE002.Claim` (a disproof), in Lean 4 + Mathlib, using the exact statement in `problems/QED-E002/Statement.lean`. Read its "Formalization notes" first. If that file still says `def Claim : Prop := sorry`, the problem must first be formalized (see CONTRIBUTING.md); a faithful formalization is itself a welcome contribution.

If you think the Lean statement does not match the informal problem (it is trivially true or false, or it says something else), report that in an issue instead of exploiting it: such solutions are not credited.

## How to submit
1. Claim it (optional but encouraged): open an issue titled `Claim QED-E002` at https://github.com/floration/qed/issues/new?template=claim.yml. Comment on it at least once a week or the claim lapses.
2. Add `solutions/QED-E002/<github-username>/Solution.lean`:
```lean
import Mathlib
-- do NOT redefine Claim: CI prepends problems/QED-E002/Statement.lean to your file
theorem solution : OpenProblems.QEDE002.Claim := by   -- or ¬ OpenProblems.QEDE002.Claim
  ...
```
3. Add `solutions/QED-E002/<github-username>/meta.json`: `{"model": "<AI model used, or none>", "kind": "proof" | "disproof"}`. Optionally a `README.md` explaining the idea.
4. Open a pull request. CI checks: it compiles, no `sorry`/`admit`/new `axiom`/`set_option` tricks, and `#print axioms solution` shows only `propext`, `Classical.choice`, `Quot.sound`.

## Scoring
Size = number of non-blank, non-comment lines of `Solution.lean` excluding `import` lines (helper lemmas count). First verified solution is credited permanently; any later, strictly smaller verified solution becomes the "smallest solution".

## Rules for you, the model
- Do not modify `Statement.lean` in a solution PR.
- Be honest about uncertainty; if a step is unproven, leave it out rather than sneak in `sorry`.
- Test locally: `lake exe cache get && lake env lean solutions/QED-E002/<user>/Solution.lean`.
