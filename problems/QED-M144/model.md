# QED-M144 — Joint residues of the largest prime factors of n and n+1

You are an AI model helping someone attack this open problem. Read all of this before working.

## The problem
Main set · Grade B · QED Original · Number theory

**Plain words:** Let P(n) be the largest prime factor of n. Show that the last digits of P(n) and P(n+1) behave like two independent fair choices from {1,3,7,9}: each of the 16 pairs occurs for asymptotically 1/16 of all n. More generally, for any modulus q, the pair (P(n) mod q, P(n+1) mod q) should be uniform over pairs of reduced residues.

**Math:** Let P(n) denote the largest prime factor of n >= 2. Prove that for every q >= 2 and a,b in (Z/qZ)^x, the natural density of {n >= 2: P(n) = a, P(n+1) = b (mod q)} equals phi(q)^{-2}. In particular (q=10), for all a,b in {1,3,7,9}, #{2<=n<=x: P(n)=a, P(n+1)=b (mod 10)} ~ x/16. (A logarithmic-density version is a natural first step.)

**Credit:** QED original (archived Nov 2026, restored after re-review).

**References:**
- https://arxiv.org/abs/1710.01195
- https://arxiv.org/abs/2607.16032
- https://arxiv.org/abs/2610.23280
- https://cs.uwaterloo.ca/journals/JIS/VOL23/Kim/kim22.pdf

Difficulty estimate: 5.0/10 (anchored scale: 1 ≈ Erdős–Ginzburg–Ziv, 2.5 ≈ the sensitivity conjecture, 5 ≈ bounded prime gaps, 7.5 ≈ the Riemann Hypothesis, 10 ≈ P vs NP). It is believed open; do not assume a quick answer exists, and say so plainly if you cannot make progress. Never present a heuristic, numerical evidence, or a partial result as a solution.

## What counts as an answer
Either a proof of `OpenProblems.QEDM144.Claim` or a proof of `¬ OpenProblems.QEDM144.Claim` (a disproof), in Lean 4 + Mathlib, using the exact statement in `problems/QED-M144/Statement.lean`. Read its "Formalization notes" first. If that file still says `def Claim : Prop := sorry`, the problem must first be formalized (see CONTRIBUTING.md); a faithful formalization is itself a welcome contribution.

If you think the Lean statement does not match the informal problem (it is trivially true or false, or it says something else), report that in an issue instead of exploiting it: such solutions are not credited.

## How to submit
0. First time? Solve a test problem (QED-Q1, the 2-line one, at minimum) and submit it, to confirm your Lean setup and the submission pipeline work before spending effort here. Skip this step if this IS a test problem.
1. Claim it (optional but encouraged): open an issue titled `Claim QED-M144` at https://github.com/floration/qed/issues/new?template=claim.yml. Comment on it at least once a week or the claim lapses.
2. Add `solutions/QED-M144/<github-username>/Solution.lean`:
```lean
import Mathlib
-- do NOT redefine Claim: CI prepends problems/QED-M144/Statement.lean to your file
theorem solution : OpenProblems.QEDM144.Claim := by   -- or ¬ OpenProblems.QEDM144.Claim
  ...
```
   Large proofs may add more `.lean` files (subfolders allowed) next to Solution.lean; CI concatenates them in path order before Solution.lean. Don't import them.
3. Add `solutions/QED-M144/<github-username>/meta.json`: `{"model": "<AI model used, or none>", "kind": "proof" | "disproof"}`. Optionally a `README.md` explaining the idea.
4. Open a pull request. CI checks: it compiles, no `sorry`/`admit`/new `axiom`/`set_option` tricks, and `#print axioms solution` shows only `propext`, `Classical.choice`, `Quot.sound`.

## Scoring
Size = number of non-blank, non-comment lines of `Solution.lean` excluding `import` lines (helper lemmas count). First verified solution is credited permanently; any later, strictly smaller verified solution becomes the "smallest solution".

## Rules for you, the model
- Do not modify `Statement.lean` in a solution PR.
- Be honest about uncertainty; if a step is unproven, leave it out rather than sneak in `sorry`.
- Test locally: `lake exe cache get && lake env lean solutions/QED-M144/<user>/Solution.lean`.
