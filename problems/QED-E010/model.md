# QED-E010 — Rotation-proof lattice-point-poor shapes

You are an AI model helping someone attack this open problem. Read all of this before working.

## The problem
Extended set · Grade C · Geometry

**Plain words:** Among convex shapes of area A, how few lattice points can a shape be guaranteed to contain under every rotation about the origin? Can any shape do much better than a disc centred at the origin?

**Math:** For $A>0$ let $m(A)=\inf\{\sup_{\theta}\#(\rho_\theta K\cap\mathbb Z^2): K\subset\mathbb R^2\text{ compact convex},\ |K|=A\}$. Decide whether $m(A)\ge A-O_\varepsilon(A^{1/4+\varepsilon})$.

**Reviewer note:** T

Difficulty estimate: 6.5/10 (calibrated: Collatz ≈ 5.5, twin primes ≈ 5.0). It is believed open; do not assume a quick answer exists, and say so plainly if you cannot make progress. Never present a heuristic, numerical evidence, or a partial result as a solution.

## What counts as an answer
Either a proof of `OpenProblems.QEDE010.Claim` or a proof of `¬ OpenProblems.QEDE010.Claim` (a disproof), in Lean 4 + Mathlib, using the exact statement in `problems/QED-E010/Statement.lean`. Read its "Formalization notes" first. If that file still says `def Claim : Prop := sorry`, the problem must first be formalized (see CONTRIBUTING.md); a faithful formalization is itself a welcome contribution.

If you think the Lean statement does not match the informal problem (it is trivially true or false, or it says something else), report that in an issue instead of exploiting it: such solutions are not credited.

## How to submit
1. Claim it (optional but encouraged): open an issue titled `Claim QED-E010` at https://github.com/floration/qed/issues/new?template=claim.yml. Comment on it at least once a week or the claim lapses.
2. Add `solutions/QED-E010/<github-username>/Solution.lean`:
```lean
import Mathlib
-- do NOT redefine Claim: CI prepends problems/QED-E010/Statement.lean to your file
theorem solution : OpenProblems.QEDE010.Claim := by   -- or ¬ OpenProblems.QEDE010.Claim
  ...
```
   Large proofs may add more `.lean` files (subfolders allowed) next to Solution.lean; CI concatenates them in path order before Solution.lean. Don't import them.
3. Add `solutions/QED-E010/<github-username>/meta.json`: `{"model": "<AI model used, or none>", "kind": "proof" | "disproof"}`. Optionally a `README.md` explaining the idea.
4. Open a pull request. CI checks: it compiles, no `sorry`/`admit`/new `axiom`/`set_option` tricks, and `#print axioms solution` shows only `propext`, `Classical.choice`, `Quot.sound`.

## Scoring
Size = number of non-blank, non-comment lines of `Solution.lean` excluding `import` lines (helper lemmas count). First verified solution is credited permanently; any later, strictly smaller verified solution becomes the "smallest solution".

## Rules for you, the model
- Do not modify `Statement.lean` in a solution PR.
- Be honest about uncertainty; if a step is unproven, leave it out rather than sneak in `sorry`.
- Test locally: `lake exe cache get && lake env lean solutions/QED-E010/<user>/Solution.lean`.
