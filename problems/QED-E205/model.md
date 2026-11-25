# QED-E205 — A rational Diophantine septuple

You are an AI model helping someone attack this open problem. Read all of this before working.

## The problem
Extended set · Grade A · QED Curated · Number theory

**Plain words:** A rational Diophantine m-tuple is a set of m distinct nonzero rational numbers such that the product of any two of them, plus 1, is a square of a rational number. Infinitely many such sets of size 6 are known, but nobody knows whether a set of size 7 exists. Find one, or prove that none exists.

**Math:** Decide whether there exist seven distinct $a_1,\dots,a_7\in\mathbb Q\setminus\{0\}$ such that $a_ia_j+1$ is the square of a rational number for all $1\le i<j\le7$.

**Credit:** Classical (Diophantus, Fermat, Euler); modern formulation and record constructions by Dujella, Gibbs, Kazalicki, Mikić, Szikszai

**Rests on recent unrefereed work. Check these premises first:**
- Listed on Epoch FrontierMath Open Problems, so actively targeted by AI search efforts; could be found by computation
- Expected answer unknown; if no septuple exists, a proof is far beyond current methods (needs bounds on rational points of general-type varieties)

**References:**
- https://arxiv.org/abs/1507.00569
- https://arxiv.org/pdf/2403.17959
- https://arxiv.org/pdf/2604.08729
- https://epoch.ai/frontiermath/open-problems/diophantine-septuple

Difficulty estimate: 5.0/10 (calibrated: Collatz ≈ 5.5, twin primes ≈ 5.0). It is believed open; do not assume a quick answer exists, and say so plainly if you cannot make progress. Never present a heuristic, numerical evidence, or a partial result as a solution.

## What counts as an answer
Either a proof of `OpenProblems.QEDE205.Claim` or a proof of `¬ OpenProblems.QEDE205.Claim` (a disproof), in Lean 4 + Mathlib, using the exact statement in `problems/QED-E205/Statement.lean`. Read its "Formalization notes" first. If that file still says `def Claim : Prop := sorry`, the problem must first be formalized (see CONTRIBUTING.md); a faithful formalization is itself a welcome contribution.

If you think the Lean statement does not match the informal problem (it is trivially true or false, or it says something else), report that in an issue instead of exploiting it: such solutions are not credited.

## How to submit
0. First time? Solve a test problem (QED-Q1, the 2-line one, at minimum) and submit it, to confirm your Lean setup and the submission pipeline work before spending effort here. Skip this step if this IS a test problem.
1. Claim it (optional but encouraged): open an issue titled `Claim QED-E205` at https://github.com/floration/qed/issues/new?template=claim.yml. Comment on it at least once a week or the claim lapses.
2. Add `solutions/QED-E205/<github-username>/Solution.lean`:
```lean
import Mathlib
-- do NOT redefine Claim: CI prepends problems/QED-E205/Statement.lean to your file
theorem solution : OpenProblems.QEDE205.Claim := by   -- or ¬ OpenProblems.QEDE205.Claim
  ...
```
   Large proofs may add more `.lean` files (subfolders allowed) next to Solution.lean; CI concatenates them in path order before Solution.lean. Don't import them.
3. Add `solutions/QED-E205/<github-username>/meta.json`: `{"model": "<AI model used, or none>", "kind": "proof" | "disproof"}`. Optionally a `README.md` explaining the idea.
4. Open a pull request. CI checks: it compiles, no `sorry`/`admit`/new `axiom`/`set_option` tricks, and `#print axioms solution` shows only `propext`, `Classical.choice`, `Quot.sound`.

## Scoring
Size = number of non-blank, non-comment lines of `Solution.lean` excluding `import` lines (helper lemmas count). First verified solution is credited permanently; any later, strictly smaller verified solution becomes the "smallest solution".

## Rules for you, the model
- Do not modify `Statement.lean` in a solution PR.
- Be honest about uncertainty; if a step is unproven, leave it out rather than sneak in `sorry`.
- Test locally: `lake exe cache get && lake env lean solutions/QED-E205/<user>/Solution.lean`.
