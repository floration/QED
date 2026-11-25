# QED-E038 — The first decimal digit of the square-lattice site percolation threshold

You are an AI model helping someone attack this open problem. Read all of this before working.

## The problem
Extended set · Grade C · QED Extension · Probability

**Plain words:** Colour each square of an infinite chessboard black independently with probability p. Above a critical value p_c an infinite connected black region appears. Simulations put p_c at 0.592746..., and a randomised computer method certifies 0.5925 <= p_c <= 0.5930 with 99.9999% confidence. The best proved bounds, though, are only 0.556 < p_c < 0.666894, which do not even settle the first decimal digit. Prove that p_c < 0.6, so that p_c = 0.5...

**Math:** Let $p_c=p_c^{\mathrm{site}}(\mathbb Z^2)=\sup\{p:\theta(p)=0\}$, where $\theta(p)$ is the probability under product Bernoulli($p$) site percolation on $\mathbb Z^2$ (nearest-neighbour adjacency) that the origin lies in an infinite open cluster. Prove, by a deterministic argument (computer assistance with exact or interval arithmetic allowed, statistical sampling not), that $p_c<3/5$. With the known $p_c>0.556$, this gives $p_c\in(0.5,0.6)$.

**Reviewer note:** Known: Lower bound: p_c > 0.556 (van den Berg-Ermakov 1996), with no improvement found since. Upper bounds: 0.679492 (Wierman 1995, substitution method, CPC 4), then 0.666894 (Wierman-Oberly 2024, substitution method on self-matching lattices, the first improvement since 1995). Oberly-Wierman describe ongoing work on further small improvements by the same method. Non-rigorous: p_c = 0.59274605... from high-precision numerics (e.g. Jacobsen 2015 transfer matrices; Newman-Ziff Monte Carlo). Statistical: Riordan-Walters 2007, using the Balister-Bollobas-Walters 1-independent comparison method with Monte Carlo evaluation of a finite-box event, give [0.5925, 0.5930] at 99.9999% confidence. They note that exact enumeration of the needed box probabilities is impractical. Also p_c^site(Z^2) > 1/2 strictly (Higuchi) and p_c^site(Z^2) + p_c^site(matching lattice) = 1.

**Credit:** Wierman–Oberly 2024 (upper bound 0.666894); van den Berg–Ermakov 1996 (lower bound 0.556); Riordan–Walters 2007 (high-confidence numerics)

**References:**
- J. C. Wierman, Substitution method critical probability bounds for the square lattice site percolation model, Combin. Probab. Comput. 4 (1995) 181-188.
- J. C. Wierman, S. P. Oberly, A new upper bound for the site percolation threshold of the square lattice, in Combinatorics, Graph Theory and Computing (Springer, 2024), doi:10.1007/978-3-031-62166-6_9.
- J. van den Berg, A. Ermakov, A new lower bound for the critical probability of site percolation on the square lattice, Random Structures Algorithms 8 (1996) 199-212.
- O. Riordan, M. Walters, Rigorous confidence intervals for critical probabilities, Phys. Rev. E 76 (2007) 011110, arXiv:math/0702232.
- P. Balister, B. Bollobas, M. Walters, Continuum percolation with steps in the square or the disc, Random Structures Algorithms 26 (2005) 392-403.
- J. L. Jacobsen, Critical points of Potts and O(N) models from eigenvalue identities in periodic Temperley-Lieb algebras, J. Phys. A 48 (2015) 454003.

Difficulty estimate: 4.5/10 (anchored scale: 1 ≈ Erdős–Ginzburg–Ziv, 2.5 ≈ the sensitivity conjecture, 5 ≈ bounded prime gaps, 7.5 ≈ the Riemann Hypothesis, 10 ≈ P vs NP). It is believed open; do not assume a quick answer exists, and say so plainly if you cannot make progress. Never present a heuristic, numerical evidence, or a partial result as a solution.

## What counts as an answer
Either a proof of `OpenProblems.QEDE038.Claim` or a proof of `¬ OpenProblems.QEDE038.Claim` (a disproof), in Lean 4 + Mathlib, using the exact statement in `problems/QED-E038/Statement.lean`. Read its "Formalization notes" first. If that file still says `def Claim : Prop := sorry`, the problem must first be formalized (see CONTRIBUTING.md); a faithful formalization is itself a welcome contribution.

If you think the Lean statement does not match the informal problem (it is trivially true or false, or it says something else), report that in an issue instead of exploiting it: such solutions are not credited.

## How to submit
0. First time? Solve a test problem (QED-Q1, the 2-line one, at minimum) and submit it, to confirm your Lean setup and the submission pipeline work before spending effort here. Skip this step if this IS a test problem.
1. Claim it (optional but encouraged): open an issue titled `Claim QED-E038` at https://github.com/floration/qed/issues/new?template=claim.yml. Comment on it at least once a week or the claim lapses.
2. Add `solutions/QED-E038/<github-username>/Solution.lean`:
```lean
import Mathlib
-- do NOT redefine Claim: CI prepends problems/QED-E038/Statement.lean to your file
theorem solution : OpenProblems.QEDE038.Claim := by   -- or ¬ OpenProblems.QEDE038.Claim
  ...
```
   Large proofs may add more `.lean` files (subfolders allowed) next to Solution.lean; CI concatenates them in path order before Solution.lean. Don't import them.
3. Add `solutions/QED-E038/<github-username>/meta.json`: `{"model": "<AI model used, or none>", "kind": "proof" | "disproof"}`. Optionally a `README.md` explaining the idea.
4. Open a pull request. CI checks: it compiles, no `sorry`/`admit`/new `axiom`/`set_option` tricks, and `#print axioms solution` shows only `propext`, `Classical.choice`, `Quot.sound`.

## Scoring
Size = number of non-blank, non-comment lines of `Solution.lean` excluding `import` lines (helper lemmas count). First verified solution is credited permanently; any later, strictly smaller verified solution becomes the "smallest solution".

## Rules for you, the model
- Do not modify `Statement.lean` in a solution PR.
- Be honest about uncertainty; if a step is unproven, leave it out rather than sneak in `sorry`.
- Test locally: `lake exe cache get && lake env lean solutions/QED-E038/<user>/Solution.lean`.
