# QED-E236 — Ballistic transport for the Thue–Morse quantum walk

You are an AI model helping someone attack this open problem. Read all of this before working.

## The problem
Extended set · Grade C · QED Original · Analysis

**Plain words:** A quantum walker on the integers flips one of two rotation coins at each site, chosen by the Thue–Morse sequence. Previous work shows its spread is at least close to linear in time on average. Decide whether it actually spreads linearly in time (ballistically).

**Math:** For $\gamma\in(0,\pi/2)$ let $R_\gamma=\begin{pmatrix}\cos\gamma&-\sin\gamma\\ \sin\gamma&\cos\gamma\end{pmatrix}$. Let $x\in\{0,1\}^{\mathbb Z}$ be the two-sided Thue--Morse sequence $x_n=t_n$ ($n\ge0$), $x_n=t_{-n-1}$ ($n<0$), where $t_n=s_2(n)\bmod 2$. On $\ell^2(\mathbb Z)\otimes\mathbb C^2$ let $U=SC$, $(C\psi)(n)=R_{\gamma_{x_n}}\psi(n)$ with fixed $\gamma_0\neq\gamma_1$ in $(0,\pi/2)$, and $S$ shifting the first component by $+1$ and the second by $-1$. For $\psi_0=\delta_0\otimes e_1$ let $\tilde\beta^+=\limsup_{T\to\infty}\frac{\log\big(\frac1T\sum_{t<T}\sum_n|n|^2\|(U^t\psi_0)(n)\|^2\big)}{2\log T}$. It is known that $\tilde\beta^+\ge 1/2$. Decide whether $\tilde\beta^+=1$.

**Credit:** QED original (archived Nov 2026, restored after re-review).

**References:**
- https://arxiv.org/abs/1704.07328
- https://arxiv.org/abs/1505.07292

Difficulty estimate: 2.8/10 (calibrated: Collatz ≈ 5.5, twin primes ≈ 5.0). It is believed open; do not assume a quick answer exists, and say so plainly if you cannot make progress. Never present a heuristic, numerical evidence, or a partial result as a solution.

## What counts as an answer
Either a proof of `OpenProblems.QEDE236.Claim` or a proof of `¬ OpenProblems.QEDE236.Claim` (a disproof), in Lean 4 + Mathlib, using the exact statement in `problems/QED-E236/Statement.lean`. Read its "Formalization notes" first. If that file still says `def Claim : Prop := sorry`, the problem must first be formalized (see CONTRIBUTING.md); a faithful formalization is itself a welcome contribution.

If you think the Lean statement does not match the informal problem (it is trivially true or false, or it says something else), report that in an issue instead of exploiting it: such solutions are not credited.

## How to submit
0. First time? Solve a test problem (QED-Q1, the 2-line one, at minimum) and submit it, to confirm your Lean setup and the submission pipeline work before spending effort here. Skip this step if this IS a test problem.
1. Claim it (optional but encouraged): open an issue titled `Claim QED-E236` at https://github.com/floration/qed/issues/new?template=claim.yml. Comment on it at least once a week or the claim lapses.
2. Add `solutions/QED-E236/<github-username>/Solution.lean`:
```lean
import Mathlib
-- do NOT redefine Claim: CI prepends problems/QED-E236/Statement.lean to your file
theorem solution : OpenProblems.QEDE236.Claim := by   -- or ¬ OpenProblems.QEDE236.Claim
  ...
```
   Large proofs may add more `.lean` files (subfolders allowed) next to Solution.lean; CI concatenates them in path order before Solution.lean. Don't import them.
3. Add `solutions/QED-E236/<github-username>/meta.json`: `{"model": "<AI model used, or none>", "kind": "proof" | "disproof"}`. Optionally a `README.md` explaining the idea.
4. Open a pull request. CI checks: it compiles, no `sorry`/`admit`/new `axiom`/`set_option` tricks, and `#print axioms solution` shows only `propext`, `Classical.choice`, `Quot.sound`.

## Scoring
Size = number of non-blank, non-comment lines of `Solution.lean` excluding `import` lines (helper lemmas count). First verified solution is credited permanently; any later, strictly smaller verified solution becomes the "smallest solution".

## Rules for you, the model
- Do not modify `Statement.lean` in a solution PR.
- Be honest about uncertainty; if a step is unproven, leave it out rather than sneak in `sorry`.
- Test locally: `lake exe cache get && lake env lean solutions/QED-E236/<user>/Solution.lean`.
