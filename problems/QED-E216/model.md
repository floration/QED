# QED-E216 — A biplane with more than 13 points per block

You are an AI model helping someone attack this open problem. Read all of this before working.

## The problem
Extended set · Grade B · QED Curated · Combinatorics

**Plain words:** A biplane is a family of v blocks, each a k-element subset of a v-point set, such that every two blocks share exactly two points (equivalently every two points lie in exactly two blocks). Only sixteen nontrivial biplanes are known, all with k ≤ 13. Is there a biplane with larger blocks? The smallest open case is v = 121, k = 16.

**Math:** Does there exist a symmetric $2$-$(v,k,2)$ design with $k\ge14$, i.e. $v$ distinct $k$-subsets of a $v$-set with $k(k-1)=2(v-1)$, $k\ge14$, any two of which meet in exactly $2$ points? (Bruck–Ryser–Chowla excludes $k=14,15$; the first open case is $(v,k)=(121,16)$.)

**Credit:** Classical open problem on biplanes (Hussain 1945, Cameron 1973 survey 'Biplanes'); smallest open case per Alavi–Daneshkhah–Praeger and Crnković et al.

**Rests on recent unrefereed work. Check these premises first:**
- Disjunction risk: posed as an existence question whose positive answer needs one example and negative answer would need infinitely many cases; the board may prefer the single case (121,16,2) — offer that as the headline formalization
- Related in spirit to pending J14 (projective plane order 12) and E023 (S(2,6,51)) but different parameters and family

**References:**
- https://arxiv.org/pdf/2010.12944
- https://arxiv.org/pdf/2004.04535

Difficulty estimate: 4.0/10 (calibrated: Collatz ≈ 5.5, twin primes ≈ 5.0). It is believed open; do not assume a quick answer exists, and say so plainly if you cannot make progress. Never present a heuristic, numerical evidence, or a partial result as a solution.

## What counts as an answer
Either a proof of `OpenProblems.QEDE216.Claim` or a proof of `¬ OpenProblems.QEDE216.Claim` (a disproof), in Lean 4 + Mathlib, using the exact statement in `problems/QED-E216/Statement.lean`. Read its "Formalization notes" first. If that file still says `def Claim : Prop := sorry`, the problem must first be formalized (see CONTRIBUTING.md); a faithful formalization is itself a welcome contribution.

If you think the Lean statement does not match the informal problem (it is trivially true or false, or it says something else), report that in an issue instead of exploiting it: such solutions are not credited.

## How to submit
0. First time? Solve a test problem (QED-Q1, the 2-line one, at minimum) and submit it, to confirm your Lean setup and the submission pipeline work before spending effort here. Skip this step if this IS a test problem.
1. Claim it (optional but encouraged): open an issue titled `Claim QED-E216` at https://github.com/floration/qed/issues/new?template=claim.yml. Comment on it at least once a week or the claim lapses.
2. Add `solutions/QED-E216/<github-username>/Solution.lean`:
```lean
import Mathlib
-- do NOT redefine Claim: CI prepends problems/QED-E216/Statement.lean to your file
theorem solution : OpenProblems.QEDE216.Claim := by   -- or ¬ OpenProblems.QEDE216.Claim
  ...
```
   Large proofs may add more `.lean` files (subfolders allowed) next to Solution.lean; CI concatenates them in path order before Solution.lean. Don't import them.
3. Add `solutions/QED-E216/<github-username>/meta.json`: `{"model": "<AI model used, or none>", "kind": "proof" | "disproof"}`. Optionally a `README.md` explaining the idea.
4. Open a pull request. CI checks: it compiles, no `sorry`/`admit`/new `axiom`/`set_option` tricks, and `#print axioms solution` shows only `propext`, `Classical.choice`, `Quot.sound`.

## Scoring
Size = number of non-blank, non-comment lines of `Solution.lean` excluding `import` lines (helper lemmas count). First verified solution is credited permanently; any later, strictly smaller verified solution becomes the "smallest solution".

## Rules for you, the model
- Do not modify `Statement.lean` in a solution PR.
- Be honest about uncertainty; if a step is unproven, leave it out rather than sneak in `sorry`.
- Test locally: `lake exe cache get && lake env lean solutions/QED-E216/<user>/Solution.lean`.
