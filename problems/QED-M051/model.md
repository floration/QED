# QED-M051 — Is the measure of the hyperbolic real quadratic parameters computable?

You are an AI model helping someone attack this open problem. Read all of this before working.

## The problem
Main set · Grade A · QED Original · Dynamics

**Plain words:** For real c between −2 and 1/4, the map x ↦ x²+c has an attracting cycle for an open dense set of c, yet the chaotic parameters have positive length (Jakobson). Is the total length of the parameters with an attracting cycle a computable number? It can be approximated from below by listing windows, but no known method approximates it from above.

**Math:** Let $H=\{c\in[-2,1/4]:\ x\mapsto x^2+c\text{ has an attracting periodic orbit}\}$. Is the Lebesgue measure $\lambda(H)$ a computable real number? ($H$ is open and its components can be certified by interval arithmetic, so $\lambda(H)$ is lower semicomputable; Jakobson's theorem gives $\lambda(H)<9/4$.) Equivalently: is the measure of the set of stochastic (Collet–Eckmann) parameters lower semicomputable?

**QED results so far (reviewer-derived; check before relying on them):** Checked: λ(H) is lower semicomputable. Each CE(C,γ) piece is an intersection of finite-time conditions, so it is only upper semicomputable, which is the wrong direction. The 'equivalently' clause is valid through Lyubich's regular-or-stochastic theorem and Avila–Moreira (almost every stochastic parameter is CE).

**Rests on recent unrefereed work. Check these premises first:**
- arXiv 2505.20495 (Golmakani–Koudjinan–Luzzatto–Pilarczyk, 2025 preprint): cited only for the remark that computer-assisted schemes certify expansion, not measure; statement does not depend on it.

**References:**
- https://arxiv.org/abs/math/0508302
- https://arxiv.org/abs/2004.13444
- https://arxiv.org/pdf/1504.00116
- https://annals.math.princeton.edu/2002/156-1/p01
- https://arxiv.org/abs/math/0508302
- https://arxiv.org/abs/2505.20495
- https://arxiv.org/abs/2501.00006

Difficulty estimate: 5.5/10 (calibrated: Collatz ≈ 5.5, twin primes ≈ 5.0). It is believed open; do not assume a quick answer exists, and say so plainly if you cannot make progress. Never present a heuristic, numerical evidence, or a partial result as a solution.

## What counts as an answer
Either a proof of `OpenProblems.QEDM051.Claim` or a proof of `¬ OpenProblems.QEDM051.Claim` (a disproof), in Lean 4 + Mathlib, using the exact statement in `problems/QED-M051/Statement.lean`. Read its "Formalization notes" first. If that file still says `def Claim : Prop := sorry`, the problem must first be formalized (see CONTRIBUTING.md); a faithful formalization is itself a welcome contribution.

If you think the Lean statement does not match the informal problem (it is trivially true or false, or it says something else), report that in an issue instead of exploiting it: such solutions are not credited.

## How to submit
0. First time? Solve a test problem (QED-Q1, the 2-line one, at minimum) and submit it, to confirm your Lean setup and the submission pipeline work before spending effort here. Skip this step if this IS a test problem.
1. Claim it (optional but encouraged): open an issue titled `Claim QED-M051` at https://github.com/floration/qed/issues/new?template=claim.yml. Comment on it at least once a week or the claim lapses.
2. Add `solutions/QED-M051/<github-username>/Solution.lean`:
```lean
import Mathlib
-- do NOT redefine Claim: CI prepends problems/QED-M051/Statement.lean to your file
theorem solution : OpenProblems.QEDM051.Claim := by   -- or ¬ OpenProblems.QEDM051.Claim
  ...
```
3. Add `solutions/QED-M051/<github-username>/meta.json`: `{"model": "<AI model used, or none>", "kind": "proof" | "disproof"}`. Optionally a `README.md` explaining the idea.
4. Open a pull request. CI checks: it compiles, no `sorry`/`admit`/new `axiom`/`set_option` tricks, and `#print axioms solution` shows only `propext`, `Classical.choice`, `Quot.sound`.

## Scoring
Size = number of non-blank, non-comment lines of `Solution.lean` excluding `import` lines (helper lemmas count). First verified solution is credited permanently; any later, strictly smaller verified solution becomes the "smallest solution".

## Rules for you, the model
- Do not modify `Statement.lean` in a solution PR.
- Be honest about uncertainty; if a step is unproven, leave it out rather than sneak in `sorry`.
- Test locally: `lake exe cache get && lake env lean solutions/QED-M051/<user>/Solution.lean`.
