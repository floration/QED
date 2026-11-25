# QED-M042 — Sparse 3-LPN at noise n^{-1/2}: beating Gaussian elimination

You are an AI model helping someone attack this open problem. Read all of this before working.

## The problem
Main set · Grade B · QED Extension · Complexity · formerly N-702

**Plain words:** For 3-sparse LPN with m = n^{1.4} samples and noise rate eta = n^{-0.6} (or any eta in [n^{-0.7}, n^{-0.5}]), give an algorithm running in time exp(o(eta*n)), or prove a lower bound (e.g. for low-degree/SoS or statistical-query-like models) showing exp(Omega(eta*n)) is needed in this regime.

**Math:** Fix k = 3, m = ⌊n^{1.4}⌋ and η = n^{-0.6}. In the 3-sparse LPN problem a secret s ∈ F_2^n is uniform, each sample is (a_i, ⟨a_i,s⟩ + e_i) with a_i uniform among weight-3 vectors of F_2^n and e_i ~ Bernoulli(η) independent, i = 1..m. Prove or disprove: there is a (classical, randomized) algorithm that, given the m samples, outputs s with probability ≥ 2/3 in time exp(o(ηn)) = exp(o(n^{0.4})).

**Credit:** Chen, Shu, Zhou, 'Algorithms for Sparse LPN and LSPN Against Low-noise', COLT 2025, arXiv:2407.19215; Applebaum, FOCS 2017.

**References:**
- Chen, Shu, Zhou, Algorithms for Sparse LPN and LSPN Against Low-noise, COLT 2025, arXiv:2407.19215
- Applebaum, Exponentially-hard Gap-CSP and local PRG via local hardcore functions, FOCS 2017

Difficulty estimate: 3.5/10 (calibrated: Collatz ≈ 5.5, twin primes ≈ 5.0). It is believed open; do not assume a quick answer exists, and say so plainly if you cannot make progress. Never present a heuristic, numerical evidence, or a partial result as a solution.

## What counts as an answer
Either a proof of `OpenProblems.QEDM042.Claim` or a proof of `¬ OpenProblems.QEDM042.Claim` (a disproof), in Lean 4 + Mathlib, using the exact statement in `problems/QED-M042/Statement.lean`. Read its "Formalization notes" first. If that file still says `def Claim : Prop := sorry`, the problem must first be formalized (see CONTRIBUTING.md); a faithful formalization is itself a welcome contribution. What is missing: Not formalized: needs a time-bounded model of (randomized) computation. Consider removing or splitting into an algorithmic problem and a separate low-degree lower-bound problem with a precise model.

If you think the Lean statement does not match the informal problem (it is trivially true or false, or it says something else), report that in an issue instead of exploiting it: such solutions are not credited.

## How to submit
1. Claim it (optional but encouraged): open an issue titled `Claim QED-M042` at https://github.com/floration/qed/issues/new?template=claim.yml. Comment on it at least once a week or the claim lapses.
2. Add `solutions/QED-M042/<github-username>/Solution.lean`:
```lean
import Mathlib
-- do NOT redefine Claim: CI prepends problems/QED-M042/Statement.lean to your file
theorem solution : OpenProblems.QEDM042.Claim := by   -- or ¬ OpenProblems.QEDM042.Claim
  ...
```
3. Add `solutions/QED-M042/<github-username>/meta.json`: `{"model": "<AI model used, or none>", "kind": "proof" | "disproof"}`. Optionally a `README.md` explaining the idea.
4. Open a pull request. CI checks: it compiles, no `sorry`/`admit`/new `axiom`/`set_option` tricks, and `#print axioms solution` shows only `propext`, `Classical.choice`, `Quot.sound`.

## Scoring
Size = number of non-blank, non-comment lines of `Solution.lean` excluding `import` lines (helper lemmas count). First verified solution is credited permanently; any later, strictly smaller verified solution becomes the "smallest solution".

## Rules for you, the model
- Do not modify `Statement.lean` in a solution PR.
- Be honest about uncertainty; if a step is unproven, leave it out rather than sneak in `sorry`.
- Test locally: `lake exe cache get && lake env lean solutions/QED-M042/<user>/Solution.lean`.
