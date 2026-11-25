# QED-M010 — Jacobi matrix of primes

You are an AI model helping someone attack this open problem. Read all of this before working.

## The problem
Main set · Grade B · QED Original · Analysis

**Plain words:** Build an infinite tridiagonal (Jacobi) matrix with zero diagonal and the primes 2, 3, 5, 7, ... on the off-diagonals. The standard criteria for purely absolutely continuous spectrum need the off-diagonal sequence to vary regularly, and they just fail because prime gaps fluctuate. Decide whether the spectrum is nevertheless purely absolutely continuous on the whole real line.

**Math:** Let $J$ be the self-adjoint Jacobi operator on $\ell^2(\mathbb N)$ given by $(Ju)_n=p_{n-1}u_{n-1}+p_nu_{n+1}$ (with $p_0u_0:=0$), where $p_n$ is the $n$-th prime. It is self-adjoint by Carleman's criterion, since $\sum1/p_n=\infty$. Decide whether $\sigma(J)=\sigma_{ac}(J)=\mathbb R$ with no singular part.

**References:**
- https://ar5iv.labs.arxiv.org/html/0711.4035
- https://web.ma.utexas.edu/mp_arc-bin/mpa?yn=03-378

Difficulty estimate: 4.0/10 (anchored scale: 1 ≈ Erdős–Ginzburg–Ziv, 2.5 ≈ the sensitivity conjecture, 5 ≈ bounded prime gaps, 7.5 ≈ the Riemann Hypothesis, 10 ≈ P vs NP). It is believed open; do not assume a quick answer exists, and say so plainly if you cannot make progress. Never present a heuristic, numerical evidence, or a partial result as a solution.

## What counts as an answer
Either a proof of `OpenProblems.QEDM010.Claim` or a proof of `¬ OpenProblems.QEDM010.Claim` (a disproof), in Lean 4 + Mathlib, using the exact statement in `problems/QED-M010/Statement.lean`. Read its "Formalization notes" first. If that file still says `def Claim : Prop := sorry`, the problem must first be formalized (see CONTRIBUTING.md); a faithful formalization is itself a welcome contribution.

If you think the Lean statement does not match the informal problem (it is trivially true or false, or it says something else), report that in an issue instead of exploiting it: such solutions are not credited.

## How to submit
0. First time? Solve a test problem (QED-Q1, the 2-line one, at minimum) and submit it, to confirm your Lean setup and the submission pipeline work before spending effort here. Skip this step if this IS a test problem.
1. Claim it (optional but encouraged): open an issue titled `Claim QED-M010` at https://github.com/floration/qed/issues/new?template=claim.yml. Comment on it at least once a week or the claim lapses.
2. Add `solutions/QED-M010/<github-username>/Solution.lean`:
```lean
import Mathlib
-- do NOT redefine Claim: CI prepends problems/QED-M010/Statement.lean to your file
theorem solution : OpenProblems.QEDM010.Claim := by   -- or ¬ OpenProblems.QEDM010.Claim
  ...
```
   Large proofs may add more `.lean` files (subfolders allowed) next to Solution.lean; CI concatenates them in path order before Solution.lean. Don't import them.
3. Add `solutions/QED-M010/<github-username>/meta.json`: `{"model": "<AI model used, or none>", "kind": "proof" | "disproof"}`. Optionally a `README.md` explaining the idea.
4. Open a pull request. CI checks: it compiles, no `sorry`/`admit`/new `axiom`/`set_option` tricks, and `#print axioms solution` shows only `propext`, `Classical.choice`, `Quot.sound`.

## Scoring
Size = number of non-blank, non-comment lines of `Solution.lean` excluding `import` lines (helper lemmas count). First verified solution is credited permanently; any later, strictly smaller verified solution becomes the "smallest solution".

## Rules for you, the model
- Do not modify `Statement.lean` in a solution PR.
- Be honest about uncertainty; if a step is unproven, leave it out rather than sneak in `sorry`.
- Test locally: `lake exe cache get && lake env lean solutions/QED-M010/<user>/Solution.lean`.
