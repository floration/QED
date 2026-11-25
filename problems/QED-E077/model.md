# QED-E077 — Critical linear firefighter rate on Z^3

You are an AI model helping someone attack this open problem. Read all of this before working.

## The problem
Extended set · Grade B · QED Extension · Combinatorics

**Plain words:** On the 3D grid, a finite fire spreads to all unprotected neighbours each step, and at step t you may protect about ct new vertices. It is known that linear growth is the right order. Elementary arguments show that rate c>8 always contains the fire and that c<32/27 does not. Narrow this gap, or find the exact critical rate.

**Math:** Let c* = inf{c : for every finite initial fire B_0 ⊂ Z^3 there is a protection schedule with at most ⌊ct⌋ newly protected vertices at step t that keeps the total burnt set finite}. Elementary: the growth recursion |B_{t+1}| ≥ |B_t| + |∂B_t| − c(t+1)(t+2)/2 with the Wang–Wang vertex-isoperimetric inequality in Z^3 gives c* ≥ 32/27; numerics suggest a static wall gives c* ≲ 6.4. Target: prove c* > 32/27, i.e. some rate c > 32/27 fails to contain some finite outbreak.

**Credit:** Extension of Develin-Hartke (arXiv:math/0409195) and Dyer-Martinez-Pedroza-Thorne (arXiv:1507.03050, Cor. 4); o(t) failure from arXiv:2002.11205.

**QED results so far (reviewer-derived; check before relying on them):** c* >= 8/243 (~0.033), elementary: Loomis-Whitney gives |vertex boundary of B| >= |B|^{2/3}; for c<2a^2-6a^3 with a=2/9, a large initial cube burns forever by induction b_t >= (a(t+T0))^3. Using the asymptotically sharp Wang-Wang vertex isoperimetry (l1-balls, constant 4(3/4)^{2/3}) the same argument heuristically gives ~32/27, not checked rigorously c* <= 8, elementary: protect the l1-sphere |x|_1=D (4D^2+2 vertices) before step D-R; c>8 suffices for large D.

**References:**
- https://arxiv.org/abs/math/0409195
- https://arxiv.org/abs/1507.03050
- https://arxiv.org/abs/2002.11205
- https://arxiv.org/pdf/2307.10081

Difficulty estimate: 2.5/10 (calibrated: Collatz ≈ 5.5, twin primes ≈ 5.0). It is believed open; do not assume a quick answer exists, and say so plainly if you cannot make progress. Never present a heuristic, numerical evidence, or a partial result as a solution.

## What counts as an answer
Either a proof of `OpenProblems.QEDE077.Claim` or a proof of `¬ OpenProblems.QEDE077.Claim` (a disproof), in Lean 4 + Mathlib, using the exact statement in `problems/QED-E077/Statement.lean`. Read its "Formalization notes" first. If that file still says `def Claim : Prop := sorry`, the problem must first be formalized (see CONTRIBUTING.md); a faithful formalization is itself a welcome contribution.

If you think the Lean statement does not match the informal problem (it is trivially true or false, or it says something else), report that in an issue instead of exploiting it: such solutions are not credited.

## How to submit
1. Claim it (optional but encouraged): open an issue titled `Claim QED-E077` at https://github.com/floration/qed/issues/new?template=claim.yml. Comment on it at least once a week or the claim lapses.
2. Add `solutions/QED-E077/<github-username>/Solution.lean`:
```lean
import Mathlib
-- do NOT redefine Claim: CI prepends problems/QED-E077/Statement.lean to your file
theorem solution : OpenProblems.QEDE077.Claim := by   -- or ¬ OpenProblems.QEDE077.Claim
  ...
```
3. Add `solutions/QED-E077/<github-username>/meta.json`: `{"model": "<AI model used, or none>", "kind": "proof" | "disproof"}`. Optionally a `README.md` explaining the idea.
4. Open a pull request. CI checks: it compiles, no `sorry`/`admit`/new `axiom`/`set_option` tricks, and `#print axioms solution` shows only `propext`, `Classical.choice`, `Quot.sound`.

## Scoring
Size = number of non-blank, non-comment lines of `Solution.lean` excluding `import` lines (helper lemmas count). First verified solution is credited permanently; any later, strictly smaller verified solution becomes the "smallest solution".

## Rules for you, the model
- Do not modify `Statement.lean` in a solution PR.
- Be honest about uncertainty; if a step is unproven, leave it out rather than sneak in `sorry`.
- Test locally: `lake exe cache get && lake env lean solutions/QED-E077/<user>/Solution.lean`.
