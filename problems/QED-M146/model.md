# QED-M146 — Primes with a missing digit in bases 10 and 11 at once

You are an AI model helping someone attack this open problem. Read all of this before working.

## The problem
Main set · Grade B · QED Original · Number theory

**Plain words:** Are there infinitely many primes that have no digit 9 when written in base 10 and also no digit 10 (the digit 'A') when written in base 11?

**Math:** Let $\mathcal A=\{n\ge1:\ 9\text{ is not a base-}10\text{ digit of }n\text{ and }10\text{ is not a base-}11\text{ digit of }n\}$. Prove that $\mathcal A$ contains infinitely many primes; more strongly, prove $\#\{p\le x: p\in\mathcal A\}=x^{\gamma+o(1)}$ with $\gamma=\frac{\log 9}{\log 10}+\frac{\log 10}{\log 11}-1\approx0.9145$.

**Credit:** QED original (archived Nov 2026, restored after re-review).

**References:**
- https://arxiv.org/abs/1604.01041
- https://arxiv.org/abs/2503.09528
- https://arxiv.org/abs/2509.02835

Difficulty estimate: 3.2/10 (calibrated: Collatz ≈ 5.5, twin primes ≈ 5.0). It is believed open; do not assume a quick answer exists, and say so plainly if you cannot make progress. Never present a heuristic, numerical evidence, or a partial result as a solution.

## What counts as an answer
Either a proof of `OpenProblems.QEDM146.Claim` or a proof of `¬ OpenProblems.QEDM146.Claim` (a disproof), in Lean 4 + Mathlib, using the exact statement in `problems/QED-M146/Statement.lean`. Read its "Formalization notes" first. If that file still says `def Claim : Prop := sorry`, the problem must first be formalized (see CONTRIBUTING.md); a faithful formalization is itself a welcome contribution.

If you think the Lean statement does not match the informal problem (it is trivially true or false, or it says something else), report that in an issue instead of exploiting it: such solutions are not credited.

## How to submit
0. First time? Solve a test problem (QED-Q1, the 2-line one, at minimum) and submit it, to confirm your Lean setup and the submission pipeline work before spending effort here. Skip this step if this IS a test problem.
1. Claim it (optional but encouraged): open an issue titled `Claim QED-M146` at https://github.com/floration/qed/issues/new?template=claim.yml. Comment on it at least once a week or the claim lapses.
2. Add `solutions/QED-M146/<github-username>/Solution.lean`:
```lean
import Mathlib
-- do NOT redefine Claim: CI prepends problems/QED-M146/Statement.lean to your file
theorem solution : OpenProblems.QEDM146.Claim := by   -- or ¬ OpenProblems.QEDM146.Claim
  ...
```
   Large proofs may add more `.lean` files (subfolders allowed) next to Solution.lean; CI concatenates them in path order before Solution.lean. Don't import them.
3. Add `solutions/QED-M146/<github-username>/meta.json`: `{"model": "<AI model used, or none>", "kind": "proof" | "disproof"}`. Optionally a `README.md` explaining the idea.
4. Open a pull request. CI checks: it compiles, no `sorry`/`admit`/new `axiom`/`set_option` tricks, and `#print axioms solution` shows only `propext`, `Classical.choice`, `Quot.sound`.

## Scoring
Size = number of non-blank, non-comment lines of `Solution.lean` excluding `import` lines (helper lemmas count). First verified solution is credited permanently; any later, strictly smaller verified solution becomes the "smallest solution".

## Rules for you, the model
- Do not modify `Statement.lean` in a solution PR.
- Be honest about uncertainty; if a step is unproven, leave it out rather than sneak in `sorry`.
- Test locally: `lake exe cache get && lake env lean solutions/QED-M146/<user>/Solution.lean`.
