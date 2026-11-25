# QED-M002 — Minimal degree of a Jacobian counterexample

You are an AI model helping someone attack this open problem. Read all of this before working.

## The problem
Main set · Grade B · QED Extension · Algebra · formerly N-553

**Plain words:** The 2026 counterexamples to the Jacobian conjecture in three variables have degree 7 at best (Alpöge's map has component degrees 7,6,4). Wang's theorem says degree 2 is impossible. Find the smallest degree a three-variable counterexample can have: some number from 3 to 7.

**Math:** Call F ∈ C[x,y,z]^3 a Keller map if det JF ∈ C^×, and let deg F = max_i deg F_i. Prove or disprove: every Keller map F : C^3 → C^3 with deg F <= 3 is injective (equivalently, by Białynicki-Birula-Rosenlicht and the Keller condition, a polynomial automorphism); i.e. d_3 >= 4. (Known: 3 <= d_3 <= 7, where d_3 is the least degree of a non-injective Keller map of C^3.)

**Credit:** Jacobian conjecture (Keller 1939); degree 2: Wang 1980; 2026 counterexamples: arXiv:2608.00222, arXiv:2609.17795, arXiv:2607.22198, arXiv:2607.18186 (Alpöge, van den Essen et al.)

**Rests on recent unrefereed work. Check these premises first:**
- arXiv:2608.00222, arXiv:2609.17795, arXiv:2607.22198, arXiv:2607.18186 (2026 preprints, unrefereed; one has an Isabelle AFP formalization): existence of non-injective Keller maps of C^3 of degree 7, i.e. the upper bound d_3 <= 7 and the claim that the Jacobian conjecture fails in dimension 3. Claim (cubic case) does not logically depend on them.

**References:**
- https://en.wikipedia.org/wiki/Jacobian_conjecture
- https://arxiv.org/pdf/2608.00222
- https://arxiv.org/pdf/2609.17795
- https://arxiv.org/pdf/2607.22198
- https://isa-afp.org/entries/Jacobian_Counterexample.html
- https://arxiv.org/pdf/2607.18186

Difficulty estimate: 3.5/10 (calibrated: Collatz ≈ 5.5, twin primes ≈ 5.0). It is believed open; do not assume a quick answer exists, and say so plainly if you cannot make progress. Never present a heuristic, numerical evidence, or a partial result as a solution.

## What counts as an answer
Either a proof of `OpenProblems.QEDM002.Claim` or a proof of `¬ OpenProblems.QEDM002.Claim` (a disproof), in Lean 4 + Mathlib, using the exact statement in `problems/QED-M002/Statement.lean`. Read its "Formalization notes" first. If that file still says `def Claim : Prop := sorry`, the problem must first be formalized (see CONTRIBUTING.md); a faithful formalization is itself a welcome contribution.

If you think the Lean statement does not match the informal problem (it is trivially true or false, or it says something else), report that in an issue instead of exploiting it: such solutions are not credited.

## How to submit
1. Claim it (optional but encouraged): open an issue titled `Claim QED-M002` at https://github.com/floration/qed/issues/new?template=claim.yml. Comment on it at least once a week or the claim lapses.
2. Add `solutions/QED-M002/<github-username>/Solution.lean`:
```lean
import Mathlib
-- do NOT redefine Claim: CI prepends problems/QED-M002/Statement.lean to your file
theorem solution : OpenProblems.QEDM002.Claim := by   -- or ¬ OpenProblems.QEDM002.Claim
  ...
```
3. Add `solutions/QED-M002/<github-username>/meta.json`: `{"model": "<AI model used, or none>", "kind": "proof" | "disproof"}`. Optionally a `README.md` explaining the idea.
4. Open a pull request. CI checks: it compiles, no `sorry`/`admit`/new `axiom`/`set_option` tricks, and `#print axioms solution` shows only `propext`, `Classical.choice`, `Quot.sound`.

## Scoring
Size = number of non-blank, non-comment lines of `Solution.lean` excluding `import` lines (helper lemmas count). First verified solution is credited permanently; any later, strictly smaller verified solution becomes the "smallest solution".

## Rules for you, the model
- Do not modify `Statement.lean` in a solution PR.
- Be honest about uncertainty; if a step is unproven, leave it out rather than sneak in `sorry`.
- Test locally: `lake exe cache get && lake env lean solutions/QED-M002/<user>/Solution.lean`.
