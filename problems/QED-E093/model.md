# QED-E093 — Sofa stability

You are an AI model helping someone attack this open problem. Read all of this before working.

## The problem
Extended set · Grade B · QED Extension · Geometry

**Plain words:** Baek (2024) proved that Gerver's sofa has the largest area among shapes that can be moved around a right-angled corner in a hallway of width 1. Show that any movable sofa whose area is nearly Gerver's must be nearly Gerver's sofa in shape (which in particular gives uniqueness).

**Math:** A moving sofa is a compact connected $S\subset\mathbb R^2$ that can be moved by a continuous rigid motion from $(-\infty,0]\times[0,1]$ to $[0,1]\times(-\infty,0]$ inside $L=((-\infty,1]\times[0,1])\cup([0,1]\times(-\infty,1])$. Let $G$ be Gerver's sofa, of area $A_G\approx2.21953$. Prove that there are $C,\alpha>0$ such that every moving sofa $S$ with $|S|\ge A_G-\varepsilon$ satisfies $\min_{g}|gS\,\triangle\,G|\le C\varepsilon^{\alpha}$, the minimum over rigid motions $g$ of the plane.

**Credit:** Baek (2024), 'Optimality of Gerver's Sofa', arXiv:2411.19826.

**Rests on recent unrefereed work. Check these premises first:**
- arXiv:2411.19826 (Baek 2024; refereeing status unclear): the problem assumes Gerver's sofa is the maximizer. The formal Claim avoids this by quantifying over an unspecified stable sofa G, so it does not depend on Baek's result.
- arXiv:2610.13955 (2026 preprint, cited in refs): context only; nothing in the statement depends on it.

**References:**
- https://arxiv.org/abs/2411.19826
- https://arxiv.org/pdf/2610.13955
- https://en.wikipedia.org/wiki/Moving_sofa_problem

Difficulty estimate: 3.0/10 (calibrated: Collatz ≈ 5.5, twin primes ≈ 5.0). It is believed open; do not assume a quick answer exists, and say so plainly if you cannot make progress. Never present a heuristic, numerical evidence, or a partial result as a solution.

## What counts as an answer
Either a proof of `OpenProblems.QEDE093.Claim` or a proof of `¬ OpenProblems.QEDE093.Claim` (a disproof), in Lean 4 + Mathlib, using the exact statement in `problems/QED-E093/Statement.lean`. Read its "Formalization notes" first. If that file still says `def Claim : Prop := sorry`, the problem must first be formalized (see CONTRIBUTING.md); a faithful formalization is itself a welcome contribution.

If you think the Lean statement does not match the informal problem (it is trivially true or false, or it says something else), report that in an issue instead of exploiting it: such solutions are not credited.

## How to submit
0. First time? Solve a test problem (QED-Q1, the 2-line one, at minimum) and submit it, to confirm your Lean setup and the submission pipeline work before spending effort here. Skip this step if this IS a test problem.
1. Claim it (optional but encouraged): open an issue titled `Claim QED-E093` at https://github.com/floration/qed/issues/new?template=claim.yml. Comment on it at least once a week or the claim lapses.
2. Add `solutions/QED-E093/<github-username>/Solution.lean`:
```lean
import Mathlib
-- do NOT redefine Claim: CI prepends problems/QED-E093/Statement.lean to your file
theorem solution : OpenProblems.QEDE093.Claim := by   -- or ¬ OpenProblems.QEDE093.Claim
  ...
```
   Large proofs may add more `.lean` files (subfolders allowed) next to Solution.lean; CI concatenates them in path order before Solution.lean. Don't import them.
3. Add `solutions/QED-E093/<github-username>/meta.json`: `{"model": "<AI model used, or none>", "kind": "proof" | "disproof"}`. Optionally a `README.md` explaining the idea.
4. Open a pull request. CI checks: it compiles, no `sorry`/`admit`/new `axiom`/`set_option` tricks, and `#print axioms solution` shows only `propext`, `Classical.choice`, `Quot.sound`.

## Scoring
Size = number of non-blank, non-comment lines of `Solution.lean` excluding `import` lines (helper lemmas count). First verified solution is credited permanently; any later, strictly smaller verified solution becomes the "smallest solution".

## Rules for you, the model
- Do not modify `Statement.lean` in a solution PR.
- Be honest about uncertainty; if a step is unproven, leave it out rather than sneak in `sorry`.
- Test locally: `lake exe cache get && lake env lean solutions/QED-E093/<user>/Solution.lean`.
