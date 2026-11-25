# QED-M084 — Push the GRH lower bound for Montgomery's F(alpha) beyond alpha = 1

You are an AI model helping someone attack this open problem. Read all of this before working.

## The problem
Main set · Grade B · QED Extension · Number theory · formerly N-705

**Plain words:** Montgomery's function F(α) is known only for |α|≤1 (on RH). Under GRH for Dirichlet L-functions, Goldston–Gonek–Özlük–Snyder proved F(α) ≥ 3/2−|α|−ε on 1≤|α|≤3/2, while the conjecture says F(α)=1 there. Improve this lower bound.

**Math:** Assume GRH for all Dirichlet $L$-functions. Prove that for some $\delta>0$ and all $\alpha\in[1,1+\delta]$, $\liminf_{T\to\infty}F(\alpha,T)\ge \tfrac32-\alpha+\delta$, or prove $\liminf_T \int_{1}^{3/2}F(\alpha,T)\,d\alpha>1/8$ (the value forced by the GGOS bound).

**Credit:** Goldston, Gonek, Özlük, Snyder (2000), 'On the pair correlation of zeros of the Riemann zeta-function', Proc. London Math. Soc.

**References:**
- https://www.cambridge.org/core/journals/proceedings-of-the-london-mathematical-society/article/on-the-pair-correlation-of-zeros-of-the-riemann-zetafunction/29A91CBF07210A94E8EEFEAFFBB9FDEE
- https://arxiv.org/abs/2508.10857
- https://myweb.ecu.edu/baluyots24/alternativehyp.pdf

Difficulty estimate: 5.0/10 (calibrated: Collatz ≈ 5.5, twin primes ≈ 5.0). It is believed open; do not assume a quick answer exists, and say so plainly if you cannot make progress. Never present a heuristic, numerical evidence, or a partial result as a solution.

## What counts as an answer
Either a proof of `OpenProblems.QEDM084.Claim` or a proof of `¬ OpenProblems.QEDM084.Claim` (a disproof), in Lean 4 + Mathlib, using the exact statement in `problems/QED-M084/Statement.lean`. Read its "Formalization notes" first. If that file still says `def Claim : Prop := sorry`, the problem must first be formalized (see CONTRIBUTING.md); a faithful formalization is itself a welcome contribution.

If you think the Lean statement does not match the informal problem (it is trivially true or false, or it says something else), report that in an issue instead of exploiting it: such solutions are not credited.

## How to submit
1. Claim it (optional but encouraged): open an issue titled `Claim QED-M084` at https://github.com/floration/qed/issues/new?template=claim.yml. Comment on it at least once a week or the claim lapses.
2. Add `solutions/QED-M084/<github-username>/Solution.lean`:
```lean
import Mathlib
-- do NOT redefine Claim: CI prepends problems/QED-M084/Statement.lean to your file
theorem solution : OpenProblems.QEDM084.Claim := by   -- or ¬ OpenProblems.QEDM084.Claim
  ...
```
3. Add `solutions/QED-M084/<github-username>/meta.json`: `{"model": "<AI model used, or none>", "kind": "proof" | "disproof"}`. Optionally a `README.md` explaining the idea.
4. Open a pull request. CI checks: it compiles, no `sorry`/`admit`/new `axiom`/`set_option` tricks, and `#print axioms solution` shows only `propext`, `Classical.choice`, `Quot.sound`.

## Scoring
Size = number of non-blank, non-comment lines of `Solution.lean` excluding `import` lines (helper lemmas count). First verified solution is credited permanently; any later, strictly smaller verified solution becomes the "smallest solution".

## Rules for you, the model
- Do not modify `Statement.lean` in a solution PR.
- Be honest about uncertainty; if a step is unproven, leave it out rather than sneak in `sorry`.
- Test locally: `lake exe cache get && lake env lean solutions/QED-M084/<user>/Solution.lean`.
