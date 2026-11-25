# QED-M024 — Paley spin glass

You are an AI model helping someone attack this open problem. Read all of this before working.

## The problem
Main set · Grade A · QED Original · Combinatorics

**Plain words:** Place a ±1 spin at each element of F_p, and let each pair interact through the Legendre symbol of their difference. Equivalently, this is the max-cut problem for the Paley graph. The eigenvalue bound caps the ground-state energy at p^{3/2}/2. Simple square-wave configurations reach this bound along special primes, but heuristic search for typical primes stalls around 0.46. Is the eigenvalue bound asymptotically sharp for all primes?

**Math:** For primes $p\equiv1\pmod4$ let $E_p=\max_{\sigma\in\{\pm1\}^{\mathbb F_p}}\sum_{i<j}\left(\frac{j-i}{p}\right)\sigma_i\sigma_j$. The circulant matrix $Q=\big(\big(\frac{j-i}p\big)\big)_{i,j\in\mathbb F_p}$ is symmetric with eigenvalues $\pm\sqrt p$ (each with multiplicity $\frac{p-1}2$) and $0$, so $E_p\le\frac12p^{3/2}$. (For the Paley graph $P_p$, $\mathrm{surp}(P_p)=\mathrm{maxcut}(P_p)-\frac12|E(P_p)|\le \frac14E_p+\frac p8$.) It is known that $\limsup_p E_p/p^{3/2}=\frac12$: if $(\frac qp)=1$ for all primes $q\le y$, then $\sigma_x=\operatorname{sgn}\cos(2\pi x/p)$ has ratio $\frac12-o_y(1)$; and the same $\sigma$ gives $E_p/p^{3/2}\ge\frac4{\pi^2}\big(2-\frac{\pi^2}8\big)-o(1)\approx0.31$ for every $p$. Determine $\liminf_{p}E_p/p^{3/2}$; in particular, is it $\frac12$?

**QED results so far (reviewer-derived; check before relying on them):** Correct. Q is circulant with eigenvalues chi(a)sqrt p (Gauss sums), so E_p<=p^{3/2}/2. Square-wave ratio is (4/pi^2)sum_{m odd}chi(m)/m^2 + o(1); taking p=1 mod 8 and p=1 mod q for odd q<=y (reciprocity + Dirichlet) gives limsup=1/2. Recomputed p=53881: 0.4925. Bonus: the sum is >=2-pi^2/8 so liminf>=0.31.

**References:**
- https://arxiv.org/pdf/2509.03490
- https://arxiv.org/pdf/2610.01657
- https://en.wikipedia.org/wiki/Paley_graph
- https://arxiv.org/pdf/math/0503745
- https://arxiv.org/abs/2509.03490
- https://web.math.princeton.edu/~nalon/PDFS/eigsmall6.pdf
- https://arxiv.org/pdf/math/0503745

Difficulty estimate: 5.5/10 (anchored scale: 1 ≈ Erdős–Ginzburg–Ziv, 2.5 ≈ the sensitivity conjecture, 5 ≈ bounded prime gaps, 7.5 ≈ the Riemann Hypothesis, 10 ≈ P vs NP). It is believed open; do not assume a quick answer exists, and say so plainly if you cannot make progress. Never present a heuristic, numerical evidence, or a partial result as a solution.

## What counts as an answer
Either a proof of `OpenProblems.QEDM024.Claim` or a proof of `¬ OpenProblems.QEDM024.Claim` (a disproof), in Lean 4 + Mathlib, using the exact statement in `problems/QED-M024/Statement.lean`. Read its "Formalization notes" first. If that file still says `def Claim : Prop := sorry`, the problem must first be formalized (see CONTRIBUTING.md); a faithful formalization is itself a welcome contribution.

If you think the Lean statement does not match the informal problem (it is trivially true or false, or it says something else), report that in an issue instead of exploiting it: such solutions are not credited.

## How to submit
0. First time? Solve a test problem (QED-Q1, the 2-line one, at minimum) and submit it, to confirm your Lean setup and the submission pipeline work before spending effort here. Skip this step if this IS a test problem.
1. Claim it (optional but encouraged): open an issue titled `Claim QED-M024` at https://github.com/floration/qed/issues/new?template=claim.yml. Comment on it at least once a week or the claim lapses.
2. Add `solutions/QED-M024/<github-username>/Solution.lean`:
```lean
import Mathlib
-- do NOT redefine Claim: CI prepends problems/QED-M024/Statement.lean to your file
theorem solution : OpenProblems.QEDM024.Claim := by   -- or ¬ OpenProblems.QEDM024.Claim
  ...
```
   Large proofs may add more `.lean` files (subfolders allowed) next to Solution.lean; CI concatenates them in path order before Solution.lean. Don't import them.
3. Add `solutions/QED-M024/<github-username>/meta.json`: `{"model": "<AI model used, or none>", "kind": "proof" | "disproof"}`. Optionally a `README.md` explaining the idea.
4. Open a pull request. CI checks: it compiles, no `sorry`/`admit`/new `axiom`/`set_option` tricks, and `#print axioms solution` shows only `propext`, `Classical.choice`, `Quot.sound`.

## Scoring
Size = number of non-blank, non-comment lines of `Solution.lean` excluding `import` lines (helper lemmas count). First verified solution is credited permanently; any later, strictly smaller verified solution becomes the "smallest solution".

## Rules for you, the model
- Do not modify `Statement.lean` in a solution PR.
- Be honest about uncertainty; if a step is unproven, leave it out rather than sneak in `sorry`.
- Test locally: `lake exe cache get && lake env lean solutions/QED-M024/<user>/Solution.lean`.
