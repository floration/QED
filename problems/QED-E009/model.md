# QED-E009 — Non-flat free-boundary minimal disks in the superball

You are an AI model helping someone attack this open problem. Read all of this before working.

## The problem
Extended set · Grade C · Geometry

**Plain words:** In a round ball the only free-boundary minimal disks are flat slices through the centre (Nitsche). The superball x^4+y^4+z^4 <= 1 has nine flat ones, cut by its mirror planes. Is there also one that is not flat? A natural candidate has threefold symmetry about the diagonal (1,1,1).

**Math:** For $p>2$ let $B_p=\{|x|^p+|y|^p+|z|^p\le1\}$. Decide whether $B_4$ (more generally $B_p$) contains an embedded minimal disk $\Sigma$ with $\partial\Sigma\subset\partial B_p$, meeting $\partial B_p$ orthogonally, that is not contained in a plane. Specifically, show that there is one invariant under the rotation by $2\pi/3$ about the axis $\mathbb R(1,1,1)$ and under $v\mapsto-v$.

**Reviewer note:** W

Difficulty estimate: 3.0/10 (calibrated: Collatz ≈ 5.5, twin primes ≈ 5.0). It is believed open; do not assume a quick answer exists, and say so plainly if you cannot make progress. Never present a heuristic, numerical evidence, or a partial result as a solution.

## What counts as an answer
Either a proof of `OpenProblems.QEDE009.Claim` or a proof of `¬ OpenProblems.QEDE009.Claim` (a disproof), in Lean 4 + Mathlib, using the exact statement in `problems/QED-E009/Statement.lean`. Read its "Formalization notes" first. If that file still says `def Claim : Prop := sorry`, the problem must first be formalized (see CONTRIBUTING.md); a faithful formalization is itself a welcome contribution.

If you think the Lean statement does not match the informal problem (it is trivially true or false, or it says something else), report that in an issue instead of exploiting it: such solutions are not credited.

## How to submit
0. First time? Solve a test problem (QED-Q1, the 2-line one, at minimum) and submit it, to confirm your Lean setup and the submission pipeline work before spending effort here. Skip this step if this IS a test problem.
1. Claim it (optional but encouraged): open an issue titled `Claim QED-E009` at https://github.com/floration/qed/issues/new?template=claim.yml. Comment on it at least once a week or the claim lapses.
2. Add `solutions/QED-E009/<github-username>/Solution.lean`:
```lean
import Mathlib
-- do NOT redefine Claim: CI prepends problems/QED-E009/Statement.lean to your file
theorem solution : OpenProblems.QEDE009.Claim := by   -- or ¬ OpenProblems.QEDE009.Claim
  ...
```
3. Add `solutions/QED-E009/<github-username>/meta.json`: `{"model": "<AI model used, or none>", "kind": "proof" | "disproof"}`. Optionally a `README.md` explaining the idea.
4. Open a pull request. CI checks: it compiles, no `sorry`/`admit`/new `axiom`/`set_option` tricks, and `#print axioms solution` shows only `propext`, `Classical.choice`, `Quot.sound`.

## Scoring
Size = number of non-blank, non-comment lines of `Solution.lean` excluding `import` lines (helper lemmas count). First verified solution is credited permanently; any later, strictly smaller verified solution becomes the "smallest solution".

## Rules for you, the model
- Do not modify `Statement.lean` in a solution PR.
- Be honest about uncertainty; if a step is unproven, leave it out rather than sneak in `sorry`.
- Test locally: `lake exe cache get && lake env lean solutions/QED-E009/<user>/Solution.lean`.
