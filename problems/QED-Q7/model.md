# QED-Q7 — Erdős–Szekeres monotone subsequences

You are an AI model helping someone attack this open problem. Read all of this before working.

## The problem
Submission test · QED Curated · Test

**Plain words:** Any list of rs + 1 distinct real numbers has an increasing run of r + 1 of them or a decreasing run of s + 1 of them (not necessarily consecutive).

**Math:** For $f:\{0,\dots,rs\}\to\mathbb R$ injective there is a set of $r+1$ indices on which $f$ is strictly increasing, or a set of $s+1$ indices on which it is strictly decreasing.

**Reviewer note:** Submission test. Estimated proof length about 128 lines; using Mathlib lemmas is allowed.

**Credit:** classical result with known proof

Difficulty estimate: 0.7/10 (calibrated: Collatz ≈ 5.5, twin primes ≈ 5.0). It is believed open; do not assume a quick answer exists, and say so plainly if you cannot make progress. Never present a heuristic, numerical evidence, or a partial result as a solution.

## What counts as an answer
Either a proof of `OpenProblems.QEDQ7.Claim` or a proof of `¬ OpenProblems.QEDQ7.Claim` (a disproof), in Lean 4 + Mathlib, using the exact statement in `problems/QED-Q7/Statement.lean`. Read its "Formalization notes" first. If that file still says `def Claim : Prop := sorry`, the problem must first be formalized (see CONTRIBUTING.md); a faithful formalization is itself a welcome contribution.

If you think the Lean statement does not match the informal problem (it is trivially true or false, or it says something else), report that in an issue instead of exploiting it: such solutions are not credited.

## How to submit
1. Claim it (optional but encouraged): open an issue titled `Claim QED-Q7` at https://github.com/floration/qed/issues/new?template=claim.yml. Comment on it at least once a week or the claim lapses.
2. Add `solutions/QED-Q7/<github-username>/Solution.lean`:
```lean
import Mathlib
-- do NOT redefine Claim: CI prepends problems/QED-Q7/Statement.lean to your file
theorem solution : OpenProblems.QEDQ7.Claim := by   -- or ¬ OpenProblems.QEDQ7.Claim
  ...
```
3. Add `solutions/QED-Q7/<github-username>/meta.json`: `{"model": "<AI model used, or none>", "kind": "proof" | "disproof"}`. Optionally a `README.md` explaining the idea.
4. Open a pull request. CI checks: it compiles, no `sorry`/`admit`/new `axiom`/`set_option` tricks, and `#print axioms solution` shows only `propext`, `Classical.choice`, `Quot.sound`.

## Scoring
Size = number of non-blank, non-comment lines of `Solution.lean` excluding `import` lines (helper lemmas count). First verified solution is credited permanently; any later, strictly smaller verified solution becomes the "smallest solution".

## Rules for you, the model
- Do not modify `Statement.lean` in a solution PR.
- Be honest about uncertainty; if a step is unproven, leave it out rather than sneak in `sorry`.
- Test locally: `lake exe cache get && lake env lean solutions/QED-Q7/<user>/Solution.lean`.
