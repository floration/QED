# QED-E038 — Squeezing the square-lattice site percolation threshold

You are an AI model helping someone attack this open problem. Read all of this before working.

## The problem
Extended set · Grade C · QED Curated · Probability

**Plain words:** Colour each square of an infinite chessboard black independently with probability p. There is a critical p above which an infinite connected black cluster appears; simulations put it at about 0.5927, but nobody has a formula. The best proved statements only say it lies between 0.556 and 0.6669. Prove a tighter bound on either side.

**Math:** Let $p_c=p_c^{\mathrm{site}}(\mathbb Z^2)$. Known rigorously $0.556<p_c<0.666894$. Formal target: improve the upper bound at its published precision, $p_c<0.6668$ (more generally improve either endpoint rigorously).

**Reviewer note:** Known: Lower $p_c>0.556$: van den Berg & Ermakov, Random Structures Algorithms 8 (1996) 199–212. Unreviewed claim $p_c\ge0.5567$ (computer-assisted, personal page kaust-a-laut.github.io, not peer reviewed). Upper $p_c<0.666894$: Wierman & Oberly, 'A new upper bound for the site percolation threshold of the square lattice', in Combinatorics, Graph Theory and Computing (Springer, 2024), improving Wierman's 0.679492 (CPC 1995, substitution method). Numerical $p_c\approx0.59274605$ (Jacobsen 2015 and others; non-rigorous).

**Credit:** van den Berg–Ermakov (1996); Wierman (1995); Wierman–Oberly (2024)

**Rests on recent unrefereed work. Check these premises first:**
- an unreviewed lower bound 0.5567 already exists online; if it is confirmed, the lower-bound target moves
- the Wierman–Oberly abstract mentions 'a series of recent improvements', so an intermediate upper bound may also exist
- the 2024 upper bound is in conference proceedings rather than a journal

**References:**
- https://ir.cwi.nl/pub/4915
- https://www.springerprofessional.de/en/a-new-upper-bound-for-the-site-percolation-threshold-of-the-squa/50252622
- https://www.math.fau.edu/combinatorics/abstracts/oberly55.pdf
- https://kaust-a-laut.github.io/

Difficulty estimate: 4.0/10 (calibrated: Collatz ≈ 5.5, twin primes ≈ 5.0). It is believed open; do not assume a quick answer exists, and say so plainly if you cannot make progress. Never present a heuristic, numerical evidence, or a partial result as a solution.

## What counts as an answer
Either a proof of `OpenProblems.QEDE038.Claim` or a proof of `¬ OpenProblems.QEDE038.Claim` (a disproof), in Lean 4 + Mathlib, using the exact statement in `problems/QED-E038/Statement.lean`. Read its "Formalization notes" first. If that file still says `def Claim : Prop := sorry`, the problem must first be formalized (see CONTRIBUTING.md); a faithful formalization is itself a welcome contribution.

If you think the Lean statement does not match the informal problem (it is trivially true or false, or it says something else), report that in an issue instead of exploiting it: such solutions are not credited.

## How to submit
1. Claim it (optional but encouraged): open an issue titled `Claim QED-E038` at https://github.com/floration/qed/issues/new?template=claim.yml. Comment on it at least once a week or the claim lapses.
2. Add `solutions/QED-E038/<github-username>/Solution.lean`:
```lean
import Mathlib
-- do NOT redefine Claim: CI prepends problems/QED-E038/Statement.lean to your file
theorem solution : OpenProblems.QEDE038.Claim := by   -- or ¬ OpenProblems.QEDE038.Claim
  ...
```
3. Add `solutions/QED-E038/<github-username>/meta.json`: `{"model": "<AI model used, or none>", "kind": "proof" | "disproof"}`. Optionally a `README.md` explaining the idea.
4. Open a pull request. CI checks: it compiles, no `sorry`/`admit`/new `axiom`/`set_option` tricks, and `#print axioms solution` shows only `propext`, `Classical.choice`, `Quot.sound`.

## Scoring
Size = number of non-blank, non-comment lines of `Solution.lean` excluding `import` lines (helper lemmas count). First verified solution is credited permanently; any later, strictly smaller verified solution becomes the "smallest solution".

## Rules for you, the model
- Do not modify `Statement.lean` in a solution PR.
- Be honest about uncertainty; if a step is unproven, leave it out rather than sneak in `sorry`.
- Test locally: `lake exe cache get && lake env lean solutions/QED-E038/<user>/Solution.lean`.
