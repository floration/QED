# QED-M130 — Positivity of order-6 linear recurrences: decidable?

You are an AI model helping someone attack this open problem. Read all of this before working.

## The problem
Main set · Grade A · QED Curated · Logic & computability

**Plain words:** An integer sequence obeying a fixed linear recurrence u_{n+6} = a_1 u_{n+5} + ... + a_6 u_n is determined by six coefficients and six starting values. Is there an algorithm that, given these twelve integers, decides whether every term of the sequence is nonnegative? Such an algorithm exists for recurrences of order at most 5; order 6 is the first open case.

**Math:** For $a=(a_1,\dots,a_6)\in\mathbb Z^6$ and $c=(c_0,\dots,c_5)\in\mathbb Z^6$ let $u=u^{a,c}$ be defined by $u_n=c_n$ ($n<6$) and $u_{n+6}=\sum_{i=1}^6 a_iu_{n+6-i}$. Let $\mathrm{Pos}=\{(a,c)\in\mathbb Z^{12}: u^{a,c}_n\ge 0\ \forall n\in\mathbb N\}$. Problem: is $\mathrm{Pos}$ a decidable (computable) subset of $\mathbb Z^{12}$? Board Claim (either direction accepted): $\mathrm{Pos}$ is decidable, or $\mathrm{Pos}$ is undecidable.

**Credit:** Open problem as posed by Ouaknine and Worrell (2014); restated in Ibrahim et al. arXiv:2412.08576.

**Rests on recent unrefereed work. Check these premises first:**
- The rational-to-integer reduction I sketched (scaling by d^n) changes the recurrence coefficients but preserves order and sign; standard but worth a one-line check by the formalizer.
- Undecidability direction is considered very unlikely; the board accepts either.

**References:**
- https://arxiv.org/abs/1307.2779
- https://arxiv.org/abs/1309.1550
- https://arxiv.org/abs/1309.1914
- https://ar5iv.labs.arxiv.org/html/2412.08576
- https://arxiv.org/html/2605.17013v1
- https://www.emergentmind.com/open-problems/decidability-positivity-c-finite-order-6

Difficulty estimate: 8.0/10 (anchored scale: 1 ≈ Erdős–Ginzburg–Ziv, 2.5 ≈ the sensitivity conjecture, 5 ≈ bounded prime gaps, 7.5 ≈ the Riemann Hypothesis, 10 ≈ P vs NP). It is believed open; do not assume a quick answer exists, and say so plainly if you cannot make progress. Never present a heuristic, numerical evidence, or a partial result as a solution.

## What counts as an answer
Either a proof of `OpenProblems.QEDM130.Claim` or a proof of `¬ OpenProblems.QEDM130.Claim` (a disproof), in Lean 4 + Mathlib, using the exact statement in `problems/QED-M130/Statement.lean`. Read its "Formalization notes" first. If that file still says `def Claim : Prop := sorry`, the problem must first be formalized (see CONTRIBUTING.md); a faithful formalization is itself a welcome contribution.

If you think the Lean statement does not match the informal problem (it is trivially true or false, or it says something else), report that in an issue instead of exploiting it: such solutions are not credited.

## How to submit
0. First time? Solve a test problem (QED-Q1, the 2-line one, at minimum) and submit it, to confirm your Lean setup and the submission pipeline work before spending effort here. Skip this step if this IS a test problem.
1. Claim it (optional but encouraged): open an issue titled `Claim QED-M130` at https://github.com/floration/qed/issues/new?template=claim.yml. Comment on it at least once a week or the claim lapses.
2. Add `solutions/QED-M130/<github-username>/Solution.lean`:
```lean
import Mathlib
-- do NOT redefine Claim: CI prepends problems/QED-M130/Statement.lean to your file
theorem solution : OpenProblems.QEDM130.Claim := by   -- or ¬ OpenProblems.QEDM130.Claim
  ...
```
   Large proofs may add more `.lean` files (subfolders allowed) next to Solution.lean; CI concatenates them in path order before Solution.lean. Don't import them.
3. Add `solutions/QED-M130/<github-username>/meta.json`: `{"model": "<AI model used, or none>", "kind": "proof" | "disproof"}`. Optionally a `README.md` explaining the idea.
4. Open a pull request. CI checks: it compiles, no `sorry`/`admit`/new `axiom`/`set_option` tricks, and `#print axioms solution` shows only `propext`, `Classical.choice`, `Quot.sound`.

## Scoring
Size = number of non-blank, non-comment lines of `Solution.lean` excluding `import` lines (helper lemmas count). First verified solution is credited permanently; any later, strictly smaller verified solution becomes the "smallest solution".

## Rules for you, the model
- Do not modify `Statement.lean` in a solution PR.
- Be honest about uncertainty; if a step is unproven, leave it out rather than sneak in `sorry`.
- Test locally: `lake exe cache get && lake env lean solutions/QED-M130/<user>/Solution.lean`.
