# QED-M071 — Hat Ising universality

You are an AI model helping someone attack this open problem. Read all of this before working.

## The problem
Main set · Grade B · QED Extension · Mathematical physics · formerly N-344

**Plain words:** Magnets on a hat tiling should behave at their critical point exactly like magnets on a square grid. Prove it.

**Math:** Let G be the tile-adjacency graph of a hat tiling T in the hull. Prove: there is β_c ∈ (0,∞), the same for all T in the hull, such that (a) for β > β_c the plus-state magnetization at a tile satisfies c(β−β_c)^{1/8} ≤ M_T(β) ≤ C(β−β_c)^{1/8} uniformly in the tile, and M_T(β) = 0 for β ≤ β_c; (b) for β < β_c the susceptibility χ(β) = sup over tiles x of Σ_y ⟨σ_xσ_y⟩_β satisfies χ(β) ≍ (β_c−β)^{−7/4}; (c) for β < β_c the correlation length ξ(β), defined by −lim inf_{|x−y|→∞} log⟨σ_xσ_y⟩/|x−y| = 1/ξ, satisfies ξ(β) ≍ (β_c−β)^{−1}; all for β in a neighbourhood of β_c.

**Credit:** Hat tiling: Smith, Myers, Kaplan, Goodman-Strauss (2023); numerics on hat-tiling Ising models as cited in the notes (arXiv:2402.11331, arXiv:2307.11054); background: Chelkak-Smirnov universality on isoradial graphs.

**References:**
- https://arxiv.org/abs/2402.11331
- https://arxiv.org/pdf/2307.11054

Difficulty estimate: 4.0/10 (calibrated: Collatz ≈ 5.5, twin primes ≈ 5.0). It is believed open; do not assume a quick answer exists, and say so plainly if you cannot make progress. Never present a heuristic, numerical evidence, or a partial result as a solution.

## What counts as an answer
Either a proof of `OpenProblems.QEDM071.Claim` or a proof of `¬ OpenProblems.QEDM071.Claim` (a disproof), in Lean 4 + Mathlib, using the exact statement in `problems/QED-M071/Statement.lean`. Read its "Formalization notes" first. If that file still says `def Claim : Prop := sorry`, the problem must first be formalized (see CONTRIBUTING.md); a faithful formalization is itself a welcome contribution. What is missing: Not formalized: needs hat tiling construction, infinite-volume Ising Gibbs states, and definitions of M, χ, ξ.

If you think the Lean statement does not match the informal problem (it is trivially true or false, or it says something else), report that in an issue instead of exploiting it: such solutions are not credited.

## How to submit
1. Claim it (optional but encouraged): open an issue titled `Claim QED-M071` at https://github.com/floration/qed/issues/new?template=claim.yml. Comment on it at least once a week or the claim lapses.
2. Add `solutions/QED-M071/<github-username>/Solution.lean`:
```lean
import Mathlib
-- do NOT redefine Claim: CI prepends problems/QED-M071/Statement.lean to your file
theorem solution : OpenProblems.QEDM071.Claim := by   -- or ¬ OpenProblems.QEDM071.Claim
  ...
```
3. Add `solutions/QED-M071/<github-username>/meta.json`: `{"model": "<AI model used, or none>", "kind": "proof" | "disproof"}`. Optionally a `README.md` explaining the idea.
4. Open a pull request. CI checks: it compiles, no `sorry`/`admit`/new `axiom`/`set_option` tricks, and `#print axioms solution` shows only `propext`, `Classical.choice`, `Quot.sound`.

## Scoring
Size = number of non-blank, non-comment lines of `Solution.lean` excluding `import` lines (helper lemmas count). First verified solution is credited permanently; any later, strictly smaller verified solution becomes the "smallest solution".

## Rules for you, the model
- Do not modify `Statement.lean` in a solution PR.
- Be honest about uncertainty; if a step is unproven, leave it out rather than sneak in `sorry`.
- Test locally: `lake exe cache get && lake env lean solutions/QED-M071/<user>/Solution.lean`.
