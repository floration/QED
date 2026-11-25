# QED-M064 — Superlinear unit distances on the unit sphere

You are an AI model helping someone attack this open problem. Read all of this before working.

## The problem
Main set · Grade A · QED Curated · Geometry

**Plain words:** In 2026 a number-field construction showed that points in the plane can have n^(1+c) unit distances, disproving Erdos's conjecture. On a sphere of radius 1/sqrt2 an n^(4/3) construction is classical, but on the unit sphere only n·sqrt(log n) is known. Can the new ideas give a power gain there?

**Math:** Prove or disprove: there is $c>0$ such that for infinitely many $n$ there exist $P\subset S^2=\{x\in\mathbb{R}^3:|x|=1\}$ with $|P|=n$ and $\#\{\{p,q\}\subset P:|p-q|=1\}\ge n^{1+c}$.

**Credit:** Erdős, Hickerson, Pach, 'A problem of Leo Moser about repeated distances on the sphere', Amer. Math. Monthly 96 (1989); Swanepoel-Valtr (2004)

**References:**
- https://arxiv.org/abs/2605.20579
- https://arxiv.org/html/2605.20695
- https://web.math.princeton.edu/~nalon/PDFS/udremarks.pdf
- https://researchonline.lse.ac.uk/id/eprint/25462
- https://ar5iv.arxiv.org/html/0707.0213
- https://kam.mff.cuni.cz/kamserie/clanky/2004/s673.pdf
- https://arxiv.org/abs/2605.20579
- https://arxiv.org/html/2605.20695
- https://arxiv.org/abs/2606.03419

Difficulty estimate: 4.5/10 (calibrated: Collatz ≈ 5.5, twin primes ≈ 5.0). It is believed open; do not assume a quick answer exists, and say so plainly if you cannot make progress. Never present a heuristic, numerical evidence, or a partial result as a solution.

## What counts as an answer
Either a proof of `OpenProblems.QEDM064.Claim` or a proof of `¬ OpenProblems.QEDM064.Claim` (a disproof), in Lean 4 + Mathlib, using the exact statement in `problems/QED-M064/Statement.lean`. Read its "Formalization notes" first. If that file still says `def Claim : Prop := sorry`, the problem must first be formalized (see CONTRIBUTING.md); a faithful formalization is itself a welcome contribution.

If you think the Lean statement does not match the informal problem (it is trivially true or false, or it says something else), report that in an issue instead of exploiting it: such solutions are not credited.

## How to submit
1. Claim it (optional but encouraged): open an issue titled `Claim QED-M064` at https://github.com/floration/qed/issues/new?template=claim.yml. Comment on it at least once a week or the claim lapses.
2. Add `solutions/QED-M064/<github-username>/Solution.lean`:
```lean
import Mathlib
-- do NOT redefine Claim: CI prepends problems/QED-M064/Statement.lean to your file
theorem solution : OpenProblems.QEDM064.Claim := by   -- or ¬ OpenProblems.QEDM064.Claim
  ...
```
   Large proofs may add more `.lean` files (subfolders allowed) next to Solution.lean; CI concatenates them in path order before Solution.lean. Don't import them.
3. Add `solutions/QED-M064/<github-username>/meta.json`: `{"model": "<AI model used, or none>", "kind": "proof" | "disproof"}`. Optionally a `README.md` explaining the idea.
4. Open a pull request. CI checks: it compiles, no `sorry`/`admit`/new `axiom`/`set_option` tricks, and `#print axioms solution` shows only `propext`, `Classical.choice`, `Quot.sound`.

## Scoring
Size = number of non-blank, non-comment lines of `Solution.lean` excluding `import` lines (helper lemmas count). First verified solution is credited permanently; any later, strictly smaller verified solution becomes the "smallest solution".

## Rules for you, the model
- Do not modify `Statement.lean` in a solution PR.
- Be honest about uncertainty; if a step is unproven, leave it out rather than sneak in `sorry`.
- Test locally: `lake exe cache get && lake env lean solutions/QED-M064/<user>/Solution.lean`.
