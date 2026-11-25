# QED-E219 — A triangle-free strongly regular graph on 162 vertices

You are an AI model helping someone attack this open problem. Read all of this before working.

## The problem
Extended set · Grade B · QED Curated · Graph theory

**Plain words:** Only seven triangle-free strongly regular graphs are known (pentagon, Petersen, Clebsch, Hoffman-Singleton, Gewirtz, M22 and Higman-Sims graphs). The smallest parameter set for which such a graph is neither known nor ruled out has 162 vertices, every vertex of degree 21, no triangles, and every pair of non-adjacent vertices with exactly 3 common neighbours. Does such a graph exist?

**Math:** Decide whether there exists a simple graph on $162$ vertices that is strongly regular with parameters $(162,21,0,3)$: $21$-regular, adjacent vertices have no common neighbours, and distinct non-adjacent vertices have exactly $3$ common neighbours.

**Credit:** Classical question (Biggs, Brouwer); smallest open case per A. E. Brouwer's table of strongly regular graphs.

**Rests on recent unrefereed work. Check these premises first:**
- Same family as the pending degree-57 Moore graph (H06); scorer may see overlap
- AI-assisted SRG exclusions are moving quickly in 2026 (Kovaľ + AI; Akiyama), so this case may fall soon
- Pure existence question resolved, if at all, likely by computation

**References:**
- https://aeb.win.tue.nl/graphs/srg/srgtab151-200.html
- https://norcom2019.math.aau.dk/J%C3%B8rgensen.pdf
- https://arxiv.org/abs/0911.2160
- https://arxiv.org/pdf/2610.20259

Difficulty estimate: 6.5/10 (anchored scale: 1 ≈ Erdős–Ginzburg–Ziv, 2.5 ≈ the sensitivity conjecture, 5 ≈ bounded prime gaps, 7.5 ≈ the Riemann Hypothesis, 10 ≈ P vs NP). It is believed open; do not assume a quick answer exists, and say so plainly if you cannot make progress. Never present a heuristic, numerical evidence, or a partial result as a solution.

## What counts as an answer
Either a proof of `OpenProblems.QEDE219.Claim` or a proof of `¬ OpenProblems.QEDE219.Claim` (a disproof), in Lean 4 + Mathlib, using the exact statement in `problems/QED-E219/Statement.lean`. Read its "Formalization notes" first. If that file still says `def Claim : Prop := sorry`, the problem must first be formalized (see CONTRIBUTING.md); a faithful formalization is itself a welcome contribution.

If you think the Lean statement does not match the informal problem (it is trivially true or false, or it says something else), report that in an issue instead of exploiting it: such solutions are not credited.

## How to submit
0. First time? Solve a test problem (QED-Q1, the 2-line one, at minimum) and submit it, to confirm your Lean setup and the submission pipeline work before spending effort here. Skip this step if this IS a test problem.
1. Claim it (optional but encouraged): open an issue titled `Claim QED-E219` at https://github.com/floration/qed/issues/new?template=claim.yml. Comment on it at least once a week or the claim lapses.
2. Add `solutions/QED-E219/<github-username>/Solution.lean`:
```lean
import Mathlib
-- do NOT redefine Claim: CI prepends problems/QED-E219/Statement.lean to your file
theorem solution : OpenProblems.QEDE219.Claim := by   -- or ¬ OpenProblems.QEDE219.Claim
  ...
```
   Large proofs may add more `.lean` files (subfolders allowed) next to Solution.lean; CI concatenates them in path order before Solution.lean. Don't import them.
3. Add `solutions/QED-E219/<github-username>/meta.json`: `{"model": "<AI model used, or none>", "kind": "proof" | "disproof"}`. Optionally a `README.md` explaining the idea.
4. Open a pull request. CI checks: it compiles, no `sorry`/`admit`/new `axiom`/`set_option` tricks, and `#print axioms solution` shows only `propext`, `Classical.choice`, `Quot.sound`.

## Scoring
Size = number of non-blank, non-comment lines of `Solution.lean` excluding `import` lines (helper lemmas count). First verified solution is credited permanently; any later, strictly smaller verified solution becomes the "smallest solution".

## Rules for you, the model
- Do not modify `Statement.lean` in a solution PR.
- Be honest about uncertainty; if a step is unproven, leave it out rather than sneak in `sorry`.
- Test locally: `lake exe cache get && lake env lean solutions/QED-E219/<user>/Solution.lean`.
