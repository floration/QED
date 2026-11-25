# QED-M028 — A super-constant-degree SoS integrality gap for Unique Games

You are an AI model helping someone attack this open problem. Read all of this before working.

## The problem
Main set · Grade A · QED Curated · Complexity · formerly N-666

**Plain words:** Construct Unique Games instances with value <= eps on which degree-d Sum-of-Squares has value >= 1-eps, for some d = omega(1) (any slowly growing function of n), or show degree-O(1) SoS achieves a (1-eps, delta) distinguishing guarantee on all UG instances.

**Math:** (Gap) For every eps>0 there is q=q(eps) such that for every degree D there is a Unique Games instance over [q] with optimum <= eps whose degree-2D SoS (Lasserre) value is >= 1-eps. Claim := Gap; ¬Claim is exactly the algorithmic alternative.

**Credit:** Barak, Sum-of-Squares open problems (lecture notes); Barak & Steurer 2014, arXiv:1404.5236

**References:**
- Barak, Brandão, Harrow, Kelner, Steurer, Zhou, Hypercontractivity, sum-of-squares proofs, and their applications, STOC 2012, arXiv:1205.4484
- Khot, Minzer, Safra, Pseudorandom sets in Grassmann graph have near-perfect expansion, FOCS 2018
- Barak, Sum of Squares: open problems (lecture notes)
- arXiv:1205.4484
- arXiv:1211.1958
- arXiv:1404.5236
- Khot-Minzer-Safra FOCS 2018

Difficulty estimate: 4.5/10 (calibrated: Collatz ≈ 5.5, twin primes ≈ 5.0). It is believed open; do not assume a quick answer exists, and say so plainly if you cannot make progress. Never present a heuristic, numerical evidence, or a partial result as a solution.

## What counts as an answer
Either a proof of `OpenProblems.QEDM028.Claim` or a proof of `¬ OpenProblems.QEDM028.Claim` (a disproof), in Lean 4 + Mathlib, using the exact statement in `problems/QED-M028/Statement.lean`. Read its "Formalization notes" first. If that file still says `def Claim : Prop := sorry`, the problem must first be formalized (see CONTRIBUTING.md); a faithful formalization is itself a welcome contribution.

If you think the Lean statement does not match the informal problem (it is trivially true or false, or it says something else), report that in an issue instead of exploiting it: such solutions are not credited.

## How to submit
1. Claim it (optional but encouraged): open an issue titled `Claim QED-M028` at https://github.com/floration/qed/issues/new?template=claim.yml. Comment on it at least once a week or the claim lapses.
2. Add `solutions/QED-M028/<github-username>/Solution.lean`:
```lean
import Mathlib
-- do NOT redefine Claim: CI prepends problems/QED-M028/Statement.lean to your file
theorem solution : OpenProblems.QEDM028.Claim := by   -- or ¬ OpenProblems.QEDM028.Claim
  ...
```
3. Add `solutions/QED-M028/<github-username>/meta.json`: `{"model": "<AI model used, or none>", "kind": "proof" | "disproof"}`. Optionally a `README.md` explaining the idea.
4. Open a pull request. CI checks: it compiles, no `sorry`/`admit`/new `axiom`/`set_option` tricks, and `#print axioms solution` shows only `propext`, `Classical.choice`, `Quot.sound`.

## Scoring
Size = number of non-blank, non-comment lines of `Solution.lean` excluding `import` lines (helper lemmas count). First verified solution is credited permanently; any later, strictly smaller verified solution becomes the "smallest solution".

## Rules for you, the model
- Do not modify `Statement.lean` in a solution PR.
- Be honest about uncertainty; if a step is unproven, leave it out rather than sneak in `sorry`.
- Test locally: `lake exe cache get && lake env lean solutions/QED-M028/<user>/Solution.lean`.
