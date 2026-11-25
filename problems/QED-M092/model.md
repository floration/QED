# QED-M092 — Forced blow-up up to the Lions threshold

You are an AI model helping someone attack this open problem. Read all of this before working.

## The problem
Main set · Grade A · QED Extension · PDE

**Plain words:** With an ordinary Laplacian, a smooth compactly supported push can make a fluid at rest blow up in finite time (OpenAI, 2026). With dissipation (-Δ)^α for α ≥ 5/4, Lions proved that solutions stay smooth. Does forced blow-up from rest still happen for every α strictly between 1 and 5/4?

**Math:** For $\alpha\in(1,5/4)$ consider $\partial_tu+(u\cdot\nabla)u+\nabla p=-(-\Delta)^{\alpha}u+f$, $\nabla\cdot u=0$ on $\mathbb R^3$, $u(\cdot,0)=0$. Determine the set of $\alpha\in(1,5/4)$ for which there exists $f\in C_c^\infty(\mathbb R^3\times(0,\infty);\mathbb R^3)$ whose unique smooth solution satisfies $\limsup_{t\uparrow T}\|u(t)\|_{L^\infty}=\infty$ for some $T<\infty$. In particular, is it all of $(1,5/4)$, or is it nonempty?

**Credit:** OpenAI, forced Navier–Stokes blow-up (Sep 2026, unrefereed PDF); Lions (1969) for α ≥ 5/4; Tao, averaged Navier–Stokes (arXiv:1402.0290).

**Rests on recent unrefereed work. Check these premises first:**
- OpenAI Navier–Stokes PDF (Sep 2026, company PDF, unrefereed, reportedly Lean-formalized): the problem assumes forced blow-up from rest is known at α = 1.
- arXiv:2609.10262 (2026 preprint): cited as related forced-blow-up work for the Laplacian; motivation only.

**References:**
- https://openai.com/index/navier-stokes-solution/
- https://cdn.openai.com/pdf/32d9f210-8b73-45e0-91bc-82a30aef8a9a/navier-stokes.pdf
- https://arxiv.org/pdf/2609.10262
- https://arxiv.org/abs/2407.06776
- https://cdn.openai.com/pdf/32d9f210-8b73-45e0-91bc-82a30aef8a9a/navier-stokes.pdf
- https://arxiv.org/abs/2609.10262
- https://arxiv.org/abs/2407.06776
- https://arxiv.org/abs/1402.0290
- https://arxiv.org/abs/2307.15986

Difficulty estimate: 4.5/10 (calibrated: Collatz ≈ 5.5, twin primes ≈ 5.0). It is believed open; do not assume a quick answer exists, and say so plainly if you cannot make progress. Never present a heuristic, numerical evidence, or a partial result as a solution.

## What counts as an answer
Either a proof of `OpenProblems.QEDM092.Claim` or a proof of `¬ OpenProblems.QEDM092.Claim` (a disproof), in Lean 4 + Mathlib, using the exact statement in `problems/QED-M092/Statement.lean`. Read its "Formalization notes" first. If that file still says `def Claim : Prop := sorry`, the problem must first be formalized (see CONTRIBUTING.md); a faithful formalization is itself a welcome contribution. What is missing: Not formalized: needs fractional Navier–Stokes solution theory.

If you think the Lean statement does not match the informal problem (it is trivially true or false, or it says something else), report that in an issue instead of exploiting it: such solutions are not credited.

## How to submit
1. Claim it (optional but encouraged): open an issue titled `Claim QED-M092` at https://github.com/floration/qed/issues/new?template=claim.yml. Comment on it at least once a week or the claim lapses.
2. Add `solutions/QED-M092/<github-username>/Solution.lean`:
```lean
import Mathlib
-- do NOT redefine Claim: CI prepends problems/QED-M092/Statement.lean to your file
theorem solution : OpenProblems.QEDM092.Claim := by   -- or ¬ OpenProblems.QEDM092.Claim
  ...
```
   Large proofs may add more `.lean` files (subfolders allowed) next to Solution.lean; CI concatenates them in path order before Solution.lean. Don't import them.
3. Add `solutions/QED-M092/<github-username>/meta.json`: `{"model": "<AI model used, or none>", "kind": "proof" | "disproof"}`. Optionally a `README.md` explaining the idea.
4. Open a pull request. CI checks: it compiles, no `sorry`/`admit`/new `axiom`/`set_option` tricks, and `#print axioms solution` shows only `propext`, `Classical.choice`, `Quot.sound`.

## Scoring
Size = number of non-blank, non-comment lines of `Solution.lean` excluding `import` lines (helper lemmas count). First verified solution is credited permanently; any later, strictly smaller verified solution becomes the "smallest solution".

## Rules for you, the model
- Do not modify `Statement.lean` in a solution PR.
- Be honest about uncertainty; if a step is unproven, leave it out rather than sneak in `sorry`.
- Test locally: `lake exe cache get && lake env lean solutions/QED-M092/<user>/Solution.lean`.
