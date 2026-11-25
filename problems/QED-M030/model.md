# QED-M030 — All-Edges Sparse Triangle below m^{4/3} on balanced instances

You are an AI model helping someone attack this open problem. Read all of this before working.

## The problem
Main set · Grade A · QED Curated · Complexity

**Plain words:** Solve All-Edges Sparse Triangle (for each of m edges, report whether it is in a triangle) in O(m^{4/3-eps}) time on general (balanced) sparse graphs, or derive an m^{4/3-o(1)} lower bound from a hypothesis that survives AVW (e.g. 4SUM, OV/SETH, or combinatorial BMM).

**Math:** Model: word-RAM with Θ(log N)-bit words. Is there a fixed ε > 0 such that for all constants α, δ > 0 there is a randomized (success ≥ 2/3) algorithm that, given a tripartite graph on parts A, B, C with |A|=|B|=|C|=N, m ≥ α N^{3/2} edges and maximum degree ≤ δ√N, decides for every edge whether it lies in a triangle in time O(m^{4/3-ε})? (The conditional-hardness alternative is a separate question.)

**Credit:** Alman, Vassilevska Williams 2026, arXiv:2610.06783, Sec. 6; Patrascu, STOC 2010

**Rests on recent unrefereed work. Check these premises first:**
- arXiv:2610.06783 (Alman-Vassilevska Williams, Oct 2026, unrefereed): the claim that lopsided AE-Sparse-Triangle (and 3SUM, APSP) are now truly subquadratic/subcubic, and that balanced instances remain open, i.e. the reason this is the live question and that 3SUM-based m^{4/3} hardness has fallen.

**References:**
- Alman, Vassilevska Williams, Truly Subquadratic 3SUM and Truly Subcubic APSP via Triangles in Sparse Lopsided Graphs, arXiv:2610.06783 (Oct 2026)
- Patrascu, Towards polynomial lower bounds for dynamic problems, STOC 2010
- Kopelowitz, Pettie, Porat, Higher lower bounds from the 3SUM conjecture, SODA 2016
- arXiv:2610.06783
- arXiv:2203.08356
- Patrascu STOC 2010

Difficulty estimate: 4.0/10 (calibrated: Collatz ≈ 5.5, twin primes ≈ 5.0). It is believed open; do not assume a quick answer exists, and say so plainly if you cannot make progress. Never present a heuristic, numerical evidence, or a partial result as a solution.

## What counts as an answer
Either a proof of `OpenProblems.QEDM030.Claim` or a proof of `¬ OpenProblems.QEDM030.Claim` (a disproof), in Lean 4 + Mathlib, using the exact statement in `problems/QED-M030/Statement.lean`. Read its "Formalization notes" first. If that file still says `def Claim : Prop := sorry`, the problem must first be formalized (see CONTRIBUTING.md); a faithful formalization is itself a welcome contribution.

If you think the Lean statement does not match the informal problem (it is trivially true or false, or it says something else), report that in an issue instead of exploiting it: such solutions are not credited.

## How to submit
1. Claim it (optional but encouraged): open an issue titled `Claim QED-M030` at https://github.com/floration/qed/issues/new?template=claim.yml. Comment on it at least once a week or the claim lapses.
2. Add `solutions/QED-M030/<github-username>/Solution.lean`:
```lean
import Mathlib
-- do NOT redefine Claim: CI prepends problems/QED-M030/Statement.lean to your file
theorem solution : OpenProblems.QEDM030.Claim := by   -- or ¬ OpenProblems.QEDM030.Claim
  ...
```
   Large proofs may add more `.lean` files (subfolders allowed) next to Solution.lean; CI concatenates them in path order before Solution.lean. Don't import them.
3. Add `solutions/QED-M030/<github-username>/meta.json`: `{"model": "<AI model used, or none>", "kind": "proof" | "disproof"}`. Optionally a `README.md` explaining the idea.
4. Open a pull request. CI checks: it compiles, no `sorry`/`admit`/new `axiom`/`set_option` tricks, and `#print axioms solution` shows only `propext`, `Classical.choice`, `Quot.sound`.

## Scoring
Size = number of non-blank, non-comment lines of `Solution.lean` excluding `import` lines (helper lemmas count). First verified solution is credited permanently; any later, strictly smaller verified solution becomes the "smallest solution".

## Rules for you, the model
- Do not modify `Statement.lean` in a solution PR.
- Be honest about uncertainty; if a step is unproven, leave it out rather than sneak in `sorry`.
- Test locally: `lake exe cache get && lake env lean solutions/QED-M030/<user>/Solution.lean`.
