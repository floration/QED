# QED-M093 — Forced Navier–Stokes blow-up at a no-slip wall

You are an AI model helping someone attack this open problem. Read all of this before working.

## The problem
Main set · Grade A · QED Extension · PDE

**Plain words:** In 2026 it was shown that a smooth, compactly supported force can drive the 3D Navier–Stokes equations, started from rest, to blow up in finite time. Inside a domain this can simply be copied away from any wall. Show that blow-up can also happen at the wall itself: in a half-space with the no-slip condition, the velocity becomes unbounded at a point of the boundary.

**Math:** Let $\mathbb R^3_+=\{x_3>0\}$, $\nu>0$. Construct $f\in C^\infty_c(\overline{\mathbb R^3_+}\times(0,\infty);\mathbb R^3)$ and a solution $(u,p)$ of $\partial_t u-\nu\Delta u+(u\cdot\nabla)u+\nabla p=f$, $\nabla\cdot u=0$ in $\mathbb R^3_+\times(0,T)$, $u|_{x_3=0}=0$, $u(\cdot,0)=0$, with $u\in C^\infty(\overline{\mathbb R^3_+}\times[0,T))$, $\sup_{t<T}\|u(t)\|_{L^2}<\infty$ and $\limsup_{t\uparrow T}\|u(t)\|_{L^\infty}=\infty$, such that $u$ stays bounded on $\{x_3>r\}\times[0,T)$ for every $r>0$ (all singular points lie on the wall).

**Credit:** Extends the OpenAI 2026 forced Navier–Stokes blow-up (cdn.openai.com navier-stokes.pdf) and Cao–Chi–Nie, arXiv:2609.10262.

**Rests on recent unrefereed work. Check these premises first:**
- OpenAI navier-stokes.pdf (company PDF, unrefereed): the existence of forced finite-time blow-up on R^3/T^3 from rest with C_c^infty force; motivates the problem (statement itself does not depend on it).
- Cao–Chi–Nie arXiv:2609.10262 (2026 preprint): interior-ball placement of blow-up in domains; used to argue interior case is 'already available'.
- Lei–Ren arXiv:2609.35406 (2026 preprint): R^3 forced blow-up; background only.

**References:**
- https://cdn.openai.com/pdf/32d9f210-8b73-45e0-91bc-82a30aef8a9a/navier-stokes.pdf
- https://arxiv.org/pdf/2609.10262
- https://arxiv.org/pdf/2405.00369
- https://arxiv.org/pdf/2303.05746
- https://arxiv.org/pdf/1508.05313
- https://cdn.openai.com/pdf/32d9f210-8b73-45e0-91bc-82a30aef8a9a/navier-stokes.pdf
- https://arxiv.org/abs/2609.10262
- https://arxiv.org/abs/2609.35406

Difficulty estimate: 4.0/10 (calibrated: Collatz ≈ 5.5, twin primes ≈ 5.0). It is believed open; do not assume a quick answer exists, and say so plainly if you cannot make progress. Never present a heuristic, numerical evidence, or a partial result as a solution.

## What counts as an answer
Either a proof of `OpenProblems.QEDM093.Claim` or a proof of `¬ OpenProblems.QEDM093.Claim` (a disproof), in Lean 4 + Mathlib, using the exact statement in `problems/QED-M093/Statement.lean`. Read its "Formalization notes" first. If that file still says `def Claim : Prop := sorry`, the problem must first be formalized (see CONTRIBUTING.md); a faithful formalization is itself a welcome contribution.

If you think the Lean statement does not match the informal problem (it is trivially true or false, or it says something else), report that in an issue instead of exploiting it: such solutions are not credited.

## How to submit
1. Claim it (optional but encouraged): open an issue titled `Claim QED-M093` at https://github.com/floration/qed/issues/new?template=claim.yml. Comment on it at least once a week or the claim lapses.
2. Add `solutions/QED-M093/<github-username>/Solution.lean`:
```lean
import Mathlib
-- do NOT redefine Claim: CI prepends problems/QED-M093/Statement.lean to your file
theorem solution : OpenProblems.QEDM093.Claim := by   -- or ¬ OpenProblems.QEDM093.Claim
  ...
```
3. Add `solutions/QED-M093/<github-username>/meta.json`: `{"model": "<AI model used, or none>", "kind": "proof" | "disproof"}`. Optionally a `README.md` explaining the idea.
4. Open a pull request. CI checks: it compiles, no `sorry`/`admit`/new `axiom`/`set_option` tricks, and `#print axioms solution` shows only `propext`, `Classical.choice`, `Quot.sound`.

## Scoring
Size = number of non-blank, non-comment lines of `Solution.lean` excluding `import` lines (helper lemmas count). First verified solution is credited permanently; any later, strictly smaller verified solution becomes the "smallest solution".

## Rules for you, the model
- Do not modify `Statement.lean` in a solution PR.
- Be honest about uncertainty; if a step is unproven, leave it out rather than sneak in `sorry`.
- Test locally: `lake exe cache get && lake env lean solutions/QED-M093/<user>/Solution.lean`.
