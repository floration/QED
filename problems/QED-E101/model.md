# QED-E101 — Interval-sieve extremal bounds behind the Banks–Ford–Tao gap prediction

You are an AI model helping someone attack this open problem. Read all of this before working.

## The problem
Extended set · Grade B · QED Curated · Number theory

**Plain words:** Banks, Ford and Tao showed that a random sieve model of the primes predicts the largest prime gap below x is about g(ξ log²x), where g is controlled by an extremal sieve quantity W_y. W_y is the fewest survivors in [0,y] after one residue class is removed for each prime up to √(y/log y). Narrow the bounds on W_y.

**Math:** Let W_y = min over residue choices (a_p) of #{n ∈ [0,y] ∩ ℤ : n ≢ a_p (mod p) for all primes p <= (y/log y)^{1/2}}. Known (Banks-Ford-Tao): (4+o(1)) y log log y/log^2 y <= W_y <= y/log y + O(y log log y/log^2 y). Prove or disprove: there is an absolute c > 0 with W_y >= c·y/log y for all sufficiently large y.

**Credit:** Banks, Ford, Tao, Large prime gaps and probabilistic models, Invent. Math. 2023 (arXiv:1908.08613)

**References:**
- https://arxiv.org/abs/1908.08613

Difficulty estimate: 4.0/10 (calibrated: Collatz ≈ 5.5, twin primes ≈ 5.0). It is believed open; do not assume a quick answer exists, and say so plainly if you cannot make progress. Never present a heuristic, numerical evidence, or a partial result as a solution.

## What counts as an answer
Either a proof of `OpenProblems.QEDE101.Claim` or a proof of `¬ OpenProblems.QEDE101.Claim` (a disproof), in Lean 4 + Mathlib, using the exact statement in `problems/QED-E101/Statement.lean`. Read its "Formalization notes" first. If that file still says `def Claim : Prop := sorry`, the problem must first be formalized (see CONTRIBUTING.md); a faithful formalization is itself a welcome contribution.

If you think the Lean statement does not match the informal problem (it is trivially true or false, or it says something else), report that in an issue instead of exploiting it: such solutions are not credited.

## How to submit
1. Claim it (optional but encouraged): open an issue titled `Claim QED-E101` at https://github.com/floration/qed/issues/new?template=claim.yml. Comment on it at least once a week or the claim lapses.
2. Add `solutions/QED-E101/<github-username>/Solution.lean`:
```lean
import Mathlib
-- do NOT redefine Claim: CI prepends problems/QED-E101/Statement.lean to your file
theorem solution : OpenProblems.QEDE101.Claim := by   -- or ¬ OpenProblems.QEDE101.Claim
  ...
```
3. Add `solutions/QED-E101/<github-username>/meta.json`: `{"model": "<AI model used, or none>", "kind": "proof" | "disproof"}`. Optionally a `README.md` explaining the idea.
4. Open a pull request. CI checks: it compiles, no `sorry`/`admit`/new `axiom`/`set_option` tricks, and `#print axioms solution` shows only `propext`, `Classical.choice`, `Quot.sound`.

## Scoring
Size = number of non-blank, non-comment lines of `Solution.lean` excluding `import` lines (helper lemmas count). First verified solution is credited permanently; any later, strictly smaller verified solution becomes the "smallest solution".

## Rules for you, the model
- Do not modify `Statement.lean` in a solution PR.
- Be honest about uncertainty; if a step is unproven, leave it out rather than sneak in `sorry`.
- Test locally: `lake exe cache get && lake env lean solutions/QED-E101/<user>/Solution.lean`.
