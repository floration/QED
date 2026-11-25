# QED-E187 — Rademacher sums exceed √2 standard deviations with probability at most 1/8

You are an AI model helping someone attack this open problem. Read all of this before working.

## The problem
Extended set · Grade B · QED Curated · Analysis

**Plain words:** Take real weights a_1,...,a_n with a_1²+...+a_n²=1 and independent fair ±1 signs, and form X = Σ a_i ε_i. With three equal weights 1/√3, X equals √3 with probability 1/8, so P(X > √2) can be 1/8. Prove that P(X > √2) <= 1/8 for every n and all such weights.

**Math:** For $n\ge1$ and $a\in\mathbb R^n$ with $\sum_i a_i^2=1$, let $\varepsilon_1,\dots,\varepsilon_n$ be i.i.d. uniform on $\{\pm1\}$. Prove $\Pr\big(\sum_i a_i\varepsilon_i>\sqrt2\big)\le 1/8$; equivalently $\#\{\varepsilon\in\{\pm1\}^n:\langle a,\varepsilon\rangle>\sqrt2\}\le 2^{n-3}$. (Equality is attained, e.g. $a=(1,1,1)/\sqrt3$.)

**Credit:** Hollom and Portier, Conjecture 6.2 in arXiv:2306.07811 (2023); background Keller–Klein, Pinelis.

**Rests on recent unrefereed work. Check these premises first:**
- Edelman's unrefereed 2025 preprint arXiv:2508.13226 claims a general equal-weight theorem for mid-tails which would imply the claim; its correctness is doubtful (earlier version retracted after Pinelis's counterexample) but a scorer should know of it
- Hollom–Portier preprint: publication venue not verified

**References:**
- https://arxiv.org/abs/2306.07811
- https://onlinelibrary.wiley.com/doi/full/10.1002/rsa.70024
- https://arxiv.org/abs/2006.16834
- https://arxiv.org/abs/1204.1761
- https://arxiv.org/abs/2508.13226

Difficulty estimate: 3.5/10 (anchored scale: 1 ≈ Erdős–Ginzburg–Ziv, 2.5 ≈ the sensitivity conjecture, 5 ≈ bounded prime gaps, 7.5 ≈ the Riemann Hypothesis, 10 ≈ P vs NP). It is believed open; do not assume a quick answer exists, and say so plainly if you cannot make progress. Never present a heuristic, numerical evidence, or a partial result as a solution.

## What counts as an answer
Either a proof of `OpenProblems.QEDE187.Claim` or a proof of `¬ OpenProblems.QEDE187.Claim` (a disproof), in Lean 4 + Mathlib, using the exact statement in `problems/QED-E187/Statement.lean`. Read its "Formalization notes" first. If that file still says `def Claim : Prop := sorry`, the problem must first be formalized (see CONTRIBUTING.md); a faithful formalization is itself a welcome contribution.

If you think the Lean statement does not match the informal problem (it is trivially true or false, or it says something else), report that in an issue instead of exploiting it: such solutions are not credited.

## How to submit
0. First time? Solve a test problem (QED-Q1, the 2-line one, at minimum) and submit it, to confirm your Lean setup and the submission pipeline work before spending effort here. Skip this step if this IS a test problem.
1. Claim it (optional but encouraged): open an issue titled `Claim QED-E187` at https://github.com/floration/qed/issues/new?template=claim.yml. Comment on it at least once a week or the claim lapses.
2. Add `solutions/QED-E187/<github-username>/Solution.lean`:
```lean
import Mathlib
-- do NOT redefine Claim: CI prepends problems/QED-E187/Statement.lean to your file
theorem solution : OpenProblems.QEDE187.Claim := by   -- or ¬ OpenProblems.QEDE187.Claim
  ...
```
   Large proofs may add more `.lean` files (subfolders allowed) next to Solution.lean; CI concatenates them in path order before Solution.lean. Don't import them.
3. Add `solutions/QED-E187/<github-username>/meta.json`: `{"model": "<AI model used, or none>", "kind": "proof" | "disproof"}`. Optionally a `README.md` explaining the idea.
4. Open a pull request. CI checks: it compiles, no `sorry`/`admit`/new `axiom`/`set_option` tricks, and `#print axioms solution` shows only `propext`, `Classical.choice`, `Quot.sound`.

## Scoring
Size = number of non-blank, non-comment lines of `Solution.lean` excluding `import` lines (helper lemmas count). First verified solution is credited permanently; any later, strictly smaller verified solution becomes the "smallest solution".

## Rules for you, the model
- Do not modify `Statement.lean` in a solution PR.
- Be honest about uncertainty; if a step is unproven, leave it out rather than sneak in `sorry`.
- Test locally: `lake exe cache get && lake env lean solutions/QED-E187/<user>/Solution.lean`.
