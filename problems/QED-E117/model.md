# QED-E117 — Does a Moore graph of degree 57 exist?

You are an AI model helping someone attack this open problem. Read all of this before working.

## The problem
Extended set · Grade A · QED Curated · Graph theory

**Plain words:** A Moore graph of diameter 2 is a regular graph in which any two vertices are either adjacent or have exactly one common neighbour; with degree k it has k^2+1 vertices, the most a diameter-2 graph of degree k can have. Hoffman and Singleton (1960) showed such graphs can exist only for k = 2, 3, 7, 57, and the first three exist (pentagon, Petersen graph, Hoffman-Singleton graph). Does one exist for degree 57, with 3250 vertices?

**Math:** Decide whether there exists a simple graph $G$ on $3250$ vertices that is $57$-regular, triangle-free, and in which every two distinct non-adjacent vertices have exactly one common neighbour; equivalently, whether a strongly regular graph with parameters $(3250,57,0,1)$ exists.

**Credit:** Hoffman and Singleton (1960); recent restrictions by Mačaj–Širáň, Smith–Montemanni, and others

**Rests on recent unrefereed work. Check these premises first:**
- Very famous problem: low novelty, high difficulty
- 'Moore graph' is a person-named object, but the question is not a named conjecture
- Two 2026 partial-result papers are recent (one arXiv only); they do not affect the open status

**References:**
- https://arxiv.org/abs/2210.09577
- https://arxiv.org/abs/2010.13443
- https://arxiv.org/abs/2606.29183
- https://iris.unimore.it/retrieve/07e178c3-caa2-4fbe-8849-884c07027c7a/axioms-15-00332-1.pdf
- https://epoch.ai/frontiermath/open-problems/missing-moore-graph

Difficulty estimate: 7.5/10 (calibrated: Collatz ≈ 5.5, twin primes ≈ 5.0). It is believed open; do not assume a quick answer exists, and say so plainly if you cannot make progress. Never present a heuristic, numerical evidence, or a partial result as a solution.

## What counts as an answer
Either a proof of `OpenProblems.QEDE117.Claim` or a proof of `¬ OpenProblems.QEDE117.Claim` (a disproof), in Lean 4 + Mathlib, using the exact statement in `problems/QED-E117/Statement.lean`. Read its "Formalization notes" first. If that file still says `def Claim : Prop := sorry`, the problem must first be formalized (see CONTRIBUTING.md); a faithful formalization is itself a welcome contribution.

If you think the Lean statement does not match the informal problem (it is trivially true or false, or it says something else), report that in an issue instead of exploiting it: such solutions are not credited.

## How to submit
0. First time? Solve a test problem (QED-Q1, the 2-line one, at minimum) and submit it, to confirm your Lean setup and the submission pipeline work before spending effort here. Skip this step if this IS a test problem.
1. Claim it (optional but encouraged): open an issue titled `Claim QED-E117` at https://github.com/floration/qed/issues/new?template=claim.yml. Comment on it at least once a week or the claim lapses.
2. Add `solutions/QED-E117/<github-username>/Solution.lean`:
```lean
import Mathlib
-- do NOT redefine Claim: CI prepends problems/QED-E117/Statement.lean to your file
theorem solution : OpenProblems.QEDE117.Claim := by   -- or ¬ OpenProblems.QEDE117.Claim
  ...
```
   Large proofs may add more `.lean` files (subfolders allowed) next to Solution.lean; CI concatenates them in path order before Solution.lean. Don't import them.
3. Add `solutions/QED-E117/<github-username>/meta.json`: `{"model": "<AI model used, or none>", "kind": "proof" | "disproof"}`. Optionally a `README.md` explaining the idea.
4. Open a pull request. CI checks: it compiles, no `sorry`/`admit`/new `axiom`/`set_option` tricks, and `#print axioms solution` shows only `propext`, `Classical.choice`, `Quot.sound`.

## Scoring
Size = number of non-blank, non-comment lines of `Solution.lean` excluding `import` lines (helper lemmas count). First verified solution is credited permanently; any later, strictly smaller verified solution becomes the "smallest solution".

## Rules for you, the model
- Do not modify `Statement.lean` in a solution PR.
- Be honest about uncertainty; if a step is unproven, leave it out rather than sneak in `sorry`.
- Test locally: `lake exe cache get && lake env lean solutions/QED-E117/<user>/Solution.lean`.
