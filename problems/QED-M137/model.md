# QED-M137 — Navier–Stokes blow-up with the force kept away from the singularity

You are an AI model helping someone attack this open problem. Read all of this before working.

## The problem
Main set · Grade A · QED Original · Analysis

**Plain words:** In 2026 OpenAI built a smooth, compactly supported force that drives the 3D Navier–Stokes equations, started from rest, to blow up in finite time. In that construction the force acts right where the singularity forms. Can it be done with a force that never acts anywhere near the blow-up point, so that the fluid near the singularity obeys the unforced equations the whole time?

**Math:** Let $\nu>0$. Decide whether there exist $f\in C_c^\infty(\mathbb R^3\times(0,\infty);\mathbb R^3)$, $T>0$ and $x_*\in\mathbb R^3$ with $\operatorname{supp}f\cap\big(B(x_*,1)\times(0,\infty)\big)=\emptyset$ such that the unique smooth solution of $\partial_tu+(u\cdot\nabla)u+\nabla p=\nu\Delta u+f$, $\nabla\cdot u=0$, $u(\cdot,0)=0$ on $\mathbb R^3\times[0,T)$ satisfies $\sup_{t<T}\|u(t)\|_{L^2}<\infty$ and $\limsup_{t\uparrow T}\|u(t)\|_{L^\infty(B(x_*,r))}=\infty$ for every $r>0$. (By the scaling $u_\lambda(x,t)=\lambda u(\lambda x,\lambda^2t)$, the radius $1$ can be replaced by any $\rho>0$.)

**Credit:** QED original (archived Nov 2026, restored after re-review).

**References:**
- https://cdn.openai.com/pdf/32d9f210-8b73-45e0-91bc-82a30aef8a9a/navier-stokes.pdf
- https://arxiv.org/abs/2609.10262
- https://arxiv.org/abs/2303.05746
- https://arxiv.org/abs/2411.13896

Difficulty estimate: 7.0/10 (anchored scale: 1 ≈ Erdős–Ginzburg–Ziv, 2.5 ≈ the sensitivity conjecture, 5 ≈ bounded prime gaps, 7.5 ≈ the Riemann Hypothesis, 10 ≈ P vs NP). It is believed open; do not assume a quick answer exists, and say so plainly if you cannot make progress. Never present a heuristic, numerical evidence, or a partial result as a solution.

## What counts as an answer
Either a proof of `OpenProblems.QEDM137.Claim` or a proof of `¬ OpenProblems.QEDM137.Claim` (a disproof), in Lean 4 + Mathlib, using the exact statement in `problems/QED-M137/Statement.lean`. Read its "Formalization notes" first. If that file still says `def Claim : Prop := sorry`, the problem must first be formalized (see CONTRIBUTING.md); a faithful formalization is itself a welcome contribution.

If you think the Lean statement does not match the informal problem (it is trivially true or false, or it says something else), report that in an issue instead of exploiting it: such solutions are not credited.

## How to submit
0. First time? Solve a test problem (QED-Q1, the 2-line one, at minimum) and submit it, to confirm your Lean setup and the submission pipeline work before spending effort here. Skip this step if this IS a test problem.
1. Claim it (optional but encouraged): open an issue titled `Claim QED-M137` at https://github.com/floration/qed/issues/new?template=claim.yml. Comment on it at least once a week or the claim lapses.
2. Add `solutions/QED-M137/<github-username>/Solution.lean`:
```lean
import Mathlib
-- do NOT redefine Claim: CI prepends problems/QED-M137/Statement.lean to your file
theorem solution : OpenProblems.QEDM137.Claim := by   -- or ¬ OpenProblems.QEDM137.Claim
  ...
```
   Large proofs may add more `.lean` files (subfolders allowed) next to Solution.lean; CI concatenates them in path order before Solution.lean. Don't import them.
3. Add `solutions/QED-M137/<github-username>/meta.json`: `{"model": "<AI model used, or none>", "kind": "proof" | "disproof"}`. Optionally a `README.md` explaining the idea.
4. Open a pull request. CI checks: it compiles, no `sorry`/`admit`/new `axiom`/`set_option` tricks, and `#print axioms solution` shows only `propext`, `Classical.choice`, `Quot.sound`.

## Scoring
Size = number of non-blank, non-comment lines of `Solution.lean` excluding `import` lines (helper lemmas count). First verified solution is credited permanently; any later, strictly smaller verified solution becomes the "smallest solution".

## Rules for you, the model
- Do not modify `Statement.lean` in a solution PR.
- Be honest about uncertainty; if a step is unproven, leave it out rather than sneak in `sorry`.
- Test locally: `lake exe cache get && lake env lean solutions/QED-M137/<user>/Solution.lean`.
