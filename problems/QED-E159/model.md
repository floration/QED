# QED-E159 — Are the edges of a uniformly random forest negatively correlated?

You are an AI model helping someone attack this open problem. Read all of this before working.

## The problem
Extended set · Grade A · QED Curated · Probability

**Plain words:** Pick a forest (an acyclic set of edges) uniformly at random from a finite graph. If edge e is in the forest, does that make edge f less likely to be in it? For uniformly random spanning trees the answer is yes (Kirchhoff), but for forests, the independent sets of the graphic matroid, it has been open since about 2000. It has been checked on all graphs with at most 8 vertices and proved for complete and complete bipartite graphs.

**Math:** For a finite simple graph $G=(V,E)$ let $\mathcal F$ be the set of acyclic subsets of $E$, and for $S\subseteq E$ let $N_S=\#\{F\in\mathcal F: S\subseteq F\}$, $N=|\mathcal F|$. Claim: for all distinct $e,f\in E$, $N_{\{e,f\}}\,N\le N_{\{e\}}\,N_{\{f\}}$. Known: $N_{\{e,f\}}N\le 2(1-1/|E|)\,N_{\{e\}}N_{\{f\}}$ (Huh-Schroter-Wang; Branden-Huh). Fallback unnamed sub-target: some absolute constant $c<2$ in place of 1.

**Credit:** Posed by Kahn and by Grimmett-Winkler (also in Pemantle, 'Towards a theory of negative dependence'); Branden-Huh factor-2 bound.

**Rests on recent unrefereed work. Check these premises first:**
- NAMING: several papers call this 'Kahn's conjecture' or the Grimmett-Winkler conjecture; if the owner counts that as person-named, use the unnamed sub-target (absolute constant c<2) or a class such as planar graphs
- Recent progress is all 2026 preprints, which may signal that a resolution is near
- Mostly computational small-case evidence; a counterexample on 10+ vertices is not excluded

**References:**
- https://arxiv.org/abs/math/0302185
- https://arxiv.org/pdf/2610.36749
- https://arxiv.org/pdf/2610.00549
- https://arxiv.org/pdf/2609.26134
- https://arxiv.org/pdf/2609.11578
- https://arxiv.org/abs/2603.10738

Difficulty estimate: 3.5/10 (calibrated: Collatz ≈ 5.5, twin primes ≈ 5.0). It is believed open; do not assume a quick answer exists, and say so plainly if you cannot make progress. Never present a heuristic, numerical evidence, or a partial result as a solution.

## What counts as an answer
Either a proof of `OpenProblems.QEDE159.Claim` or a proof of `¬ OpenProblems.QEDE159.Claim` (a disproof), in Lean 4 + Mathlib, using the exact statement in `problems/QED-E159/Statement.lean`. Read its "Formalization notes" first. If that file still says `def Claim : Prop := sorry`, the problem must first be formalized (see CONTRIBUTING.md); a faithful formalization is itself a welcome contribution.

If you think the Lean statement does not match the informal problem (it is trivially true or false, or it says something else), report that in an issue instead of exploiting it: such solutions are not credited.

## How to submit
0. First time? Solve a test problem (QED-Q1, the 2-line one, at minimum) and submit it, to confirm your Lean setup and the submission pipeline work before spending effort here. Skip this step if this IS a test problem.
1. Claim it (optional but encouraged): open an issue titled `Claim QED-E159` at https://github.com/floration/qed/issues/new?template=claim.yml. Comment on it at least once a week or the claim lapses.
2. Add `solutions/QED-E159/<github-username>/Solution.lean`:
```lean
import Mathlib
-- do NOT redefine Claim: CI prepends problems/QED-E159/Statement.lean to your file
theorem solution : OpenProblems.QEDE159.Claim := by   -- or ¬ OpenProblems.QEDE159.Claim
  ...
```
   Large proofs may add more `.lean` files (subfolders allowed) next to Solution.lean; CI concatenates them in path order before Solution.lean. Don't import them.
3. Add `solutions/QED-E159/<github-username>/meta.json`: `{"model": "<AI model used, or none>", "kind": "proof" | "disproof"}`. Optionally a `README.md` explaining the idea.
4. Open a pull request. CI checks: it compiles, no `sorry`/`admit`/new `axiom`/`set_option` tricks, and `#print axioms solution` shows only `propext`, `Classical.choice`, `Quot.sound`.

## Scoring
Size = number of non-blank, non-comment lines of `Solution.lean` excluding `import` lines (helper lemmas count). First verified solution is credited permanently; any later, strictly smaller verified solution becomes the "smallest solution".

## Rules for you, the model
- Do not modify `Statement.lean` in a solution PR.
- Be honest about uncertainty; if a step is unproven, leave it out rather than sneak in `sorry`.
- Test locally: `lake exe cache get && lake env lean solutions/QED-E159/<user>/Solution.lean`.
