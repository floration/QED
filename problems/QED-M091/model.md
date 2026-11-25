# QED-M091 — Euler with reversed stretching

You are an AI model helping someone attack this open problem. Read all of this before working.

## The problem
Main set · Grade B · QED Original · PDE

**Plain words:** Flip the sign of the vortex-stretching term in the 3D Euler vorticity equation and keep advection and the Biot-Savart law. Do smooth solutions stay smooth forever, or can they blow up in finite time?

**Math:** On $\mathbb T^3$ let $\omega:\mathbb T^3\times[0,T)\to\mathbb R^3$ solve $\partial_t\omega+(u\cdot\nabla)\omega=-S\omega$, where $u=\nabla\times(-\Delta)^{-1}(\omega-\langle\omega\rangle)$, $S=\tfrac12(\nabla u+\nabla u^{T})$ and $\langle\omega\rangle$ is the spatial mean. Decide whether every $\omega_0\in C^\infty(\mathbb T^3;\mathbb R^3)$ with $\nabla\cdot\omega_0=0$ generates a global smooth solution.

**Rests on recent unrefereed work. Check these premises first:**
- arXiv:2602.13963 (2026 preprint, cited in refs): background on 1D/sign-of-stretching models only; the statement does not depend on it.

**References:**
- https://arxiv.org/abs/1701.04050
- https://arxiv.org/abs/1905.06387
- https://arxiv.org/abs/1203.5151
- https://arxiv.org/pdf/2602.13963

Difficulty estimate: 5.0/10 (calibrated: Collatz ≈ 5.5, twin primes ≈ 5.0). It is believed open; do not assume a quick answer exists, and say so plainly if you cannot make progress. Never present a heuristic, numerical evidence, or a partial result as a solution.

## What counts as an answer
Either a proof of `OpenProblems.QEDM091.Claim` or a proof of `¬ OpenProblems.QEDM091.Claim` (a disproof), in Lean 4 + Mathlib, using the exact statement in `problems/QED-M091/Statement.lean`. Read its "Formalization notes" first. If that file still says `def Claim : Prop := sorry`, the problem must first be formalized (see CONTRIBUTING.md); a faithful formalization is itself a welcome contribution.

If you think the Lean statement does not match the informal problem (it is trivially true or false, or it says something else), report that in an issue instead of exploiting it: such solutions are not credited.

## How to submit
0. First time? Solve a test problem (QED-Q1, the 2-line one, at minimum) and submit it, to confirm your Lean setup and the submission pipeline work before spending effort here. Skip this step if this IS a test problem.
1. Claim it (optional but encouraged): open an issue titled `Claim QED-M091` at https://github.com/floration/qed/issues/new?template=claim.yml. Comment on it at least once a week or the claim lapses.
2. Add `solutions/QED-M091/<github-username>/Solution.lean`:
```lean
import Mathlib
-- do NOT redefine Claim: CI prepends problems/QED-M091/Statement.lean to your file
theorem solution : OpenProblems.QEDM091.Claim := by   -- or ¬ OpenProblems.QEDM091.Claim
  ...
```
3. Add `solutions/QED-M091/<github-username>/meta.json`: `{"model": "<AI model used, or none>", "kind": "proof" | "disproof"}`. Optionally a `README.md` explaining the idea.
4. Open a pull request. CI checks: it compiles, no `sorry`/`admit`/new `axiom`/`set_option` tricks, and `#print axioms solution` shows only `propext`, `Classical.choice`, `Quot.sound`.

## Scoring
Size = number of non-blank, non-comment lines of `Solution.lean` excluding `import` lines (helper lemmas count). First verified solution is credited permanently; any later, strictly smaller verified solution becomes the "smallest solution".

## Rules for you, the model
- Do not modify `Statement.lean` in a solution PR.
- Be honest about uncertainty; if a step is unproven, leave it out rather than sneak in `sorry`.
- Test locally: `lake exe cache get && lake env lean solutions/QED-M091/<user>/Solution.lean`.
