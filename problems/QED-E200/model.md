# QED-E200 — Beat √2−1: the zero-rate threshold for adversarial bit deletions

You are an AI model helping someone attack this open problem. Read all of this before working.

## The problem
Extended set · Grade A · QED Curated · Coding theory

**Plain words:** A binary code of length n can correct pn adversarial deletions if no two codewords share a common subsequence of length (1−p)n. Let p* be the largest fraction for which there are codes of exponential size (positive rate). Simple pigeonhole shows p* ≤ 1/2. The best known constructions (Bukh-Guruswami-Håstad, 2015) give p* ≥ √2−1 ≈ 0.414, and the best upper bound is 1/2 − δ for a tiny unspecified δ. Decide whether p* > √2−1, i.e. whether there are positive-rate binary codes that correct more than a √2−1 fraction of deletions.

**Math:** For $x,y\in\{0,1\}^n$ let $\mathrm{LCS}(x,y)$ be the length of a longest common subsequence. Let $p^*$ be the supremum of $p\in[0,1]$ for which there is $R>0$ and, for infinitely many $n$, a code $C\subseteq\{0,1\}^n$ with $|C|\ge 2^{Rn}$ and $\mathrm{LCS}(x,y)<(1-p)n$ for all distinct $x,y\in C$. It is known that $\sqrt2-1\le p^*<1/2$. Determine whether $p^*>\sqrt2-1$.

**Credit:** Bukh-Guruswami-Håstad (2017) open question

**Rests on recent unrefereed work. Check these premises first:**
- Could not read arXiv:2609.21395 (Sept 2026); title suggests it concerns code size for few deletions, but unverified
- If p*=√2-1 the claim is false; posed as prove-or-disprove would also be fine

**References:**
- https://arxiv.org/abs/1507.01719
- https://arxiv.org/abs/2106.05250
- https://arxiv.org/pdf/1612.06335
- https://arxiv.org/pdf/2107.01785
- https://cs.stanford.edu/~rayyli/static/paper/MSThesis.pdf

Difficulty estimate: 7.0/10 (calibrated: Collatz ≈ 5.5, twin primes ≈ 5.0). It is believed open; do not assume a quick answer exists, and say so plainly if you cannot make progress. Never present a heuristic, numerical evidence, or a partial result as a solution.

## What counts as an answer
Either a proof of `OpenProblems.QEDE200.Claim` or a proof of `¬ OpenProblems.QEDE200.Claim` (a disproof), in Lean 4 + Mathlib, using the exact statement in `problems/QED-E200/Statement.lean`. Read its "Formalization notes" first. If that file still says `def Claim : Prop := sorry`, the problem must first be formalized (see CONTRIBUTING.md); a faithful formalization is itself a welcome contribution.

If you think the Lean statement does not match the informal problem (it is trivially true or false, or it says something else), report that in an issue instead of exploiting it: such solutions are not credited.

## How to submit
0. First time? Solve a test problem (QED-Q1, the 2-line one, at minimum) and submit it, to confirm your Lean setup and the submission pipeline work before spending effort here. Skip this step if this IS a test problem.
1. Claim it (optional but encouraged): open an issue titled `Claim QED-E200` at https://github.com/floration/qed/issues/new?template=claim.yml. Comment on it at least once a week or the claim lapses.
2. Add `solutions/QED-E200/<github-username>/Solution.lean`:
```lean
import Mathlib
-- do NOT redefine Claim: CI prepends problems/QED-E200/Statement.lean to your file
theorem solution : OpenProblems.QEDE200.Claim := by   -- or ¬ OpenProblems.QEDE200.Claim
  ...
```
   Large proofs may add more `.lean` files (subfolders allowed) next to Solution.lean; CI concatenates them in path order before Solution.lean. Don't import them.
3. Add `solutions/QED-E200/<github-username>/meta.json`: `{"model": "<AI model used, or none>", "kind": "proof" | "disproof"}`. Optionally a `README.md` explaining the idea.
4. Open a pull request. CI checks: it compiles, no `sorry`/`admit`/new `axiom`/`set_option` tricks, and `#print axioms solution` shows only `propext`, `Classical.choice`, `Quot.sound`.

## Scoring
Size = number of non-blank, non-comment lines of `Solution.lean` excluding `import` lines (helper lemmas count). First verified solution is credited permanently; any later, strictly smaller verified solution becomes the "smallest solution".

## Rules for you, the model
- Do not modify `Statement.lean` in a solution PR.
- Be honest about uncertainty; if a step is unproven, leave it out rather than sneak in `sorry`.
- Test locally: `lake exe cache get && lake env lean solutions/QED-E200/<user>/Solution.lean`.
