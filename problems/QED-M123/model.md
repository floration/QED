# QED-M123 — Halving planes in 3-space: beat n^{5/2}

You are an AI model helping someone attack this open problem. Read all of this before working.

## The problem
Extended set · Grade A · QED Curated · Geometry

**Plain words:** Take n points in 3-space, with n odd and no four on a common plane. A halving triangle is a triple of the points whose plane splits the remaining n-3 points evenly, half on each side. The best upper bound on the number of halving triangles, about n^{5/2}, has not been improved since 2001. Show that the exponent 5/2 can be lowered.

**Math:** For $S\subset\mathbb{R}^3$ with $|S|=n$ odd and no four points coplanar, let $h(S)$ be the number of $3$-subsets $T\subseteq S$ such that each open half-space bounded by $\operatorname{aff}(T)$ contains exactly $(n-3)/2$ points of $S$. Prove that there exist $\varepsilon>0$ and $C$ with $h(S)\le C\,n^{5/2-\varepsilon}$ for all such $S$.

**Credit:** Problem of bounding halving planes / k-sets in R^3 (Barany-Furedi-Lovasz 1990, Dey-Edelsbrunner, Sharir-Smorodinsky-Tardos)

**Rests on recent unrefereed work. Check these premises first:**
- OpenAI's unrefereed 2026 preprint claims a power saving for planar halving lines; if its method extends, 3D could fall quickly

**References:**
- https://dl.acm.org/doi/10.1007/s00454-001-0005-3
- https://arxiv.org/abs/2403.00412
- https://arxiv.org/abs/1903.07196
- https://jeffe.cs.illinois.edu/open/ksets.html

Difficulty estimate: 5.0/10 (anchored scale: 1 ≈ Erdős–Ginzburg–Ziv, 2.5 ≈ the sensitivity conjecture, 5 ≈ bounded prime gaps, 7.5 ≈ the Riemann Hypothesis, 10 ≈ P vs NP). It is believed open; do not assume a quick answer exists, and say so plainly if you cannot make progress. Never present a heuristic, numerical evidence, or a partial result as a solution.

## What counts as an answer
Either a proof of `OpenProblems.QEDM123.Claim` or a proof of `¬ OpenProblems.QEDM123.Claim` (a disproof), in Lean 4 + Mathlib, using the exact statement in `problems/QED-M123/Statement.lean`. Read its "Formalization notes" first. If that file still says `def Claim : Prop := sorry`, the problem must first be formalized (see CONTRIBUTING.md); a faithful formalization is itself a welcome contribution.

If you think the Lean statement does not match the informal problem (it is trivially true or false, or it says something else), report that in an issue instead of exploiting it: such solutions are not credited.

## How to submit
0. First time? Solve a test problem (QED-Q1, the 2-line one, at minimum) and submit it, to confirm your Lean setup and the submission pipeline work before spending effort here. Skip this step if this IS a test problem.
1. Claim it (optional but encouraged): open an issue titled `Claim QED-M123` at https://github.com/floration/qed/issues/new?template=claim.yml. Comment on it at least once a week or the claim lapses.
2. Add `solutions/QED-M123/<github-username>/Solution.lean`:
```lean
import Mathlib
-- do NOT redefine Claim: CI prepends problems/QED-M123/Statement.lean to your file
theorem solution : OpenProblems.QEDM123.Claim := by   -- or ¬ OpenProblems.QEDM123.Claim
  ...
```
   Large proofs may add more `.lean` files (subfolders allowed) next to Solution.lean; CI concatenates them in path order before Solution.lean. Don't import them.
3. Add `solutions/QED-M123/<github-username>/meta.json`: `{"model": "<AI model used, or none>", "kind": "proof" | "disproof"}`. Optionally a `README.md` explaining the idea.
4. Open a pull request. CI checks: it compiles, no `sorry`/`admit`/new `axiom`/`set_option` tricks, and `#print axioms solution` shows only `propext`, `Classical.choice`, `Quot.sound`.

## Scoring
Size = number of non-blank, non-comment lines of `Solution.lean` excluding `import` lines (helper lemmas count). First verified solution is credited permanently; any later, strictly smaller verified solution becomes the "smallest solution".

## Rules for you, the model
- Do not modify `Statement.lean` in a solution PR.
- Be honest about uncertainty; if a step is unproven, leave it out rather than sneak in `sorry`.
- Test locally: `lake exe cache get && lake env lean solutions/QED-M123/<user>/Solution.lean`.
