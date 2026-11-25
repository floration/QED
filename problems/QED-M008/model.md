# QED-M008 — Fibonacci-modulated growing Jacobi matrix

You are an AI model helping someone attack this open problem. Read all of this before working.

## The problem
Main set · Grade B · QED Extension · Analysis · formerly N-659

**Plain words:** Take a Jacobi matrix with zero diagonal and off-diagonal weights sqrt(n). Double the weight at every position where the Fibonacci word has a 1. Periodic modulations of power-growing weights are known to produce spectral phase transitions. Determine the spectral type for this aperiodic modulation.

**Math:** Let $f=f_1f_2f_3\cdots=0100101001001\cdots\in\{0,1\}^{\mathbb N}$ be the Fibonacci word, the fixed point of $0\mapsto01,\ 1\mapsto0$. Let $J$ be the Jacobi operator on $\ell^2(\mathbb N)$ with $(Ju)_n=a_{n-1}u_{n-1}+a_nu_{n+1}$, where $a_n=\sqrt n\,(1+f_n)$ and $a_0u_0:=0$. Since $\sum 1/a_n=\infty$, $J$ is self-adjoint (Carleman). Determine the spectral type of $J$. In particular: is $\sigma_{ac}(J)\neq\emptyset$? Is $\sigma_{ac}(J)=\mathbb R$? Is the spectrum on some interval pure point or singular continuous?

**Credit:** Extends Janas-Naboko (periodic modulations, e.g. arXiv:math/0605593) and Swiderski (arXiv:1707.06486) on periodically modulated Jacobi matrices.

**References:**
- https://arxiv.org/abs/1003.3597
- https://arxiv.org/abs/math/0605593
- https://arxiv.org/abs/1707.06486
- https://arxiv.org/abs/0711.4035

Difficulty estimate: 3.0/10 (calibrated: Collatz ≈ 5.5, twin primes ≈ 5.0). It is believed open; do not assume a quick answer exists, and say so plainly if you cannot make progress. Never present a heuristic, numerical evidence, or a partial result as a solution.

## What counts as an answer
Either a proof of `OpenProblems.QEDM008.Claim` or a proof of `¬ OpenProblems.QEDM008.Claim` (a disproof), in Lean 4 + Mathlib, using the exact statement in `problems/QED-M008/Statement.lean`. Read its "Formalization notes" first. If that file still says `def Claim : Prop := sorry`, the problem must first be formalized (see CONTRIBUTING.md); a faithful formalization is itself a welcome contribution.

If you think the Lean statement does not match the informal problem (it is trivially true or false, or it says something else), report that in an issue instead of exploiting it: such solutions are not credited.

## How to submit
1. Claim it (optional but encouraged): open an issue titled `Claim QED-M008` at https://github.com/floration/qed/issues/new?template=claim.yml. Comment on it at least once a week or the claim lapses.
2. Add `solutions/QED-M008/<github-username>/Solution.lean`:
```lean
import Mathlib
-- do NOT redefine Claim: CI prepends problems/QED-M008/Statement.lean to your file
theorem solution : OpenProblems.QEDM008.Claim := by   -- or ¬ OpenProblems.QEDM008.Claim
  ...
```
3. Add `solutions/QED-M008/<github-username>/meta.json`: `{"model": "<AI model used, or none>", "kind": "proof" | "disproof"}`. Optionally a `README.md` explaining the idea.
4. Open a pull request. CI checks: it compiles, no `sorry`/`admit`/new `axiom`/`set_option` tricks, and `#print axioms solution` shows only `propext`, `Classical.choice`, `Quot.sound`.

## Scoring
Size = number of non-blank, non-comment lines of `Solution.lean` excluding `import` lines (helper lemmas count). First verified solution is credited permanently; any later, strictly smaller verified solution becomes the "smallest solution".

## Rules for you, the model
- Do not modify `Statement.lean` in a solution PR.
- Be honest about uncertainty; if a step is unproven, leave it out rather than sneak in `sorry`.
- Test locally: `lake exe cache get && lake env lean solutions/QED-M008/<user>/Solution.lean`.
