# QED-E052 — A shape with Heesch number 7

You are an AI model helping someone attack this open problem. Read all of this before working.

## The problem
Extended set · Grade B- · QED Curated · Geometry

**Plain words:** Some shapes cannot tile the whole plane but can still be surrounded by a ring of copies of themselves, and that ring by another ring, and so on, up to some limit. The number of rings possible is the shape's Heesch number. The record is 6, found in 2021. Find a shape whose Heesch number is finite but at least 7.

**Math:** For a closed topological disk $T\subset\mathbb R^2$ that does not tile the plane, the Heesch number $H(T)$ is the largest $k$ such that there is a patch of congruent copies of $T$ made of $T$ surrounded by $k$ successive coronas. Each corona is a ring of copies covering a neighbourhood of the previous patch's boundary, and each intermediate union must be a closed disk (no holes). Exhibit $T$ with $7\le H(T)<\infty$. Polyform version: exhibit a polyomino, polyhex or polyiamond with $7\le H<\infty$.

**Reviewer note:** Known: Record $H=6$ (B. Bašić, 2021). Kaplan's SAT method ('Heesch numbers of unmarked polyforms', arXiv:2105.09438, Contrib. Discrete Math. 17 (2022)) computed Heesch numbers exhaustively for polyforms up to 19-ominoes, 17-hexes and 24-iamonds and found nothing above the record. In $\mathbb E^3$, finite Heesch numbers are unbounded (arXiv:2610.24281, Oct 2026), which says nothing about the plane. Listed as unsolved by Epoch AI FrontierMath (hole-free $H_c$ convention, with a 200-cell polyform witness format).

**Credit:** Heesch (1968); Bašić (2021); posed as a target by Epoch AI FrontierMath open problems

**Rests on recent unrefereed work. Check these premises first:**
- Already a public FrontierMath target, so it is curated rather than new
- Corona conventions: hole-free vs holes-allowed outer corona (H_h ∈ {H_c, H_c+1}); fix hole-free
- No shape with H=7 may exist; then the problem is a (hard) impossibility question

**References:**
- https://epoch.ai/frontiermath/open-problems/heesch-number
- https://arxiv.org/abs/2105.09438
- https://arxiv.org/pdf/2509.12216
- https://arxiv.org/pdf/2610.24281

Difficulty estimate: 4.5/10 (calibrated: Collatz ≈ 5.5, twin primes ≈ 5.0). It is believed open; do not assume a quick answer exists, and say so plainly if you cannot make progress. Never present a heuristic, numerical evidence, or a partial result as a solution.

## What counts as an answer
Either a proof of `OpenProblems.QEDE052.Claim` or a proof of `¬ OpenProblems.QEDE052.Claim` (a disproof), in Lean 4 + Mathlib, using the exact statement in `problems/QED-E052/Statement.lean`. Read its "Formalization notes" first. If that file still says `def Claim : Prop := sorry`, the problem must first be formalized (see CONTRIBUTING.md); a faithful formalization is itself a welcome contribution. What is missing: Mathlib lacks closed topological disks as tiles, patches and coronas of congruent copies, and a usable 'union is a closed disk' (simple connectivity of polyform unions) predicate. The polyomino version is finitary but needs a combinatorial hole-free corona definition that is error-prone to write without a checker.

If you think the Lean statement does not match the informal problem (it is trivially true or false, or it says something else), report that in an issue instead of exploiting it: such solutions are not credited.

## How to submit
1. Claim it (optional but encouraged): open an issue titled `Claim QED-E052` at https://github.com/floration/qed/issues/new?template=claim.yml. Comment on it at least once a week or the claim lapses.
2. Add `solutions/QED-E052/<github-username>/Solution.lean`:
```lean
import Mathlib
-- do NOT redefine Claim: CI prepends problems/QED-E052/Statement.lean to your file
theorem solution : OpenProblems.QEDE052.Claim := by   -- or ¬ OpenProblems.QEDE052.Claim
  ...
```
3. Add `solutions/QED-E052/<github-username>/meta.json`: `{"model": "<AI model used, or none>", "kind": "proof" | "disproof"}`. Optionally a `README.md` explaining the idea.
4. Open a pull request. CI checks: it compiles, no `sorry`/`admit`/new `axiom`/`set_option` tricks, and `#print axioms solution` shows only `propext`, `Classical.choice`, `Quot.sound`.

## Scoring
Size = number of non-blank, non-comment lines of `Solution.lean` excluding `import` lines (helper lemmas count). First verified solution is credited permanently; any later, strictly smaller verified solution becomes the "smallest solution".

## Rules for you, the model
- Do not modify `Statement.lean` in a solution PR.
- Be honest about uncertainty; if a step is unproven, leave it out rather than sneak in `sorry`.
- Test locally: `lake exe cache get && lake env lean solutions/QED-E052/<user>/Solution.lean`.
