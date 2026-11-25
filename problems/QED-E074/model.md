# QED-E074 — Two-frequency localization

You are an AI model helping someone attack this open problem. Read all of this before working.

## The problem
Extended set · Grade B · QED Curated · Analysis

**Plain words:** Take a one-dimensional lattice Schrödinger operator whose potential is the sum of two cosines with frequencies √2 and √3, and make the coupling strong. Prove that for these specific frequencies, not just for almost every frequency pair, almost every phase gives localized eigenfunctions that decay exponentially.

**Math:** For $\lambda>0$ and $\theta\in\mathbb T^2$ let $(H_{\lambda,\theta}\psi)(n)=\psi(n+1)+\psi(n-1)+\lambda\big(\cos2\pi(n\sqrt2+\theta_1)+\cos2\pi(n\sqrt3+\theta_2)\big)\psi(n)$ on $\ell^2(\mathbb Z)$. Prove there is $\lambda_0$ such that for all $\lambda\ge\lambda_0$ and Lebesgue-a.e. $\theta$, $H_{\lambda,\theta}$ has pure point spectrum with exponentially decaying eigenfunctions (Anderson localization).

**Credit:** Recognised open problem from the Bourgain-Goldstein / Bourgain-Goldstein-Schlag multi-frequency programme; stated open in arXiv:2603.07180 (2026). Pure point spectrum without exponential decay at fixed Diophantine frequency: Eliasson, Acta Math. 1997.

**Rests on recent unrefereed work. Check these premises first:**
- arXiv:2603.07180 (2026 preprint): the problem relies on its statement that it is unknown whether any fixed Diophantine frequency vector gives localization.
- arXiv:2603.10649 (2026 preprint): cited background; content not relied on in the statement.

**References:**
- https://arxiv.org/abs/2603.07180
- https://arxiv.org/abs/1204.3086
- https://arxiv.org/abs/1610.00380
- https://arxiv.org/abs/2603.10649

Difficulty estimate: 6.0/10 (anchored scale: 1 ≈ Erdős–Ginzburg–Ziv, 2.5 ≈ the sensitivity conjecture, 5 ≈ bounded prime gaps, 7.5 ≈ the Riemann Hypothesis, 10 ≈ P vs NP). It is believed open; do not assume a quick answer exists, and say so plainly if you cannot make progress. Never present a heuristic, numerical evidence, or a partial result as a solution.

## What counts as an answer
Either a proof of `OpenProblems.QEDE074.Claim` or a proof of `¬ OpenProblems.QEDE074.Claim` (a disproof), in Lean 4 + Mathlib, using the exact statement in `problems/QED-E074/Statement.lean`. Read its "Formalization notes" first. If that file still says `def Claim : Prop := sorry`, the problem must first be formalized (see CONTRIBUTING.md); a faithful formalization is itself a welcome contribution.

If you think the Lean statement does not match the informal problem (it is trivially true or false, or it says something else), report that in an issue instead of exploiting it: such solutions are not credited.

## How to submit
0. First time? Solve a test problem (QED-Q1, the 2-line one, at minimum) and submit it, to confirm your Lean setup and the submission pipeline work before spending effort here. Skip this step if this IS a test problem.
1. Claim it (optional but encouraged): open an issue titled `Claim QED-E074` at https://github.com/floration/qed/issues/new?template=claim.yml. Comment on it at least once a week or the claim lapses.
2. Add `solutions/QED-E074/<github-username>/Solution.lean`:
```lean
import Mathlib
-- do NOT redefine Claim: CI prepends problems/QED-E074/Statement.lean to your file
theorem solution : OpenProblems.QEDE074.Claim := by   -- or ¬ OpenProblems.QEDE074.Claim
  ...
```
   Large proofs may add more `.lean` files (subfolders allowed) next to Solution.lean; CI concatenates them in path order before Solution.lean. Don't import them.
3. Add `solutions/QED-E074/<github-username>/meta.json`: `{"model": "<AI model used, or none>", "kind": "proof" | "disproof"}`. Optionally a `README.md` explaining the idea.
4. Open a pull request. CI checks: it compiles, no `sorry`/`admit`/new `axiom`/`set_option` tricks, and `#print axioms solution` shows only `propext`, `Classical.choice`, `Quot.sound`.

## Scoring
Size = number of non-blank, non-comment lines of `Solution.lean` excluding `import` lines (helper lemmas count). First verified solution is credited permanently; any later, strictly smaller verified solution becomes the "smallest solution".

## Rules for you, the model
- Do not modify `Statement.lean` in a solution PR.
- Be honest about uncertainty; if a step is unproven, leave it out rather than sneak in `sorry`.
- Test locally: `lake exe cache get && lake env lean solutions/QED-E074/<user>/Solution.lean`.
