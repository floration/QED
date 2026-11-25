# QED-M057 — A strongly aperiodic monotile in four dimensions

You are an AI model helping someone attack this open problem. Read all of this before working.

## The problem
Main set · Grade A · QED Curated · Geometry · formerly N-106

**Plain words:** The hat (2023) is a single shape that tiles the plane only non-periodically, and in 2026 a 3D analogue was announced (Chair44, a decorated chair-shaped polycube). Find one connected 4D shape whose copies fill 4D space, where no tiling by it is left unchanged by any translation.

**Math:** Find a compact set $T\subset\mathbb R^4$ homeomorphic to a closed 4-ball such that (i) $\mathbb R^4$ admits a tiling by isometric copies of $T$ (reflections allowed; copies cover $\mathbb R^4$ with pairwise disjoint interiors), and (ii) no such tiling is invariant under any nonzero translation. (Drop the weak variant (ii'), or flag it as possibly easy via prisms over a 3D monotile.)

**Credit:** Kamenetsky 2026, arXiv:2610.00916, Problem 9.1 (context: Smith-Myers-Kaplan-Goodman-Strauss 2023, arXiv:2303.10798; Tsiokos 2026, arXiv:2609.19214)

**Rests on recent unrefereed work. Check these premises first:**
- arXiv:2609.19214 (Tsiokos, 2026, unrefereed): the claimed strongly aperiodic 3D monotile Chair44 that motivates the question; Claim does not depend on it.
- arXiv:2609.24779 (Goodman-Strauss, 2026, unrefereed): independent proof for Chair44; context only.
- arXiv:2610.00916 (Kamenetsky, 2026, unrefereed): reports a failed 4D search and poses the problem; context only.

**References:**
- https://arxiv.org/pdf/2303.10798
- https://arxiv.org/pdf/2609.19214
- https://arxiv.org/pdf/2609.23783
- https://arxiv.org/pdf/2609.24779
- https://arxiv.org/pdf/2610.00916
- https://arxiv.org/abs/2609.19214
- https://arxiv.org/abs/2609.24779
- https://arxiv.org/pdf/2610.00916
- https://arxiv.org/pdf/2303.10798

Difficulty estimate: 3.0/10 (calibrated: Collatz ≈ 5.5, twin primes ≈ 5.0). It is believed open; do not assume a quick answer exists, and say so plainly if you cannot make progress. Never present a heuristic, numerical evidence, or a partial result as a solution.

## What counts as an answer
Either a proof of `OpenProblems.QEDM057.Claim` or a proof of `¬ OpenProblems.QEDM057.Claim` (a disproof), in Lean 4 + Mathlib, using the exact statement in `problems/QED-M057/Statement.lean`. Read its "Formalization notes" first. If that file still says `def Claim : Prop := sorry`, the problem must first be formalized (see CONTRIBUTING.md); a faithful formalization is itself a welcome contribution.

If you think the Lean statement does not match the informal problem (it is trivially true or false, or it says something else), report that in an issue instead of exploiting it: such solutions are not credited.

## How to submit
1. Claim it (optional but encouraged): open an issue titled `Claim QED-M057` at https://github.com/floration/qed/issues/new?template=claim.yml. Comment on it at least once a week or the claim lapses.
2. Add `solutions/QED-M057/<github-username>/Solution.lean`:
```lean
import Mathlib
-- do NOT redefine Claim: CI prepends problems/QED-M057/Statement.lean to your file
theorem solution : OpenProblems.QEDM057.Claim := by   -- or ¬ OpenProblems.QEDM057.Claim
  ...
```
3. Add `solutions/QED-M057/<github-username>/meta.json`: `{"model": "<AI model used, or none>", "kind": "proof" | "disproof"}`. Optionally a `README.md` explaining the idea.
4. Open a pull request. CI checks: it compiles, no `sorry`/`admit`/new `axiom`/`set_option` tricks, and `#print axioms solution` shows only `propext`, `Classical.choice`, `Quot.sound`.

## Scoring
Size = number of non-blank, non-comment lines of `Solution.lean` excluding `import` lines (helper lemmas count). First verified solution is credited permanently; any later, strictly smaller verified solution becomes the "smallest solution".

## Rules for you, the model
- Do not modify `Statement.lean` in a solution PR.
- Be honest about uncertainty; if a step is unproven, leave it out rather than sneak in `sorry`.
- Test locally: `lake exe cache get && lake env lean solutions/QED-M057/<user>/Solution.lean`.
