# QED-M077 — Do GRH and Elliott–Halberstam together refute the Alternative Hypothesis?

You are an AI model helping someone attack this open problem. Read all of this before working.

## The problem
Main set · Grade B · QED Extension · Number theory

**Plain words:** The Alternative Hypothesis says normalized gaps between zeta zeros are almost all near half-integers. It contradicts GUE, but no proven hypothesis is known to rule it out. Decide whether GRH plus Elliott–Halberstam (strong statements about primes, not zeros) is incompatible with it.

**Math:** Let AH be as in arXiv:2508.10857. Does RH + GRH for Dirichlet L-functions + the Elliott–Halberstam conjecture (or GEH) imply that AH fails? (The 'equivalently' clause is a research route, not an equivalent statement, and is dropped.)

**Credit:** Baluyot, Goldston, Suriajaya, Turnage-Butterbaugh, The Alternative Hypothesis for zeros of the Riemann zeta-function, arXiv:2508.10857 (2025); Goldston et al., arXiv:2507.06823; Lagarias–Rodgers arXiv:1905.12123.

**Rests on recent unrefereed work. Check these premises first:**
- arXiv:2508.10857 (2025 preprint, unrefereed as far as known): the problem takes its precise definition of AH, and the claimed explicit limit of F(α) under RH + AH, from this paper.
- arXiv:2507.06823 (2025 preprint): background on F(α) under AH.

**References:**
- https://arxiv.org/abs/1905.12123
- https://arxiv.org/abs/2508.10857
- https://arxiv.org/abs/2507.06823

Difficulty estimate: 5.0/10 (calibrated: Collatz ≈ 5.5, twin primes ≈ 5.0). It is believed open; do not assume a quick answer exists, and say so plainly if you cannot make progress. Never present a heuristic, numerical evidence, or a partial result as a solution.

## What counts as an answer
Either a proof of `OpenProblems.QEDM077.Claim` or a proof of `¬ OpenProblems.QEDM077.Claim` (a disproof), in Lean 4 + Mathlib, using the exact statement in `problems/QED-M077/Statement.lean`. Read its "Formalization notes" first. If that file still says `def Claim : Prop := sorry`, the problem must first be formalized (see CONTRIBUTING.md); a faithful formalization is itself a welcome contribution. What is missing: Not formalized: needs zeta-zero enumeration, pair correlation, EH.

If you think the Lean statement does not match the informal problem (it is trivially true or false, or it says something else), report that in an issue instead of exploiting it: such solutions are not credited.

## How to submit
1. Claim it (optional but encouraged): open an issue titled `Claim QED-M077` at https://github.com/floration/qed/issues/new?template=claim.yml. Comment on it at least once a week or the claim lapses.
2. Add `solutions/QED-M077/<github-username>/Solution.lean`:
```lean
import Mathlib
-- do NOT redefine Claim: CI prepends problems/QED-M077/Statement.lean to your file
theorem solution : OpenProblems.QEDM077.Claim := by   -- or ¬ OpenProblems.QEDM077.Claim
  ...
```
   Large proofs may add more `.lean` files (subfolders allowed) next to Solution.lean; CI concatenates them in path order before Solution.lean. Don't import them.
3. Add `solutions/QED-M077/<github-username>/meta.json`: `{"model": "<AI model used, or none>", "kind": "proof" | "disproof"}`. Optionally a `README.md` explaining the idea.
4. Open a pull request. CI checks: it compiles, no `sorry`/`admit`/new `axiom`/`set_option` tricks, and `#print axioms solution` shows only `propext`, `Classical.choice`, `Quot.sound`.

## Scoring
Size = number of non-blank, non-comment lines of `Solution.lean` excluding `import` lines (helper lemmas count). First verified solution is credited permanently; any later, strictly smaller verified solution becomes the "smallest solution".

## Rules for you, the model
- Do not modify `Statement.lean` in a solution PR.
- Be honest about uncertainty; if a step is unproven, leave it out rather than sneak in `sorry`.
- Test locally: `lake exe cache get && lake env lean solutions/QED-M077/<user>/Solution.lean`.
