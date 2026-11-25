# QED-E029 — Oriented chromatic number of planar graphs (18 vs 80)

You are an AI model helping someone attack this open problem. Read all of this before working.

## The problem
Extended set · Grade C · QED Curated · Graph theory

**Plain words:** Orient every edge of a planar graph. An oriented colouring colours vertices so adjacent vertices differ and all arcs between two colour classes point the same way. Every oriented planar graph can be coloured with 80 colours, and some need 18. The gap has barely moved since 1994: narrow it.

**Math:** Let $\chi_o(\mathcal P)=\max\chi_o(\vec G)$ over orientations of simple planar graphs ($\chi_o$ = least order of a tournament receiving a homomorphism). Known $18\le\chi_o(\mathcal P)\le80$. Formal target: strict improvement of the upper bound, $\chi_o(\mathcal P)\le79$ (the lower-bound direction, an example with $\chi_o\ge19$, is the alternative improvement and is not the formal Claim).

**Reviewer note:** Known: Upper 80: Raspaud-Sopena, Inform. Process. Lett. 51 (1994), via acyclic 5-colourability (Borodin). Lower bound history: 15 (Sopena), 16 and 17 (Marshall), 18 (Marshall, Ars Combin. 2015). Clow, 'MAD phase transitions in the oriented chromatic number', arXiv:2607.22915 (2026), confirms both bounds are still current.

**Credit:** Courcelle; Raspaud-Sopena; Marshall; Sopena surveys.

**Rests on recent unrefereed work. Check these premises first:**
- The precise sharper statement ('improve to 79') is incremental; the real interest is a substantially better bound

**References:**
- https://arxiv.org/abs/2607.22915
- https://arxiv.org/abs/2409.13076
- https://arxiv.org/abs/1411.7192

Difficulty estimate: 4.5/10 (calibrated: Collatz ≈ 5.5, twin primes ≈ 5.0). It is believed open; do not assume a quick answer exists, and say so plainly if you cannot make progress. Never present a heuristic, numerical evidence, or a partial result as a solution.

## What counts as an answer
Either a proof of `OpenProblems.QEDE029.Claim` or a proof of `¬ OpenProblems.QEDE029.Claim` (a disproof), in Lean 4 + Mathlib, using the exact statement in `problems/QED-E029/Statement.lean`. Read its "Formalization notes" first. If that file still says `def Claim : Prop := sorry`, the problem must first be formalized (see CONTRIBUTING.md); a faithful formalization is itself a welcome contribution.

If you think the Lean statement does not match the informal problem (it is trivially true or false, or it says something else), report that in an issue instead of exploiting it: such solutions are not credited.

## How to submit
1. Claim it (optional but encouraged): open an issue titled `Claim QED-E029` at https://github.com/floration/qed/issues/new?template=claim.yml. Comment on it at least once a week or the claim lapses.
2. Add `solutions/QED-E029/<github-username>/Solution.lean`:
```lean
import Mathlib
-- do NOT redefine Claim: CI prepends problems/QED-E029/Statement.lean to your file
theorem solution : OpenProblems.QEDE029.Claim := by   -- or ¬ OpenProblems.QEDE029.Claim
  ...
```
   Large proofs may add more `.lean` files (subfolders allowed) next to Solution.lean; CI concatenates them in path order before Solution.lean. Don't import them.
3. Add `solutions/QED-E029/<github-username>/meta.json`: `{"model": "<AI model used, or none>", "kind": "proof" | "disproof"}`. Optionally a `README.md` explaining the idea.
4. Open a pull request. CI checks: it compiles, no `sorry`/`admit`/new `axiom`/`set_option` tricks, and `#print axioms solution` shows only `propext`, `Classical.choice`, `Quot.sound`.

## Scoring
Size = number of non-blank, non-comment lines of `Solution.lean` excluding `import` lines (helper lemmas count). First verified solution is credited permanently; any later, strictly smaller verified solution becomes the "smallest solution".

## Rules for you, the model
- Do not modify `Statement.lean` in a solution PR.
- Be honest about uncertainty; if a step is unproven, leave it out rather than sneak in `sorry`.
- Test locally: `lake exe cache get && lake env lean solutions/QED-E029/<user>/Solution.lean`.
