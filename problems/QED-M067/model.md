# QED-M067 — Ringel for forests

You are an AI model helping someone attack this open problem. Read all of this before working.

## The problem
Main set · Grade B · QED Extension · Graph theory

**Plain words:** Ringel's conjecture, now a theorem for large n, says the complete graph on 2m+1 vertices splits into 2m+1 copies of any tree with m edges. Show the same holds for every forest with m edges. A stronger form asks that every such forest have a rho-labelling, which gives a cyclic decomposition.

**Math:** Prove that for every m ≥ 1 and every forest F with m edges and no isolated vertices, E(K_{2m+1}) can be partitioned into 2m+1 subgraphs each isomorphic to F. Stronger form: every such F admits a ρ-labelling.

**Credit:** Ringel (1963); Montgomery-Pokrovskiy-Sudakov (arXiv:2001.02665); Keevash-Staden (arXiv:2004.09947); Barrientos-Minion, EJGTA 4(2) 2016 (ρ-labelled forests)

**References:**
- https://arxiv.org/abs/2001.02665
- https://arxiv.org/abs/2004.09947
- https://arxiv.org/abs/2202.03178
- https://arxiv.org/abs/1803.03316
- https://ejgta.org/index.php/ejgta/article/view/132

Difficulty estimate: 3.5/10 (calibrated: Collatz ≈ 5.5, twin primes ≈ 5.0). It is believed open; do not assume a quick answer exists, and say so plainly if you cannot make progress. Never present a heuristic, numerical evidence, or a partial result as a solution.

## What counts as an answer
Either a proof of `OpenProblems.QEDM067.Claim` or a proof of `¬ OpenProblems.QEDM067.Claim` (a disproof), in Lean 4 + Mathlib, using the exact statement in `problems/QED-M067/Statement.lean`. Read its "Formalization notes" first. If that file still says `def Claim : Prop := sorry`, the problem must first be formalized (see CONTRIBUTING.md); a faithful formalization is itself a welcome contribution.

If you think the Lean statement does not match the informal problem (it is trivially true or false, or it says something else), report that in an issue instead of exploiting it: such solutions are not credited.

## How to submit
1. Claim it (optional but encouraged): open an issue titled `Claim QED-M067` at https://github.com/floration/qed/issues/new?template=claim.yml. Comment on it at least once a week or the claim lapses.
2. Add `solutions/QED-M067/<github-username>/Solution.lean`:
```lean
import Mathlib
-- do NOT redefine Claim: CI prepends problems/QED-M067/Statement.lean to your file
theorem solution : OpenProblems.QEDM067.Claim := by   -- or ¬ OpenProblems.QEDM067.Claim
  ...
```
3. Add `solutions/QED-M067/<github-username>/meta.json`: `{"model": "<AI model used, or none>", "kind": "proof" | "disproof"}`. Optionally a `README.md` explaining the idea.
4. Open a pull request. CI checks: it compiles, no `sorry`/`admit`/new `axiom`/`set_option` tricks, and `#print axioms solution` shows only `propext`, `Classical.choice`, `Quot.sound`.

## Scoring
Size = number of non-blank, non-comment lines of `Solution.lean` excluding `import` lines (helper lemmas count). First verified solution is credited permanently; any later, strictly smaller verified solution becomes the "smallest solution".

## Rules for you, the model
- Do not modify `Statement.lean` in a solution PR.
- Be honest about uncertainty; if a step is unproven, leave it out rather than sneak in `sorry`.
- Test locally: `lake exe cache get && lake env lean solutions/QED-M067/<user>/Solution.lean`.
