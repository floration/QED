# QED-E116 — Square-lattice polygon counts satisfy no polynomial recurrence

You are an AI model helping someone attack this open problem. Read all of this before working.

## The problem
Extended set · Grade B · QED Curated · Mathematical physics

**Plain words:** Let p_n count closed self-avoiding loops of length 2n on the square grid, up to translation (p_2 = 1, p_3 = 2, p_4 = 7, p_5 = 28, ...). Many solved lattice models have counting sequences that obey a linear recurrence with polynomial coefficients (their generating function is 'D-finite'). For square-lattice polygons it is believed that no such recurrence exists, reflecting that the model has no exact solution of this kind. Prove it.

**Math:** Let $p_n$ be the number of self-avoiding polygons (unrooted, unoriented closed nearest-neighbour cycles) of perimeter $2n$ on $\mathbb Z^2$, counted modulo translation, so $p_1=0$, $p_2=1,p_3=2,p_4=7$. Prove that there are no $k\ge0$ and polynomials $Q_0,\dots,Q_k\in\mathbb Q[x]$, not all zero, with $\sum_{i=0}^k Q_i(n)\,p_{n+i}=0$ for all $n\ge1$. Equivalently, $P(x)=\sum_n p_nx^n$ is not D-finite.

**Credit:** Guttmann-Enting solvability criterion; open question recorded by Rechnitzer (2006).

**Rests on recent unrefereed work. Check these premises first:**
- May be very hard (essentially requires structural control of an unsolved model)
- Formalizing 'polygon modulo translation' needs care (cyclic, unoriented, rooted at lexicographically least vertex)

**References:**
- https://arxiv.org/abs/math/0406450
- https://personal.math.ubc.ca/~andrewr/pubs/sdf_final.pdf
- https://arxiv.org/pdf/0809.5232
- https://arxiv.org/pdf/cond-mat/0202339
- https://arxiv.org/pdf/1212.3448

Difficulty estimate: 8.0/10 (calibrated: Collatz ≈ 5.5, twin primes ≈ 5.0). It is believed open; do not assume a quick answer exists, and say so plainly if you cannot make progress. Never present a heuristic, numerical evidence, or a partial result as a solution.

## What counts as an answer
Either a proof of `OpenProblems.QEDE116.Claim` or a proof of `¬ OpenProblems.QEDE116.Claim` (a disproof), in Lean 4 + Mathlib, using the exact statement in `problems/QED-E116/Statement.lean`. Read its "Formalization notes" first. If that file still says `def Claim : Prop := sorry`, the problem must first be formalized (see CONTRIBUTING.md); a faithful formalization is itself a welcome contribution.

If you think the Lean statement does not match the informal problem (it is trivially true or false, or it says something else), report that in an issue instead of exploiting it: such solutions are not credited.

## How to submit
0. First time? Solve a test problem (QED-Q1, the 2-line one, at minimum) and submit it, to confirm your Lean setup and the submission pipeline work before spending effort here. Skip this step if this IS a test problem.
1. Claim it (optional but encouraged): open an issue titled `Claim QED-E116` at https://github.com/floration/qed/issues/new?template=claim.yml. Comment on it at least once a week or the claim lapses.
2. Add `solutions/QED-E116/<github-username>/Solution.lean`:
```lean
import Mathlib
-- do NOT redefine Claim: CI prepends problems/QED-E116/Statement.lean to your file
theorem solution : OpenProblems.QEDE116.Claim := by   -- or ¬ OpenProblems.QEDE116.Claim
  ...
```
   Large proofs may add more `.lean` files (subfolders allowed) next to Solution.lean; CI concatenates them in path order before Solution.lean. Don't import them.
3. Add `solutions/QED-E116/<github-username>/meta.json`: `{"model": "<AI model used, or none>", "kind": "proof" | "disproof"}`. Optionally a `README.md` explaining the idea.
4. Open a pull request. CI checks: it compiles, no `sorry`/`admit`/new `axiom`/`set_option` tricks, and `#print axioms solution` shows only `propext`, `Classical.choice`, `Quot.sound`.

## Scoring
Size = number of non-blank, non-comment lines of `Solution.lean` excluding `import` lines (helper lemmas count). First verified solution is credited permanently; any later, strictly smaller verified solution becomes the "smallest solution".

## Rules for you, the model
- Do not modify `Statement.lean` in a solution PR.
- Be honest about uncertainty; if a step is unproven, leave it out rather than sneak in `sorry`.
- Test locally: `lake exe cache get && lake env lean solutions/QED-E116/<user>/Solution.lean`.
