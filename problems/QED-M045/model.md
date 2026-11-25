# QED-M045 — Chaos in the symmetric ABC flow

You are an AI model helping someone attack this open problem. Read all of this before working.

## The problem
Main set · Grade B · QED Curated · Dynamics

**Plain words:** The ABC flow with all three coefficients equal to 1 is the classical steady Euler flow on the 3-torus that is believed to be chaotic. Prove that it really is: show it has positive topological entropy.

**Math:** Prove that the flow of $\dot x=\sin z+\cos y,\ \dot y=\sin x+\cos z,\ \dot z=\sin y+\cos x$ on $\mathbb{T}^3=(\mathbb{R}/2\pi\mathbb{Z})^3$ has positive topological entropy (e.g. by exhibiting a transversal homoclinic orbit to a hyperbolic periodic orbit, or a horseshoe for a Poincare map).

**Credit:** T. Dombre, U. Frisch, J. M. Greene, M. Henon, A. Mehr, A. M. Soward, 'Chaotic streamlines in the ABC flows', J. Fluid Mech. 167 (1986); V. I. Arnold (1965); M. Henon (1966).

**Rests on recent unrefereed work. Check these premises first:**
- arXiv:2609.17449 (Szuminski-Llibre, 2026 preprint): relied on only for the openness check (it is perturbative near the axes and does not settle A=B=C=1); the statement assumes nothing from it.

**References:**
- https://arxiv.org/abs/1601.02724
- https://arxiv.org/abs/1704.03128
- https://arxiv.org/abs/2609.17449
- https://www.mathnet.ru/eng/faa525
- https://www.cambridge.org/core/journals/journal-of-fluid-mechanics/article/abs/chaotic-streamlines-in-the-abc-flows/7139EDCF0CC8A9B4D9D749B1FAA6CE54
- https://arxiv.org/pdf/2504.04887
- https://arxiv.org/abs/2204.14056

Difficulty estimate: 2.5/10 (calibrated: Collatz ≈ 5.5, twin primes ≈ 5.0). It is believed open; do not assume a quick answer exists, and say so plainly if you cannot make progress. Never present a heuristic, numerical evidence, or a partial result as a solution.

## What counts as an answer
Either a proof of `OpenProblems.QEDM045.Claim` or a proof of `¬ OpenProblems.QEDM045.Claim` (a disproof), in Lean 4 + Mathlib, using the exact statement in `problems/QED-M045/Statement.lean`. Read its "Formalization notes" first. If that file still says `def Claim : Prop := sorry`, the problem must first be formalized (see CONTRIBUTING.md); a faithful formalization is itself a welcome contribution.

If you think the Lean statement does not match the informal problem (it is trivially true or false, or it says something else), report that in an issue instead of exploiting it: such solutions are not credited.

## How to submit
1. Claim it (optional but encouraged): open an issue titled `Claim QED-M045` at https://github.com/floration/qed/issues/new?template=claim.yml. Comment on it at least once a week or the claim lapses.
2. Add `solutions/QED-M045/<github-username>/Solution.lean`:
```lean
import Mathlib
-- do NOT redefine Claim: CI prepends problems/QED-M045/Statement.lean to your file
theorem solution : OpenProblems.QEDM045.Claim := by   -- or ¬ OpenProblems.QEDM045.Claim
  ...
```
3. Add `solutions/QED-M045/<github-username>/meta.json`: `{"model": "<AI model used, or none>", "kind": "proof" | "disproof"}`. Optionally a `README.md` explaining the idea.
4. Open a pull request. CI checks: it compiles, no `sorry`/`admit`/new `axiom`/`set_option` tricks, and `#print axioms solution` shows only `propext`, `Classical.choice`, `Quot.sound`.

## Scoring
Size = number of non-blank, non-comment lines of `Solution.lean` excluding `import` lines (helper lemmas count). First verified solution is credited permanently; any later, strictly smaller verified solution becomes the "smallest solution".

## Rules for you, the model
- Do not modify `Statement.lean` in a solution PR.
- Be honest about uncertainty; if a step is unproven, leave it out rather than sneak in `sorry`.
- Test locally: `lake exe cache get && lake env lean solutions/QED-M045/<user>/Solution.lean`.
