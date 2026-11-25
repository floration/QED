# QED-E120 — Does ex(n, K_{4,4}) grow faster than n^{5/3}?

You are an AI model helping someone attack this open problem. Read all of this before working.

## The problem
Extended set · Grade A · QED Curated · Combinatorics

**Plain words:** How many edges can a graph on n vertices have if it contains no complete bipartite graph K_{4,4}? The general upper bound is of order n^{7/4}. The best known constructions give only order n^{5/3}, which is already achieved by graphs that avoid the smaller K_{3,3}. Can one do better than a constant times n^{5/3}?

**Math:** Let $\mathrm{ex}(n,K_{4,4})$ be the maximum number of edges in a $K_{4,4}$-free graph on $n$ vertices. Known: $c\,n^{5/3}\le\mathrm{ex}(n,K_{4,4})\le C\,n^{7/4}$. Decide whether $\mathrm{ex}(n,K_{4,4})=O(n^{5/3})$, i.e. whether $\limsup_n \mathrm{ex}(n,K_{4,4})/n^{5/3}<\infty$. (Stronger target: $\mathrm{ex}(n,K_{4,4})=\Theta(n^{7/4})$.)

**Credit:** Erdős (question as posed in Chung–Graham's Erdős problems collection); Zarankiewicz problem background

**Rests on recent unrefereed work. Check these premises first:**
- Sits inside the Zarankiewicz problem (person-named); the specific K_{4,4} question is an unnamed sub-question
- Very hard; partial progress may come only for K_{4,6} first

**References:**
- https://fanchung.ucsd.edu/erdosprb/erdos/newproblems/TuranK44.html
- https://arxiv.org/abs/1607.01141
- https://arxiv.org/abs/1908.05190
- https://arxiv.org/abs/1306.5167

Difficulty estimate: 7.5/10 (anchored scale: 1 ≈ Erdős–Ginzburg–Ziv, 2.5 ≈ the sensitivity conjecture, 5 ≈ bounded prime gaps, 7.5 ≈ the Riemann Hypothesis, 10 ≈ P vs NP). It is believed open; do not assume a quick answer exists, and say so plainly if you cannot make progress. Never present a heuristic, numerical evidence, or a partial result as a solution.

## What counts as an answer
Either a proof of `OpenProblems.QEDE120.Claim` or a proof of `¬ OpenProblems.QEDE120.Claim` (a disproof), in Lean 4 + Mathlib, using the exact statement in `problems/QED-E120/Statement.lean`. Read its "Formalization notes" first. If that file still says `def Claim : Prop := sorry`, the problem must first be formalized (see CONTRIBUTING.md); a faithful formalization is itself a welcome contribution.

If you think the Lean statement does not match the informal problem (it is trivially true or false, or it says something else), report that in an issue instead of exploiting it: such solutions are not credited.

## How to submit
0. First time? Solve a test problem (QED-Q1, the 2-line one, at minimum) and submit it, to confirm your Lean setup and the submission pipeline work before spending effort here. Skip this step if this IS a test problem.
1. Claim it (optional but encouraged): open an issue titled `Claim QED-E120` at https://github.com/floration/qed/issues/new?template=claim.yml. Comment on it at least once a week or the claim lapses.
2. Add `solutions/QED-E120/<github-username>/Solution.lean`:
```lean
import Mathlib
-- do NOT redefine Claim: CI prepends problems/QED-E120/Statement.lean to your file
theorem solution : OpenProblems.QEDE120.Claim := by   -- or ¬ OpenProblems.QEDE120.Claim
  ...
```
   Large proofs may add more `.lean` files (subfolders allowed) next to Solution.lean; CI concatenates them in path order before Solution.lean. Don't import them.
3. Add `solutions/QED-E120/<github-username>/meta.json`: `{"model": "<AI model used, or none>", "kind": "proof" | "disproof"}`. Optionally a `README.md` explaining the idea.
4. Open a pull request. CI checks: it compiles, no `sorry`/`admit`/new `axiom`/`set_option` tricks, and `#print axioms solution` shows only `propext`, `Classical.choice`, `Quot.sound`.

## Scoring
Size = number of non-blank, non-comment lines of `Solution.lean` excluding `import` lines (helper lemmas count). First verified solution is credited permanently; any later, strictly smaller verified solution becomes the "smallest solution".

## Rules for you, the model
- Do not modify `Statement.lean` in a solution PR.
- Be honest about uncertainty; if a step is unproven, leave it out rather than sneak in `sorry`.
- Test locally: `lake exe cache get && lake env lean solutions/QED-E120/<user>/Solution.lean`.
