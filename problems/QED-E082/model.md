# QED-E082 — Binary-error LWE with linearly many samples

You are an AI model helping someone attack this open problem. Read all of this before working.

## The problem
Extended set · Grade B · QED Curated · Complexity

**Plain words:** For LWE with secret in Z_q^n (q = poly(n)) and errors uniform in {0,1}, given m = C*n samples for a fixed constant C > 1, either give a polynomial-time (or 2^{o(n)}) algorithm, or prove hardness from standard LWE/worst-case lattice problems for m = C*n (beyond the n(1+O(1/log n)) samples of Micciancio-Peikert).

**Math:** Fix q=q(n) with 2<=q(n)<=poly(n), all of whose prime factors are at most n^{1/2+o(1)} (e.g. q<=sqrt(n), or q a power of 2), and a constant C>1; m=ceil(Cn). Decision binary-error LWE: given (A,b), A uniform in Z_q^{m x n}, b=As+e mod q (s uniform, e uniform in {0,1}^m) or b uniform. Show that for every such C and q either (a) some randomized 2^{o(n)}-time algorithm distinguishes with non-negligible advantage, or (b) the problem is polynomial-time hard assuming standard decision LWE is hard for some standard parameter family (dimension polynomially related to n, poly(n) modulus and samples, discrete Gaussian error of width alpha q' >= 2 sqrt(n')). Known: Arora-Ge solves m ~ n^2 in poly time; Micciancio-Peikert give (b) for m = n(1+O(1/log n)); for q with a prime factor n^{a+o(1)}, a>1/2, (a) follows from reduction mod p + normal form + ePrint 2026/2289.

**Credit:** Micciancio, Peikert, Hardness of SIS and LWE with small parameters, CRYPTO 2013; Arora, Ge, ICALP 2011.

**References:**
- Micciancio, Peikert, Hardness of SIS and LWE with small parameters, CRYPTO 2013
- Arora, Ge, New algorithms for learning in presence of errors, ICALP 2011
- Albrecht, Cid, Faugère, Fitzpatrick, Perret, Algebraic algorithms for LWE problems, ACM CCA 2015
- Aaronson, That IACR preprint (blog post on Chen 2024), scottaaronson.blog/?p=7946

Difficulty estimate: 4.0/10 (anchored scale: 1 ≈ Erdős–Ginzburg–Ziv, 2.5 ≈ the sensitivity conjecture, 5 ≈ bounded prime gaps, 7.5 ≈ the Riemann Hypothesis, 10 ≈ P vs NP). It is believed open; do not assume a quick answer exists, and say so plainly if you cannot make progress. Never present a heuristic, numerical evidence, or a partial result as a solution.

## What counts as an answer
Either a proof of `OpenProblems.QEDE082.Claim` or a proof of `¬ OpenProblems.QEDE082.Claim` (a disproof), in Lean 4 + Mathlib, using the exact statement in `problems/QED-E082/Statement.lean`. Read its "Formalization notes" first. If that file still says `def Claim : Prop := sorry`, the problem must first be formalized (see CONTRIBUTING.md); a faithful formalization is itself a welcome contribution.

If you think the Lean statement does not match the informal problem (it is trivially true or false, or it says something else), report that in an issue instead of exploiting it: such solutions are not credited.

## How to submit
0. First time? Solve a test problem (QED-Q1, the 2-line one, at minimum) and submit it, to confirm your Lean setup and the submission pipeline work before spending effort here. Skip this step if this IS a test problem.
1. Claim it (optional but encouraged): open an issue titled `Claim QED-E082` at https://github.com/floration/qed/issues/new?template=claim.yml. Comment on it at least once a week or the claim lapses.
2. Add `solutions/QED-E082/<github-username>/Solution.lean`:
```lean
import Mathlib
-- do NOT redefine Claim: CI prepends problems/QED-E082/Statement.lean to your file
theorem solution : OpenProblems.QEDE082.Claim := by   -- or ¬ OpenProblems.QEDE082.Claim
  ...
```
   Large proofs may add more `.lean` files (subfolders allowed) next to Solution.lean; CI concatenates them in path order before Solution.lean. Don't import them.
3. Add `solutions/QED-E082/<github-username>/meta.json`: `{"model": "<AI model used, or none>", "kind": "proof" | "disproof"}`. Optionally a `README.md` explaining the idea.
4. Open a pull request. CI checks: it compiles, no `sorry`/`admit`/new `axiom`/`set_option` tricks, and `#print axioms solution` shows only `propext`, `Classical.choice`, `Quot.sound`.

## Scoring
Size = number of non-blank, non-comment lines of `Solution.lean` excluding `import` lines (helper lemmas count). First verified solution is credited permanently; any later, strictly smaller verified solution becomes the "smallest solution".

## Rules for you, the model
- Do not modify `Statement.lean` in a solution PR.
- Be honest about uncertainty; if a step is unproven, leave it out rather than sneak in `sorry`.
- Test locally: `lake exe cache get && lake env lean solutions/QED-E082/<user>/Solution.lean`.
