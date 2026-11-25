# QED-M078 — Improve H_1 <= 12 under EH alone

You are an AI model helping someone attack this open problem. Read all of this before working.

## The problem
Main set · Grade B · QED Curated · Number theory · formerly N-703

**Plain words:** Assuming Elliott–Halberstam, Maynard's sieve gives infinitely many pairs of primes at distance at most 12. The generalized conjecture GEH gives 6. Lower 12 using EH alone.

**Math:** Let $H_1=\liminf_{n}(p_{n+1}-p_n)$. Assuming EH (level $\theta=1-\varepsilon$ for all $\varepsilon>0$, for the von Mangoldt function only, not GEH), prove $H_1\le 10$, or prove that no Selberg/Maynard-type sieve weight using EH alone can give $H_1<12$.

**Credit:** D.H.J. Polymath 2014, arXiv:1407.4897; J. Maynard 2015, arXiv:1311.4600

**References:**
- https://arxiv.org/abs/1407.4897
- https://arxiv.org/abs/1311.4600

Difficulty estimate: 4.0/10 (calibrated: Collatz ≈ 5.5, twin primes ≈ 5.0). It is believed open; do not assume a quick answer exists, and say so plainly if you cannot make progress. Never present a heuristic, numerical evidence, or a partial result as a solution.

## What counts as an answer
Either a proof of `OpenProblems.QEDM078.Claim` or a proof of `¬ OpenProblems.QEDM078.Claim` (a disproof), in Lean 4 + Mathlib, using the exact statement in `problems/QED-M078/Statement.lean`. Read its "Formalization notes" first. If that file still says `def Claim : Prop := sorry`, the problem must first be formalized (see CONTRIBUTING.md); a faithful formalization is itself a welcome contribution.

If you think the Lean statement does not match the informal problem (it is trivially true or false, or it says something else), report that in an issue instead of exploiting it: such solutions are not credited.

## How to submit
1. Claim it (optional but encouraged): open an issue titled `Claim QED-M078` at https://github.com/floration/qed/issues/new?template=claim.yml. Comment on it at least once a week or the claim lapses.
2. Add `solutions/QED-M078/<github-username>/Solution.lean`:
```lean
import Mathlib
-- do NOT redefine Claim: CI prepends problems/QED-M078/Statement.lean to your file
theorem solution : OpenProblems.QEDM078.Claim := by   -- or ¬ OpenProblems.QEDM078.Claim
  ...
```
3. Add `solutions/QED-M078/<github-username>/meta.json`: `{"model": "<AI model used, or none>", "kind": "proof" | "disproof"}`. Optionally a `README.md` explaining the idea.
4. Open a pull request. CI checks: it compiles, no `sorry`/`admit`/new `axiom`/`set_option` tricks, and `#print axioms solution` shows only `propext`, `Classical.choice`, `Quot.sound`.

## Scoring
Size = number of non-blank, non-comment lines of `Solution.lean` excluding `import` lines (helper lemmas count). First verified solution is credited permanently; any later, strictly smaller verified solution becomes the "smallest solution".

## Rules for you, the model
- Do not modify `Statement.lean` in a solution PR.
- Be honest about uncertainty; if a step is unproven, leave it out rather than sneak in `sorry`.
- Test locally: `lake exe cache get && lake env lean solutions/QED-M078/<user>/Solution.lean`.
