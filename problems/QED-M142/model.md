# QED-M142 — Lonely runner with speeds at most 2n

You are an AI model helping someone attack this open problem. Read all of this before working.

## The problem
Main set · Grade B · QED Curated · Number theory

**Plain words:** Tao proved the lonely runner conjecture when every speed is at most 1.2 times the number of runners. Push this to speeds at most twice the number of runners (and ideally any fixed multiple).

**Math:** For distinct positive integers v_1,…,v_n let δ(v) = sup_{t∈ℝ} min_i ‖t v_i‖, where ‖·‖ is distance to the nearest integer. Prove that δ(v) ≥ 1/(n+1) for every n ≥ 1 and all distinct v_1,…,v_n ∈ {1,…,2n}. (Tao 2018, Prop. 1.5, proves this for speeds ≤ ⌊6n/5⌋; conjecturally there is no speed restriction.)

**Credit:** QED original (archived Nov 2026, restored after re-review).

**References:**
- https://arxiv.org/abs/1701.02048
- https://arxiv.org/abs/2511.16636
- https://arxiv.org/pdf/2609.02604
- https://arxiv.org/abs/2603.24784
- https://en.wikipedia.org/wiki/Lonely_runner_conjecture

Difficulty estimate: 5.0/10 (anchored scale: 1 ≈ Erdős–Ginzburg–Ziv, 2.5 ≈ the sensitivity conjecture, 5 ≈ bounded prime gaps, 7.5 ≈ the Riemann Hypothesis, 10 ≈ P vs NP). It is believed open; do not assume a quick answer exists, and say so plainly if you cannot make progress. Never present a heuristic, numerical evidence, or a partial result as a solution.

## What counts as an answer
Either a proof of `OpenProblems.QEDM142.Claim` or a proof of `¬ OpenProblems.QEDM142.Claim` (a disproof), in Lean 4 + Mathlib, using the exact statement in `problems/QED-M142/Statement.lean`. Read its "Formalization notes" first. If that file still says `def Claim : Prop := sorry`, the problem must first be formalized (see CONTRIBUTING.md); a faithful formalization is itself a welcome contribution.

If you think the Lean statement does not match the informal problem (it is trivially true or false, or it says something else), report that in an issue instead of exploiting it: such solutions are not credited.

## How to submit
0. First time? Solve a test problem (QED-Q1, the 2-line one, at minimum) and submit it, to confirm your Lean setup and the submission pipeline work before spending effort here. Skip this step if this IS a test problem.
1. Claim it (optional but encouraged): open an issue titled `Claim QED-M142` at https://github.com/floration/qed/issues/new?template=claim.yml. Comment on it at least once a week or the claim lapses.
2. Add `solutions/QED-M142/<github-username>/Solution.lean`:
```lean
import Mathlib
-- do NOT redefine Claim: CI prepends problems/QED-M142/Statement.lean to your file
theorem solution : OpenProblems.QEDM142.Claim := by   -- or ¬ OpenProblems.QEDM142.Claim
  ...
```
   Large proofs may add more `.lean` files (subfolders allowed) next to Solution.lean; CI concatenates them in path order before Solution.lean. Don't import them.
3. Add `solutions/QED-M142/<github-username>/meta.json`: `{"model": "<AI model used, or none>", "kind": "proof" | "disproof"}`. Optionally a `README.md` explaining the idea.
4. Open a pull request. CI checks: it compiles, no `sorry`/`admit`/new `axiom`/`set_option` tricks, and `#print axioms solution` shows only `propext`, `Classical.choice`, `Quot.sound`.

## Scoring
Size = number of non-blank, non-comment lines of `Solution.lean` excluding `import` lines (helper lemmas count). First verified solution is credited permanently; any later, strictly smaller verified solution becomes the "smallest solution".

## Rules for you, the model
- Do not modify `Statement.lean` in a solution PR.
- Be honest about uncertainty; if a step is unproven, leave it out rather than sneak in `sorry`.
- Test locally: `lake exe cache get && lake env lean solutions/QED-M142/<user>/Solution.lean`.
