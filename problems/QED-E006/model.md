# QED-E006 — Multiplicities on the Fermat quartic

You are an AI model helping someone attack this open problem. Read all of this before working.

## The problem
Extended set · Grade C · Analysis

**Plain words:** The surface x^4+y^4+z^4 = 1 has exactly the 48 symmetries of a cube. Show its Laplace eigenvalues repeat no more often than those symmetries force (at most 3 times), except possibly for finitely many eigenvalues.

**Math:** Let $S=\{x^4+y^4+z^4=1\}\subset\mathbb R^3$ with the induced metric (isometry group the hyperoctahedral group of order 48, whose irreducible representations have dimension $\le3$). Prove that all but finitely many eigenvalues of $\Delta_S$ have multiplicity $\le3$.

**Reviewer note:** F

**References:**
- https://ar5iv.labs.arxiv.org/html/1804.02726
- https://arxiv.org/pdf/1602.04602

Difficulty estimate: 6.5/10 (calibrated: Collatz ≈ 5.5, twin primes ≈ 5.0). It is believed open; do not assume a quick answer exists, and say so plainly if you cannot make progress. Never present a heuristic, numerical evidence, or a partial result as a solution.

## What counts as an answer
Either a proof of `OpenProblems.QEDE006.Claim` or a proof of `¬ OpenProblems.QEDE006.Claim` (a disproof), in Lean 4 + Mathlib, using the exact statement in `problems/QED-E006/Statement.lean`. Read its "Formalization notes" first. If that file still says `def Claim : Prop := sorry`, the problem must first be formalized (see CONTRIBUTING.md); a faithful formalization is itself a welcome contribution.

If you think the Lean statement does not match the informal problem (it is trivially true or false, or it says something else), report that in an issue instead of exploiting it: such solutions are not credited.

## How to submit
1. Claim it (optional but encouraged): open an issue titled `Claim QED-E006` at https://github.com/floration/qed/issues/new?template=claim.yml. Comment on it at least once a week or the claim lapses.
2. Add `solutions/QED-E006/<github-username>/Solution.lean`:
```lean
import Mathlib
-- do NOT redefine Claim: CI prepends problems/QED-E006/Statement.lean to your file
theorem solution : OpenProblems.QEDE006.Claim := by   -- or ¬ OpenProblems.QEDE006.Claim
  ...
```
3. Add `solutions/QED-E006/<github-username>/meta.json`: `{"model": "<AI model used, or none>", "kind": "proof" | "disproof"}`. Optionally a `README.md` explaining the idea.
4. Open a pull request. CI checks: it compiles, no `sorry`/`admit`/new `axiom`/`set_option` tricks, and `#print axioms solution` shows only `propext`, `Classical.choice`, `Quot.sound`.

## Scoring
Size = number of non-blank, non-comment lines of `Solution.lean` excluding `import` lines (helper lemmas count). First verified solution is credited permanently; any later, strictly smaller verified solution becomes the "smallest solution".

## Rules for you, the model
- Do not modify `Statement.lean` in a solution PR.
- Be honest about uncertainty; if a step is unproven, leave it out rather than sneak in `sorry`.
- Test locally: `lake exe cache get && lake env lean solutions/QED-E006/<user>/Solution.lean`.
