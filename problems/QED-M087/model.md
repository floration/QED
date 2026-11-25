# QED-M087 — Blow-up under a steady force

You are an AI model helping someone attack this open problem. Read all of this before working.

## The problem
Main set · Grade B · QED Extension · PDE

**Plain words:** The 2026 forced Navier–Stokes blow-up uses a push that varies in time and is switched on and off. Can a smooth, compactly supported push that never changes in time also drive a fluid at rest to a singularity?

**Math:** Decide whether there is $f\in C_c^\infty(\mathbb R^3;\mathbb R^3)$, independent of $t$, such that the solution of $\partial_tu+(u\cdot\nabla)u+\nabla p=\Delta u+f$, $\nabla\cdot u=0$, $u(\cdot,0)=0$ on $\mathbb R^3$ loses smoothness in finite time.

**Credit:** Fefferman, Clay Millennium problem statement (forced breakdown on R^3); OpenAI forced blow-up claim (2026, unrefereed)

**Rests on recent unrefereed work. Check these premises first:**
- OpenAI company PDF (cdn.openai.com navier-stokes.pdf, unrefereed): claimed time-dependent forced blow-up. This is motivation only and Claim does not depend on it.
- arXiv:2609.10262 (2026 preprint): cited for context (possibly the source of the Cao-Chi-Nie gradient-force remark); Claim does not depend on it.

**References:**
- https://cdn.openai.com/pdf/32d9f210-8b73-45e0-91bc-82a30aef8a9a/navier-stokes.pdf
- https://arxiv.org/pdf/2609.10262
- https://openai.com/index/navier-stokes-solution/

Difficulty estimate: 5.5/10 (calibrated: Collatz ≈ 5.5, twin primes ≈ 5.0). It is believed open; do not assume a quick answer exists, and say so plainly if you cannot make progress. Never present a heuristic, numerical evidence, or a partial result as a solution.

## What counts as an answer
Either a proof of `OpenProblems.QEDM087.Claim` or a proof of `¬ OpenProblems.QEDM087.Claim` (a disproof), in Lean 4 + Mathlib, using the exact statement in `problems/QED-M087/Statement.lean`. Read its "Formalization notes" first. If that file still says `def Claim : Prop := sorry`, the problem must first be formalized (see CONTRIBUTING.md); a faithful formalization is itself a welcome contribution.

If you think the Lean statement does not match the informal problem (it is trivially true or false, or it says something else), report that in an issue instead of exploiting it: such solutions are not credited.

## How to submit
0. First time? Solve a test problem (QED-Q1, the 2-line one, at minimum) and submit it, to confirm your Lean setup and the submission pipeline work before spending effort here. Skip this step if this IS a test problem.
1. Claim it (optional but encouraged): open an issue titled `Claim QED-M087` at https://github.com/floration/qed/issues/new?template=claim.yml. Comment on it at least once a week or the claim lapses.
2. Add `solutions/QED-M087/<github-username>/Solution.lean`:
```lean
import Mathlib
-- do NOT redefine Claim: CI prepends problems/QED-M087/Statement.lean to your file
theorem solution : OpenProblems.QEDM087.Claim := by   -- or ¬ OpenProblems.QEDM087.Claim
  ...
```
   Large proofs may add more `.lean` files (subfolders allowed) next to Solution.lean; CI concatenates them in path order before Solution.lean. Don't import them.
3. Add `solutions/QED-M087/<github-username>/meta.json`: `{"model": "<AI model used, or none>", "kind": "proof" | "disproof"}`. Optionally a `README.md` explaining the idea.
4. Open a pull request. CI checks: it compiles, no `sorry`/`admit`/new `axiom`/`set_option` tricks, and `#print axioms solution` shows only `propext`, `Classical.choice`, `Quot.sound`.

## Scoring
Size = number of non-blank, non-comment lines of `Solution.lean` excluding `import` lines (helper lemmas count). First verified solution is credited permanently; any later, strictly smaller verified solution becomes the "smallest solution".

## Rules for you, the model
- Do not modify `Statement.lean` in a solution PR.
- Be honest about uncertainty; if a step is unproven, leave it out rather than sneak in `sorry`.
- Test locally: `lake exe cache get && lake env lean solutions/QED-M087/<user>/Solution.lean`.
