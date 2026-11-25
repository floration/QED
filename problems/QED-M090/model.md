# QED-M090 — Does an oscillating source lower the Strauss exponent?

You are an AI model helping someone attack this open problem. Read all of this before working.

## The problem
Main set · Grade A · QED Original · PDE

**Plain words:** For the 3D wave equation with source |u|^p, small smooth data give global solutions exactly when p > 1+√2 (Strauss). Multiply the source by a factor that oscillates periodically in time with average zero, such as cos t. The global-existence proof still works above 1+√2. Every blow-up proof below it breaks, because they all need the source to be positive. Is the true threshold strictly smaller?

**Math:** For u_tt − Δu = cos(t)|u|^p on R^{1+3} (continuous Kirchhoff–Duhamel mild solutions), is p_c < 1+√2, i.e. does some p in (1,1+√2) have small-data global existence for all real C_c^∞ data? Exact p_c, dependence on g and lifespan are not formalized; the all-g version is ClaimGeneral (secondary).

**QED results so far (reviewer-derived; check before relying on them):** Bound p_c<=1+sqrt2 is correct: John/Zhou iteration uses only |F(u)|<=C|u|^p and |F(u)-F(v)|<=C(|u|+|v|)^{p-1}|u-v|, both hold for g(t)|u|^p. The 'resonance predicts 2' heuristic (exp of int t^{1-p}) is arithmetically right but not an argument; a normal-form attempt (H''=g) just recycles the oscillating factor, so nothing is proved.

**Rests on recent unrefereed work. Check these premises first:**
- arXiv:2609.28389 (2026 preprint): cited background on Strauss-type problems with time-dependent coefficients; the statement does not depend on it.

**References:**
- https://arxiv.org/pdf/1705.03965
- https://ricerca.uniba.it/retrieve/df4c0680-37be-4856-a2cb-00c79cabccc2/Postprint%20DAbbiccoLucenteReissig2015%20JDE.pdf
- https://arxiv.org/pdf/2306.11471
- https://arxiv.org/pdf/1110.4454
- https://arxiv.org/pdf/2306.11471
- https://arxiv.org/html/2609.28389
- https://arxiv.org/pdf/1705.03965

Difficulty estimate: 4.0/10 (anchored scale: 1 ≈ Erdős–Ginzburg–Ziv, 2.5 ≈ the sensitivity conjecture, 5 ≈ bounded prime gaps, 7.5 ≈ the Riemann Hypothesis, 10 ≈ P vs NP). It is believed open; do not assume a quick answer exists, and say so plainly if you cannot make progress. Never present a heuristic, numerical evidence, or a partial result as a solution.

## What counts as an answer
Either a proof of `OpenProblems.QEDM090.Claim` or a proof of `¬ OpenProblems.QEDM090.Claim` (a disproof), in Lean 4 + Mathlib, using the exact statement in `problems/QED-M090/Statement.lean`. Read its "Formalization notes" first. If that file still says `def Claim : Prop := sorry`, the problem must first be formalized (see CONTRIBUTING.md); a faithful formalization is itself a welcome contribution.

If you think the Lean statement does not match the informal problem (it is trivially true or false, or it says something else), report that in an issue instead of exploiting it: such solutions are not credited.

## How to submit
0. First time? Solve a test problem (QED-Q1, the 2-line one, at minimum) and submit it, to confirm your Lean setup and the submission pipeline work before spending effort here. Skip this step if this IS a test problem.
1. Claim it (optional but encouraged): open an issue titled `Claim QED-M090` at https://github.com/floration/qed/issues/new?template=claim.yml. Comment on it at least once a week or the claim lapses.
2. Add `solutions/QED-M090/<github-username>/Solution.lean`:
```lean
import Mathlib
-- do NOT redefine Claim: CI prepends problems/QED-M090/Statement.lean to your file
theorem solution : OpenProblems.QEDM090.Claim := by   -- or ¬ OpenProblems.QEDM090.Claim
  ...
```
   Large proofs may add more `.lean` files (subfolders allowed) next to Solution.lean; CI concatenates them in path order before Solution.lean. Don't import them.
3. Add `solutions/QED-M090/<github-username>/meta.json`: `{"model": "<AI model used, or none>", "kind": "proof" | "disproof"}`. Optionally a `README.md` explaining the idea.
4. Open a pull request. CI checks: it compiles, no `sorry`/`admit`/new `axiom`/`set_option` tricks, and `#print axioms solution` shows only `propext`, `Classical.choice`, `Quot.sound`.

## Scoring
Size = number of non-blank, non-comment lines of `Solution.lean` excluding `import` lines (helper lemmas count). First verified solution is credited permanently; any later, strictly smaller verified solution becomes the "smallest solution".

## Rules for you, the model
- Do not modify `Statement.lean` in a solution PR.
- Be honest about uncertainty; if a step is unproven, leave it out rather than sneak in `sorry`.
- Test locally: `lake exe cache get && lake env lean solutions/QED-M090/<user>/Solution.lean`.
