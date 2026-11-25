# QED-M076 — Close the gap in the density of integers that are sums of two rational cubes

You are an AI model helping someone attack this open problem. Read all of this before working.

## The problem
Main set · Grade B · QED Curated · Number theory

**Plain words:** BSD plus the minimalist rank heuristic predict that exactly half of all integers are sums of two rational cubes. Proven: at least 2/21 are (Alpöge–Bhargava–Shnidman), and at least 31.95% are not (Koymans–Smith). Improve either bound.

**Math:** Let $\mathcal S=\{n\in\mathbb Z: n=x^3+y^3,\ x,y\in\mathbb Q\}$ and $d_\pm$ the lower densities of $\mathcal S$ and of its complement (ordered by $|n|$). Known: $\underline d(\mathcal S)\ge 2/21$, $\underline d(\mathcal S^c)\ge 0.3195$. Conjecture: both densities equal $1/2$. Improve either constant.

**Credit:** Alpöge, Bhargava, Shnidman, Integers expressible as the sum of two rational cubes, arXiv:2210.10730 (2022); Koymans-Smith arXiv:2606.06024 (2026) for the complement side.

**Rests on recent unrefereed work. Check these premises first:**
- arXiv:2606.06024 (Koymans-Smith, 2026 preprint): source of the 31.95% (0.3195) lower bound for non-sums; the formalized Claim does not use it, but the stated M does.

**References:**
- https://arxiv.org/abs/2210.10730
- https://arxiv.org/abs/2606.06024

Difficulty estimate: 4.0/10 (calibrated: Collatz ≈ 5.5, twin primes ≈ 5.0). It is believed open; do not assume a quick answer exists, and say so plainly if you cannot make progress. Never present a heuristic, numerical evidence, or a partial result as a solution.

## What counts as an answer
Either a proof of `OpenProblems.QEDM076.Claim` or a proof of `¬ OpenProblems.QEDM076.Claim` (a disproof), in Lean 4 + Mathlib, using the exact statement in `problems/QED-M076/Statement.lean`. Read its "Formalization notes" first. If that file still says `def Claim : Prop := sorry`, the problem must first be formalized (see CONTRIBUTING.md); a faithful formalization is itself a welcome contribution.

If you think the Lean statement does not match the informal problem (it is trivially true or false, or it says something else), report that in an issue instead of exploiting it: such solutions are not credited.

## How to submit
1. Claim it (optional but encouraged): open an issue titled `Claim QED-M076` at https://github.com/floration/qed/issues/new?template=claim.yml. Comment on it at least once a week or the claim lapses.
2. Add `solutions/QED-M076/<github-username>/Solution.lean`:
```lean
import Mathlib
-- do NOT redefine Claim: CI prepends problems/QED-M076/Statement.lean to your file
theorem solution : OpenProblems.QEDM076.Claim := by   -- or ¬ OpenProblems.QEDM076.Claim
  ...
```
3. Add `solutions/QED-M076/<github-username>/meta.json`: `{"model": "<AI model used, or none>", "kind": "proof" | "disproof"}`. Optionally a `README.md` explaining the idea.
4. Open a pull request. CI checks: it compiles, no `sorry`/`admit`/new `axiom`/`set_option` tricks, and `#print axioms solution` shows only `propext`, `Classical.choice`, `Quot.sound`.

## Scoring
Size = number of non-blank, non-comment lines of `Solution.lean` excluding `import` lines (helper lemmas count). First verified solution is credited permanently; any later, strictly smaller verified solution becomes the "smallest solution".

## Rules for you, the model
- Do not modify `Statement.lean` in a solution PR.
- Be honest about uncertainty; if a step is unproven, leave it out rather than sneak in `sorry`.
- Test locally: `lake exe cache get && lake env lean solutions/QED-M076/<user>/Solution.lean`.
