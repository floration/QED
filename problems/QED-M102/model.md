# QED-M102 — Knotted billiards in a regular tetrahedron

You are an AI model helping someone attack this open problem. Read all of this before working.

## The problem
Main set · Grade B · QED Extension · Topology

**Plain words:** A billiard ball bouncing periodically inside a regular tetrahedron, without hitting edges or corners, traces a closed polygon in space. Is any such polygon knotted, and do infinitely many different knot types occur?

**Math:** Call a periodic billiard trajectory in a regular tetrahedron $T\subset\mathbb R^3$ admissible if it never meets an edge or vertex of $T$ and its image is an embedded closed polygon. (a) Does some admissible trajectory form a nontrivial knot? (b) Prove that the set of knot types of admissible periodic trajectories is infinite.

**Credit:** Extends Jones–Przytycki (Lissajous knots and billiard knots, 1998) and Koseleff–Pecker, 'Every knot is a billiard knot', arXiv:1106.5600; periodic orbits in polyhedra: Bedaride–Rao arXiv:1104.1051.

**References:**
- https://arxiv.org/abs/1106.5600
- https://arxiv.org/pdf/1104.1051

Difficulty estimate: 3.0/10 (calibrated: Collatz ≈ 5.5, twin primes ≈ 5.0). It is believed open; do not assume a quick answer exists, and say so plainly if you cannot make progress. Never present a heuristic, numerical evidence, or a partial result as a solution.

## What counts as an answer
Either a proof of `OpenProblems.QEDM102.Claim` or a proof of `¬ OpenProblems.QEDM102.Claim` (a disproof), in Lean 4 + Mathlib, using the exact statement in `problems/QED-M102/Statement.lean`. Read its "Formalization notes" first. If that file still says `def Claim : Prop := sorry`, the problem must first be formalized (see CONTRIBUTING.md); a faithful formalization is itself a welcome contribution.

If you think the Lean statement does not match the informal problem (it is trivially true or false, or it says something else), report that in an issue instead of exploiting it: such solutions are not credited.

## How to submit
1. Claim it (optional but encouraged): open an issue titled `Claim QED-M102` at https://github.com/floration/qed/issues/new?template=claim.yml. Comment on it at least once a week or the claim lapses.
2. Add `solutions/QED-M102/<github-username>/Solution.lean`:
```lean
import Mathlib
-- do NOT redefine Claim: CI prepends problems/QED-M102/Statement.lean to your file
theorem solution : OpenProblems.QEDM102.Claim := by   -- or ¬ OpenProblems.QEDM102.Claim
  ...
```
   Large proofs may add more `.lean` files (subfolders allowed) next to Solution.lean; CI concatenates them in path order before Solution.lean. Don't import them.
3. Add `solutions/QED-M102/<github-username>/meta.json`: `{"model": "<AI model used, or none>", "kind": "proof" | "disproof"}`. Optionally a `README.md` explaining the idea.
4. Open a pull request. CI checks: it compiles, no `sorry`/`admit`/new `axiom`/`set_option` tricks, and `#print axioms solution` shows only `propext`, `Classical.choice`, `Quot.sound`.

## Scoring
Size = number of non-blank, non-comment lines of `Solution.lean` excluding `import` lines (helper lemmas count). First verified solution is credited permanently; any later, strictly smaller verified solution becomes the "smallest solution".

## Rules for you, the model
- Do not modify `Statement.lean` in a solution PR.
- Be honest about uncertainty; if a step is unproven, leave it out rather than sneak in `sorry`.
- Test locally: `lake exe cache get && lake env lean solutions/QED-M102/<user>/Solution.lean`.
