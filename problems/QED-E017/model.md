# QED-E017 — Unforced blow-up near the forced one

You are an AI model helping someone attack this open problem. Read all of this before working.

## The problem
Extended set · Grade C · PDE · formerly N-610

**Plain words:** The 2026 forced Navier–Stokes blow-up uses a force that is smooth through the blow-up time. Can the force be made to vanish identically at the blow-up instant while staying smooth up to and including that instant?

**Math:** Do there exist $T>0$ and $f\in C_c^\infty(\mathbb R^3\times(0,\infty))$ with $f(\cdot,T)\equiv0$ such that the 3D Navier–Stokes solution on $\mathbb R^3$ with $u_0=0$ and force $f$ satisfies $\limsup_{t\uparrow T}\|u(t)\|_{L^\infty}=\infty$? (Requiring $f\equiv0$ on $[T-\delta,T]$ for some $\delta>0$ instead would be equivalent to unforced blow-up from smooth data, which is the Millennium problem.)

**Reviewer note:** A

**References:**
- https://cdn.openai.com/pdf/32d9f210-8b73-45e0-91bc-82a30aef8a9a/navier-stokes.pdf
- https://arxiv.org/pdf/2609.10262
- https://arxiv.org/pdf/2609.35406
- https://arxiv.org/pdf/2611.06869

Difficulty estimate: 6.8/10 (calibrated: Collatz ≈ 5.5, twin primes ≈ 5.0). It is believed open; do not assume a quick answer exists, and say so plainly if you cannot make progress. Never present a heuristic, numerical evidence, or a partial result as a solution.

## What counts as an answer
Either a proof of `OpenProblems.QEDE017.Claim` or a proof of `¬ OpenProblems.QEDE017.Claim` (a disproof), in Lean 4 + Mathlib, using the exact statement in `problems/QED-E017/Statement.lean`. Read its "Formalization notes" first. If that file still says `def Claim : Prop := sorry`, the problem must first be formalized (see CONTRIBUTING.md); a faithful formalization is itself a welcome contribution.

If you think the Lean statement does not match the informal problem (it is trivially true or false, or it says something else), report that in an issue instead of exploiting it: such solutions are not credited.

## How to submit
1. Claim it (optional but encouraged): open an issue titled `Claim QED-E017` at https://github.com/floration/qed/issues/new?template=claim.yml. Comment on it at least once a week or the claim lapses.
2. Add `solutions/QED-E017/<github-username>/Solution.lean`:
```lean
import Mathlib
-- do NOT redefine Claim: CI prepends problems/QED-E017/Statement.lean to your file
theorem solution : OpenProblems.QEDE017.Claim := by   -- or ¬ OpenProblems.QEDE017.Claim
  ...
```
3. Add `solutions/QED-E017/<github-username>/meta.json`: `{"model": "<AI model used, or none>", "kind": "proof" | "disproof"}`. Optionally a `README.md` explaining the idea.
4. Open a pull request. CI checks: it compiles, no `sorry`/`admit`/new `axiom`/`set_option` tricks, and `#print axioms solution` shows only `propext`, `Classical.choice`, `Quot.sound`.

## Scoring
Size = number of non-blank, non-comment lines of `Solution.lean` excluding `import` lines (helper lemmas count). First verified solution is credited permanently; any later, strictly smaller verified solution becomes the "smallest solution".

## Rules for you, the model
- Do not modify `Statement.lean` in a solution PR.
- Be honest about uncertainty; if a step is unproven, leave it out rather than sneak in `sorry`.
- Test locally: `lake exe cache get && lake env lean solutions/QED-E017/<user>/Solution.lean`.
