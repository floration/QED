# QED-E220 — Is there a cubic graph of girth 13 with fewer than 272 vertices?

You are an AI model helping someone attack this open problem. Read all of this before working.

## The problem
Extended set · Grade C · QED Curated · Graph theory

**Plain words:** A (3,g)-cage is a smallest 3-regular graph with no cycle shorter than g. Cubic cages are known for every girth up to 12. For girth 13 the best known graph has 272 vertices, while exhaustive computer searches only show that at least 202 vertices are needed. Is there a 3-regular graph of girth at least 13 on fewer than 272 vertices?

**Math:** Does there exist a $3$-regular simple graph $G$ with $|V(G)|<272$ and girth at least $13$? Equivalently (by strict monotonicity $n(3,g)<n(3,g+1)$), is $n(3,13)<272$, given the known bounds $202\le n(3,13)\le272$?

**Credit:** Cage problem (Tutte 1947); bounds from McKay–Myrvold–Nadon (1998) and the Exoo–Jajcay dynamic survey.

**Rests on recent unrefereed work. Check these premises first:**
- Largely computational; could be seen as a 'pure large computation' (rule 5) though it is a recognized open problem with refereed bounds
- Upper-bound constructions for neighbouring girths moved in Nov 2026; 272 may be beaten soon by search

**References:**
- https://www.combinatorics.org/ojs/index.php/eljc/article/download/v33i1p54/pdf
- https://arxiv.org/abs/2511.07247
- https://arxiv.org/abs/2611.09000

Difficulty estimate: 3.0/10 (calibrated: Collatz ≈ 5.5, twin primes ≈ 5.0). It is believed open; do not assume a quick answer exists, and say so plainly if you cannot make progress. Never present a heuristic, numerical evidence, or a partial result as a solution.

## What counts as an answer
Either a proof of `OpenProblems.QEDE220.Claim` or a proof of `¬ OpenProblems.QEDE220.Claim` (a disproof), in Lean 4 + Mathlib, using the exact statement in `problems/QED-E220/Statement.lean`. Read its "Formalization notes" first. If that file still says `def Claim : Prop := sorry`, the problem must first be formalized (see CONTRIBUTING.md); a faithful formalization is itself a welcome contribution.

If you think the Lean statement does not match the informal problem (it is trivially true or false, or it says something else), report that in an issue instead of exploiting it: such solutions are not credited.

## How to submit
0. First time? Solve a test problem (QED-Q1, the 2-line one, at minimum) and submit it, to confirm your Lean setup and the submission pipeline work before spending effort here. Skip this step if this IS a test problem.
1. Claim it (optional but encouraged): open an issue titled `Claim QED-E220` at https://github.com/floration/qed/issues/new?template=claim.yml. Comment on it at least once a week or the claim lapses.
2. Add `solutions/QED-E220/<github-username>/Solution.lean`:
```lean
import Mathlib
-- do NOT redefine Claim: CI prepends problems/QED-E220/Statement.lean to your file
theorem solution : OpenProblems.QEDE220.Claim := by   -- or ¬ OpenProblems.QEDE220.Claim
  ...
```
   Large proofs may add more `.lean` files (subfolders allowed) next to Solution.lean; CI concatenates them in path order before Solution.lean. Don't import them.
3. Add `solutions/QED-E220/<github-username>/meta.json`: `{"model": "<AI model used, or none>", "kind": "proof" | "disproof"}`. Optionally a `README.md` explaining the idea.
4. Open a pull request. CI checks: it compiles, no `sorry`/`admit`/new `axiom`/`set_option` tricks, and `#print axioms solution` shows only `propext`, `Classical.choice`, `Quot.sound`.

## Scoring
Size = number of non-blank, non-comment lines of `Solution.lean` excluding `import` lines (helper lemmas count). First verified solution is credited permanently; any later, strictly smaller verified solution becomes the "smallest solution".

## Rules for you, the model
- Do not modify `Statement.lean` in a solution PR.
- Be honest about uncertainty; if a step is unproven, leave it out rather than sneak in `sorry`.
- Test locally: `lake exe cache get && lake env lean solutions/QED-E220/<user>/Solution.lean`.
