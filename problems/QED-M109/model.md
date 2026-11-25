# QED-M109 — Are random Cayley graphs of S_n expanders?

You are an AI model helping someone attack this open problem. Read all of this before working.

## The problem
Main set · Grade A · QED Curated · Probability

**Plain words:** Pick two uniformly random permutations s, t of n symbols and run the random walk on the group they generate (with high probability all of S_n or A_n) that at each step multiplies by one of s, t, s^-1, t^-1 chosen uniformly. Is the spectral gap of this walk bounded below by a fixed positive constant, with probability tending to 1 as n grows? Specific bounded generating sets of S_n are known to give expanders, but for random generators the best proven gap still tends to 0 polynomially in n.

**Math:** For $\sigma,\tau\in S_n$ let $H=\langle\sigma,\tau\rangle$ and $Pf(x)=\tfrac14\sum_{g\in\{\sigma^{\pm1},\tau^{\pm1}\}}f(xg)$ on $\ell^2(H)$, with second-largest eigenvalue $\lambda_2(\sigma,\tau)$ (largest eigenvalue on $\{f:\sum_x f(x)=0\}$). Prove or disprove: there is an absolute $\varepsilon>0$ such that, for $\sigma,\tau$ independent and uniform in $S_n$, $\Pr[\lambda_2(\sigma,\tau)\le 1-\varepsilon]\to1$ as $n\to\infty$.

**Reviewer note:** Known: Whp $\langle\sigma,\tau\rangle\in\{A_n,S_n\}$ (Dixon 1969). Whp diameter $O(n^2(\log n)^c)$ and mixing time $O(n^3(\log n)^c)$, i.e. a gap that is only inverse polynomial (Helfgott-Seress-Zuk, J. Algebra 2015, arXiv 1311.6742); improved but still non-constant bounds later (e.g. Eberhard-Jezernik on Babai's conjecture for random generators). Random permutations have near-optimal spectral gap on $k$-tuples for $k\le n^{1/20-\epsilon}$ (Cassidy, arXiv 2412.13941), and constant $k$ earlier (Friedman et al. 1998). Some explicit bounded generating sets of $S_n$ give expanders (Kassabov, Invent. Math. 2007). No constant gap for random generators.

**Credit:** Long-standing question (attributed variously to Lubotzky and to Babai); stated as open in Handel (2025)

**Rests on recent unrefereed work. Check these premises first:**
- Could be false (non-expansion for random generators would itself be a major surprise but is not ruled out).
- Exact form of the best known inverse-polynomial gap bound after Helfgott-Seress-Zuk should be confirmed by the vetter.

**References:**
- https://arxiv.org/abs/2507.00346
- https://www.emergentmind.com/open-problems/expansion-random-cayley-graphs-symmetric-group
- https://arxiv.org/abs/1311.6742
- https://arxiv.org/abs/2412.13941
- https://arxiv.org/abs/1807.03879

Difficulty estimate: 7.5/10 (calibrated: Collatz ≈ 5.5, twin primes ≈ 5.0). It is believed open; do not assume a quick answer exists, and say so plainly if you cannot make progress. Never present a heuristic, numerical evidence, or a partial result as a solution.

## What counts as an answer
Either a proof of `OpenProblems.QEDM109.Claim` or a proof of `¬ OpenProblems.QEDM109.Claim` (a disproof), in Lean 4 + Mathlib, using the exact statement in `problems/QED-M109/Statement.lean`. Read its "Formalization notes" first. If that file still says `def Claim : Prop := sorry`, the problem must first be formalized (see CONTRIBUTING.md); a faithful formalization is itself a welcome contribution.

If you think the Lean statement does not match the informal problem (it is trivially true or false, or it says something else), report that in an issue instead of exploiting it: such solutions are not credited.

## How to submit
0. First time? Solve a test problem (QED-Q1, the 2-line one, at minimum) and submit it, to confirm your Lean setup and the submission pipeline work before spending effort here. Skip this step if this IS a test problem.
1. Claim it (optional but encouraged): open an issue titled `Claim QED-M109` at https://github.com/floration/qed/issues/new?template=claim.yml. Comment on it at least once a week or the claim lapses.
2. Add `solutions/QED-M109/<github-username>/Solution.lean`:
```lean
import Mathlib
-- do NOT redefine Claim: CI prepends problems/QED-M109/Statement.lean to your file
theorem solution : OpenProblems.QEDM109.Claim := by   -- or ¬ OpenProblems.QEDM109.Claim
  ...
```
3. Add `solutions/QED-M109/<github-username>/meta.json`: `{"model": "<AI model used, or none>", "kind": "proof" | "disproof"}`. Optionally a `README.md` explaining the idea.
4. Open a pull request. CI checks: it compiles, no `sorry`/`admit`/new `axiom`/`set_option` tricks, and `#print axioms solution` shows only `propext`, `Classical.choice`, `Quot.sound`.

## Scoring
Size = number of non-blank, non-comment lines of `Solution.lean` excluding `import` lines (helper lemmas count). First verified solution is credited permanently; any later, strictly smaller verified solution becomes the "smallest solution".

## Rules for you, the model
- Do not modify `Statement.lean` in a solution PR.
- Be honest about uncertainty; if a step is unproven, leave it out rather than sneak in `sorry`.
- Test locally: `lake exe cache get && lake env lean solutions/QED-M109/<user>/Solution.lean`.
