# QED-E232 — Bombieri–Vinogradov for primes with a missing decimal digit

You are an AI model helping someone attack this open problem. Read all of this before working.

## The problem
Extended set · Grade C · QED Original · Number theory

**Plain words:** Maynard proved there are infinitely many primes with no digit 7 in base 10, with the expected count. Show these primes are also well spread over arithmetic progressions, on average over all moduli up to a small power of x, as the Bombieri-Vinogradov theorem says for all primes.

**Math:** Let $\mathcal S$ be the set of positive integers with no digit $7$ in base $10$, and for $(a,q)=1$ let $\pi_{\mathcal S}(x;q,a)=\#\{p\le x \text{ prime}: p\in\mathcal S,\ p\equiv a \ (q)\}$, $\pi_{\mathcal S}(x)=\pi_{\mathcal S}(x;1,0)$. Prove there is $\theta>0$ such that for every $A>0$: $\sum_{q\le x^{\theta},\,(q,10)=1}\ \max_{(a,q)=1}\big|\pi_{\mathcal S}(x;q,a)-\pi_{\mathcal S}(x)/\varphi(q)\big|\ll_A \pi_{\mathcal S}(x)(\log x)^{-A}$.

**Credit:** QED original (archived Nov 2026, restored after re-review).

**References:**
- https://arxiv.org/abs/1604.01041
- https://arxiv.org/abs/2510.13076
- https://arxiv.org/abs/2409.06894

Difficulty estimate: 3.1/10 (calibrated: Collatz ≈ 5.5, twin primes ≈ 5.0). It is believed open; do not assume a quick answer exists, and say so plainly if you cannot make progress. Never present a heuristic, numerical evidence, or a partial result as a solution.

## What counts as an answer
Either a proof of `OpenProblems.QEDE232.Claim` or a proof of `¬ OpenProblems.QEDE232.Claim` (a disproof), in Lean 4 + Mathlib, using the exact statement in `problems/QED-E232/Statement.lean`. Read its "Formalization notes" first. If that file still says `def Claim : Prop := sorry`, the problem must first be formalized (see CONTRIBUTING.md); a faithful formalization is itself a welcome contribution.

If you think the Lean statement does not match the informal problem (it is trivially true or false, or it says something else), report that in an issue instead of exploiting it: such solutions are not credited.

## How to submit
0. First time? Solve a test problem (QED-Q1, the 2-line one, at minimum) and submit it, to confirm your Lean setup and the submission pipeline work before spending effort here. Skip this step if this IS a test problem.
1. Claim it (optional but encouraged): open an issue titled `Claim QED-E232` at https://github.com/floration/qed/issues/new?template=claim.yml. Comment on it at least once a week or the claim lapses.
2. Add `solutions/QED-E232/<github-username>/Solution.lean`:
```lean
import Mathlib
-- do NOT redefine Claim: CI prepends problems/QED-E232/Statement.lean to your file
theorem solution : OpenProblems.QEDE232.Claim := by   -- or ¬ OpenProblems.QEDE232.Claim
  ...
```
   Large proofs may add more `.lean` files (subfolders allowed) next to Solution.lean; CI concatenates them in path order before Solution.lean. Don't import them.
3. Add `solutions/QED-E232/<github-username>/meta.json`: `{"model": "<AI model used, or none>", "kind": "proof" | "disproof"}`. Optionally a `README.md` explaining the idea.
4. Open a pull request. CI checks: it compiles, no `sorry`/`admit`/new `axiom`/`set_option` tricks, and `#print axioms solution` shows only `propext`, `Classical.choice`, `Quot.sound`.

## Scoring
Size = number of non-blank, non-comment lines of `Solution.lean` excluding `import` lines (helper lemmas count). First verified solution is credited permanently; any later, strictly smaller verified solution becomes the "smallest solution".

## Rules for you, the model
- Do not modify `Statement.lean` in a solution PR.
- Be honest about uncertainty; if a step is unproven, leave it out rather than sneak in `sorry`.
- Test locally: `lake exe cache get && lake env lean solutions/QED-E232/<user>/Solution.lean`.
