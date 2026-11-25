# N-656 — Spikes at the squares

You are an AI model helping someone attack this open problem. Read all of this before working.

## The problem
Grade A · QED Extension · Mathematical physics

**Plain words:** On the half-line lattice, add a fixed spike of height λ at every perfect square. The free band (-2,2) then has no absolutely continuous spectrum, by Remling's theorem. Decide whether the spectrum inside the band is pure point (localized states) or singular continuous. A heuristic in the physics literature predicts singular continuous.

**Math:** Let $(Hu)(n)=u(n+1)+u(n-1)+\lambda\,\mathbf 1_{\{m^2:m\ge1\}}(n)\,u(n)$ on $\ell^2(\mathbb N)$, $u(0)=0$, $\lambda\ne0$ fixed, and let $\mu$ be the spectral measure of $\delta_1$. Determine the spectral type of $\mu|_{(-2,2)}$: is it pure point, purely singular continuous, or mixed? (Known: $\mu_{ac}=0$ by Remling's theorem. Cheon–Exner–Šeba heuristically predict purely singular continuous spectrum for the continuum analogue; positive Lyapunov exponents of the spike-to-spike cocycle suggest pure point.)

**Credit:** Cheon, Exner, Šeba (2000), arXiv:quant-ph/0004058 (continuum analogue with spikes at the squares).

**QED results so far (reviewer-derived; check before relying on them):** Correct with a caveat. The spike gaps are 2m+1, so the spike-to-spike map is C·R(k(2m+1)), a one-frequency analytic cocycle over rotation by 2k. Herman's subharmonicity gives L ≥ log|C_11| = log sqrt(1+λ²/(4sin²k)). This bounds the phase-averaged exponent only: at the fixed phase θ=k (coupled to the frequency) the limit is not guaranteed, so eigenfunction decay is heuristic.

**References:**
- https://arxiv.org/pdf/quant-ph/0004058
- https://ar5iv.labs.arxiv.org/html/2110.08684
- https://arxiv.org/pdf/math-ph/0210054
- https://arxiv.org/abs/quant-ph/0004058
- https://arxiv.org/abs/2110.08684
- https://arxiv.org/abs/2508.18599

Difficulty estimate: 4.5/10 (calibrated: Collatz ≈ 5.5, twin primes ≈ 5.0). It is believed open; do not assume a quick answer exists, and say so plainly if you cannot make progress. Never present a heuristic, numerical evidence, or a partial result as a solution.

## What counts as an answer
Either a proof of `OpenProblems.N656.Claim` or a proof of `¬ OpenProblems.N656.Claim` (a disproof), in Lean 4 + Mathlib, using the exact statement in `problems/N-656/Statement.lean`. Read its "Formalization notes" first. If that file still says `def Claim : Prop := sorry`, the problem must first be formalized (see CONTRIBUTING.md); a faithful formalization is itself a welcome contribution.

If you think the Lean statement does not match the informal problem (it is trivially true or false, or it says something else), report that in an issue instead of exploiting it: such solutions are not credited.

## How to submit
1. Claim it (optional but encouraged): open an issue titled `Claim N-656` at https://github.com/floration/qed/issues/new?template=claim.yml. Comment on it at least once a week or the claim lapses.
2. Add `solutions/N-656/<github-username>/Solution.lean`:
```lean
import Mathlib
-- do NOT redefine Claim: CI prepends problems/N-656/Statement.lean to your file
theorem solution : OpenProblems.N656.Claim := by   -- or ¬ OpenProblems.N656.Claim
  ...
```
3. Add `solutions/N-656/<github-username>/meta.json`: `{"model": "<AI model used, or none>", "kind": "proof" | "disproof"}`. Optionally a `README.md` explaining the idea.
4. Open a pull request. CI checks: it compiles, no `sorry`/`admit`/new `axiom`/`set_option` tricks, and `#print axioms solution` shows only `propext`, `Classical.choice`, `Quot.sound`.

## Scoring
Size = number of non-blank, non-comment lines of `Solution.lean` excluding `import` lines (helper lemmas count). First verified solution is credited permanently; any later, strictly smaller verified solution becomes the "smallest solution".

## Rules for you, the model
- Do not modify `Statement.lean` in a solution PR.
- Be honest about uncertainty; if a step is unproven, leave it out rather than sneak in `sorry`.
- Test locally: `lake exe cache get && lake env lean solutions/N-656/<user>/Solution.lean`.
