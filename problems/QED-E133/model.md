# QED-E133 — Beat (3+√2)/2 for diamond-free families

You are an AI model helping someone attack this open problem. Read all of this before working.

## The problem
Extended set · Grade A · QED Curated · Combinatorics

**Plain words:** A family of subsets of {1,...,n} is diamond-free if it contains no four distinct sets A, B, C, D with A ⊂ B ⊂ D and A ⊂ C ⊂ D. For years it was believed that the two middle layers, about 2·binom(n, n/2) sets, are optimal; in July 2026 a random linear-algebra construction beat that with about 2.1479·binom(n, n/2) sets. The best general upper bound, (3+√2)/2 ≈ 2.2071 times binom(n, n/2), dates from 2016–2018. Lower it by any fixed amount.

**Math:** Let $La(n,Q_2)$ be the maximum size of $\mathcal F\subseteq 2^{[n]}$ containing no four distinct $A,B,C,D\in\mathcal F$ with $A\subsetneq B\subsetneq D$ and $A\subsetneq C\subsetneq D$. Prove that $\limsup_{n\to\infty} La(n,Q_2)/\binom{n}{\lfloor n/2\rfloor} < \frac{3+\sqrt2}{2}$. (Known: $\liminf \ge 2+\frac{29}{135}\prod_{i\ge1}(1-4^{-i})\approx 2.1479$; for families inside three consecutive middle layers the density is at most $2.15121$. Stretch goal: determine the limit, whose existence is itself unknown.)

**Credit:** Problem line from Griggs–Lu and Griggs–Li–Lu. Upper bound (3+√2)/2 by Grósz, Methuku, Tompkins (2018). Lower bound 2.1479 by Tompkins (2026). Three-layer bound by Balogh, Hu, Lidický, Liu.

**Rests on recent unrefereed work. Check these premises first:**
- The lower bound 2.1479 (and the disproof of the diamond conjecture) rests on an unrefereed July 2026 preprint (arXiv:2607.09497). The Claim itself does not depend on it.
- The Ai–Liu–Song window-density results are an unrefereed 2026 preprint.
- An improved upper bound might exist in a recent preprint not indexed by search.

**References:**
- https://arxiv.org/abs/2607.09497
- https://arxiv.org/abs/1601.06332
- https://arxiv.org/abs/1503.00631
- https://arxiv.org/pdf/2610.28413
- https://arxiv.org/abs/1010.5311

Difficulty estimate: 3.5/10 (calibrated: Collatz ≈ 5.5, twin primes ≈ 5.0). It is believed open; do not assume a quick answer exists, and say so plainly if you cannot make progress. Never present a heuristic, numerical evidence, or a partial result as a solution.

## What counts as an answer
Either a proof of `OpenProblems.QEDE133.Claim` or a proof of `¬ OpenProblems.QEDE133.Claim` (a disproof), in Lean 4 + Mathlib, using the exact statement in `problems/QED-E133/Statement.lean`. Read its "Formalization notes" first. If that file still says `def Claim : Prop := sorry`, the problem must first be formalized (see CONTRIBUTING.md); a faithful formalization is itself a welcome contribution.

If you think the Lean statement does not match the informal problem (it is trivially true or false, or it says something else), report that in an issue instead of exploiting it: such solutions are not credited.

## How to submit
0. First time? Solve a test problem (QED-Q1, the 2-line one, at minimum) and submit it, to confirm your Lean setup and the submission pipeline work before spending effort here. Skip this step if this IS a test problem.
1. Claim it (optional but encouraged): open an issue titled `Claim QED-E133` at https://github.com/floration/qed/issues/new?template=claim.yml. Comment on it at least once a week or the claim lapses.
2. Add `solutions/QED-E133/<github-username>/Solution.lean`:
```lean
import Mathlib
-- do NOT redefine Claim: CI prepends problems/QED-E133/Statement.lean to your file
theorem solution : OpenProblems.QEDE133.Claim := by   -- or ¬ OpenProblems.QEDE133.Claim
  ...
```
   Large proofs may add more `.lean` files (subfolders allowed) next to Solution.lean; CI concatenates them in path order before Solution.lean. Don't import them.
3. Add `solutions/QED-E133/<github-username>/meta.json`: `{"model": "<AI model used, or none>", "kind": "proof" | "disproof"}`. Optionally a `README.md` explaining the idea.
4. Open a pull request. CI checks: it compiles, no `sorry`/`admit`/new `axiom`/`set_option` tricks, and `#print axioms solution` shows only `propext`, `Classical.choice`, `Quot.sound`.

## Scoring
Size = number of non-blank, non-comment lines of `Solution.lean` excluding `import` lines (helper lemmas count). First verified solution is credited permanently; any later, strictly smaller verified solution becomes the "smallest solution".

## Rules for you, the model
- Do not modify `Statement.lean` in a solution PR.
- Be honest about uncertainty; if a step is unproven, leave it out rather than sneak in `sorry`.
- Test locally: `lake exe cache get && lake env lean solutions/QED-E133/<user>/Solution.lean`.
