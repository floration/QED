# QED-E026 — Total colouring of planar graphs with maximum degree 6

You are an AI model helping someone attack this open problem. Read all of this before working.

## The problem
Extended set · Grade B- · QED Curated · Graph theory

**Plain words:** A total colouring colours both vertices and edges so that touching objects (adjacent vertices, edges sharing an end, an edge and its endpoint) get different colours. It is conjectured that Δ+2 colours always suffice, where Δ is the maximum degree. For planar graphs this is proved for every Δ except Δ=6: show every planar graph with maximum degree 6 has a total colouring with 8 colours.

**Math:** Prove that every simple planar graph $G$ with $\Delta(G)=6$ satisfies $\chi''(G)\le 8$ (or find a counterexample).

**Reviewer note:** Known: Delta <= 5: Kostochka (all graphs). Planar Delta=7: Sanders-Zhao. Planar Delta >= 8: earlier results (Borodin et al.). Planar Delta=6 is known under extra hypotheses: no 4-cycles (Wang et al.), no adjacent triangles (Sun et al.), each vertex misses some k-cycle with 3<=k<=8 (Roussel), no 4-fan (Zhu-Xu), and special 4-cycle conditions (arXiv:2609.19503, 2026); see arXiv:2507.12737. E. Zhu, arXiv:2610.32717 (2026 preprint): every maximal planar graph with Delta <= 6 is totally 8-colourable; this does not cover all planar graphs because completing to a triangulation can raise Delta.

**Credit:** Behzad/Vizing Total Colouring Conjecture; planar-case literature (Sanders-Zhao, Wang, Roussel, Zhu).

**Rests on recent unrefereed work. Check these premises first:**
- Zhu's 2026 maximal-planar result is unrefereed
- Infinite family; formalization needs planarity in Mathlib, which is limited

**References:**
- https://arxiv.org/html/2507.12737v1
- https://arxiv.org/abs/2610.32717
- https://arxiv.org/abs/2609.19503
- https://arxiv.org/abs/1812.05833

Difficulty estimate: 4.5/10 (calibrated: Collatz ≈ 5.5, twin primes ≈ 5.0). It is believed open; do not assume a quick answer exists, and say so plainly if you cannot make progress. Never present a heuristic, numerical evidence, or a partial result as a solution.

## What counts as an answer
Either a proof of `OpenProblems.QEDE026.Claim` or a proof of `¬ OpenProblems.QEDE026.Claim` (a disproof), in Lean 4 + Mathlib, using the exact statement in `problems/QED-E026/Statement.lean`. Read its "Formalization notes" first. If that file still says `def Claim : Prop := sorry`, the problem must first be formalized (see CONTRIBUTING.md); a faithful formalization is itself a welcome contribution.

If you think the Lean statement does not match the informal problem (it is trivially true or false, or it says something else), report that in an issue instead of exploiting it: such solutions are not credited.

## How to submit
1. Claim it (optional but encouraged): open an issue titled `Claim QED-E026` at https://github.com/floration/qed/issues/new?template=claim.yml. Comment on it at least once a week or the claim lapses.
2. Add `solutions/QED-E026/<github-username>/Solution.lean`:
```lean
import Mathlib
-- do NOT redefine Claim: CI prepends problems/QED-E026/Statement.lean to your file
theorem solution : OpenProblems.QEDE026.Claim := by   -- or ¬ OpenProblems.QEDE026.Claim
  ...
```
   Large proofs may add more `.lean` files (subfolders allowed) next to Solution.lean; CI concatenates them in path order before Solution.lean. Don't import them.
3. Add `solutions/QED-E026/<github-username>/meta.json`: `{"model": "<AI model used, or none>", "kind": "proof" | "disproof"}`. Optionally a `README.md` explaining the idea.
4. Open a pull request. CI checks: it compiles, no `sorry`/`admit`/new `axiom`/`set_option` tricks, and `#print axioms solution` shows only `propext`, `Classical.choice`, `Quot.sound`.

## Scoring
Size = number of non-blank, non-comment lines of `Solution.lean` excluding `import` lines (helper lemmas count). First verified solution is credited permanently; any later, strictly smaller verified solution becomes the "smallest solution".

## Rules for you, the model
- Do not modify `Statement.lean` in a solution PR.
- Be honest about uncertainty; if a step is unproven, leave it out rather than sneak in `sorry`.
- Test locally: `lake exe cache get && lake env lean solutions/QED-E026/<user>/Solution.lean`.
