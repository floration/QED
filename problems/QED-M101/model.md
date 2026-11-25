# QED-M101 — Infinitely many knot types in the symmetric ABC flow

You are an AI model helping someone attack this open problem. Read all of this before working.

## The problem
Main set · Grade B · QED Extension · Topology

**Plain words:** Steady Euler flows can carry knotted streamlines, and generic high-frequency Beltrami fields on the torus contain every knot. Show that the most-studied explicit example, the ABC flow with A = B = C = 1, has closed streamlines tied in infinitely many different knots.

**Math:** Let $X=(\sin z+\cos y,\ \sin x+\cos z,\ \sin y+\cos x)$ on $\mathbb T^3=(\mathbb R/2\pi\mathbb Z)^3$ (a curl eigenfield, $\nabla\times X=X$). Prove that the periodic orbits of $X$ that lie in some embedded 3-ball $B\subset\mathbb T^3$ realize infinitely many distinct knot types (as knots in $B\cong$ a ball in $\mathbb R^3$). Stronger: every knot type is realized.

**Credit:** Etnyre & Ghrist (2000), arXiv:math-ph/9906021; Enciso, Peralta-Salas (and Romaniega), arXiv:2006.15033.

**Rests on recent unrefereed work. Check these premises first:**
- arXiv:2609.17449 (Szumiński–Llibre, 2026 preprint): cited only as related perturbative work; nothing in the statement depends on it.

**References:**
- https://arxiv.org/pdf/math-ph/9906021
- https://arxiv.org/pdf/1601.02724
- https://arxiv.org/pdf/2609.17449
- https://arxiv.org/pdf/2006.15033
- https://www2.math.upenn.edu/%7Eghrist/preprints/beltrami.pdf

Difficulty estimate: 4.5/10 (calibrated: Collatz ≈ 5.5, twin primes ≈ 5.0). It is believed open; do not assume a quick answer exists, and say so plainly if you cannot make progress. Never present a heuristic, numerical evidence, or a partial result as a solution.

## What counts as an answer
Either a proof of `OpenProblems.QEDM101.Claim` or a proof of `¬ OpenProblems.QEDM101.Claim` (a disproof), in Lean 4 + Mathlib, using the exact statement in `problems/QED-M101/Statement.lean`. Read its "Formalization notes" first. If that file still says `def Claim : Prop := sorry`, the problem must first be formalized (see CONTRIBUTING.md); a faithful formalization is itself a welcome contribution.

If you think the Lean statement does not match the informal problem (it is trivially true or false, or it says something else), report that in an issue instead of exploiting it: such solutions are not credited.

## How to submit
0. First time? Solve a test problem (QED-Q1, the 2-line one, at minimum) and submit it, to confirm your Lean setup and the submission pipeline work before spending effort here. Skip this step if this IS a test problem.
1. Claim it (optional but encouraged): open an issue titled `Claim QED-M101` at https://github.com/floration/qed/issues/new?template=claim.yml. Comment on it at least once a week or the claim lapses.
2. Add `solutions/QED-M101/<github-username>/Solution.lean`:
```lean
import Mathlib
-- do NOT redefine Claim: CI prepends problems/QED-M101/Statement.lean to your file
theorem solution : OpenProblems.QEDM101.Claim := by   -- or ¬ OpenProblems.QEDM101.Claim
  ...
```
3. Add `solutions/QED-M101/<github-username>/meta.json`: `{"model": "<AI model used, or none>", "kind": "proof" | "disproof"}`. Optionally a `README.md` explaining the idea.
4. Open a pull request. CI checks: it compiles, no `sorry`/`admit`/new `axiom`/`set_option` tricks, and `#print axioms solution` shows only `propext`, `Classical.choice`, `Quot.sound`.

## Scoring
Size = number of non-blank, non-comment lines of `Solution.lean` excluding `import` lines (helper lemmas count). First verified solution is credited permanently; any later, strictly smaller verified solution becomes the "smallest solution".

## Rules for you, the model
- Do not modify `Statement.lean` in a solution PR.
- Be honest about uncertainty; if a step is unproven, leave it out rather than sneak in `sorry`.
- Test locally: `lake exe cache get && lake env lean solutions/QED-M101/<user>/Solution.lean`.
