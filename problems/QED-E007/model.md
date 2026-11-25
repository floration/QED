# QED-E007 — Frozen vortices for Kuramoto on a cube

You are an AI model helping someone attack this open problem. Read all of this before working.

## The problem
Extended set · Grade C · Dynamics

**Plain words:** Identical Kuramoto oscillators sit on the grid of a cube's surface. Besides full synchrony, there is a 'longitude' state with a vortex at the centre of the top face and an antivortex at the centre of the bottom face. Prove that this state is a linearly stable equilibrium for every grid size.

**Math:** Let $Q_n$ be the vertex–edge graph of the $n\times n$ subdivided surface of the cube, and $\dot\theta_i=\sum_{j\sim i}\sin(\theta_j-\theta_i)$. Prove that for every odd $n\ge3$ there is an equilibrium $\theta^*$ with the cube's 4-fold rotational symmetry about the vertical axis and winding number $\pm1$ around the central plaquettes of the top and bottom faces, whose Jacobian (the Laplacian with edge weights $\cos(\theta^*_j-\theta^*_i)$) has kernel exactly $\mathrm{span}(\mathbf 1)$ and is otherwise positive. (More generally: for which $n$ does $Q_n$ have a stable non-synchronous equilibrium?)

**Reviewer note:** T

**References:**
- https://arxiv.org/abs/1609.02359v2
- https://arxiv.org/pdf/1512.04266
- https://arxiv.org/pdf/2207.08182

Difficulty estimate: 2.5/10 (calibrated: Collatz ≈ 5.5, twin primes ≈ 5.0). It is believed open; do not assume a quick answer exists, and say so plainly if you cannot make progress. Never present a heuristic, numerical evidence, or a partial result as a solution.

## What counts as an answer
Either a proof of `OpenProblems.QEDE007.Claim` or a proof of `¬ OpenProblems.QEDE007.Claim` (a disproof), in Lean 4 + Mathlib, using the exact statement in `problems/QED-E007/Statement.lean`. Read its "Formalization notes" first. If that file still says `def Claim : Prop := sorry`, the problem must first be formalized (see CONTRIBUTING.md); a faithful formalization is itself a welcome contribution.

If you think the Lean statement does not match the informal problem (it is trivially true or false, or it says something else), report that in an issue instead of exploiting it: such solutions are not credited.

## How to submit
0. First time? Solve a test problem (QED-Q1, the 2-line one, at minimum) and submit it, to confirm your Lean setup and the submission pipeline work before spending effort here. Skip this step if this IS a test problem.
1. Claim it (optional but encouraged): open an issue titled `Claim QED-E007` at https://github.com/floration/qed/issues/new?template=claim.yml. Comment on it at least once a week or the claim lapses.
2. Add `solutions/QED-E007/<github-username>/Solution.lean`:
```lean
import Mathlib
-- do NOT redefine Claim: CI prepends problems/QED-E007/Statement.lean to your file
theorem solution : OpenProblems.QEDE007.Claim := by   -- or ¬ OpenProblems.QEDE007.Claim
  ...
```
3. Add `solutions/QED-E007/<github-username>/meta.json`: `{"model": "<AI model used, or none>", "kind": "proof" | "disproof"}`. Optionally a `README.md` explaining the idea.
4. Open a pull request. CI checks: it compiles, no `sorry`/`admit`/new `axiom`/`set_option` tricks, and `#print axioms solution` shows only `propext`, `Classical.choice`, `Quot.sound`.

## Scoring
Size = number of non-blank, non-comment lines of `Solution.lean` excluding `import` lines (helper lemmas count). First verified solution is credited permanently; any later, strictly smaller verified solution becomes the "smallest solution".

## Rules for you, the model
- Do not modify `Statement.lean` in a solution PR.
- Be honest about uncertainty; if a step is unproven, leave it out rather than sneak in `sorry`.
- Test locally: `lake exe cache get && lake env lean solutions/QED-E007/<user>/Solution.lean`.
