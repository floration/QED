# QED-E096 — Hat Ising universality

You are an AI model helping someone attack this open problem. Read all of this before working.

## The problem
Extended set · Grade B · QED Extension · Mathematical physics

**Plain words:** Magnets on a hat tiling should behave at their critical point exactly like magnets on a square grid. Prove it.

**Math:** Let T be any hat tiling (tiling of ℂ by isometric copies, reflections allowed, of the Smith–Myers–Kaplan–Goodman-Strauss hat; all such tilings form the hull) and G its tile-adjacency graph (tiles sharing a boundary segment), with the J=1 ferromagnetic Ising model. Prove: there is β_c ∈ (0,∞), the same for all T, such that, with constants c, C, δ > 0 depending only on T: (a) the plus-state magnetization M_T(β,x) = 0 for all tiles x and 0 ≤ β ≤ β_c, and c(β−β_c)^{1/8} ≤ M_T(β,x) ≤ C(β−β_c)^{1/8} uniformly in x for β_c < β < β_c+δ; (b) for β_c−δ < β < β_c, χ_T(β) = sup_x Σ_y ⟨σ_xσ_y⟩_β satisfies c(β_c−β)^{−7/4} ≤ χ_T(β) ≤ C(β_c−β)^{−7/4}; (c) for β_c−δ < β < β_c, the inverse correlation length 1/ξ_T(β) = liminf_{|x−y|→∞} (−log⟨σ_xσ_y⟩_β/|x−y|) satisfies c(β_c−β) ≤ 1/ξ_T(β) ≤ C(β_c−β).

**Credit:** Hat tiling: Smith, Myers, Kaplan, Goodman-Strauss (2023); numerics on hat-tiling Ising models as cited in the notes (arXiv:2402.11331, arXiv:2307.11054); background: Chelkak-Smirnov universality on isoradial graphs.

**References:**
- https://arxiv.org/abs/2402.11331
- https://arxiv.org/pdf/2307.11054

Difficulty estimate: 4.0/10 (calibrated: Collatz ≈ 5.5, twin primes ≈ 5.0). It is believed open; do not assume a quick answer exists, and say so plainly if you cannot make progress. Never present a heuristic, numerical evidence, or a partial result as a solution.

## What counts as an answer
Either a proof of `OpenProblems.QEDE096.Claim` or a proof of `¬ OpenProblems.QEDE096.Claim` (a disproof), in Lean 4 + Mathlib, using the exact statement in `problems/QED-E096/Statement.lean`. Read its "Formalization notes" first. If that file still says `def Claim : Prop := sorry`, the problem must first be formalized (see CONTRIBUTING.md); a faithful formalization is itself a welcome contribution.

If you think the Lean statement does not match the informal problem (it is trivially true or false, or it says something else), report that in an issue instead of exploiting it: such solutions are not credited.

## How to submit
1. Claim it (optional but encouraged): open an issue titled `Claim QED-E096` at https://github.com/floration/qed/issues/new?template=claim.yml. Comment on it at least once a week or the claim lapses.
2. Add `solutions/QED-E096/<github-username>/Solution.lean`:
```lean
import Mathlib
-- do NOT redefine Claim: CI prepends problems/QED-E096/Statement.lean to your file
theorem solution : OpenProblems.QEDE096.Claim := by   -- or ¬ OpenProblems.QEDE096.Claim
  ...
```
3. Add `solutions/QED-E096/<github-username>/meta.json`: `{"model": "<AI model used, or none>", "kind": "proof" | "disproof"}`. Optionally a `README.md` explaining the idea.
4. Open a pull request. CI checks: it compiles, no `sorry`/`admit`/new `axiom`/`set_option` tricks, and `#print axioms solution` shows only `propext`, `Classical.choice`, `Quot.sound`.

## Scoring
Size = number of non-blank, non-comment lines of `Solution.lean` excluding `import` lines (helper lemmas count). First verified solution is credited permanently; any later, strictly smaller verified solution becomes the "smallest solution".

## Rules for you, the model
- Do not modify `Statement.lean` in a solution PR.
- Be honest about uncertainty; if a step is unproven, leave it out rather than sneak in `sorry`.
- Test locally: `lake exe cache get && lake env lean solutions/QED-E096/<user>/Solution.lean`.
