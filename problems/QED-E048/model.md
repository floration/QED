# QED-E048 — Equilateral stick number versus stick number

You are an AI model helping someone attack this open problem. Read all of this before working.

## The problem
Extended set · Grade B- · QED Curated · Topology

**Plain words:** Build a knot out of straight sticks joined end to end. The stick number of a knot is the fewest sticks that can make it. If all the sticks must also be the same length, you might need more. Is there any knot that really does need more sticks when they all have to be the same length?

**Math:** For a knot type $K$ let $s(K)$ be the minimum number of edges of a polygonal knot of type $K$, and $s_{eq}(K)$ the minimum over equilateral polygons. Formal Claim: there is a knot type $K$ with $s_{eq}(K)>s(K)$ (¬Claim: $s_{eq}=s$ for all $K$; the infinite-family variant is not formalized).

**Reviewer note:** Known: Posed by Rawdon–Scharein (2002). After the equilateral 9-stick $9_{29}$ (Theorem 4, proved via a Millett–Rawdon perturbation condition), no knot with ≤10 crossings has differing best known bounds for $s$ and $s_{eq}$ (Cantarella–Rechnitzer–Schumacher–Shonkwiler, arXiv:2508.18263, Sec. 4). Lower bounds for $s$ (Calvo's crossing-number bound, superbridge index) do not depend on edge lengths. Upper bounds on $s_{eq}$ in terms of crossing number: Kim–No–Oh, arXiv:1401.7383.

**Credit:** Rawdon & Scharein (2002); restated as open in Cantarella–Rechnitzer–Schumacher–Shonkwiler, arXiv 2508.18263

**Rests on recent unrefereed work. Check these premises first:**
- A strict gap needs exact lower bounds on s_eq, so the problem may be out of reach in practice
- Exact s(K) is unknown for many ≤10-crossing knots; 'agree' means only that the best known bounds coincide

**References:**
- https://arxiv.org/abs/2508.18263
- https://arxiv.org/abs/1401.7383
- https://arxiv.org/abs/1909.00917
- https://cecm-colab.dcr.sfu.ca/KnotPlot/ktheory.html

Difficulty estimate: 5.0/10 (anchored scale: 1 ≈ Erdős–Ginzburg–Ziv, 2.5 ≈ the sensitivity conjecture, 5 ≈ bounded prime gaps, 7.5 ≈ the Riemann Hypothesis, 10 ≈ P vs NP). It is believed open; do not assume a quick answer exists, and say so plainly if you cannot make progress. Never present a heuristic, numerical evidence, or a partial result as a solution.

## What counts as an answer
Either a proof of `OpenProblems.QEDE048.Claim` or a proof of `¬ OpenProblems.QEDE048.Claim` (a disproof), in Lean 4 + Mathlib, using the exact statement in `problems/QED-E048/Statement.lean`. Read its "Formalization notes" first. If that file still says `def Claim : Prop := sorry`, the problem must first be formalized (see CONTRIBUTING.md); a faithful formalization is itself a welcome contribution.

If you think the Lean statement does not match the informal problem (it is trivially true or false, or it says something else), report that in an issue instead of exploiting it: such solutions are not credited.

## How to submit
0. First time? Solve a test problem (QED-Q1, the 2-line one, at minimum) and submit it, to confirm your Lean setup and the submission pipeline work before spending effort here. Skip this step if this IS a test problem.
1. Claim it (optional but encouraged): open an issue titled `Claim QED-E048` at https://github.com/floration/qed/issues/new?template=claim.yml. Comment on it at least once a week or the claim lapses.
2. Add `solutions/QED-E048/<github-username>/Solution.lean`:
```lean
import Mathlib
-- do NOT redefine Claim: CI prepends problems/QED-E048/Statement.lean to your file
theorem solution : OpenProblems.QEDE048.Claim := by   -- or ¬ OpenProblems.QEDE048.Claim
  ...
```
   Large proofs may add more `.lean` files (subfolders allowed) next to Solution.lean; CI concatenates them in path order before Solution.lean. Don't import them.
3. Add `solutions/QED-E048/<github-username>/meta.json`: `{"model": "<AI model used, or none>", "kind": "proof" | "disproof"}`. Optionally a `README.md` explaining the idea.
4. Open a pull request. CI checks: it compiles, no `sorry`/`admit`/new `axiom`/`set_option` tricks, and `#print axioms solution` shows only `propext`, `Classical.choice`, `Quot.sound`.

## Scoring
Size = number of non-blank, non-comment lines of `Solution.lean` excluding `import` lines (helper lemmas count). First verified solution is credited permanently; any later, strictly smaller verified solution becomes the "smallest solution".

## Rules for you, the model
- Do not modify `Statement.lean` in a solution PR.
- Be honest about uncertainty; if a step is unproven, leave it out rather than sneak in `sorry`.
- Test locally: `lake exe cache get && lake env lean solutions/QED-E048/<user>/Solution.lean`.
