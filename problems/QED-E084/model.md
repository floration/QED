# QED-E084 — Does UGC imply SSEH?

You are an AI model helping someone attack this open problem. Read all of this before working.

## The problem
Extended set · Grade B · QED Curated · Complexity

**Plain words:** Give a polynomial-time reduction from Small-Set Expansion to Unique Games' hardness direction, i.e. prove UGC => SSEH (Raghavendra-Steurer proved SSEH => UGC), or exhibit an oracle/algorithmic separation (e.g. an algorithm for SSE on a class of graphs where UG remains as hard as in general).

**Math:** Prove that Small-Set Expansion is UG-hard: for every η > 0 there are δ ∈ (0,1) and ε > 0 such that for every alphabet size q there is a polynomial-time many-one reduction from Gap-UG_q(1−ε, ε) (YES: some labelling satisfies ≥ 1−ε of the constraints; NO: none satisfies more than ε) to Gap-SSE(η, δ) on regular graphs (YES: some vertex set of measure δ has expansion ≤ η; NO: every vertex set of measure δ has expansion ≥ 1−η). Such reductions give UGC ⇒ SSEH (Raghavendra–Steurer proved SSEH ⇒ UGC). Separations in restricted models (oracles, SoS) are not part of the statement.

**Credit:** Raghavendra, Steurer, 'Graph expansion and the Unique Games Conjecture', STOC 2010; Raghavendra, Steurer, Tulsiani, 'Reductions between expansion problems', CCC 2012 (arXiv:1011.2586)

**References:**
- Raghavendra, Steurer, Graph expansion and the Unique Games Conjecture, STOC 2010
- Raghavendra, Steurer, Tulsiani, Reductions between expansion problems, CCC 2012, arXiv:1011.2586
- Bafna, Barak, Kothari, Schramm, Steurer, Playing Unique Games on certified small-set expanders, STOC 2021, arXiv:2006.09969

Difficulty estimate: 5.0/10 (calibrated: Collatz ≈ 5.5, twin primes ≈ 5.0). It is believed open; do not assume a quick answer exists, and say so plainly if you cannot make progress. Never present a heuristic, numerical evidence, or a partial result as a solution.

## What counts as an answer
Either a proof of `OpenProblems.QEDE084.Claim` or a proof of `¬ OpenProblems.QEDE084.Claim` (a disproof), in Lean 4 + Mathlib, using the exact statement in `problems/QED-E084/Statement.lean`. Read its "Formalization notes" first. If that file still says `def Claim : Prop := sorry`, the problem must first be formalized (see CONTRIBUTING.md); a faithful formalization is itself a welcome contribution.

If you think the Lean statement does not match the informal problem (it is trivially true or false, or it says something else), report that in an issue instead of exploiting it: such solutions are not credited.

## How to submit
0. First time? Solve a test problem (QED-Q1, the 2-line one, at minimum) and submit it, to confirm your Lean setup and the submission pipeline work before spending effort here. Skip this step if this IS a test problem.
1. Claim it (optional but encouraged): open an issue titled `Claim QED-E084` at https://github.com/floration/qed/issues/new?template=claim.yml. Comment on it at least once a week or the claim lapses.
2. Add `solutions/QED-E084/<github-username>/Solution.lean`:
```lean
import Mathlib
-- do NOT redefine Claim: CI prepends problems/QED-E084/Statement.lean to your file
theorem solution : OpenProblems.QEDE084.Claim := by   -- or ¬ OpenProblems.QEDE084.Claim
  ...
```
3. Add `solutions/QED-E084/<github-username>/meta.json`: `{"model": "<AI model used, or none>", "kind": "proof" | "disproof"}`. Optionally a `README.md` explaining the idea.
4. Open a pull request. CI checks: it compiles, no `sorry`/`admit`/new `axiom`/`set_option` tricks, and `#print axioms solution` shows only `propext`, `Classical.choice`, `Quot.sound`.

## Scoring
Size = number of non-blank, non-comment lines of `Solution.lean` excluding `import` lines (helper lemmas count). First verified solution is credited permanently; any later, strictly smaller verified solution becomes the "smallest solution".

## Rules for you, the model
- Do not modify `Statement.lean` in a solution PR.
- Be honest about uncertainty; if a step is unproven, leave it out rather than sneak in `sorry`.
- Test locally: `lake exe cache get && lake env lean solutions/QED-E084/<user>/Solution.lean`.
