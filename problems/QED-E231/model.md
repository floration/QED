# QED-E231 — AKLT spectral gap on hat tilings

You are an AI model helping someone attack this open problem. Read all of this before working.

## The problem
Extended set · Grade C · QED Original · Mathematical physics

**Plain words:** The AKLT model is a standard quantum spin model built on a graph, with a spin of size (degree)/2 at each vertex. Proofs that it has an energy gap exist for the honeycomb and several other periodic planar lattices, by computer-assisted finite-size criteria. Show the AKLT model on the graph of a hat tiling, which is not periodic, also has a gap that does not depend on which hat tiling or how large a region is taken.

**Math:** For a hat tiling $\mathcal T$ let $G_{\mathcal T}$ be its planar graph: vertices are points lying in at least three tiles, edges are the boundary arcs between consecutive such points. Put spin $S_v=\deg(v)/2$ at each $v$ and, for finite $\Lambda$, $H_\Lambda=\sum_{uv\in E(\Lambda)}P^{(S_u+S_v)}_{uv}$ (projection onto total spin $S_u+S_v$). Prove there is $\gamma>0$ such that for every hat tiling $\mathcal T$ the infinite-volume AKLT model on $G_{\mathcal T}$ has a unique frustration-free ground state $\omega$, and its GNS Hamiltonian $H_\omega$ has $\ker H_\omega=\mathbb C\Omega_\omega$ and $\operatorname{spec}(H_\omega)\setminus\{0\}\subseteq[\gamma,\infty)$.

**Credit:** QED original (archived Nov 2026, restored after re-review).

**References:**
- https://arxiv.org/abs/1910.11810
- https://arxiv.org/abs/1911.01410
- https://arxiv.org/abs/2010.03137
- https://arxiv.org/abs/2308.02811

Difficulty estimate: 6.5/10 (anchored scale: 1 ≈ Erdős–Ginzburg–Ziv, 2.5 ≈ the sensitivity conjecture, 5 ≈ bounded prime gaps, 7.5 ≈ the Riemann Hypothesis, 10 ≈ P vs NP). It is believed open; do not assume a quick answer exists, and say so plainly if you cannot make progress. Never present a heuristic, numerical evidence, or a partial result as a solution.

## What counts as an answer
Either a proof of `OpenProblems.QEDE231.Claim` or a proof of `¬ OpenProblems.QEDE231.Claim` (a disproof), in Lean 4 + Mathlib, using the exact statement in `problems/QED-E231/Statement.lean`. Read its "Formalization notes" first. If that file still says `def Claim : Prop := sorry`, the problem must first be formalized (see CONTRIBUTING.md); a faithful formalization is itself a welcome contribution.

If you think the Lean statement does not match the informal problem (it is trivially true or false, or it says something else), report that in an issue instead of exploiting it: such solutions are not credited.

## How to submit
0. First time? Solve a test problem (QED-Q1, the 2-line one, at minimum) and submit it, to confirm your Lean setup and the submission pipeline work before spending effort here. Skip this step if this IS a test problem.
1. Claim it (optional but encouraged): open an issue titled `Claim QED-E231` at https://github.com/floration/qed/issues/new?template=claim.yml. Comment on it at least once a week or the claim lapses.
2. Add `solutions/QED-E231/<github-username>/Solution.lean`:
```lean
import Mathlib
-- do NOT redefine Claim: CI prepends problems/QED-E231/Statement.lean to your file
theorem solution : OpenProblems.QEDE231.Claim := by   -- or ¬ OpenProblems.QEDE231.Claim
  ...
```
   Large proofs may add more `.lean` files (subfolders allowed) next to Solution.lean; CI concatenates them in path order before Solution.lean. Don't import them.
3. Add `solutions/QED-E231/<github-username>/meta.json`: `{"model": "<AI model used, or none>", "kind": "proof" | "disproof"}`. Optionally a `README.md` explaining the idea.
4. Open a pull request. CI checks: it compiles, no `sorry`/`admit`/new `axiom`/`set_option` tricks, and `#print axioms solution` shows only `propext`, `Classical.choice`, `Quot.sound`.

## Scoring
Size = number of non-blank, non-comment lines of `Solution.lean` excluding `import` lines (helper lemmas count). First verified solution is credited permanently; any later, strictly smaller verified solution becomes the "smallest solution".

## Rules for you, the model
- Do not modify `Statement.lean` in a solution PR.
- Be honest about uncertainty; if a step is unproven, leave it out rather than sneak in `sorry`.
- Test locally: `lake exe cache get && lake env lean solutions/QED-E231/<user>/Solution.lean`.
