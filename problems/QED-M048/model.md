# QED-M048 — From density to Kolmogorov typicality of positive entropy in symplectic families

You are an AI model helping someone attack this open problem. Read all of this before working.

## The problem
Main set · Grade B · QED Extension · Dynamics · formerly N-710

**Plain words:** Berger and Turaev showed that families of area-preserving surface maps having positive metric entropy at every parameter are dense among smooth families. Show this is typical, i.e. holds for a Kolmogorov-generic (prevalent) set of families, or find a robust obstruction.

**Math:** Fix a compact surface Σ with area form ω and k ≥ 1. Let F be the space of C^∞ families (f_p)_{p∈[0,1]^k} of ω-preserving diffeomorphisms of Σ (C^∞ topology on (p,x) ↦ f_p(x)) such that f_p has an elliptic periodic point for every p, and let F_+ = {families with h_Leb(f_p) > 0 for Lebesgue-a.e. p}. Prove or disprove: F_+ contains a Baire-generic (countable intersection of open dense) subset of an open set U ⊂ F on which Berger-Turaev's density theorem applies; equivalently disprove by exhibiting a nonempty open U ⊂ F such that for every family in a dense subset of U, {p : h_Leb(f_p) = 0} has positive Lebesgue measure. (Here 'Kolmogorov typical' must be replaced by the exact notion in Berger-Turaev, arXiv:2507.11375, if it differs from Baire genericity in the family space.)

**Credit:** P. Berger and D. Turaev, arXiv:2507.11375 (2025), Thm B; P. Berger, arXiv:2003.09329 (Kolmogorov typicality / emergence).

**Rests on recent unrefereed work. Check these premises first:**
- arXiv:2507.11375 (Berger-Turaev, 2025 preprint, refereeing status unverified): the problem assumes its Thm B (density of families with positive metric entropy at every parameter) and borrows its definition of Kolmogorov typicality.

**References:**
- https://arxiv.org/abs/2507.11375
- https://arxiv.org/abs/2003.09329

Difficulty estimate: 4.5/10 (calibrated: Collatz ≈ 5.5, twin primes ≈ 5.0). It is believed open; do not assume a quick answer exists, and say so plainly if you cannot make progress. Never present a heuristic, numerical evidence, or a partial result as a solution.

## What counts as an answer
Either a proof of `OpenProblems.QEDM048.Claim` or a proof of `¬ OpenProblems.QEDM048.Claim` (a disproof), in Lean 4 + Mathlib, using the exact statement in `problems/QED-M048/Statement.lean`. Read its "Formalization notes" first. If that file still says `def Claim : Prop := sorry`, the problem must first be formalized (see CONTRIBUTING.md); a faithful formalization is itself a welcome contribution. What is missing: Not formalized: needs C^∞ family spaces of symplectic surface diffeomorphisms, Kolmogorov-Sinai entropy, and the Berger-Turaev typicality notion. The M_fix's genericity notion should be verified against arXiv:2507.11375 before use.

If you think the Lean statement does not match the informal problem (it is trivially true or false, or it says something else), report that in an issue instead of exploiting it: such solutions are not credited.

## How to submit
1. Claim it (optional but encouraged): open an issue titled `Claim QED-M048` at https://github.com/floration/qed/issues/new?template=claim.yml. Comment on it at least once a week or the claim lapses.
2. Add `solutions/QED-M048/<github-username>/Solution.lean`:
```lean
import Mathlib
-- do NOT redefine Claim: CI prepends problems/QED-M048/Statement.lean to your file
theorem solution : OpenProblems.QEDM048.Claim := by   -- or ¬ OpenProblems.QEDM048.Claim
  ...
```
3. Add `solutions/QED-M048/<github-username>/meta.json`: `{"model": "<AI model used, or none>", "kind": "proof" | "disproof"}`. Optionally a `README.md` explaining the idea.
4. Open a pull request. CI checks: it compiles, no `sorry`/`admit`/new `axiom`/`set_option` tricks, and `#print axioms solution` shows only `propext`, `Classical.choice`, `Quot.sound`.

## Scoring
Size = number of non-blank, non-comment lines of `Solution.lean` excluding `import` lines (helper lemmas count). First verified solution is credited permanently; any later, strictly smaller verified solution becomes the "smallest solution".

## Rules for you, the model
- Do not modify `Statement.lean` in a solution PR.
- Be honest about uncertainty; if a step is unproven, leave it out rather than sneak in `sorry`.
- Test locally: `lake exe cache get && lake env lean solutions/QED-M048/<user>/Solution.lean`.
