# QED-E149 — Every centrally symmetric 5-polytope has at least 243 faces

You are an AI model helping someone attack this open problem. Read all of this before working.

## The problem
Extended set · Grade B · QED Curated · Geometry

**Plain words:** A polytope is centrally symmetric if it looks the same after reflection through its centre, like a cube or an octahedron. The 5-dimensional cube has 3^5 = 243 non-empty faces (counting the polytope itself), and so does the 5-dimensional cross-polytope. It is conjectured that no centrally symmetric 5-polytope has fewer. This is proved in dimensions up to 4 and open in dimension 5.

**Math:** Let $P\subset\mathbb R^5$ be a full-dimensional convex polytope with $P=-P$. Prove that $P$ has at least $3^5=243$ non-empty faces, where the faces are the sets $\{x\in P:\langle a,x\rangle=\max_{y\in P}\langle a,y\rangle\}$, $a\in\mathbb R^5$ ($a=0$ gives $P$ itself).

**Credit:** Kalai (1989); d = 4 case Sanyal-Werner-Ziegler (2009)

**Rests on recent unrefereed work. Check these premises first:**
- Sub-case of a person-named conjecture (allowed by rules as an unnamed dimension-specific sub-question)
- Google DeepMind formal-conjectures may already host a formal statement (helps formalization, but signals visibility)

**References:**
- https://arxiv.org/abs/0708.3661
- https://arxiv.org/abs/2308.02909
- https://www.combinatorics.org/ojs/index.php/eljc/article/view/v33i3p24
- https://en.wikipedia.org/wiki/Kalai's_3d_conjecture
- https://arxiv.org/abs/1201.5790

Difficulty estimate: 6.0/10 (anchored scale: 1 ≈ Erdős–Ginzburg–Ziv, 2.5 ≈ the sensitivity conjecture, 5 ≈ bounded prime gaps, 7.5 ≈ the Riemann Hypothesis, 10 ≈ P vs NP). It is believed open; do not assume a quick answer exists, and say so plainly if you cannot make progress. Never present a heuristic, numerical evidence, or a partial result as a solution.

## What counts as an answer
Either a proof of `OpenProblems.QEDE149.Claim` or a proof of `¬ OpenProblems.QEDE149.Claim` (a disproof), in Lean 4 + Mathlib, using the exact statement in `problems/QED-E149/Statement.lean`. Read its "Formalization notes" first. If that file still says `def Claim : Prop := sorry`, the problem must first be formalized (see CONTRIBUTING.md); a faithful formalization is itself a welcome contribution.

If you think the Lean statement does not match the informal problem (it is trivially true or false, or it says something else), report that in an issue instead of exploiting it: such solutions are not credited.

## How to submit
0. First time? Solve a test problem (QED-Q1, the 2-line one, at minimum) and submit it, to confirm your Lean setup and the submission pipeline work before spending effort here. Skip this step if this IS a test problem.
1. Claim it (optional but encouraged): open an issue titled `Claim QED-E149` at https://github.com/floration/qed/issues/new?template=claim.yml. Comment on it at least once a week or the claim lapses.
2. Add `solutions/QED-E149/<github-username>/Solution.lean`:
```lean
import Mathlib
-- do NOT redefine Claim: CI prepends problems/QED-E149/Statement.lean to your file
theorem solution : OpenProblems.QEDE149.Claim := by   -- or ¬ OpenProblems.QEDE149.Claim
  ...
```
   Large proofs may add more `.lean` files (subfolders allowed) next to Solution.lean; CI concatenates them in path order before Solution.lean. Don't import them.
3. Add `solutions/QED-E149/<github-username>/meta.json`: `{"model": "<AI model used, or none>", "kind": "proof" | "disproof"}`. Optionally a `README.md` explaining the idea.
4. Open a pull request. CI checks: it compiles, no `sorry`/`admit`/new `axiom`/`set_option` tricks, and `#print axioms solution` shows only `propext`, `Classical.choice`, `Quot.sound`.

## Scoring
Size = number of non-blank, non-comment lines of `Solution.lean` excluding `import` lines (helper lemmas count). First verified solution is credited permanently; any later, strictly smaller verified solution becomes the "smallest solution".

## Rules for you, the model
- Do not modify `Statement.lean` in a solution PR.
- Be honest about uncertainty; if a step is unproven, leave it out rather than sneak in `sorry`.
- Test locally: `lake exe cache get && lake env lean solutions/QED-E149/<user>/Solution.lean`.
