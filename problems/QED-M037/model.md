# QED-M037 — From S_2E to E^NP: near-maximum circuit lower bounds

You are an AI model helping someone attack this open problem. Read all of this before working.

## The problem
Main set · Grade B · QED Curated · Complexity

**Plain words:** Prove E^NP is not contained in SIZE[2^n/n] (or even SIZE[2^{epsilon n}] for some eps>0 infinitely often); equivalently, put Range Avoidance in FP^NP for the relevant circuit classes, improving Li's FS_2^P algorithm.

**Math:** Prove that for some ε > 0 there is L ∈ E^NP such that for infinitely many n, L ∩ {0,1}^n has no circuit of size 2^{εn} (stronger: for all large n). Related target (not claimed equivalent at this size): AVOID ∈ FP^NP, which by Korten (2021) implies E^NP ⊄ SIZE[2^n/n].

**Credit:** Korten (FOCS 2021); Chen, Hirahara, Ren (STOC 2024), arXiv:2309.12912; Li (STOC 2024), arXiv:2310.17762.

**Rests on recent unrefereed work. Check these premises first:**
- ECCC TR26-118 (Ren–Williams, Jul 2026, unrefereed): status claim that E^{prMA}/1 requires 2^n/n circuits; only affects the 'state of the art' summary, not the statement.
- arXiv:2605.03306 (Hitchcock, May 2026 preprint): comeagerness result in S₂E; context only.

**References:**
- Chen, Hirahara, Ren, Symmetric exponential time requires near-maximum circuit size, STOC 2024, arXiv:2309.12912
- Li, Symmetric exponential time requires near-maximum circuit size: simplified, truly uniform, STOC 2024, arXiv:2310.17762
- Hitchcock, Exponential-size circuit complexity is comeager in symmetric exponential time, arXiv:2605.03306
- ECCC TR26-118 (Ren, Williams)
- arXiv:2605.03306
- arXiv:2309.12912
- arXiv:2310.17762

Difficulty estimate: 7.0/10 (calibrated: Collatz ≈ 5.5, twin primes ≈ 5.0). It is believed open; do not assume a quick answer exists, and say so plainly if you cannot make progress. Never present a heuristic, numerical evidence, or a partial result as a solution.

## What counts as an answer
Either a proof of `OpenProblems.QEDM037.Claim` or a proof of `¬ OpenProblems.QEDM037.Claim` (a disproof), in Lean 4 + Mathlib, using the exact statement in `problems/QED-M037/Statement.lean`. Read its "Formalization notes" first. If that file still says `def Claim : Prop := sorry`, the problem must first be formalized (see CONTRIBUTING.md); a faithful formalization is itself a welcome contribution.

If you think the Lean statement does not match the informal problem (it is trivially true or false, or it says something else), report that in an issue instead of exploiting it: such solutions are not credited.

## How to submit
1. Claim it (optional but encouraged): open an issue titled `Claim QED-M037` at https://github.com/floration/qed/issues/new?template=claim.yml. Comment on it at least once a week or the claim lapses.
2. Add `solutions/QED-M037/<github-username>/Solution.lean`:
```lean
import Mathlib
-- do NOT redefine Claim: CI prepends problems/QED-M037/Statement.lean to your file
theorem solution : OpenProblems.QEDM037.Claim := by   -- or ¬ OpenProblems.QEDM037.Claim
  ...
```
   Large proofs may add more `.lean` files (subfolders allowed) next to Solution.lean; CI concatenates them in path order before Solution.lean. Don't import them.
3. Add `solutions/QED-M037/<github-username>/meta.json`: `{"model": "<AI model used, or none>", "kind": "proof" | "disproof"}`. Optionally a `README.md` explaining the idea.
4. Open a pull request. CI checks: it compiles, no `sorry`/`admit`/new `axiom`/`set_option` tricks, and `#print axioms solution` shows only `propext`, `Classical.choice`, `Quot.sound`.

## Scoring
Size = number of non-blank, non-comment lines of `Solution.lean` excluding `import` lines (helper lemmas count). First verified solution is credited permanently; any later, strictly smaller verified solution becomes the "smallest solution".

## Rules for you, the model
- Do not modify `Statement.lean` in a solution PR.
- Be honest about uncertainty; if a step is unproven, leave it out rather than sneak in `sorry`.
- Test locally: `lake exe cache get && lake env lean solutions/QED-M037/<user>/Solution.lean`.
