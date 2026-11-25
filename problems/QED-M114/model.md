# QED-M114 — Is there an aperiodic polyomino?

You are an AI model helping someone attack this open problem. Read all of this before working.

## The problem
Main set · Grade A · QED Curated · Geometry

**Plain words:** A polyomino is a shape made of unit squares glued edge to edge with no holes. In 2023 a single tile was found that tiles the plane only non-periodically, but it is built from kites, not squares. Is there a polyomino that tiles the plane (rotations and reflections allowed) but has no tiling that a translation maps onto itself?

**Math:** A polyomino is a finite $P\subset\mathbb Z^2$ such that the union of the closed unit squares $c+[0,1]^2$, $c\in P$, is a closed topological disk. A tiling by $P$ is a set $\mathcal T$ of tiles $g(P)$, with $g(x)=Ax+b$, $A\in D_4\subset GL_2(\mathbb Z)$ and $b\in\mathbb Z^2$, that partition $\mathbb Z^2$. $P$ is aperiodic if some tiling exists but no tiling satisfies $\mathcal T+v=\mathcal T$ for any $v\in\mathbb Z^2\setminus\{0\}$. Problem: does an aperiodic polyomino exist? Board Claim: yes. A proof that every polyomino that tiles also has a periodic tiling settles the problem negatively. (Variant: allow holes, i.e. require only that $P$ is edge-connected.)

**Reviewer note:** Known: Translations only: a polyomino tiles iff it tiles isohedrally/periodically (Wijshoff-van Leeuwen 1984; Beauquier-Nivat 1991). k-anisohedral polyominoes known for k<=6 (Winslow survey, Open Problem 6 asks for k>=7). Aperiodic sets of 3 polyominoes (with isometries) known; aperiodic sets of 2 polyominoes unknown (Winslow, Open Problem 8); translational aperiodic sets of 7 polyominoes (Yang-Zhang arXiv:2412.17382). Undecidability for sets of 5 polyominoes (Ollinger 2009). Non-polyomino aperiodic monotiles: hat and spectre (Smith-Myers-Kaplan-Goodman-Strauss 2023/24, Combinatorial Theory). Survey: A. Winslow, 'Some open problems in polyomino tilings', DLT 2018.

**Credit:** Open problem as posed in A. Winslow, 'Some open problems in polyomino tilings' (DLT 2018); long-standing folklore (Golomb)

**Rests on recent unrefereed work. Check these premises first:**
- 'Polyomino' may be required to be simply connected in some sources; the Claim allows holes, which only makes the existence claim easier, so the vetter may prefer the simply connected version
- existence proofs would likely be computer-assisted substitution arguments, heavy but finite in Lean
- related to existing board items on hat/spectre tilings (M056, M057, N-117) but about a different tile class

**References:**
- https://andrewwinslow.com/papers/polyprobs-dlt18.pdf
- https://arxiv.org/abs/2412.17382
- https://arxiv.org/abs/2303.10798
- https://arxiv.org/abs/2305.17743

Difficulty estimate: 4.5/10 (calibrated: Collatz ≈ 5.5, twin primes ≈ 5.0). It is believed open; do not assume a quick answer exists, and say so plainly if you cannot make progress. Never present a heuristic, numerical evidence, or a partial result as a solution.

## What counts as an answer
Either a proof of `OpenProblems.QEDM114.Claim` or a proof of `¬ OpenProblems.QEDM114.Claim` (a disproof), in Lean 4 + Mathlib, using the exact statement in `problems/QED-M114/Statement.lean`. Read its "Formalization notes" first. If that file still says `def Claim : Prop := sorry`, the problem must first be formalized (see CONTRIBUTING.md); a faithful formalization is itself a welcome contribution.

If you think the Lean statement does not match the informal problem (it is trivially true or false, or it says something else), report that in an issue instead of exploiting it: such solutions are not credited.

## How to submit
1. Claim it (optional but encouraged): open an issue titled `Claim QED-M114` at https://github.com/floration/qed/issues/new?template=claim.yml. Comment on it at least once a week or the claim lapses.
2. Add `solutions/QED-M114/<github-username>/Solution.lean`:
```lean
import Mathlib
-- do NOT redefine Claim: CI prepends problems/QED-M114/Statement.lean to your file
theorem solution : OpenProblems.QEDM114.Claim := by   -- or ¬ OpenProblems.QEDM114.Claim
  ...
```
3. Add `solutions/QED-M114/<github-username>/meta.json`: `{"model": "<AI model used, or none>", "kind": "proof" | "disproof"}`. Optionally a `README.md` explaining the idea.
4. Open a pull request. CI checks: it compiles, no `sorry`/`admit`/new `axiom`/`set_option` tricks, and `#print axioms solution` shows only `propext`, `Classical.choice`, `Quot.sound`.

## Scoring
Size = number of non-blank, non-comment lines of `Solution.lean` excluding `import` lines (helper lemmas count). First verified solution is credited permanently; any later, strictly smaller verified solution becomes the "smallest solution".

## Rules for you, the model
- Do not modify `Statement.lean` in a solution PR.
- Be honest about uncertainty; if a step is unproven, leave it out rather than sneak in `sorry`.
- Test locally: `lake exe cache get && lake env lean solutions/QED-M114/<user>/Solution.lean`.
