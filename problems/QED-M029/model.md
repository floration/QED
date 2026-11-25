# QED-M029 — A uniformly samplable counterexample to the poly-time low-degree conjecture

You are an AI model helping someone attack this open problem. Read all of this before working.

## The problem
Main set · Grade A · QED Curated · Complexity · formerly N-672

**Plain words:** Mao's counterexample (permutation-invariant graph distributions with zero low-degree advantage up to degree Theta(log^{r-1} n) that a linear-time rank test detects after constant-rate resampling) needs non-uniform advice for its Reed-Muller subspace / evaluation-point seed. Find a polynomial-time algorithm that outputs a good seed, giving a uniformly poly-time samplable counterexample; or show that every uniformly samplable permutation-invariant distribution with vanishing degree-polylog advantage is hard for poly-time noise-robust tests (a repaired conjecture).

**Math:** For some fixed r>=3, give a single randomized algorithm that, given 1^n, samples in expected poly(n) time from a permutation-invariant distribution P_n on n-vertex graphs whose low-degree advantage over G(n,1/2) vanishes up to degree D_n=Theta((log n)^{r-1}), while after independent edge resampling at a fixed rate delta>0 a poly-time test distinguishes it from G(n,1/2) w.p. 1-o(1). A sufficient route via Mao's construction: find in poly(n) time evaluation points with every <=L of the vectors phi(x_i) linearly independent.

**Credit:** Mao, The Polynomial-Time Low-Degree Conjecture is False, arXiv:2607.20318 (2026), Sec. 4.

**Rests on recent unrefereed work. Check these premises first:**
- arXiv:2607.20318 (Mao, 2026 preprint): the whole problem assumes Mao's construction (Reed-Muller subspace/trace functions, the advice size, the linear-time rank test after resampling) is correct.
- arXiv:2505.17360 (Buhai-Hsieh-Jain-Kothari, 2025 preprint): background quasi-polynomial counterexample; status of refereeing not verified.

**References:**
- Mao, The Polynomial-Time Low-Degree Conjecture is False, arXiv:2607.20318
- Buhai, Hsieh, Jain, Kothari, The Quasi-Polynomial Low-Degree Conjecture is False, arXiv:2505.17360
- Hopkins, Statistical inference and the sum of squares method, PhD thesis 2018
- arXiv:2607.20318
- arXiv:2505.17360

Difficulty estimate: 4.0/10 (calibrated: Collatz ≈ 5.5, twin primes ≈ 5.0). It is believed open; do not assume a quick answer exists, and say so plainly if you cannot make progress. Never present a heuristic, numerical evidence, or a partial result as a solution.

## What counts as an answer
Either a proof of `OpenProblems.QEDM029.Claim` or a proof of `¬ OpenProblems.QEDM029.Claim` (a disproof), in Lean 4 + Mathlib, using the exact statement in `problems/QED-M029/Statement.lean`. Read its "Formalization notes" first. If that file still says `def Claim : Prop := sorry`, the problem must first be formalized (see CONTRIBUTING.md); a faithful formalization is itself a welcome contribution. What is missing: Statement left as sorry by design (no complexity-class infrastructure).

If you think the Lean statement does not match the informal problem (it is trivially true or false, or it says something else), report that in an issue instead of exploiting it: such solutions are not credited.

## How to submit
1. Claim it (optional but encouraged): open an issue titled `Claim QED-M029` at https://github.com/floration/qed/issues/new?template=claim.yml. Comment on it at least once a week or the claim lapses.
2. Add `solutions/QED-M029/<github-username>/Solution.lean`:
```lean
import Mathlib
-- do NOT redefine Claim: CI prepends problems/QED-M029/Statement.lean to your file
theorem solution : OpenProblems.QEDM029.Claim := by   -- or ¬ OpenProblems.QEDM029.Claim
  ...
```
3. Add `solutions/QED-M029/<github-username>/meta.json`: `{"model": "<AI model used, or none>", "kind": "proof" | "disproof"}`. Optionally a `README.md` explaining the idea.
4. Open a pull request. CI checks: it compiles, no `sorry`/`admit`/new `axiom`/`set_option` tricks, and `#print axioms solution` shows only `propext`, `Classical.choice`, `Quot.sound`.

## Scoring
Size = number of non-blank, non-comment lines of `Solution.lean` excluding `import` lines (helper lemmas count). First verified solution is credited permanently; any later, strictly smaller verified solution becomes the "smallest solution".

## Rules for you, the model
- Do not modify `Statement.lean` in a solution PR.
- Be honest about uncertainty; if a step is unproven, leave it out rather than sneak in `sorry`.
- Test locally: `lake exe cache get && lake env lean solutions/QED-M029/<user>/Solution.lean`.
