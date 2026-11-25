# QED-E088 — Integrability of the egg-crate torus

You are an AI model helping someone attack this open problem. Read all of this before working.

## The problem
Extended set · Grade B · QED Extension · Dynamics

**Plain words:** Put the surface z = ε sin x sin y over a flat square torus. Show its geodesic flow is never integrable, however small the bumps are.

**Math:** For $\varepsilon>0$ let $g_\varepsilon$ be the metric on $\mathbb T^2=\mathbb R^2/(2\pi\mathbb Z)^2$ induced from the graph $z=\varepsilon\sin x\sin y$, i.e. $g_\varepsilon=dx^2+dy^2+\varepsilon^2(\cos x\sin y\,dx+\sin x\cos y\,dy)^2$. Prove that for every $\varepsilon>0$ the geodesic flow on $T^*\mathbb T^2\setminus0$ has no real-analytic first integral functionally independent of the Hamiltonian (for example, by showing positive topological entropy).

**Credit:** V. V. Kozlov, non-integrability of perturbed geodesic flows on the torus (Poincaré-Kozlov theory; 'Symmetries, Topology and Resonances in Hamiltonian Mechanics', 1996); Paternain, Taimanov for entropy obstructions

**References:**
- https://en.wikipedia.org/wiki/Integrable_system

Difficulty estimate: 4.0/10 (calibrated: Collatz ≈ 5.5, twin primes ≈ 5.0). It is believed open; do not assume a quick answer exists, and say so plainly if you cannot make progress. Never present a heuristic, numerical evidence, or a partial result as a solution.

## What counts as an answer
Either a proof of `OpenProblems.QEDE088.Claim` or a proof of `¬ OpenProblems.QEDE088.Claim` (a disproof), in Lean 4 + Mathlib, using the exact statement in `problems/QED-E088/Statement.lean`. Read its "Formalization notes" first. If that file still says `def Claim : Prop := sorry`, the problem must first be formalized (see CONTRIBUTING.md); a faithful formalization is itself a welcome contribution.

If you think the Lean statement does not match the informal problem (it is trivially true or false, or it says something else), report that in an issue instead of exploiting it: such solutions are not credited.

## How to submit
0. First time? Solve a test problem (QED-Q1, the 2-line one, at minimum) and submit it, to confirm your Lean setup and the submission pipeline work before spending effort here. Skip this step if this IS a test problem.
1. Claim it (optional but encouraged): open an issue titled `Claim QED-E088` at https://github.com/floration/qed/issues/new?template=claim.yml. Comment on it at least once a week or the claim lapses.
2. Add `solutions/QED-E088/<github-username>/Solution.lean`:
```lean
import Mathlib
-- do NOT redefine Claim: CI prepends problems/QED-E088/Statement.lean to your file
theorem solution : OpenProblems.QEDE088.Claim := by   -- or ¬ OpenProblems.QEDE088.Claim
  ...
```
   Large proofs may add more `.lean` files (subfolders allowed) next to Solution.lean; CI concatenates them in path order before Solution.lean. Don't import them.
3. Add `solutions/QED-E088/<github-username>/meta.json`: `{"model": "<AI model used, or none>", "kind": "proof" | "disproof"}`. Optionally a `README.md` explaining the idea.
4. Open a pull request. CI checks: it compiles, no `sorry`/`admit`/new `axiom`/`set_option` tricks, and `#print axioms solution` shows only `propext`, `Classical.choice`, `Quot.sound`.

## Scoring
Size = number of non-blank, non-comment lines of `Solution.lean` excluding `import` lines (helper lemmas count). First verified solution is credited permanently; any later, strictly smaller verified solution becomes the "smallest solution".

## Rules for you, the model
- Do not modify `Statement.lean` in a solution PR.
- Be honest about uncertainty; if a step is unproven, leave it out rather than sneak in `sorry`.
- Test locally: `lake exe cache get && lake env lean solutions/QED-E088/<user>/Solution.lean`.
