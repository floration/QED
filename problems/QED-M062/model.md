# QED-M062 — How nearly can tetrahedra close up: the exponent

You are an AI model helping someone attack this open problem. Read all of this before working.

## The problem
Main set · Grade B · QED Extension · Geometry

**Plain words:** Glue regular tetrahedra face to face in a chain of length n; it can never close exactly. How close to closing can it get? Short arguments show the best gap is at least about 3^{-n/2} and, for infinitely many n, at most about 3^{-n/12}; counting suggests 3^{-n/6}. Narrow the exponent range [1/12, 1/2].

**Math:** Let g(k) be the minimal Hausdorff distance between T_k and T_0 over non-backtracking face-reflection chains of length k, and κ := liminf_{n→∞} −(1/n) log₃ min_{1≤k≤n} g(k). Known: 1/12 ≤ κ ≤ 1/2 (heuristic κ = 1/6). Prove κ > 1/12, i.e. there are δ > 0 and N such that for every n ≥ N some non-backtracking chain of length between 1 and n ends within 3^{−(1/12+δ)n} of T_0.

**Credit:** Steinhaus problem; Świerczkowski (1959) non-closure; Elgersma & Wagon (2016), arXiv:1610.00280.

**QED results so far (reviewer-derived; check before relying on them):** g(n) >= c*3^{-n/2} for all n (new, short proof): g_n = s_{i1}...s_{in}, linear part = ±R_q, q = v_{i1}...v_{in}, v_i the pure quaternions ±i±j±k (norm 3); non-backtracking => q primitive in the Hurwitz order (unique factorisation; checked by computer to n=11). If T_n is near T_0 the linear part is near a symmetry ±R_u; q*conj(u) cannot be real (primitivity / 2*3^n not a square), so its vector part has length >=1/2 while |q u| <= sqrt2*3^{n/2}, giving rotation error >> 3^{-n/2}.

**Rests on recent unrefereed work. Check these premises first:**
- QED-internal derivation (unrefereed): the bounds 1/12 ≤ κ ≤ 1/2 (Hurwitz-order primitivity checked by computer only to n = 11). The formal Claim only uses the definitions, not these bounds.

**References:**
- https://arxiv.org/abs/1610.00280
- https://arxiv.org/pdf/1610.00280
- https://portal.mardi4nfdi.de/wiki/Item:Q2354124

Difficulty estimate: 4.5/10 (calibrated: Collatz ≈ 5.5, twin primes ≈ 5.0). It is believed open; do not assume a quick answer exists, and say so plainly if you cannot make progress. Never present a heuristic, numerical evidence, or a partial result as a solution.

## What counts as an answer
Either a proof of `OpenProblems.QEDM062.Claim` or a proof of `¬ OpenProblems.QEDM062.Claim` (a disproof), in Lean 4 + Mathlib, using the exact statement in `problems/QED-M062/Statement.lean`. Read its "Formalization notes" first. If that file still says `def Claim : Prop := sorry`, the problem must first be formalized (see CONTRIBUTING.md); a faithful formalization is itself a welcome contribution.

If you think the Lean statement does not match the informal problem (it is trivially true or false, or it says something else), report that in an issue instead of exploiting it: such solutions are not credited.

## How to submit
0. First time? Solve a test problem (QED-Q1, the 2-line one, at minimum) and submit it, to confirm your Lean setup and the submission pipeline work before spending effort here. Skip this step if this IS a test problem.
1. Claim it (optional but encouraged): open an issue titled `Claim QED-M062` at https://github.com/floration/qed/issues/new?template=claim.yml. Comment on it at least once a week or the claim lapses.
2. Add `solutions/QED-M062/<github-username>/Solution.lean`:
```lean
import Mathlib
-- do NOT redefine Claim: CI prepends problems/QED-M062/Statement.lean to your file
theorem solution : OpenProblems.QEDM062.Claim := by   -- or ¬ OpenProblems.QEDM062.Claim
  ...
```
3. Add `solutions/QED-M062/<github-username>/meta.json`: `{"model": "<AI model used, or none>", "kind": "proof" | "disproof"}`. Optionally a `README.md` explaining the idea.
4. Open a pull request. CI checks: it compiles, no `sorry`/`admit`/new `axiom`/`set_option` tricks, and `#print axioms solution` shows only `propext`, `Classical.choice`, `Quot.sound`.

## Scoring
Size = number of non-blank, non-comment lines of `Solution.lean` excluding `import` lines (helper lemmas count). First verified solution is credited permanently; any later, strictly smaller verified solution becomes the "smallest solution".

## Rules for you, the model
- Do not modify `Statement.lean` in a solution PR.
- Be honest about uncertainty; if a step is unproven, leave it out rather than sneak in `sorry`.
- Test locally: `lake exe cache get && lake env lean solutions/QED-M062/<user>/Solution.lean`.
