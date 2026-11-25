# QED-E083 — Densest k-Subgraph and k-Biclique FPT-inapproximability from plain ETH

You are an AI model helping someone attack this open problem. Read all of this before working.

## The problem
Extended set · Grade B · QED Curated · Complexity

**Plain words:** Prove, assuming only ETH, that Densest k-Subgraph cannot be approximated within k^{o(1)} (or any omega(1) factor) in f(k) n^{o(k)} time, or that k-Biclique has no f(k)n^{o(sqrt k)}-type algorithm, matching known Gap-ETH-based results.

**Math:** Assuming only (deterministic) ETH, prove that there is a function g(k) -> infinity such that no algorithm running in time f(k) n^{O(1)} (f computable) approximates (uncolored) Densest k-Subgraph within factor g(k), i.e. outputs v with OPT/g(k) <= v <= OPT. (Gap-ETH gives every g = k^{o(1)}; the k-Biclique disjunct is already known under ETH, Lin JACM 2018.)

**Credit:** Chalermsook et al., From Gap-ETH to FPT-inapproximability, FOCS 2017 (arXiv:1708.04218); Feldmann, Karthik C.S., Lee, Manurangsi, survey on approximation in parameterized complexity 2020 (arXiv:2006.04411)

**References:**
- Guruswami, Lin, Ren, Sun, Wu, Parameterized Inapproximability Hypothesis under ETH, STOC 2024, arXiv:2311.16587
- Aggarwal, Gupta, Morolia, Zhang, Mind the Gap? Not for SVP Hardness under ETH!, ICALP 2026, arXiv:2504.02695
- Chalermsook et al., From Gap-ETH to FPT-inapproximability, FOCS 2017
- arXiv:1406.3700
- arXiv:2311.16587
- arXiv:2504.02695
- arXiv:2112.04669
- arXiv:1708.04218

Difficulty estimate: 3.5/10 (calibrated: Collatz ≈ 5.5, twin primes ≈ 5.0). It is believed open; do not assume a quick answer exists, and say so plainly if you cannot make progress. Never present a heuristic, numerical evidence, or a partial result as a solution.

## What counts as an answer
Either a proof of `OpenProblems.QEDE083.Claim` or a proof of `¬ OpenProblems.QEDE083.Claim` (a disproof), in Lean 4 + Mathlib, using the exact statement in `problems/QED-E083/Statement.lean`. Read its "Formalization notes" first. If that file still says `def Claim : Prop := sorry`, the problem must first be formalized (see CONTRIBUTING.md); a faithful formalization is itself a welcome contribution.

If you think the Lean statement does not match the informal problem (it is trivially true or false, or it says something else), report that in an issue instead of exploiting it: such solutions are not credited.

## How to submit
0. First time? Solve a test problem (QED-Q1, the 2-line one, at minimum) and submit it, to confirm your Lean setup and the submission pipeline work before spending effort here. Skip this step if this IS a test problem.
1. Claim it (optional but encouraged): open an issue titled `Claim QED-E083` at https://github.com/floration/qed/issues/new?template=claim.yml. Comment on it at least once a week or the claim lapses.
2. Add `solutions/QED-E083/<github-username>/Solution.lean`:
```lean
import Mathlib
-- do NOT redefine Claim: CI prepends problems/QED-E083/Statement.lean to your file
theorem solution : OpenProblems.QEDE083.Claim := by   -- or ¬ OpenProblems.QEDE083.Claim
  ...
```
   Large proofs may add more `.lean` files (subfolders allowed) next to Solution.lean; CI concatenates them in path order before Solution.lean. Don't import them.
3. Add `solutions/QED-E083/<github-username>/meta.json`: `{"model": "<AI model used, or none>", "kind": "proof" | "disproof"}`. Optionally a `README.md` explaining the idea.
4. Open a pull request. CI checks: it compiles, no `sorry`/`admit`/new `axiom`/`set_option` tricks, and `#print axioms solution` shows only `propext`, `Classical.choice`, `Quot.sound`.

## Scoring
Size = number of non-blank, non-comment lines of `Solution.lean` excluding `import` lines (helper lemmas count). First verified solution is credited permanently; any later, strictly smaller verified solution becomes the "smallest solution".

## Rules for you, the model
- Do not modify `Statement.lean` in a solution PR.
- Be honest about uncertainty; if a step is unproven, leave it out rather than sneak in `sorry`.
- Test locally: `lake exe cache get && lake env lean solutions/QED-E083/<user>/Solution.lean`.
