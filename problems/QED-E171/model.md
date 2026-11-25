# QED-E171 — Beat the trivial x^{1/4} gap between sums of two squares

You are an AI model helping someone attack this open problem. Read all of this before working.

## The problem
Extended set · Grade A · QED Curated · Number theory

**Plain words:** Let R(x) be the largest gap between consecutive integers of the form a²+b² up to x. A greedy argument (take the largest square below n, then fix the remainder with a second square) gives R(x) <= C·x^{1/4}, and this exponent has never been improved, although gaps are believed to be only about log x in size. Prove that R(x) is eventually smaller than any constant multiple of x^{1/4}.

**Math:** Let $S=\{a^2+b^2: a,b\in\mathbb Z_{\ge0}\}$. Prove that for every $\varepsilon>0$ there is $X_0$ such that for all real $x\ge X_0$ the interval $(x,\,x+\varepsilon x^{1/4}]$ meets $S$; equivalently, the maximal gap between consecutive elements of $S\cap[1,x]$ is $o(x^{1/4})$.

**Credit:** Classical; stated as open in A. Kalmynin, 'Intervals between numbers that are sums of two squares' (arXiv:1706.07380).

**Rests on recent unrefereed work. Check these premises first:**
- Kalmynin's statement is from 2017–18; I found no later improvement but a 2025–26 claim in a non-indexed venue cannot be excluded

**References:**
- https://arxiv.org/abs/1706.07380
- https://arxiv.org/abs/1906.09100
- https://arxiv.org/abs/1810.03203

Difficulty estimate: 7.0/10 (calibrated: Collatz ≈ 5.5, twin primes ≈ 5.0). It is believed open; do not assume a quick answer exists, and say so plainly if you cannot make progress. Never present a heuristic, numerical evidence, or a partial result as a solution.

## What counts as an answer
Either a proof of `OpenProblems.QEDE171.Claim` or a proof of `¬ OpenProblems.QEDE171.Claim` (a disproof), in Lean 4 + Mathlib, using the exact statement in `problems/QED-E171/Statement.lean`. Read its "Formalization notes" first. If that file still says `def Claim : Prop := sorry`, the problem must first be formalized (see CONTRIBUTING.md); a faithful formalization is itself a welcome contribution.

If you think the Lean statement does not match the informal problem (it is trivially true or false, or it says something else), report that in an issue instead of exploiting it: such solutions are not credited.

## How to submit
0. First time? Solve a test problem (QED-Q1, the 2-line one, at minimum) and submit it, to confirm your Lean setup and the submission pipeline work before spending effort here. Skip this step if this IS a test problem.
1. Claim it (optional but encouraged): open an issue titled `Claim QED-E171` at https://github.com/floration/qed/issues/new?template=claim.yml. Comment on it at least once a week or the claim lapses.
2. Add `solutions/QED-E171/<github-username>/Solution.lean`:
```lean
import Mathlib
-- do NOT redefine Claim: CI prepends problems/QED-E171/Statement.lean to your file
theorem solution : OpenProblems.QEDE171.Claim := by   -- or ¬ OpenProblems.QEDE171.Claim
  ...
```
   Large proofs may add more `.lean` files (subfolders allowed) next to Solution.lean; CI concatenates them in path order before Solution.lean. Don't import them.
3. Add `solutions/QED-E171/<github-username>/meta.json`: `{"model": "<AI model used, or none>", "kind": "proof" | "disproof"}`. Optionally a `README.md` explaining the idea.
4. Open a pull request. CI checks: it compiles, no `sorry`/`admit`/new `axiom`/`set_option` tricks, and `#print axioms solution` shows only `propext`, `Classical.choice`, `Quot.sound`.

## Scoring
Size = number of non-blank, non-comment lines of `Solution.lean` excluding `import` lines (helper lemmas count). First verified solution is credited permanently; any later, strictly smaller verified solution becomes the "smallest solution".

## Rules for you, the model
- Do not modify `Statement.lean` in a solution PR.
- Be honest about uncertainty; if a step is unproven, leave it out rather than sneak in `sorry`.
- Test locally: `lake exe cache get && lake env lean solutions/QED-E171/<user>/Solution.lean`.
