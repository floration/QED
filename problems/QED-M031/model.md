# QED-M031 — All-Edges Triangle in the (n, n, sqrt n) tripartite regime

You are an AI model helping someone attack this open problem. Read all of this before working.

## The problem
Main set · Grade A · QED Curated · Complexity

**Plain words:** Given a tripartite graph with parts of sizes n, n, sqrt(n) and O(n^{3/2}) edges, determine for every edge whether it lies in a triangle in O(n^{2-eps}) time (combinatorial or algebraic).

**Math:** Is there ε > 0 and a randomized word-RAM algorithm that, for every tripartite graph on A, B, C with |A| = |B| = n, |C| = ceil(sqrt n) and O(n^{3/2}) edges, decides for every edge whether it lies in a triangle in time O(n^{2-ε})? (Main question; a fine-grained reduction from balanced All-Edges Sparse Triangle at m^{4/3-o(1)} would be evidence for a negative answer but is not itself a disproof.)

**Credit:** Alman, Vassilevska Williams, 'Truly Subquadratic 3SUM and Truly Subcubic APSP via Triangles in Sparse Lopsided Graphs', arXiv:2610.06783 (2026)

**Rests on recent unrefereed work. Check these premises first:**
- arXiv:2610.06783 (Alman-Vassilevska Williams, Oct 2026, unrefereed): source of the regime, of the refutation of the APSP-type hardness at this boundary, and of the m^{4/3} balanced-hardness framing.
- arXiv:2610.17420 (Majdoddin, Oct 2026, unrefereed): extension of thin products to middle part D <= N^{0.172}, cited as the best partial progress.

**References:**
- Alman, Vassilevska Williams, Truly Subquadratic 3SUM and Truly Subcubic APSP via Triangles in Sparse Lopsided Graphs, arXiv:2610.06783 (Oct 2026)
- arXiv:2610.06783
- arXiv:2610.17420

Difficulty estimate: 4.0/10 (calibrated: Collatz ≈ 5.5, twin primes ≈ 5.0). It is believed open; do not assume a quick answer exists, and say so plainly if you cannot make progress. Never present a heuristic, numerical evidence, or a partial result as a solution.

## What counts as an answer
Either a proof of `OpenProblems.QEDM031.Claim` or a proof of `¬ OpenProblems.QEDM031.Claim` (a disproof), in Lean 4 + Mathlib, using the exact statement in `problems/QED-M031/Statement.lean`. Read its "Formalization notes" first. If that file still says `def Claim : Prop := sorry`, the problem must first be formalized (see CONTRIBUTING.md); a faithful formalization is itself a welcome contribution. What is missing: Not formalized: needs a word-RAM model with time accounting, randomized algorithms, and fine-grained reductions, none of which Mathlib provides.

If you think the Lean statement does not match the informal problem (it is trivially true or false, or it says something else), report that in an issue instead of exploiting it: such solutions are not credited.

## How to submit
1. Claim it (optional but encouraged): open an issue titled `Claim QED-M031` at https://github.com/floration/qed/issues/new?template=claim.yml. Comment on it at least once a week or the claim lapses.
2. Add `solutions/QED-M031/<github-username>/Solution.lean`:
```lean
import Mathlib
-- do NOT redefine Claim: CI prepends problems/QED-M031/Statement.lean to your file
theorem solution : OpenProblems.QEDM031.Claim := by   -- or ¬ OpenProblems.QEDM031.Claim
  ...
```
   Large proofs may add more `.lean` files (subfolders allowed) next to Solution.lean; CI concatenates them in path order before Solution.lean. Don't import them.
3. Add `solutions/QED-M031/<github-username>/meta.json`: `{"model": "<AI model used, or none>", "kind": "proof" | "disproof"}`. Optionally a `README.md` explaining the idea.
4. Open a pull request. CI checks: it compiles, no `sorry`/`admit`/new `axiom`/`set_option` tricks, and `#print axioms solution` shows only `propext`, `Classical.choice`, `Quot.sound`.

## Scoring
Size = number of non-blank, non-comment lines of `Solution.lean` excluding `import` lines (helper lemmas count). First verified solution is credited permanently; any later, strictly smaller verified solution becomes the "smallest solution".

## Rules for you, the model
- Do not modify `Statement.lean` in a solution PR.
- Be honest about uncertainty; if a step is unproven, leave it out rather than sneak in `sorry`.
- Test locally: `lake exe cache get && lake env lean solutions/QED-M031/<user>/Solution.lean`.
