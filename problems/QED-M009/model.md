# QED-M009 — Hearing tetrahedra

You are an AI model helping someone attack this open problem. Read all of this before working.

## The problem
Main set · Grade A · QED Extension · Analysis

**Plain words:** Triangles can be heard: their Dirichlet spectrum determines them up to congruence (Durso 1988; Grieser–Maronna 2013). Show the same for tetrahedra.

**Math:** Let $T_1,T_2\subset\mathbb R^3$ be (nondegenerate) tetrahedra whose Dirichlet Laplacian eigenvalues, counted with multiplicity, coincide. Prove that $T_1$ and $T_2$ are congruent.

**Credit:** Extends Durso (1988, MIT thesis) and Grieser-Maronna, 'Hearing the shape of a triangle' (Notices AMS 2013, arXiv:1208.3163); Kac's question.

**QED results so far (reviewer-derived; check before relying on them):** The heat-invariant count is correct. The polyhedral Dirichlet heat trace gives volume, surface area, the edge sum of L_e times a function of the dihedral angle, and a vertex term (not explicit for general solid angles): 4 numbers against 6 congruence parameters. So the heat trace alone is insufficient.

**Rests on recent unrefereed work. Check these premises first:**
- arXiv:2609.28602 (Krejcirik, 2026 survey): used only for the openness check (does not settle the problem); the statement itself assumes nothing from it.

**References:**
- https://arxiv.org/abs/1208.3163
- https://arxiv.org/pdf/2406.18369
- https://arxiv.org/pdf/1911.06758
- https://arxiv.org/pdf/2009.00714
- https://arxiv.org/abs/1208.3163
- https://arxiv.org/pdf/1911.06758
- https://arxiv.org/pdf/2012.06465
- https://arxiv.org/pdf/2609.28602

Difficulty estimate: 5.5/10 (anchored scale: 1 ≈ Erdős–Ginzburg–Ziv, 2.5 ≈ the sensitivity conjecture, 5 ≈ bounded prime gaps, 7.5 ≈ the Riemann Hypothesis, 10 ≈ P vs NP). It is believed open; do not assume a quick answer exists, and say so plainly if you cannot make progress. Never present a heuristic, numerical evidence, or a partial result as a solution.

## What counts as an answer
Either a proof of `OpenProblems.QEDM009.Claim` or a proof of `¬ OpenProblems.QEDM009.Claim` (a disproof), in Lean 4 + Mathlib, using the exact statement in `problems/QED-M009/Statement.lean`. Read its "Formalization notes" first. If that file still says `def Claim : Prop := sorry`, the problem must first be formalized (see CONTRIBUTING.md); a faithful formalization is itself a welcome contribution.

If you think the Lean statement does not match the informal problem (it is trivially true or false, or it says something else), report that in an issue instead of exploiting it: such solutions are not credited.

## How to submit
0. First time? Solve a test problem (QED-Q1, the 2-line one, at minimum) and submit it, to confirm your Lean setup and the submission pipeline work before spending effort here. Skip this step if this IS a test problem.
1. Claim it (optional but encouraged): open an issue titled `Claim QED-M009` at https://github.com/floration/qed/issues/new?template=claim.yml. Comment on it at least once a week or the claim lapses.
2. Add `solutions/QED-M009/<github-username>/Solution.lean`:
```lean
import Mathlib
-- do NOT redefine Claim: CI prepends problems/QED-M009/Statement.lean to your file
theorem solution : OpenProblems.QEDM009.Claim := by   -- or ¬ OpenProblems.QEDM009.Claim
  ...
```
   Large proofs may add more `.lean` files (subfolders allowed) next to Solution.lean; CI concatenates them in path order before Solution.lean. Don't import them.
3. Add `solutions/QED-M009/<github-username>/meta.json`: `{"model": "<AI model used, or none>", "kind": "proof" | "disproof"}`. Optionally a `README.md` explaining the idea.
4. Open a pull request. CI checks: it compiles, no `sorry`/`admit`/new `axiom`/`set_option` tricks, and `#print axioms solution` shows only `propext`, `Classical.choice`, `Quot.sound`.

## Scoring
Size = number of non-blank, non-comment lines of `Solution.lean` excluding `import` lines (helper lemmas count). First verified solution is credited permanently; any later, strictly smaller verified solution becomes the "smallest solution".

## Rules for you, the model
- Do not modify `Statement.lean` in a solution PR.
- Be honest about uncertainty; if a step is unproven, leave it out rather than sneak in `sorry`.
- Test locally: `lake exe cache get && lake env lean solutions/QED-M009/<user>/Solution.lean`.
