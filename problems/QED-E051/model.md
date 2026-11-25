# QED-E051 — Translational tiling of the plane with two tiles: decidable?

You are an AI model helping someone attack this open problem. Read all of this before working.

## The problem
Extended set · Grade B- · QED Curated · Logic & computability

**Plain words:** You are given two shapes made of grid squares, and you may only slide copies of them around, never rotate them. Can copies of the two shapes cover the whole infinite grid with no gaps or overlaps? With one shape there is an algorithm that always answers this. With three shapes, one of them in several pieces, it was proved in 2025 that no algorithm can exist. Two shapes is the open case.

**Math:** Given finite $F_1,F_2\subset\mathbb Z^2$, decide whether there exist $A_1,A_2\subseteq\mathbb Z^2$ with $(F_1+A_1)\sqcup(F_2+A_2)=\mathbb Z^2$, i.e. every point of $\mathbb Z^2$ lies in exactly one translate $F_j+a$, $a\in A_j$. Is this problem decidable? (Variant: also require $F_1,F_2$ to be connected polyominoes.)

**Reviewer note:** Known: k=1: decidable (Beauquier–Nivat 1991 for polyominoes; Bhattacharya 2020, periodic tiling conjecture in $\mathbb Z^2$, for arbitrary finite $F$). k=3: co-RE-complete with three polyominoes, one disconnected and two connected of constant size; two trominoes suffice for a periodic subset of 2D (Abel, Akitaya, Chung, Demaine et al., 'Undecidability of Tiling with a Tromino', arXiv:2509.07906, 2025; Table 3 lists 2D/2 pieces/translation as OPEN). k=4, possibly disconnected: Yang–Zhang, arXiv:2506.19295 (2025), who list the two-tile case as open. k=5 connected: Kim, arXiv:2508.10067. Two tiles in $\mathbb Z^2\times G_0$: undecidable (Greenfeld–Tao, arXiv:2108.07902). With rotations, two tiles: undecidable (arXiv:2506.11628). A single polycube in 3D, translations only: undecidable (arXiv:2610.12392, Oct 2026).

**Credit:** Yang & Zhang, arXiv 2506.19295 (open problem stated); Abel et al., arXiv 2509.07906 (Table 3)

**Rests on recent unrefereed work. Check these premises first:**
- Fast-moving area (k went 5→4→3 in 2025, and the 3D monotile in 2026); a late-2026 preprint could settle k=2
- Connected vs. possibly-disconnected tiles may differ; the main statement allows arbitrary finite tiles

**References:**
- https://arxiv.org/abs/2509.07906
- https://arxiv.org/abs/2506.19295
- https://arxiv.org/abs/2108.07902
- https://arxiv.org/abs/2506.11628
- https://arxiv.org/abs/2610.12392
- https://arxiv.org/abs/2508.10067

Difficulty estimate: 6.0/10 (calibrated: Collatz ≈ 5.5, twin primes ≈ 5.0). It is believed open; do not assume a quick answer exists, and say so plainly if you cannot make progress. Never present a heuristic, numerical evidence, or a partial result as a solution.

## What counts as an answer
Either a proof of `OpenProblems.QEDE051.Claim` or a proof of `¬ OpenProblems.QEDE051.Claim` (a disproof), in Lean 4 + Mathlib, using the exact statement in `problems/QED-E051/Statement.lean`. Read its "Formalization notes" first. If that file still says `def Claim : Prop := sorry`, the problem must first be formalized (see CONTRIBUTING.md); a faithful formalization is itself a welcome contribution.

If you think the Lean statement does not match the informal problem (it is trivially true or false, or it says something else), report that in an issue instead of exploiting it: such solutions are not credited.

## How to submit
1. Claim it (optional but encouraged): open an issue titled `Claim QED-E051` at https://github.com/floration/qed/issues/new?template=claim.yml. Comment on it at least once a week or the claim lapses.
2. Add `solutions/QED-E051/<github-username>/Solution.lean`:
```lean
import Mathlib
-- do NOT redefine Claim: CI prepends problems/QED-E051/Statement.lean to your file
theorem solution : OpenProblems.QEDE051.Claim := by   -- or ¬ OpenProblems.QEDE051.Claim
  ...
```
3. Add `solutions/QED-E051/<github-username>/meta.json`: `{"model": "<AI model used, or none>", "kind": "proof" | "disproof"}`. Optionally a `README.md` explaining the idea.
4. Open a pull request. CI checks: it compiles, no `sorry`/`admit`/new `axiom`/`set_option` tricks, and `#print axioms solution` shows only `propext`, `Classical.choice`, `Quot.sound`.

## Scoring
Size = number of non-blank, non-comment lines of `Solution.lean` excluding `import` lines (helper lemmas count). First verified solution is credited permanently; any later, strictly smaller verified solution becomes the "smallest solution".

## Rules for you, the model
- Do not modify `Statement.lean` in a solution PR.
- Be honest about uncertainty; if a step is unproven, leave it out rather than sneak in `sorry`.
- Test locally: `lake exe cache get && lake env lean solutions/QED-E051/<user>/Solution.lean`.
