# QED-M106 — Beat the 4-cycle lower bound for cube-free graphs

You are an AI model helping someone attack this open problem. Read all of this before working.

## The problem
Main set · Grade A · QED Curated · Graph theory

**Plain words:** How many edges can an n-vertex graph have without containing the 3-dimensional cube Q3 (8 vertices, 12 edges)? Erdos and Simonovits proved about n^{8/5} is an upper bound, but the best lower bound is still about n^{3/2}, from graphs with no 4-cycle at all (every 4-cycle-free graph is cube-free). Find cube-free graphs with polynomially more edges than that, or show that no such graphs exist.

**Math:** Let $\mathrm{ex}(n,Q_3)$ be the maximum number of edges in an $n$-vertex simple graph with no subgraph isomorphic to the cube $Q_3$. Known: $(\tfrac12+o(1))n^{3/2}\le \mathrm{ex}(n,Q_3)= O(n^{8/5})$. Decide whether $\liminf_{n\to\infty}\dfrac{\log \mathrm{ex}(n,Q_3)}{\log n}>\dfrac32$, i.e. whether there is $\varepsilon>0$ with $\mathrm{ex}(n,Q_3)\ge n^{3/2+\varepsilon}$ for all large $n$. (Erdos conjectured the stronger $\mathrm{ex}(n,Q_3)=\Theta(n^{8/5})$.)

**Reviewer note:** Known: Upper: Erdős–Simonovits (1970) O(n^{8/5}); new proof by Pinchasi–Sharir and Füredi (arXiv 1307.1062). Lower: Ω(n^{3/2}) from C4-free polarity graphs, since C4 ⊂ Q3 (Erdős problems page states no better lower bound known). Janzer–Sudakov (Forum Math. Sigma, arXiv 2211.02015): ex(n,Q_d)=O(n^{2-1/(d-1)+1/((d-1)2^{d-1})}), and they record that for Q3 the bounds n^{3/2} and n^{8/5} still stand.

**Credit:** P. Erdős and M. Simonovits (1970)

**Rests on recent unrefereed work. Check these premises first:**
- Statement is a one-sided target; the vetter may prefer the full Θ(n^{8/5}) conjecture
- Erdős conjectured the n^{8/5} order, but the problem is not commonly named after a person ('Turán number of the cube'); the stated target (beat n^{3/2}) is an unnamed sub-question

**References:**
- https://mathweb.ucsd.edu/~erdosproblems/erdos/newproblems/TuranCube.html
- https://arxiv.org/abs/2211.02015
- https://arxiv.org/abs/1307.1062
- https://arxiv.org/abs/1306.5167
- https://primereboot.pages.dev/erdos/problem/576

Difficulty estimate: 7.5/10 (calibrated: Collatz ≈ 5.5, twin primes ≈ 5.0). It is believed open; do not assume a quick answer exists, and say so plainly if you cannot make progress. Never present a heuristic, numerical evidence, or a partial result as a solution.

## What counts as an answer
Either a proof of `OpenProblems.QEDM106.Claim` or a proof of `¬ OpenProblems.QEDM106.Claim` (a disproof), in Lean 4 + Mathlib, using the exact statement in `problems/QED-M106/Statement.lean`. Read its "Formalization notes" first. If that file still says `def Claim : Prop := sorry`, the problem must first be formalized (see CONTRIBUTING.md); a faithful formalization is itself a welcome contribution.

If you think the Lean statement does not match the informal problem (it is trivially true or false, or it says something else), report that in an issue instead of exploiting it: such solutions are not credited.

## How to submit
0. First time? Solve a test problem (QED-Q1, the 2-line one, at minimum) and submit it, to confirm your Lean setup and the submission pipeline work before spending effort here. Skip this step if this IS a test problem.
1. Claim it (optional but encouraged): open an issue titled `Claim QED-M106` at https://github.com/floration/qed/issues/new?template=claim.yml. Comment on it at least once a week or the claim lapses.
2. Add `solutions/QED-M106/<github-username>/Solution.lean`:
```lean
import Mathlib
-- do NOT redefine Claim: CI prepends problems/QED-M106/Statement.lean to your file
theorem solution : OpenProblems.QEDM106.Claim := by   -- or ¬ OpenProblems.QEDM106.Claim
  ...
```
   Large proofs may add more `.lean` files (subfolders allowed) next to Solution.lean; CI concatenates them in path order before Solution.lean. Don't import them.
3. Add `solutions/QED-M106/<github-username>/meta.json`: `{"model": "<AI model used, or none>", "kind": "proof" | "disproof"}`. Optionally a `README.md` explaining the idea.
4. Open a pull request. CI checks: it compiles, no `sorry`/`admit`/new `axiom`/`set_option` tricks, and `#print axioms solution` shows only `propext`, `Classical.choice`, `Quot.sound`.

## Scoring
Size = number of non-blank, non-comment lines of `Solution.lean` excluding `import` lines (helper lemmas count). First verified solution is credited permanently; any later, strictly smaller verified solution becomes the "smallest solution".

## Rules for you, the model
- Do not modify `Statement.lean` in a solution PR.
- Be honest about uncertainty; if a step is unproven, leave it out rather than sneak in `sorry`.
- Test locally: `lake exe cache get && lake env lean solutions/QED-M106/<user>/Solution.lean`.
