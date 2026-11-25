# QED-E036 — Integer complexity of powers of two

You are an AI model helping someone attack this open problem. Read all of this before working.

## The problem
Extended set · Grade B- · QED Curated · Number theory

**Plain words:** The complexity of a positive integer n is the fewest 1's needed to write n using only +, × and parentheses. Writing 2^k as (1+1)(1+1)...(1+1) uses 2k ones. Is that always optimal? It has been checked by computer for every 2^k up to 2^126, but no proof is known.

**Math:** Let $\|n\|$ be the least number of $1$'s in an expression for $n$ built from $1$, $+$, $\times$ and parentheses. Prove or disprove: $\|2^k\|=2k$ for all $k\ge1$ (more strongly, $\|2^k3^\ell\|=2k+3\ell$ for $(k,\ell)\ne(0,0)$).

**Reviewer note:** Known: Verified $\|2^k3^\ell\|=2k+3\ell$ for $k\le48$ and all $\ell$: Altman, 'Integer complexity: algorithms and computational results', Integers 18 (2018), arXiv:1606.03635 (earlier $k\le21$, Altman–Zelinsky arXiv:1207.4841). Pure powers of 2: no counterexample for $2^k\le 2^{126}\approx10^{38}$, and $\|2^i3^j5^k\|=2i+3j+5k$ checked for $2^i3^j5^k\le10^{36}$, $k\le5$ (Q. He, 'Improved algorithms for integer complexity', arXiv:2308.10301). Question attributed to Rawsthorne (in Guy, UPINT F26). Konyagin–Oganesyan arXiv:2603.20876 (2026): average-case estimates, not this question.

**Credit:** D. Rawsthorne; R. K. Guy; H. Altman; J. Zelinsky

**Rests on recent unrefereed work. Check these premises first:**
- He's 2^126 verification is in an arXiv appendix (unrefereed computation)
- may require a qualitatively new idea; known defect theory handles only finitely many k

**References:**
- https://arxiv.org/abs/1606.03635
- https://arxiv.org/abs/2308.10301
- https://arxiv.org/abs/1207.4841
- https://arxiv.org/abs/2603.20876

Difficulty estimate: 5.5/10 (calibrated: Collatz ≈ 5.5, twin primes ≈ 5.0). It is believed open; do not assume a quick answer exists, and say so plainly if you cannot make progress. Never present a heuristic, numerical evidence, or a partial result as a solution.

## What counts as an answer
Either a proof of `OpenProblems.QEDE036.Claim` or a proof of `¬ OpenProblems.QEDE036.Claim` (a disproof), in Lean 4 + Mathlib, using the exact statement in `problems/QED-E036/Statement.lean`. Read its "Formalization notes" first. If that file still says `def Claim : Prop := sorry`, the problem must first be formalized (see CONTRIBUTING.md); a faithful formalization is itself a welcome contribution.

If you think the Lean statement does not match the informal problem (it is trivially true or false, or it says something else), report that in an issue instead of exploiting it: such solutions are not credited.

## How to submit
0. First time? Solve a test problem (QED-Q1, the 2-line one, at minimum) and submit it, to confirm your Lean setup and the submission pipeline work before spending effort here. Skip this step if this IS a test problem.
1. Claim it (optional but encouraged): open an issue titled `Claim QED-E036` at https://github.com/floration/qed/issues/new?template=claim.yml. Comment on it at least once a week or the claim lapses.
2. Add `solutions/QED-E036/<github-username>/Solution.lean`:
```lean
import Mathlib
-- do NOT redefine Claim: CI prepends problems/QED-E036/Statement.lean to your file
theorem solution : OpenProblems.QEDE036.Claim := by   -- or ¬ OpenProblems.QEDE036.Claim
  ...
```
3. Add `solutions/QED-E036/<github-username>/meta.json`: `{"model": "<AI model used, or none>", "kind": "proof" | "disproof"}`. Optionally a `README.md` explaining the idea.
4. Open a pull request. CI checks: it compiles, no `sorry`/`admit`/new `axiom`/`set_option` tricks, and `#print axioms solution` shows only `propext`, `Classical.choice`, `Quot.sound`.

## Scoring
Size = number of non-blank, non-comment lines of `Solution.lean` excluding `import` lines (helper lemmas count). First verified solution is credited permanently; any later, strictly smaller verified solution becomes the "smallest solution".

## Rules for you, the model
- Do not modify `Statement.lean` in a solution PR.
- Be honest about uncertainty; if a step is unproven, leave it out rather than sneak in `sorry`.
- Test locally: `lake exe cache get && lake env lean solutions/QED-E036/<user>/Solution.lean`.
