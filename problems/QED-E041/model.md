# QED-E041 — No three in line: beat 3n/2

You are an AI model helping someone attack this open problem. Read all of this before working.

## The problem
Extended set · Grade B- · QED Curated · Geometry

**Plain words:** How many points of an n-by-n grid can you pick so that no three of them lie on one straight line (at any angle)? Each row holds at most two, so 2n is the ceiling, and explicit constructions from 1975 give about 1.5n for large n. Find, for all large n, a construction with at least cn points for some constant c > 1.5.

**Math:** Let $f(n)$ be the largest size of $S\subseteq\{1,\dots,n\}^2$ with no three collinear points. Known: $(\tfrac32-o(1))n\le f(n)\le 2n$. Prove there is $c>3/2$ with $f(n)\ge cn$ for all sufficiently large $n$.

**Reviewer note:** Known: Lower $(3/2-o(1))n$: Hall, Jackson, Sudbery, Wild, JCTA 18 (1975). Upper $2n$ (pigeonhole); Guy–Kelly (1968) heuristic $f(n)\sim(\pi/\sqrt3)n\approx1.814n$. $f(n)=2n$ attained computationally for all $n\le46$ and some larger even $n$ (Flammenkamp); Epoch AI's page reports tightness for $n\le70$. For $k\ge3$, the no-$(k+1)$-in-line maximum is $kn$ for large $n$: arXiv:2607.05255 (July 2026), after arXiv:2502.00176 and arXiv:2510.17743; arXiv:2508.07632's randomised constructions are vacuous at $k=2$. Epoch AI lists 'more than 1.8n for arbitrarily large n' as an open problem.

**Credit:** Dudeney (1917); Hall–Jackson–Sudbery–Wild (1975); Guy–Kelly (1968)

**Rests on recent unrefereed work. Check these premises first:**
- the problem is famous (Dudeney); only the constant improvement is asked, not the 2n question
- Epoch AI hosts a closely related target (1.8n, arbitrarily large n), so a solution may surface there first

**References:**
- https://epoch.ai/frontiermath/open-problems/no-three-in-line
- https://arxiv.org/abs/2607.05255
- https://arxiv.org/abs/2508.07632
- https://wwwhomes.uni-bielefeld.de/achim/no3in/readme.html
- https://arxiv.org/abs/2502.00176

Difficulty estimate: 5.5/10 (calibrated: Collatz ≈ 5.5, twin primes ≈ 5.0). It is believed open; do not assume a quick answer exists, and say so plainly if you cannot make progress. Never present a heuristic, numerical evidence, or a partial result as a solution.

## What counts as an answer
Either a proof of `OpenProblems.QEDE041.Claim` or a proof of `¬ OpenProblems.QEDE041.Claim` (a disproof), in Lean 4 + Mathlib, using the exact statement in `problems/QED-E041/Statement.lean`. Read its "Formalization notes" first. If that file still says `def Claim : Prop := sorry`, the problem must first be formalized (see CONTRIBUTING.md); a faithful formalization is itself a welcome contribution.

If you think the Lean statement does not match the informal problem (it is trivially true or false, or it says something else), report that in an issue instead of exploiting it: such solutions are not credited.

## How to submit
0. First time? Solve a test problem (QED-Q1, the 2-line one, at minimum) and submit it, to confirm your Lean setup and the submission pipeline work before spending effort here. Skip this step if this IS a test problem.
1. Claim it (optional but encouraged): open an issue titled `Claim QED-E041` at https://github.com/floration/qed/issues/new?template=claim.yml. Comment on it at least once a week or the claim lapses.
2. Add `solutions/QED-E041/<github-username>/Solution.lean`:
```lean
import Mathlib
-- do NOT redefine Claim: CI prepends problems/QED-E041/Statement.lean to your file
theorem solution : OpenProblems.QEDE041.Claim := by   -- or ¬ OpenProblems.QEDE041.Claim
  ...
```
   Large proofs may add more `.lean` files (subfolders allowed) next to Solution.lean; CI concatenates them in path order before Solution.lean. Don't import them.
3. Add `solutions/QED-E041/<github-username>/meta.json`: `{"model": "<AI model used, or none>", "kind": "proof" | "disproof"}`. Optionally a `README.md` explaining the idea.
4. Open a pull request. CI checks: it compiles, no `sorry`/`admit`/new `axiom`/`set_option` tricks, and `#print axioms solution` shows only `propext`, `Classical.choice`, `Quot.sound`.

## Scoring
Size = number of non-blank, non-comment lines of `Solution.lean` excluding `import` lines (helper lemmas count). First verified solution is credited permanently; any later, strictly smaller verified solution becomes the "smallest solution".

## Rules for you, the model
- Do not modify `Statement.lean` in a solution PR.
- Be honest about uncertainty; if a step is unproven, leave it out rather than sneak in `sorry`.
- Test locally: `lake exe cache get && lake env lean solutions/QED-E041/<user>/Solution.lean`.
