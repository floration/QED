# QED-M072 — Irrationality of the quartic oscillator ground state

You are an AI model helping someone attack this open problem. Read all of this before working.

## The problem
Main set · Grade B · QED Original · Mathematical physics · formerly N-660

**Plain words:** The lowest energy of the quartic oscillator, -d^2/dx^2 + x^4 on the line, is about 1.0603620905. Show that it is irrational.

**Math:** Let $E_0=\min\sigma\big(-\tfrac{d^2}{dx^2}+x^4\big)$, the operator taken self-adjoint on $L^2(\mathbb R)$ ($E_0=1.06036209048418\ldots$). Prove that $E_0\notin\mathbb Q$.

**References:**
- https://arxiv.org/abs/math-ph/0005029
- https://arxiv.org/abs/2401.07131

Difficulty estimate: 7.5/10 (calibrated: Collatz ≈ 5.5, twin primes ≈ 5.0). It is believed open; do not assume a quick answer exists, and say so plainly if you cannot make progress. Never present a heuristic, numerical evidence, or a partial result as a solution.

## What counts as an answer
Either a proof of `OpenProblems.QEDM072.Claim` or a proof of `¬ OpenProblems.QEDM072.Claim` (a disproof), in Lean 4 + Mathlib, using the exact statement in `problems/QED-M072/Statement.lean`. Read its "Formalization notes" first. If that file still says `def Claim : Prop := sorry`, the problem must first be formalized (see CONTRIBUTING.md); a faithful formalization is itself a welcome contribution.

If you think the Lean statement does not match the informal problem (it is trivially true or false, or it says something else), report that in an issue instead of exploiting it: such solutions are not credited.

## How to submit
1. Claim it (optional but encouraged): open an issue titled `Claim QED-M072` at https://github.com/floration/qed/issues/new?template=claim.yml. Comment on it at least once a week or the claim lapses.
2. Add `solutions/QED-M072/<github-username>/Solution.lean`:
```lean
import Mathlib
-- do NOT redefine Claim: CI prepends problems/QED-M072/Statement.lean to your file
theorem solution : OpenProblems.QEDM072.Claim := by   -- or ¬ OpenProblems.QEDM072.Claim
  ...
```
3. Add `solutions/QED-M072/<github-username>/meta.json`: `{"model": "<AI model used, or none>", "kind": "proof" | "disproof"}`. Optionally a `README.md` explaining the idea.
4. Open a pull request. CI checks: it compiles, no `sorry`/`admit`/new `axiom`/`set_option` tricks, and `#print axioms solution` shows only `propext`, `Classical.choice`, `Quot.sound`.

## Scoring
Size = number of non-blank, non-comment lines of `Solution.lean` excluding `import` lines (helper lemmas count). First verified solution is credited permanently; any later, strictly smaller verified solution becomes the "smallest solution".

## Rules for you, the model
- Do not modify `Statement.lean` in a solution PR.
- Be honest about uncertainty; if a step is unproven, leave it out rather than sneak in `sorry`.
- Test locally: `lake exe cache get && lake env lean solutions/QED-M072/<user>/Solution.lean`.
