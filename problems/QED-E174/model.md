# QED-E174 — Unbounded partial quotients of the cube root of 2

You are an AI model helping someone attack this open problem. Read all of this before working.

## The problem
Extended set · Grade A · QED Curated · Number theory

**Plain words:** The continued fraction of the square root of 2 is periodic, but no pattern is known in the continued fraction of the cube root of 2 = [1; 3, 1, 5, 1, 1, 4, 1, 1, 8, 1, 14, ...]. It is believed to behave like a random number and have arbitrarily large terms, but it has never been proved that its terms are unbounded. Prove that they are.

**Math:** Let $2^{1/3}=[a_0;a_1,a_2,\ldots]$ be the simple continued fraction. Prove $\sup_n a_n=\infty$; equivalently, $2^{1/3}$ is not badly approximable: $\liminf_{q\to\infty} q\,\|q\,2^{1/3}\|=0$, where $\|\cdot\|$ is the distance to the nearest integer.

**Credit:** Classical question (Khintchine; Lang–Trotter 1972); framing relative to Haynes' totally real claim is new here.

**Rests on recent unrefereed work. Check these premises first:**
- Haynes' totally-real theorem is an unrefereed preprint since 2023; if it is wrong the 'natural frontier' framing weakens but the problem is unaffected
- Low novelty; very hard (difficulty high)

**References:**
- https://arxiv.org/abs/2310.12703
- https://arxiv.org/abs/2311.16596
- https://arxiv.org/abs/2610.07471
- https://www.ams.org/journals/mcom/1955-09-049/S0025-5718-1955-0068900-3

Difficulty estimate: 9.0/10 (calibrated: Collatz ≈ 5.5, twin primes ≈ 5.0). It is believed open; do not assume a quick answer exists, and say so plainly if you cannot make progress. Never present a heuristic, numerical evidence, or a partial result as a solution.

## What counts as an answer
Either a proof of `OpenProblems.QEDE174.Claim` or a proof of `¬ OpenProblems.QEDE174.Claim` (a disproof), in Lean 4 + Mathlib, using the exact statement in `problems/QED-E174/Statement.lean`. Read its "Formalization notes" first. If that file still says `def Claim : Prop := sorry`, the problem must first be formalized (see CONTRIBUTING.md); a faithful formalization is itself a welcome contribution.

If you think the Lean statement does not match the informal problem (it is trivially true or false, or it says something else), report that in an issue instead of exploiting it: such solutions are not credited.

## How to submit
0. First time? Solve a test problem (QED-Q1, the 2-line one, at minimum) and submit it, to confirm your Lean setup and the submission pipeline work before spending effort here. Skip this step if this IS a test problem.
1. Claim it (optional but encouraged): open an issue titled `Claim QED-E174` at https://github.com/floration/qed/issues/new?template=claim.yml. Comment on it at least once a week or the claim lapses.
2. Add `solutions/QED-E174/<github-username>/Solution.lean`:
```lean
import Mathlib
-- do NOT redefine Claim: CI prepends problems/QED-E174/Statement.lean to your file
theorem solution : OpenProblems.QEDE174.Claim := by   -- or ¬ OpenProblems.QEDE174.Claim
  ...
```
   Large proofs may add more `.lean` files (subfolders allowed) next to Solution.lean; CI concatenates them in path order before Solution.lean. Don't import them.
3. Add `solutions/QED-E174/<github-username>/meta.json`: `{"model": "<AI model used, or none>", "kind": "proof" | "disproof"}`. Optionally a `README.md` explaining the idea.
4. Open a pull request. CI checks: it compiles, no `sorry`/`admit`/new `axiom`/`set_option` tricks, and `#print axioms solution` shows only `propext`, `Classical.choice`, `Quot.sound`.

## Scoring
Size = number of non-blank, non-comment lines of `Solution.lean` excluding `import` lines (helper lemmas count). First verified solution is credited permanently; any later, strictly smaller verified solution becomes the "smallest solution".

## Rules for you, the model
- Do not modify `Statement.lean` in a solution PR.
- Be honest about uncertainty; if a step is unproven, leave it out rather than sneak in `sorry`.
- Test locally: `lake exe cache get && lake env lean solutions/QED-E174/<user>/Solution.lean`.
