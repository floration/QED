# QED-M027 — 2^{Omega(n)} hardness of Euclidean SVP under ETH

You are an AI model helping someone attack this open problem. Read all of this before working.

## The problem
Main set · Grade A · QED Curated · Complexity

**Plain words:** Show that approximate SVP in the l_2 norm (some constant gamma>1) has no 2^{o(n)}-time algorithm unless (randomized) ETH fails; or identify an obstruction (e.g. for the Z^n-based gadget) showing the l_p, p>2 technique cannot reach p=2.

**Math:** Prove there is a constant gamma > 1 such that, if randomized ETH holds (there is delta > 0 such that no bounded-error randomized algorithm decides 3-SAT on n variables in time 2^{delta n} poly(size)), then there is delta' > 0 such that no bounded-error randomized algorithm decides gamma-GapSVP in the l_2 norm on rank-n integer lattices in time 2^{delta' n} poly(size) (2^{Omega(n)} hardness, in particular no 2^{o(n)}-time algorithm). The alternative 'technique obstruction' target is a meta-statement and is not formalized.

**Credit:** Aggarwal, Gupta, Morolia, Zhang, 'Mind the Gap? Not for SVP Hardness under ETH!', ICALP 2026 (LIPIcs 374, paper 8), arXiv:2504.02695, Open Problem 1.

**References:**
- Aggarwal, Gupta, Morolia, Zhang, Mind the Gap? Not for SVP Hardness under ETH!, ICALP 2026, arXiv:2504.02695
- Aggarwal, Stephens-Davidowitz, (Gap-)ETH-hardness of SVP, STOC 2018
- arXiv:2504.02695v2
- LIPIcs.ICALP.2026.8
- arXiv:1712.00942
- arXiv:2109.04025

Difficulty estimate: 5.5/10 (calibrated: Collatz ≈ 5.5, twin primes ≈ 5.0). It is believed open; do not assume a quick answer exists, and say so plainly if you cannot make progress. Never present a heuristic, numerical evidence, or a partial result as a solution.

## What counts as an answer
Either a proof of `OpenProblems.QEDM027.Claim` or a proof of `¬ OpenProblems.QEDM027.Claim` (a disproof), in Lean 4 + Mathlib, using the exact statement in `problems/QED-M027/Statement.lean`. Read its "Formalization notes" first. If that file still says `def Claim : Prop := sorry`, the problem must first be formalized (see CONTRIBUTING.md); a faithful formalization is itself a welcome contribution.

If you think the Lean statement does not match the informal problem (it is trivially true or false, or it says something else), report that in an issue instead of exploiting it: such solutions are not credited.

## How to submit
0. First time? Solve a test problem (QED-Q1, the 2-line one, at minimum) and submit it, to confirm your Lean setup and the submission pipeline work before spending effort here. Skip this step if this IS a test problem.
1. Claim it (optional but encouraged): open an issue titled `Claim QED-M027` at https://github.com/floration/qed/issues/new?template=claim.yml. Comment on it at least once a week or the claim lapses.
2. Add `solutions/QED-M027/<github-username>/Solution.lean`:
```lean
import Mathlib
-- do NOT redefine Claim: CI prepends problems/QED-M027/Statement.lean to your file
theorem solution : OpenProblems.QEDM027.Claim := by   -- or ¬ OpenProblems.QEDM027.Claim
  ...
```
   Large proofs may add more `.lean` files (subfolders allowed) next to Solution.lean; CI concatenates them in path order before Solution.lean. Don't import them.
3. Add `solutions/QED-M027/<github-username>/meta.json`: `{"model": "<AI model used, or none>", "kind": "proof" | "disproof"}`. Optionally a `README.md` explaining the idea.
4. Open a pull request. CI checks: it compiles, no `sorry`/`admit`/new `axiom`/`set_option` tricks, and `#print axioms solution` shows only `propext`, `Classical.choice`, `Quot.sound`.

## Scoring
Size = number of non-blank, non-comment lines of `Solution.lean` excluding `import` lines (helper lemmas count). First verified solution is credited permanently; any later, strictly smaller verified solution becomes the "smallest solution".

## Rules for you, the model
- Do not modify `Statement.lean` in a solution PR.
- Be honest about uncertainty; if a step is unproven, leave it out rather than sneak in `sorry`.
- Test locally: `lake exe cache get && lake env lean solutions/QED-M027/<user>/Solution.lean`.
