# QED-M047 — Ergodicity of the regular tetrahedron billiard

You are an AI model helping someone attack this open problem. Read all of this before working.

## The problem
Main set · Grade B · QED Original · Dynamics

**Plain words:** A billiard ball bounces inside a regular tetrahedron. The tetrahedron does not tile space, and its dihedral angle arccos(1/3) is an irrational multiple of pi. So the billiard cannot be unfolded into a straight-line flow on a torus or a translation structure. Is the motion ergodic, so that almost every trajectory equidistributes in position and direction?

**Math:** Let $\Delta\subset\mathbb R^3$ be a regular tetrahedron and $\phi_t$ the billiard flow on the unit tangent bundle $T^1\Delta$, with specular reflection at faces and orbits hitting edges or vertices discarded (a null set). Prove or disprove that $\phi_t$ is ergodic with respect to Liouville measure.

**References:**
- https://arxiv.org/abs/2403.19954
- https://arxiv.org/abs/1104.1051
- https://arxiv.org/abs/1910.14350
- https://arxiv.org/pdf/1112.2370
- https://arxiv.org/pdf/1301.2547

Difficulty estimate: 6.5/10 (calibrated: Collatz ≈ 5.5, twin primes ≈ 5.0). It is believed open; do not assume a quick answer exists, and say so plainly if you cannot make progress. Never present a heuristic, numerical evidence, or a partial result as a solution.

## What counts as an answer
Either a proof of `OpenProblems.QEDM047.Claim` or a proof of `¬ OpenProblems.QEDM047.Claim` (a disproof), in Lean 4 + Mathlib, using the exact statement in `problems/QED-M047/Statement.lean`. Read its "Formalization notes" first. If that file still says `def Claim : Prop := sorry`, the problem must first be formalized (see CONTRIBUTING.md); a faithful formalization is itself a welcome contribution.

If you think the Lean statement does not match the informal problem (it is trivially true or false, or it says something else), report that in an issue instead of exploiting it: such solutions are not credited.

## How to submit
0. First time? Solve a test problem (QED-Q1, the 2-line one, at minimum) and submit it, to confirm your Lean setup and the submission pipeline work before spending effort here. Skip this step if this IS a test problem.
1. Claim it (optional but encouraged): open an issue titled `Claim QED-M047` at https://github.com/floration/qed/issues/new?template=claim.yml. Comment on it at least once a week or the claim lapses.
2. Add `solutions/QED-M047/<github-username>/Solution.lean`:
```lean
import Mathlib
-- do NOT redefine Claim: CI prepends problems/QED-M047/Statement.lean to your file
theorem solution : OpenProblems.QEDM047.Claim := by   -- or ¬ OpenProblems.QEDM047.Claim
  ...
```
3. Add `solutions/QED-M047/<github-username>/meta.json`: `{"model": "<AI model used, or none>", "kind": "proof" | "disproof"}`. Optionally a `README.md` explaining the idea.
4. Open a pull request. CI checks: it compiles, no `sorry`/`admit`/new `axiom`/`set_option` tricks, and `#print axioms solution` shows only `propext`, `Classical.choice`, `Quot.sound`.

## Scoring
Size = number of non-blank, non-comment lines of `Solution.lean` excluding `import` lines (helper lemmas count). First verified solution is credited permanently; any later, strictly smaller verified solution becomes the "smallest solution".

## Rules for you, the model
- Do not modify `Statement.lean` in a solution PR.
- Be honest about uncertainty; if a step is unproven, leave it out rather than sneak in `sorry`.
- Test locally: `lake exe cache get && lake env lean solutions/QED-M047/<user>/Solution.lean`.
