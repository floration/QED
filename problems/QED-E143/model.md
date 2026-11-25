# QED-E143 — Does a projective plane of order 12 exist?

You are an AI model helping someone attack this open problem. Read all of this before working.

## The problem
Extended set · Grade A · QED Curated · Algebra

**Plain words:** A finite projective plane of order n has n^2+n+1 points and the same number of lines. Every line has n+1 points, and any two points lie on exactly one common line. Planes exist whenever n is a prime power, they are impossible for n = 6 and n = 10, and no plane is known for any other n. The smallest unsettled order is 12.

**Math:** Decide whether there exists a finite incidence structure with $157$ points and $157$ lines in which every line contains exactly $13$ points, every point lies on exactly $13$ lines, and any two distinct points lie on exactly one common line. Equivalently: is there a $157\times157$ $0/1$ matrix $A$ with $AA^{\mathsf T}=12I+J$, or equivalently are there $11$ mutually orthogonal Latin squares of order $12$?

**Credit:** Classical (Veblen–Bussey era question). Partial results by Janko, van Trung and others.

**Rests on recent unrefereed work. Check these premises first:**
- Very well known, so novelty is low
- May be judged a 'famous problem' (the prime power conjecture for planes), but the specific order-12 case is the natural unnamed sub-question
- Overlaps thematically with MOLS(10) (both are MOLS questions); the owner may want only one

**References:**
- https://www.emergentmind.com/open-problems/existence-projective-planes-non-prime-power-orders-order-12
- https://cs.uwaterloo.ca/~cbright/talks/canadam2025.pdf
- https://ajc-new.maths.uq.edu.au/pdf/74/ajc_v74_p112.pdf
- https://www.homepages.ucl.ac.uk/~ucahbdo/FiniteProjectivePlanes.pdf

Difficulty estimate: 6.0/10 (calibrated: Collatz ≈ 5.5, twin primes ≈ 5.0). It is believed open; do not assume a quick answer exists, and say so plainly if you cannot make progress. Never present a heuristic, numerical evidence, or a partial result as a solution.

## What counts as an answer
Either a proof of `OpenProblems.QEDE143.Claim` or a proof of `¬ OpenProblems.QEDE143.Claim` (a disproof), in Lean 4 + Mathlib, using the exact statement in `problems/QED-E143/Statement.lean`. Read its "Formalization notes" first. If that file still says `def Claim : Prop := sorry`, the problem must first be formalized (see CONTRIBUTING.md); a faithful formalization is itself a welcome contribution.

If you think the Lean statement does not match the informal problem (it is trivially true or false, or it says something else), report that in an issue instead of exploiting it: such solutions are not credited.

## How to submit
0. First time? Solve a test problem (QED-Q1, the 2-line one, at minimum) and submit it, to confirm your Lean setup and the submission pipeline work before spending effort here. Skip this step if this IS a test problem.
1. Claim it (optional but encouraged): open an issue titled `Claim QED-E143` at https://github.com/floration/qed/issues/new?template=claim.yml. Comment on it at least once a week or the claim lapses.
2. Add `solutions/QED-E143/<github-username>/Solution.lean`:
```lean
import Mathlib
-- do NOT redefine Claim: CI prepends problems/QED-E143/Statement.lean to your file
theorem solution : OpenProblems.QEDE143.Claim := by   -- or ¬ OpenProblems.QEDE143.Claim
  ...
```
   Large proofs may add more `.lean` files (subfolders allowed) next to Solution.lean; CI concatenates them in path order before Solution.lean. Don't import them.
3. Add `solutions/QED-E143/<github-username>/meta.json`: `{"model": "<AI model used, or none>", "kind": "proof" | "disproof"}`. Optionally a `README.md` explaining the idea.
4. Open a pull request. CI checks: it compiles, no `sorry`/`admit`/new `axiom`/`set_option` tricks, and `#print axioms solution` shows only `propext`, `Classical.choice`, `Quot.sound`.

## Scoring
Size = number of non-blank, non-comment lines of `Solution.lean` excluding `import` lines (helper lemmas count). First verified solution is credited permanently; any later, strictly smaller verified solution becomes the "smallest solution".

## Rules for you, the model
- Do not modify `Statement.lean` in a solution PR.
- Be honest about uncertainty; if a step is unproven, leave it out rather than sneak in `sorry`.
- Test locally: `lake exe cache get && lake env lean solutions/QED-E143/<user>/Solution.lean`.
