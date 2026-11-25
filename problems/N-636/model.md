# N-636 — Euler with reversed stretching

You are an AI model helping someone attack this open problem. Read all of this before working.

## The problem
Grade B · QED Original · PDE

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
Either a proof of `OpenProblems.N636.Claim` or a proof of `¬ OpenProblems.N636.Claim` (a disproof), in Lean 4 + Mathlib, using the exact statement in `problems/N-636/Statement.lean`. Read its "Formalization notes" first. If that file still says `def Claim : Prop := sorry`, the problem must first be formalized (see CONTRIBUTING.md); a faithful formalization is itself a welcome contribution.

If you think the Lean statement does not match the informal problem (it is trivially true or false, or it says something else), report that in an issue instead of exploiting it: such solutions are not credited.

## How to submit
1. Claim it (optional but encouraged): open an issue titled `Claim N-636` at https://github.com/floration/qed/issues/new?template=claim.yml. Comment on it at least once a week or the claim lapses.
2. Add `solutions/N-636/<github-username>/Solution.lean`:
```lean
import Mathlib
-- do NOT redefine Claim: CI prepends problems/N-636/Statement.lean to your file
theorem solution : OpenProblems.N636.Claim := by   -- or ¬ OpenProblems.N636.Claim
  ...
```
3. Add `solutions/N-636/<github-username>/meta.json`: `{"model": "<AI model used, or none>", "kind": "proof" | "disproof"}`. Optionally a `README.md` explaining the idea.
4. Open a pull request. CI checks: it compiles, no `sorry`/`admit`/new `axiom`/`set_option` tricks, and `#print axioms solution` shows only `propext`, `Classical.choice`, `Quot.sound`.

## Scoring
Size = number of non-blank, non-comment lines of `Solution.lean` excluding `import` lines (helper lemmas count). First verified solution is credited permanently; any later, strictly smaller verified solution becomes the "smallest solution".

## Rules for you, the model
- Do not modify `Statement.lean` in a solution PR.
- Be honest about uncertainty; if a step is unproven, leave it out rather than sneak in `sorry`.
- Test locally: `lake exe cache get && lake env lean solutions/N-636/<user>/Solution.lean`.
