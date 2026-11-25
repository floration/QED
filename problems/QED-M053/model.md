# QED-M053 — Positive metric entropy for the x^4+y^4 billiard

You are an AI model helping someone attack this open problem. Read all of this before working.

## The problem
Main set · Grade B · QED Curated · Dynamics · formerly N-631

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
Either a proof of `OpenProblems.QEDM053.Claim` or a proof of `¬ OpenProblems.QEDM053.Claim` (a disproof), in Lean 4 + Mathlib, using the exact statement in `problems/QED-M053/Statement.lean`. Read its "Formalization notes" first. If that file still says `def Claim : Prop := sorry`, the problem must first be formalized (see CONTRIBUTING.md); a faithful formalization is itself a welcome contribution. What is missing: Not formalized: billiard map construction on a quartic curve plus Kolmogorov-Sinai entropy or Lyapunov/Pesin theory is not in Mathlib. 2026 refs (2605.19897, 2610.28247) are background progress on topological entropy and lemons, not premises.

If you think the Lean statement does not match the informal problem (it is trivially true or false, or it says something else), report that in an issue instead of exploiting it: such solutions are not credited.

## How to submit
1. Claim it (optional but encouraged): open an issue titled `Claim QED-M053` at https://github.com/floration/qed/issues/new?template=claim.yml. Comment on it at least once a week or the claim lapses.
2. Add `solutions/QED-M053/<github-username>/Solution.lean`:
```lean
import Mathlib
-- do NOT redefine Claim: CI prepends problems/QED-M053/Statement.lean to your file
theorem solution : OpenProblems.QEDM053.Claim := by   -- or ¬ OpenProblems.QEDM053.Claim
  ...
```
3. Add `solutions/QED-M053/<github-username>/meta.json`: `{"model": "<AI model used, or none>", "kind": "proof" | "disproof"}`. Optionally a `README.md` explaining the idea.
4. Open a pull request. CI checks: it compiles, no `sorry`/`admit`/new `axiom`/`set_option` tricks, and `#print axioms solution` shows only `propext`, `Classical.choice`, `Quot.sound`.

## Scoring
Size = number of non-blank, non-comment lines of `Solution.lean` excluding `import` lines (helper lemmas count). First verified solution is credited permanently; any later, strictly smaller verified solution becomes the "smallest solution".

## Rules for you, the model
- Do not modify `Statement.lean` in a solution PR.
- Be honest about uncertainty; if a step is unproven, leave it out rather than sneak in `sorry`.
- Test locally: `lake exe cache get && lake env lean solutions/QED-M053/<user>/Solution.lean`.
