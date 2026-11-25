# QED-E087 — From density to Kolmogorov typicality of positive entropy in symplectic families

You are an AI model helping someone attack this open problem. Read all of this before working.

## The problem
Extended set · Grade B · QED Extension · Dynamics

**Plain words:** Berger and Turaev showed that families of area-preserving surface maps having positive metric entropy at every parameter are dense among smooth families. Show this is typical, i.e. holds for a Kolmogorov-generic (prevalent) set of families, or find a robust obstruction.

**Math:** Take Σ = 𝕋² = ℝ²/ℤ² with the standard area form. For k ≥ 1 let 𝓕_k be the space of C^∞ families (f_p)_{p∈[0,1]^k} of symplectic diffeomorphisms of 𝕋² such that every f_p has an elliptic periodic point, with the C^∞ topology on (p,x) ↦ f_p(x), and 𝓕_+ = {families with h_Leb(f_p) > 0 for Lebesgue-a.e. p}. Prove or disprove: for every k ≥ 1, 𝓕_+ contains a countable intersection of open subsets dense in 𝓕_k (Kolmogorov typicality in the sense of Berger–Turaev). ¬Claim: for some k, 𝓕_+ contains no residual subset of 𝓕_k.

**Credit:** P. Berger and D. Turaev, arXiv:2507.11375 (2025), Thm B; P. Berger, arXiv:2003.09329 (Kolmogorov typicality / emergence).

**Rests on recent unrefereed work. Check these premises first:**
- arXiv:2507.11375 (Berger-Turaev, 2025 preprint, refereeing status unverified): the problem assumes its Thm B (density of families with positive metric entropy at every parameter) and borrows its definition of Kolmogorov typicality.

**References:**
- https://arxiv.org/abs/2507.11375
- https://arxiv.org/abs/2003.09329

Difficulty estimate: 4.5/10 (calibrated: Collatz ≈ 5.5, twin primes ≈ 5.0). It is believed open; do not assume a quick answer exists, and say so plainly if you cannot make progress. Never present a heuristic, numerical evidence, or a partial result as a solution.

## What counts as an answer
Either a proof of `OpenProblems.QEDE087.Claim` or a proof of `¬ OpenProblems.QEDE087.Claim` (a disproof), in Lean 4 + Mathlib, using the exact statement in `problems/QED-E087/Statement.lean`. Read its "Formalization notes" first. If that file still says `def Claim : Prop := sorry`, the problem must first be formalized (see CONTRIBUTING.md); a faithful formalization is itself a welcome contribution.

If you think the Lean statement does not match the informal problem (it is trivially true or false, or it says something else), report that in an issue instead of exploiting it: such solutions are not credited.

## How to submit
1. Claim it (optional but encouraged): open an issue titled `Claim QED-E087` at https://github.com/floration/qed/issues/new?template=claim.yml. Comment on it at least once a week or the claim lapses.
2. Add `solutions/QED-E087/<github-username>/Solution.lean`:
```lean
import Mathlib
-- do NOT redefine Claim: CI prepends problems/QED-E087/Statement.lean to your file
theorem solution : OpenProblems.QEDE087.Claim := by   -- or ¬ OpenProblems.QEDE087.Claim
  ...
```
3. Add `solutions/QED-E087/<github-username>/meta.json`: `{"model": "<AI model used, or none>", "kind": "proof" | "disproof"}`. Optionally a `README.md` explaining the idea.
4. Open a pull request. CI checks: it compiles, no `sorry`/`admit`/new `axiom`/`set_option` tricks, and `#print axioms solution` shows only `propext`, `Classical.choice`, `Quot.sound`.

## Scoring
Size = number of non-blank, non-comment lines of `Solution.lean` excluding `import` lines (helper lemmas count). First verified solution is credited permanently; any later, strictly smaller verified solution becomes the "smallest solution".

## Rules for you, the model
- Do not modify `Statement.lean` in a solution PR.
- Be honest about uncertainty; if a step is unproven, leave it out rather than sneak in `sorry`.
- Test locally: `lake exe cache get && lake env lean solutions/QED-E087/<user>/Solution.lean`.
