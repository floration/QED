# QED-E188 — Is the order of vanishing at 1 of a ±1 polynomial O(log n)?

You are an AI model helping someone attack this open problem. Read all of this before working.

## The problem
Extended set · Grade B · QED Curated · Analysis

**Plain words:** A Littlewood polynomial has every coefficient equal to +1 or -1. The Thue-Morse product (1-x)(1-x^2)(1-x^4)...(1-x^{2^{m-1}}) has length 2^m and a zero of order m at x = 1, and shorter examples exist (length 240 for order 10). Is the order of the zero at 1 always at most a constant times the logarithm of the length? Equivalently, does the shortest length N(m) achieving order m grow exponentially in m? The best known lower bound, due to Boyd, is only about e^{sqrt m}.

**Math:** Let $N(m)$ be the least $n$ such that some $p(x)=\sum_{j=0}^{n-1}\varepsilon_jx^j$ with all $\varepsilon_j\in\{\pm1\}$ is divisible by $(x-1)^m$ (finite, since $N(m)\le2^m$). Because $p(x)q(x^{N(a)})$ shows $N(a+b)\le N(a)N(b)$, the limit $\rho=\lim_m N(m)^{1/m}=\inf_m N(m)^{1/m}$ exists, and $1\le\rho\le240^{1/10}\approx1.730$, while Boyd proved $N(m)\ge e^{(1+o(1))\sqrt m}$. Decide whether $\rho>1$. Equivalently: is there $C$ such that every Littlewood polynomial of length $n\ge2$ has a zero at $1$ of multiplicity at most $C\log n$?

**Credit:** Byrnes's question (N(m)=2^m?) answered negatively by Boyd; growth-rate question implicit in Boyd 1997 and Borwein–Erdélyi–Kós (1999); formulated here as ρ>1.

**Rests on recent unrefereed work. Check these premises first:**
- The exact form of Boyd's upper bound is taken from secondary citations (Erdélyi arXiv:2407.16120, Borwein–Erdélyi–Kós) since the Math. Comp. PDF could not be fetched
- Not found stated verbatim as 'is the multiplicity O(log n)' in a single source; the question is implicit in the cited gap

**References:**
- https://www.ams.org/journals/mcom/1997-66-220/S0025-5718-97-00892-2
- https://www.ams.org/mcom/2021-90-329/S0025-5718-2021-03612-1/
- https://www.ams.org/mcom/2006-75-255/S0025-5718-06-01848-5/
- https://arxiv.org/abs/2407.16120
- https://cmrr-star.ucsd.edu/static/pubs/high_order.pdf

Difficulty estimate: 7.0/10 (anchored scale: 1 ≈ Erdős–Ginzburg–Ziv, 2.5 ≈ the sensitivity conjecture, 5 ≈ bounded prime gaps, 7.5 ≈ the Riemann Hypothesis, 10 ≈ P vs NP). It is believed open; do not assume a quick answer exists, and say so plainly if you cannot make progress. Never present a heuristic, numerical evidence, or a partial result as a solution.

## What counts as an answer
Either a proof of `OpenProblems.QEDE188.Claim` or a proof of `¬ OpenProblems.QEDE188.Claim` (a disproof), in Lean 4 + Mathlib, using the exact statement in `problems/QED-E188/Statement.lean`. Read its "Formalization notes" first. If that file still says `def Claim : Prop := sorry`, the problem must first be formalized (see CONTRIBUTING.md); a faithful formalization is itself a welcome contribution.

If you think the Lean statement does not match the informal problem (it is trivially true or false, or it says something else), report that in an issue instead of exploiting it: such solutions are not credited.

## How to submit
0. First time? Solve a test problem (QED-Q1, the 2-line one, at minimum) and submit it, to confirm your Lean setup and the submission pipeline work before spending effort here. Skip this step if this IS a test problem.
1. Claim it (optional but encouraged): open an issue titled `Claim QED-E188` at https://github.com/floration/qed/issues/new?template=claim.yml. Comment on it at least once a week or the claim lapses.
2. Add `solutions/QED-E188/<github-username>/Solution.lean`:
```lean
import Mathlib
-- do NOT redefine Claim: CI prepends problems/QED-E188/Statement.lean to your file
theorem solution : OpenProblems.QEDE188.Claim := by   -- or ¬ OpenProblems.QEDE188.Claim
  ...
```
   Large proofs may add more `.lean` files (subfolders allowed) next to Solution.lean; CI concatenates them in path order before Solution.lean. Don't import them.
3. Add `solutions/QED-E188/<github-username>/meta.json`: `{"model": "<AI model used, or none>", "kind": "proof" | "disproof"}`. Optionally a `README.md` explaining the idea.
4. Open a pull request. CI checks: it compiles, no `sorry`/`admit`/new `axiom`/`set_option` tricks, and `#print axioms solution` shows only `propext`, `Classical.choice`, `Quot.sound`.

## Scoring
Size = number of non-blank, non-comment lines of `Solution.lean` excluding `import` lines (helper lemmas count). First verified solution is credited permanently; any later, strictly smaller verified solution becomes the "smallest solution".

## Rules for you, the model
- Do not modify `Statement.lean` in a solution PR.
- Be honest about uncertainty; if a step is unproven, leave it out rather than sneak in `sorry`.
- Test locally: `lake exe cache get && lake env lean solutions/QED-E188/<user>/Solution.lean`.
