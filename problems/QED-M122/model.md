# QED-M122 — The widest hollow body in 3-space

You are an AI model helping someone attack this open problem. Read all of this before working.

## The problem
Extended set · Grade A · QED Curated · Geometry

**Plain words:** A convex body is hollow if no point with all-integer coordinates lies strictly inside it. Hollow bodies must be thin in some integer direction (the flatness theorem). In the plane the largest guaranteed thinness is known exactly, 1+2/sqrt(3). In 3-space a hollow tetrahedron of lattice width 2+sqrt(2) is known: is that the widest possible?

**Math:** For a convex body (compact, convex, nonempty interior) $K\subset\mathbb{R}^3$ and $u\in\mathbb{Z}^3\setminus\{0\}$ let $w_u(K)=\max_{x\in K}\langle u,x\rangle-\min_{x\in K}\langle u,x\rangle$ and $w(K)=\min_{u\neq0}w_u(K)$. Call $K$ hollow if $\operatorname{int}K\cap\mathbb{Z}^3=\emptyset$. Prove or disprove: every hollow convex body $K\subset\mathbb{R}^3$ satisfies $w(K)\le 2+\sqrt2$. (Equivalently $\mathrm{Flt}(3)=2+\sqrt2$; known: $2+\sqrt2\le\mathrm{Flt}(3)<3.972$.)

**Credit:** Codenotti and Santos (2019), Conjecture 1.2; Averkov, Codenotti, Macchia, Santos (2021)

**Rests on recent unrefereed work. Check these premises first:**
- Listed on Tao's optimization-constants page (73a), but not moving there; no updates since 2021
- Conjecture is attributed to two people but is not commonly called by their names

**References:**
- https://teorth.github.io/optimizationproblems/constants/73a.html
- https://arxiv.org/abs/1907.06199
- https://arxiv.org/abs/1812.00916
- https://arxiv.org/pdf/2604.27260

Difficulty estimate: 4.5/10 (anchored scale: 1 ≈ Erdős–Ginzburg–Ziv, 2.5 ≈ the sensitivity conjecture, 5 ≈ bounded prime gaps, 7.5 ≈ the Riemann Hypothesis, 10 ≈ P vs NP). It is believed open; do not assume a quick answer exists, and say so plainly if you cannot make progress. Never present a heuristic, numerical evidence, or a partial result as a solution.

## What counts as an answer
Either a proof of `OpenProblems.QEDM122.Claim` or a proof of `¬ OpenProblems.QEDM122.Claim` (a disproof), in Lean 4 + Mathlib, using the exact statement in `problems/QED-M122/Statement.lean`. Read its "Formalization notes" first. If that file still says `def Claim : Prop := sorry`, the problem must first be formalized (see CONTRIBUTING.md); a faithful formalization is itself a welcome contribution.

If you think the Lean statement does not match the informal problem (it is trivially true or false, or it says something else), report that in an issue instead of exploiting it: such solutions are not credited.

## How to submit
0. First time? Solve a test problem (QED-Q1, the 2-line one, at minimum) and submit it, to confirm your Lean setup and the submission pipeline work before spending effort here. Skip this step if this IS a test problem.
1. Claim it (optional but encouraged): open an issue titled `Claim QED-M122` at https://github.com/floration/qed/issues/new?template=claim.yml. Comment on it at least once a week or the claim lapses.
2. Add `solutions/QED-M122/<github-username>/Solution.lean`:
```lean
import Mathlib
-- do NOT redefine Claim: CI prepends problems/QED-M122/Statement.lean to your file
theorem solution : OpenProblems.QEDM122.Claim := by   -- or ¬ OpenProblems.QEDM122.Claim
  ...
```
   Large proofs may add more `.lean` files (subfolders allowed) next to Solution.lean; CI concatenates them in path order before Solution.lean. Don't import them.
3. Add `solutions/QED-M122/<github-username>/meta.json`: `{"model": "<AI model used, or none>", "kind": "proof" | "disproof"}`. Optionally a `README.md` explaining the idea.
4. Open a pull request. CI checks: it compiles, no `sorry`/`admit`/new `axiom`/`set_option` tricks, and `#print axioms solution` shows only `propext`, `Classical.choice`, `Quot.sound`.

## Scoring
Size = number of non-blank, non-comment lines of `Solution.lean` excluding `import` lines (helper lemmas count). First verified solution is credited permanently; any later, strictly smaller verified solution becomes the "smallest solution".

## Rules for you, the model
- Do not modify `Statement.lean` in a solution PR.
- Be honest about uncertainty; if a step is unproven, leave it out rather than sneak in `sorry`.
- Test locally: `lake exe cache get && lake env lean solutions/QED-M122/<user>/Solution.lean`.
