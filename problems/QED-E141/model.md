# QED-E141 — An odd weird number

You are an AI model helping someone attack this open problem. Read all of this before working.

## The problem
Extended set · Grade C · QED Curated · Number theory

**Plain words:** A number is abundant if its proper divisors add up to more than the number itself, and weird if it is abundant but no selection of its distinct proper divisors adds up to exactly the number (70 is the smallest). Weird numbers have positive density, but every known one is even. Does an odd weird number exist?

**Math:** Decide whether there exists an odd $n\in\mathbb N$ with $\sigma(n)>2n$ such that no subset $S$ of the proper divisors of $n$ satisfies $\sum_{d\in S}d=n$.

**Credit:** Benkoski and Erdős (1974); erdosproblems.com #470.

**Rests on recent unrefereed work. Check these premises first:**
- Attributed as an Erdős problem (#470); the question itself is not person-named
- Abundancy-cap context uses an unrefereed 2026 preprint
- Already formalized in google-deepmind/formal-conjectures (helpful, but shows it is well known)

**References:**
- https://google-deepmind.github.io/formal-conjectures/FormalConjectures/ErdosProblems/470.html
- https://en.wikipedia.org/wiki/Weird_number
- https://arxiv.org/abs/2207.12906
- https://proofwiki.org/wiki/Do_Odd_Weird_Numbers_Exist%3F

Difficulty estimate: 5.5/10 (calibrated: Collatz ≈ 5.5, twin primes ≈ 5.0). It is believed open; do not assume a quick answer exists, and say so plainly if you cannot make progress. Never present a heuristic, numerical evidence, or a partial result as a solution.

## What counts as an answer
Either a proof of `OpenProblems.QEDE141.Claim` or a proof of `¬ OpenProblems.QEDE141.Claim` (a disproof), in Lean 4 + Mathlib, using the exact statement in `problems/QED-E141/Statement.lean`. Read its "Formalization notes" first. If that file still says `def Claim : Prop := sorry`, the problem must first be formalized (see CONTRIBUTING.md); a faithful formalization is itself a welcome contribution.

If you think the Lean statement does not match the informal problem (it is trivially true or false, or it says something else), report that in an issue instead of exploiting it: such solutions are not credited.

## How to submit
0. First time? Solve a test problem (QED-Q1, the 2-line one, at minimum) and submit it, to confirm your Lean setup and the submission pipeline work before spending effort here. Skip this step if this IS a test problem.
1. Claim it (optional but encouraged): open an issue titled `Claim QED-E141` at https://github.com/floration/qed/issues/new?template=claim.yml. Comment on it at least once a week or the claim lapses.
2. Add `solutions/QED-E141/<github-username>/Solution.lean`:
```lean
import Mathlib
-- do NOT redefine Claim: CI prepends problems/QED-E141/Statement.lean to your file
theorem solution : OpenProblems.QEDE141.Claim := by   -- or ¬ OpenProblems.QEDE141.Claim
  ...
```
   Large proofs may add more `.lean` files (subfolders allowed) next to Solution.lean; CI concatenates them in path order before Solution.lean. Don't import them.
3. Add `solutions/QED-E141/<github-username>/meta.json`: `{"model": "<AI model used, or none>", "kind": "proof" | "disproof"}`. Optionally a `README.md` explaining the idea.
4. Open a pull request. CI checks: it compiles, no `sorry`/`admit`/new `axiom`/`set_option` tricks, and `#print axioms solution` shows only `propext`, `Classical.choice`, `Quot.sound`.

## Scoring
Size = number of non-blank, non-comment lines of `Solution.lean` excluding `import` lines (helper lemmas count). First verified solution is credited permanently; any later, strictly smaller verified solution becomes the "smallest solution".

## Rules for you, the model
- Do not modify `Statement.lean` in a solution PR.
- Be honest about uncertainty; if a step is unproven, leave it out rather than sneak in `sorry`.
- Test locally: `lake exe cache get && lake env lean solutions/QED-E141/<user>/Solution.lean`.
