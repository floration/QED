# QED-E027 — Largest cap set in F_3^7

You are an AI model helping someone attack this open problem. Read all of this before working.

## The problem
Extended set · Grade C · QED Curated · Combinatorics

**Plain words:** A cap set is a set of points in the 7-dimensional grid {0,1,2}^7 (arithmetic mod 3) containing no three points on a line. The biggest known one has 236 points, and it is known that 289 points is impossible. Find a bigger cap or prove a better upper bound.

**Math:** Let $r_3(7)$ be the maximum size of $A\subseteq\mathbb F_3^7$ containing no three distinct points $x,y,z$ with $x+y+z=0$ (equivalently, no three collinear points). Known: $236\le r_3(7)\le 288$. Improve either bound; in particular, is there a cap of size $237$? Ultimately determine $r_3(7)$.

**Reviewer note:** Known: Lower 236: Edel et al. construction (Edel's cap tables), matched but not beaten by FunSearch (Romera-Paredes et al., Nature 2023) and X-evolve (arXiv:2508.07932, best known 236 in dimension 7, 512 in dimension 8). Upper 288: Thackeray, 'The cap set problem: up to dimension 7', arXiv:2206.09804, Theorem 4.2 (no 289-cap 7-flat, hence no larger cap). Exact values known through dimension 6 (r_3(6)=112, Potechin 2008).

**Credit:** Edel; Potechin; Thackeray (2022).

**Rests on recent unrefereed work. Check these premises first:**
- Thackeray's no-289 result is an arXiv paper with computer-assisted counting; refereed status unclear
- Large gap; exact value may be out of reach

**References:**
- https://arxiv.org/abs/2206.09804
- https://arxiv.org/abs/2508.07932
- https://en.wikipedia.org/wiki/Cap_set

Difficulty estimate: 5.0/10 (anchored scale: 1 ≈ Erdős–Ginzburg–Ziv, 2.5 ≈ the sensitivity conjecture, 5 ≈ bounded prime gaps, 7.5 ≈ the Riemann Hypothesis, 10 ≈ P vs NP). It is believed open; do not assume a quick answer exists, and say so plainly if you cannot make progress. Never present a heuristic, numerical evidence, or a partial result as a solution.

## What counts as an answer
Either a proof of `OpenProblems.QEDE027.Claim` or a proof of `¬ OpenProblems.QEDE027.Claim` (a disproof), in Lean 4 + Mathlib, using the exact statement in `problems/QED-E027/Statement.lean`. Read its "Formalization notes" first. If that file still says `def Claim : Prop := sorry`, the problem must first be formalized (see CONTRIBUTING.md); a faithful formalization is itself a welcome contribution.

If you think the Lean statement does not match the informal problem (it is trivially true or false, or it says something else), report that in an issue instead of exploiting it: such solutions are not credited.

## How to submit
0. First time? Solve a test problem (QED-Q1, the 2-line one, at minimum) and submit it, to confirm your Lean setup and the submission pipeline work before spending effort here. Skip this step if this IS a test problem.
1. Claim it (optional but encouraged): open an issue titled `Claim QED-E027` at https://github.com/floration/qed/issues/new?template=claim.yml. Comment on it at least once a week or the claim lapses.
2. Add `solutions/QED-E027/<github-username>/Solution.lean`:
```lean
import Mathlib
-- do NOT redefine Claim: CI prepends problems/QED-E027/Statement.lean to your file
theorem solution : OpenProblems.QEDE027.Claim := by   -- or ¬ OpenProblems.QEDE027.Claim
  ...
```
   Large proofs may add more `.lean` files (subfolders allowed) next to Solution.lean; CI concatenates them in path order before Solution.lean. Don't import them.
3. Add `solutions/QED-E027/<github-username>/meta.json`: `{"model": "<AI model used, or none>", "kind": "proof" | "disproof"}`. Optionally a `README.md` explaining the idea.
4. Open a pull request. CI checks: it compiles, no `sorry`/`admit`/new `axiom`/`set_option` tricks, and `#print axioms solution` shows only `propext`, `Classical.choice`, `Quot.sound`.

## Scoring
Size = number of non-blank, non-comment lines of `Solution.lean` excluding `import` lines (helper lemmas count). First verified solution is credited permanently; any later, strictly smaller verified solution becomes the "smallest solution".

## Rules for you, the model
- Do not modify `Statement.lean` in a solution PR.
- Be honest about uncertainty; if a step is unproven, leave it out rather than sneak in `sorry`.
- Test locally: `lake exe cache get && lake env lean solutions/QED-E027/<user>/Solution.lean`.
