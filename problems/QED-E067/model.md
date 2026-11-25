# QED-E067 — Is the complete-pivoting growth factor exactly 8 for 8x8 matrices?

You are an AI model helping someone attack this open problem. Read all of this before working.

## The problem
Extended set · Grade B · QED Curated · Algebra

**Plain words:** The worst-case complete-pivoting growth is known exactly only for n ≤ 6 (values 1, 2, 2.25, 4, 4.1325, 5). The value g_8 = 8, attained by Hadamard matrices, is conjectured but unproven, and Hadamard matrices are known not to be optimal at n = 12 and 16. Determine g_7 and decide whether g_8 = 8.

**Math:** With $g_n$ as above (real matrices, complete pivoting), prove or disprove $g_8=8$, and determine $g_7$ (known lower bounds from Edelman–Urschel Table 1).

**Credit:** A. Edelman & J. Urschel 2023, arXiv:2303.04892 (also Cryer 1968, Gould 1991 for the g_n <= n history)

**Rests on recent unrefereed work. Check these premises first:**
- Exact values g_n are cited as known only for n ≤ 6 (g_5 = 4.1325, g_6 = 5); check against Edelman–Urschel 2023 before relying on them.

**References:**
- https://arxiv.org/abs/2303.04892

Difficulty estimate: 2.5/10 (calibrated: Collatz ≈ 5.5, twin primes ≈ 5.0). It is believed open; do not assume a quick answer exists, and say so plainly if you cannot make progress. Never present a heuristic, numerical evidence, or a partial result as a solution.

## What counts as an answer
Either a proof of `OpenProblems.QEDE067.Claim` or a proof of `¬ OpenProblems.QEDE067.Claim` (a disproof), in Lean 4 + Mathlib, using the exact statement in `problems/QED-E067/Statement.lean`. Read its "Formalization notes" first. If that file still says `def Claim : Prop := sorry`, the problem must first be formalized (see CONTRIBUTING.md); a faithful formalization is itself a welcome contribution.

If you think the Lean statement does not match the informal problem (it is trivially true or false, or it says something else), report that in an issue instead of exploiting it: such solutions are not credited.

## How to submit
0. First time? Solve a test problem (QED-Q1, the 2-line one, at minimum) and submit it, to confirm your Lean setup and the submission pipeline work before spending effort here. Skip this step if this IS a test problem.
1. Claim it (optional but encouraged): open an issue titled `Claim QED-E067` at https://github.com/floration/qed/issues/new?template=claim.yml. Comment on it at least once a week or the claim lapses.
2. Add `solutions/QED-E067/<github-username>/Solution.lean`:
```lean
import Mathlib
-- do NOT redefine Claim: CI prepends problems/QED-E067/Statement.lean to your file
theorem solution : OpenProblems.QEDE067.Claim := by   -- or ¬ OpenProblems.QEDE067.Claim
  ...
```
3. Add `solutions/QED-E067/<github-username>/meta.json`: `{"model": "<AI model used, or none>", "kind": "proof" | "disproof"}`. Optionally a `README.md` explaining the idea.
4. Open a pull request. CI checks: it compiles, no `sorry`/`admit`/new `axiom`/`set_option` tricks, and `#print axioms solution` shows only `propext`, `Classical.choice`, `Quot.sound`.

## Scoring
Size = number of non-blank, non-comment lines of `Solution.lean` excluding `import` lines (helper lemmas count). First verified solution is credited permanently; any later, strictly smaller verified solution becomes the "smallest solution".

## Rules for you, the model
- Do not modify `Statement.lean` in a solution PR.
- Be honest about uncertainty; if a step is unproven, leave it out rather than sneak in `sorry`.
- Test locally: `lake exe cache get && lake env lean solutions/QED-E067/<user>/Solution.lean`.
