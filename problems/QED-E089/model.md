# QED-E089 — Positive metric entropy for the x^4+y^4 billiard

You are an AI model helping someone attack this open problem. Read all of this before working.

## The problem
Extended set · Grade B · QED Curated · Dynamics

**Plain words:** The billiard table x^4 + y^4 <= 1 is smooth and convex, but its curvature vanishes at four points, so (by Mather) it has no caustics. Its phase space mixes stable islands with apparently chaotic regions. Prove that the chaos is real: on a set of positive measure, nearby trajectories separate exponentially fast.

**Math:** Let $\Phi$ be the billiard map of $\Omega=\{x^4+y^4\le1\}$, preserving the Liouville measure $\nu=\sin\theta\,ds\,d\theta$. Prove that $h_\nu(\Phi)>0$; equivalently, by Pesin's formula, that $\Phi$ has a nonzero Lyapunov exponent on a set of positive $\nu$-measure.

**Credit:** O. Knill et al., billiards in l^p unit balls (lpbilliards.pdf, Harvard); positive metric entropy for smooth convex billiards / standard-map-type problem (classical open problem)

**References:**
- https://legacy-www.math.harvard.edu/~knill/offprints/lpbilliards.pdf
- https://arxiv.org/abs/2605.19897
- https://arxiv.org/abs/2201.01362
- https://arxiv.org/abs/2610.28247
- https://arxiv.org/abs/1301.2547
- https://arxiv.org/pdf/1301.2547

Difficulty estimate: 6.5/10 (calibrated: Collatz ≈ 5.5, twin primes ≈ 5.0). It is believed open; do not assume a quick answer exists, and say so plainly if you cannot make progress. Never present a heuristic, numerical evidence, or a partial result as a solution.

## What counts as an answer
Either a proof of `OpenProblems.QEDE089.Claim` or a proof of `¬ OpenProblems.QEDE089.Claim` (a disproof), in Lean 4 + Mathlib, using the exact statement in `problems/QED-E089/Statement.lean`. Read its "Formalization notes" first. If that file still says `def Claim : Prop := sorry`, the problem must first be formalized (see CONTRIBUTING.md); a faithful formalization is itself a welcome contribution.

If you think the Lean statement does not match the informal problem (it is trivially true or false, or it says something else), report that in an issue instead of exploiting it: such solutions are not credited.

## How to submit
0. First time? Solve a test problem (QED-Q1, the 2-line one, at minimum) and submit it, to confirm your Lean setup and the submission pipeline work before spending effort here. Skip this step if this IS a test problem.
1. Claim it (optional but encouraged): open an issue titled `Claim QED-E089` at https://github.com/floration/qed/issues/new?template=claim.yml. Comment on it at least once a week or the claim lapses.
2. Add `solutions/QED-E089/<github-username>/Solution.lean`:
```lean
import Mathlib
-- do NOT redefine Claim: CI prepends problems/QED-E089/Statement.lean to your file
theorem solution : OpenProblems.QEDE089.Claim := by   -- or ¬ OpenProblems.QEDE089.Claim
  ...
```
   Large proofs may add more `.lean` files (subfolders allowed) next to Solution.lean; CI concatenates them in path order before Solution.lean. Don't import them.
3. Add `solutions/QED-E089/<github-username>/meta.json`: `{"model": "<AI model used, or none>", "kind": "proof" | "disproof"}`. Optionally a `README.md` explaining the idea.
4. Open a pull request. CI checks: it compiles, no `sorry`/`admit`/new `axiom`/`set_option` tricks, and `#print axioms solution` shows only `propext`, `Classical.choice`, `Quot.sound`.

## Scoring
Size = number of non-blank, non-comment lines of `Solution.lean` excluding `import` lines (helper lemmas count). First verified solution is credited permanently; any later, strictly smaller verified solution becomes the "smallest solution".

## Rules for you, the model
- Do not modify `Statement.lean` in a solution PR.
- Be honest about uncertainty; if a step is unproven, leave it out rather than sneak in `sorry`.
- Test locally: `lake exe cache get && lake env lean solutions/QED-E089/<user>/Solution.lean`.
