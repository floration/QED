# QED-E053 — A polyomino of odd order

You are an AI model helping someone attack this open problem. Read all of this before working.

## The problem
Extended set · Grade B- · QED Curated · Combinatorics

**Plain words:** Some shapes made of squares, like the L-tetromino, can tile a rectangle. The order of such a shape is the fewest copies that can do it. Apart from rectangles themselves (order 1), every shape with a known order needs an even number of copies, and order 3 is proved impossible. Is there a non-rectangular polyomino whose order is odd?

**Math:** For a polyomino $P$ that tiles some rectangle with congruent copies (rotations and reflections allowed), let $\mathrm{ord}(P)$ be the minimum number of copies in such a tiling. Does there exist a non-rectangular $P$ with $\mathrm{ord}(P)$ odd? First test case: $\mathrm{ord}(P)=5$.

**Reviewer note:** Known: Order 3 is impossible: Stewart & Wormstein, 'Polyominoes of order 3 do not exist', JCTA 61 (1992) 130–136. Maltby, 'Trisecting a rectangle', JCTA 66 (1994): no non-rectangular 3-piece congruent dissection; M. Reid noted on math-fun that the 5-, 7- and 9-piece dissection cases remain open. Odd tilings, as opposed to odd minimal tilings, exist: Reid, 'Many L-shaped polyominoes have odd rectangular packings', Ann. Comb. 18 (2014) 341–357. OEIS A126140 (maximum order for n cells): 'No example of a non-rectangular polyomino is known for which its order is odd.'

**Credit:** Golomb / Klarner rectifiable-polyomino program; Stewart & Wormstein (1992); Reid

**Rests on recent unrefereed work. Check these premises first:**
- Reflections allowed (Golomb's convention); a rotations-only version could differ
- Reid's rectifiable-polyomino page (not loaded) might list an odd-order example. OEIS says none is known.

**References:**
- https://oeis.org/A126140
- https://dblp.org/rec/journals/jct/StewartW92
- https://link.springer.com/article/10.1007/s00026-014-0226-9
- https://lists.xmission.com/hyperkitty/list/mathfun@mailman.xmission.com/thread/RIZNQBDMDEYQJXS6OB3J2SLH4QHQX6MU

Difficulty estimate: 4.0/10 (calibrated: Collatz ≈ 5.5, twin primes ≈ 5.0). It is believed open; do not assume a quick answer exists, and say so plainly if you cannot make progress. Never present a heuristic, numerical evidence, or a partial result as a solution.

## What counts as an answer
Either a proof of `OpenProblems.QEDE053.Claim` or a proof of `¬ OpenProblems.QEDE053.Claim` (a disproof), in Lean 4 + Mathlib, using the exact statement in `problems/QED-E053/Statement.lean`. Read its "Formalization notes" first. If that file still says `def Claim : Prop := sorry`, the problem must first be formalized (see CONTRIBUTING.md); a faithful formalization is itself a welcome contribution.

If you think the Lean statement does not match the informal problem (it is trivially true or false, or it says something else), report that in an issue instead of exploiting it: such solutions are not credited.

## How to submit
1. Claim it (optional but encouraged): open an issue titled `Claim QED-E053` at https://github.com/floration/qed/issues/new?template=claim.yml. Comment on it at least once a week or the claim lapses.
2. Add `solutions/QED-E053/<github-username>/Solution.lean`:
```lean
import Mathlib
-- do NOT redefine Claim: CI prepends problems/QED-E053/Statement.lean to your file
theorem solution : OpenProblems.QEDE053.Claim := by   -- or ¬ OpenProblems.QEDE053.Claim
  ...
```
   Large proofs may add more `.lean` files (subfolders allowed) next to Solution.lean; CI concatenates them in path order before Solution.lean. Don't import them.
3. Add `solutions/QED-E053/<github-username>/meta.json`: `{"model": "<AI model used, or none>", "kind": "proof" | "disproof"}`. Optionally a `README.md` explaining the idea.
4. Open a pull request. CI checks: it compiles, no `sorry`/`admit`/new `axiom`/`set_option` tricks, and `#print axioms solution` shows only `propext`, `Classical.choice`, `Quot.sound`.

## Scoring
Size = number of non-blank, non-comment lines of `Solution.lean` excluding `import` lines (helper lemmas count). First verified solution is credited permanently; any later, strictly smaller verified solution becomes the "smallest solution".

## Rules for you, the model
- Do not modify `Statement.lean` in a solution PR.
- Be honest about uncertainty; if a step is unproven, leave it out rather than sneak in `sorry`.
- Test locally: `lake exe cache get && lake env lean solutions/QED-E053/<user>/Solution.lean`.
