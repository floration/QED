# QED-E005 — Drum tones of superellipses

You are an AI model helping someone attack this open problem. Read all of this before working.

## The problem
Extended set · Grade C · Analysis

**Plain words:** Take the region |x|^p + |y|^p <= r^p, scaled to have area 1. At p = 2 it is a disk, which has the lowest possible bass note of any region of that area (Faber–Krahn). As p grows to infinity it becomes a square, whose note is higher. Show that the note rises steadily the whole way from p = 2 to infinity.

**Math:** For $p\in[2,\infty)$ let $D_p=\{(x,y):|x|^p+|y|^p\le r_p^p\}$ with $r_p$ chosen so that $|D_p|=1$, and let $\lambda_1(p)$ be the first Dirichlet eigenvalue of $-\Delta$ on $D_p$. Prove that $\lambda_1$ is strictly increasing on $[2,\infty)$, with $\lambda_1(2)=\pi j_{0,1}^2$ and $\lambda_1(p)\uparrow2\pi^2$ as $p\to\infty$.

**Reviewer note:** I

**References:**
- https://arxiv.org/abs/2108.04039
- https://legacy-www.math.harvard.edu/~knill/offprints/lpbilliards.pdf

Difficulty estimate: 2.9/10 (calibrated: Collatz ≈ 5.5, twin primes ≈ 5.0). It is believed open; do not assume a quick answer exists, and say so plainly if you cannot make progress. Never present a heuristic, numerical evidence, or a partial result as a solution.

## What counts as an answer
Either a proof of `OpenProblems.QEDE005.Claim` or a proof of `¬ OpenProblems.QEDE005.Claim` (a disproof), in Lean 4 + Mathlib, using the exact statement in `problems/QED-E005/Statement.lean`. Read its "Formalization notes" first. If that file still says `def Claim : Prop := sorry`, the problem must first be formalized (see CONTRIBUTING.md); a faithful formalization is itself a welcome contribution.

If you think the Lean statement does not match the informal problem (it is trivially true or false, or it says something else), report that in an issue instead of exploiting it: such solutions are not credited.

## How to submit
0. First time? Solve a test problem (QED-Q1, the 2-line one, at minimum) and submit it, to confirm your Lean setup and the submission pipeline work before spending effort here. Skip this step if this IS a test problem.
1. Claim it (optional but encouraged): open an issue titled `Claim QED-E005` at https://github.com/floration/qed/issues/new?template=claim.yml. Comment on it at least once a week or the claim lapses.
2. Add `solutions/QED-E005/<github-username>/Solution.lean`:
```lean
import Mathlib
-- do NOT redefine Claim: CI prepends problems/QED-E005/Statement.lean to your file
theorem solution : OpenProblems.QEDE005.Claim := by   -- or ¬ OpenProblems.QEDE005.Claim
  ...
```
3. Add `solutions/QED-E005/<github-username>/meta.json`: `{"model": "<AI model used, or none>", "kind": "proof" | "disproof"}`. Optionally a `README.md` explaining the idea.
4. Open a pull request. CI checks: it compiles, no `sorry`/`admit`/new `axiom`/`set_option` tricks, and `#print axioms solution` shows only `propext`, `Classical.choice`, `Quot.sound`.

## Scoring
Size = number of non-blank, non-comment lines of `Solution.lean` excluding `import` lines (helper lemmas count). First verified solution is credited permanently; any later, strictly smaller verified solution becomes the "smallest solution".

## Rules for you, the model
- Do not modify `Statement.lean` in a solution PR.
- Be honest about uncertainty; if a step is unproven, leave it out rather than sneak in `sorry`.
- Test locally: `lake exe cache get && lake env lean solutions/QED-E005/<user>/Solution.lean`.
