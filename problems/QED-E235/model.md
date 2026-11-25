# QED-E235 — Is tiling by a single polykite decidable?

You are an AI model helping someone attack this open problem. Read all of this before working.

## The problem
Extended set · Grade B · QED Extension · Geometry

**Plain words:** A polykite is a shape glued from kites of the kite grid (the hat monotile is one). Find an algorithm that decides, for any single polykite, whether copies of it can tile the plane, or prove that no such algorithm exists.

**Math:** Let $\mathcal K$ be the deltoidal trihexagonal (Laves $[3.4.6.4]$) tiling of $\mathbb R^2$ by congruent kites. A polykite is a union $P$ of finitely many tiles of $\mathcal K$ that is a closed topological disk. $P$ tiles the plane if $\mathbb R^2=\bigcup_j g_j(P)$ with $g_j$ isometries of $\mathbb R^2$ (reflections allowed) and the $g_j(P)$ having pairwise disjoint interiors. Is the set $\{P:\ P$ tiles the plane$\}$ decidable? (Variant: restrict to $g_j$ in the symmetry group of $\mathcal K$, i.e. kite-grid-aligned tilings.)

**Credit:** QED original (archived Nov 2026, restored after re-review).

**References:**
- https://arxiv.org/abs/2303.10798
- https://arxiv.org/html/2509.12216v1
- https://arxiv.org/html/2508.10067v1
- https://arxiv.org/pdf/2506.11628
- https://arxiv.org/pdf/2309.09504
- https://arxiv.org/pdf/2509.12216

Difficulty estimate: 6.5/10 (anchored scale: 1 ≈ Erdős–Ginzburg–Ziv, 2.5 ≈ the sensitivity conjecture, 5 ≈ bounded prime gaps, 7.5 ≈ the Riemann Hypothesis, 10 ≈ P vs NP). It is believed open; do not assume a quick answer exists, and say so plainly if you cannot make progress. Never present a heuristic, numerical evidence, or a partial result as a solution.

## What counts as an answer
Either a proof of `OpenProblems.QEDE235.Claim` or a proof of `¬ OpenProblems.QEDE235.Claim` (a disproof), in Lean 4 + Mathlib, using the exact statement in `problems/QED-E235/Statement.lean`. Read its "Formalization notes" first. If that file still says `def Claim : Prop := sorry`, the problem must first be formalized (see CONTRIBUTING.md); a faithful formalization is itself a welcome contribution.

If you think the Lean statement does not match the informal problem (it is trivially true or false, or it says something else), report that in an issue instead of exploiting it: such solutions are not credited.

## How to submit
0. First time? Solve a test problem (QED-Q1, the 2-line one, at minimum) and submit it, to confirm your Lean setup and the submission pipeline work before spending effort here. Skip this step if this IS a test problem.
1. Claim it (optional but encouraged): open an issue titled `Claim QED-E235` at https://github.com/floration/qed/issues/new?template=claim.yml. Comment on it at least once a week or the claim lapses.
2. Add `solutions/QED-E235/<github-username>/Solution.lean`:
```lean
import Mathlib
-- do NOT redefine Claim: CI prepends problems/QED-E235/Statement.lean to your file
theorem solution : OpenProblems.QEDE235.Claim := by   -- or ¬ OpenProblems.QEDE235.Claim
  ...
```
   Large proofs may add more `.lean` files (subfolders allowed) next to Solution.lean; CI concatenates them in path order before Solution.lean. Don't import them.
3. Add `solutions/QED-E235/<github-username>/meta.json`: `{"model": "<AI model used, or none>", "kind": "proof" | "disproof"}`. Optionally a `README.md` explaining the idea.
4. Open a pull request. CI checks: it compiles, no `sorry`/`admit`/new `axiom`/`set_option` tricks, and `#print axioms solution` shows only `propext`, `Classical.choice`, `Quot.sound`.

## Scoring
Size = number of non-blank, non-comment lines of `Solution.lean` excluding `import` lines (helper lemmas count). First verified solution is credited permanently; any later, strictly smaller verified solution becomes the "smallest solution".

## Rules for you, the model
- Do not modify `Statement.lean` in a solution PR.
- Be honest about uncertainty; if a step is unproven, leave it out rather than sneak in `sorry`.
- Test locally: `lake exe cache get && lake env lean solutions/QED-E235/<user>/Solution.lean`.
