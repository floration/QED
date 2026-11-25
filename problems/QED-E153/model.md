# QED-E153 — Area of the boundary of the Mandelbrot set

You are an AI model helping someone attack this open problem. Read all of this before working.

## The problem
Extended set · Grade B · QED Curated · Dynamics

**Plain words:** The Mandelbrot set M is the set of complex numbers c for which the orbit of 0 under z -> z^2 + c stays bounded. Its boundary is a fractal of Hausdorff dimension 2, as large as possible for a plane set. Does the boundary of M have zero area?

**Math:** Let $M=\{c\in\mathbb C:\sup_n|f_c^{n}(0)|<\infty\}$ with $f_c(z)=z^2+c$. Decide whether the two-dimensional Lebesgue measure of $\partial M$ is $0$.

**Credit:** Classical (Milnor's problem lists; Douady-Hubbard era)

**Rests on recent unrefereed work. Check these premises first:**
- Famous and probably very hard (low novelty). It is listed because it is important and has a one-line Lean statement.
- It should be checked against the scorer's view of whether it duplicates the existing hyperbolic-measure item QED-M051. It does not: that item asks about the computability of a real-line measure.

**References:**
- https://arxiv.org/abs/math/9205209
- https://mrob.com/pub/muency/openconjectures.html
- https://arxiv.org/abs/2512.24171

Difficulty estimate: 8.5/10 (anchored scale: 1 ≈ Erdős–Ginzburg–Ziv, 2.5 ≈ the sensitivity conjecture, 5 ≈ bounded prime gaps, 7.5 ≈ the Riemann Hypothesis, 10 ≈ P vs NP). It is believed open; do not assume a quick answer exists, and say so plainly if you cannot make progress. Never present a heuristic, numerical evidence, or a partial result as a solution.

## What counts as an answer
Either a proof of `OpenProblems.QEDE153.Claim` or a proof of `¬ OpenProblems.QEDE153.Claim` (a disproof), in Lean 4 + Mathlib, using the exact statement in `problems/QED-E153/Statement.lean`. Read its "Formalization notes" first. If that file still says `def Claim : Prop := sorry`, the problem must first be formalized (see CONTRIBUTING.md); a faithful formalization is itself a welcome contribution.

If you think the Lean statement does not match the informal problem (it is trivially true or false, or it says something else), report that in an issue instead of exploiting it: such solutions are not credited.

## How to submit
0. First time? Solve a test problem (QED-Q1, the 2-line one, at minimum) and submit it, to confirm your Lean setup and the submission pipeline work before spending effort here. Skip this step if this IS a test problem.
1. Claim it (optional but encouraged): open an issue titled `Claim QED-E153` at https://github.com/floration/qed/issues/new?template=claim.yml. Comment on it at least once a week or the claim lapses.
2. Add `solutions/QED-E153/<github-username>/Solution.lean`:
```lean
import Mathlib
-- do NOT redefine Claim: CI prepends problems/QED-E153/Statement.lean to your file
theorem solution : OpenProblems.QEDE153.Claim := by   -- or ¬ OpenProblems.QEDE153.Claim
  ...
```
   Large proofs may add more `.lean` files (subfolders allowed) next to Solution.lean; CI concatenates them in path order before Solution.lean. Don't import them.
3. Add `solutions/QED-E153/<github-username>/meta.json`: `{"model": "<AI model used, or none>", "kind": "proof" | "disproof"}`. Optionally a `README.md` explaining the idea.
4. Open a pull request. CI checks: it compiles, no `sorry`/`admit`/new `axiom`/`set_option` tricks, and `#print axioms solution` shows only `propext`, `Classical.choice`, `Quot.sound`.

## Scoring
Size = number of non-blank, non-comment lines of `Solution.lean` excluding `import` lines (helper lemmas count). First verified solution is credited permanently; any later, strictly smaller verified solution becomes the "smallest solution".

## Rules for you, the model
- Do not modify `Statement.lean` in a solution PR.
- Be honest about uncertainty; if a step is unproven, leave it out rather than sneak in `sorry`.
- Test locally: `lake exe cache get && lake env lean solutions/QED-E153/<user>/Solution.lean`.
