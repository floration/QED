# QED-E164 — Smallest triangle-free 6-chromatic graph: is 40 vertices optimal?

You are an AI model helping someone attack this open problem. Read all of this before working.

## The problem
Extended set · Grade B · QED Curated · Graph theory

**Plain words:** Triangle-free graphs can need arbitrarily many colours, but they must be large. The smallest triangle-free graph needing 4 colours has 11 vertices (the Grötzsch graph), and the smallest needing 5 colours has 22 vertices. For 6 colours, the smallest such graph is known to have between 32 and 40 vertices. Either find a triangle-free graph on at most 39 vertices that cannot be properly coloured with 5 colours, or prove that every triangle-free graph on 39 vertices is 5-colourable.

**Math:** Let $n(k)$ be the minimum order of a triangle-free graph $G$ with $\chi(G)=k$. Known: $n(4)=11$, $n(5)=22$, $32\le n(6)\le 40$. Decide whether $n(6)=40$, i.e. whether every triangle-free graph on $39$ vertices satisfies $\chi(G)\le 5$.

**Credit:** Problem of determining n(k): Jensen-Toft 'Graph Coloring Problems'; bounds J. Goedgebeur (JGT 2020); n(5)=22 Jensen-Royle (1995).

**Rests on recent unrefereed work. Check these premises first:**
- Largely computational (rule 5); accepted only because it is a recognised open problem with refereed bounds
- The 40-vertex upper-bound graph should be double-checked as coming from the JGT paper (abstract states the 40 bound)
- Thematically adjacent to board item QED-E056 (minimum-order k-chromatic graphs of girth >= g), but asks for a specific value n(6), not the girth question

**References:**
- https://arxiv.org/abs/1707.07581
- https://arxiv.org/pdf/1805.06713
- https://arxiv.org/pdf/2501.17201

Difficulty estimate: 4.5/10 (anchored scale: 1 ≈ Erdős–Ginzburg–Ziv, 2.5 ≈ the sensitivity conjecture, 5 ≈ bounded prime gaps, 7.5 ≈ the Riemann Hypothesis, 10 ≈ P vs NP). It is believed open; do not assume a quick answer exists, and say so plainly if you cannot make progress. Never present a heuristic, numerical evidence, or a partial result as a solution.

## What counts as an answer
Either a proof of `OpenProblems.QEDE164.Claim` or a proof of `¬ OpenProblems.QEDE164.Claim` (a disproof), in Lean 4 + Mathlib, using the exact statement in `problems/QED-E164/Statement.lean`. Read its "Formalization notes" first. If that file still says `def Claim : Prop := sorry`, the problem must first be formalized (see CONTRIBUTING.md); a faithful formalization is itself a welcome contribution.

If you think the Lean statement does not match the informal problem (it is trivially true or false, or it says something else), report that in an issue instead of exploiting it: such solutions are not credited.

## How to submit
0. First time? Solve a test problem (QED-Q1, the 2-line one, at minimum) and submit it, to confirm your Lean setup and the submission pipeline work before spending effort here. Skip this step if this IS a test problem.
1. Claim it (optional but encouraged): open an issue titled `Claim QED-E164` at https://github.com/floration/qed/issues/new?template=claim.yml. Comment on it at least once a week or the claim lapses.
2. Add `solutions/QED-E164/<github-username>/Solution.lean`:
```lean
import Mathlib
-- do NOT redefine Claim: CI prepends problems/QED-E164/Statement.lean to your file
theorem solution : OpenProblems.QEDE164.Claim := by   -- or ¬ OpenProblems.QEDE164.Claim
  ...
```
   Large proofs may add more `.lean` files (subfolders allowed) next to Solution.lean; CI concatenates them in path order before Solution.lean. Don't import them.
3. Add `solutions/QED-E164/<github-username>/meta.json`: `{"model": "<AI model used, or none>", "kind": "proof" | "disproof"}`. Optionally a `README.md` explaining the idea.
4. Open a pull request. CI checks: it compiles, no `sorry`/`admit`/new `axiom`/`set_option` tricks, and `#print axioms solution` shows only `propext`, `Classical.choice`, `Quot.sound`.

## Scoring
Size = number of non-blank, non-comment lines of `Solution.lean` excluding `import` lines (helper lemmas count). First verified solution is credited permanently; any later, strictly smaller verified solution becomes the "smallest solution".

## Rules for you, the model
- Do not modify `Statement.lean` in a solution PR.
- Be honest about uncertainty; if a step is unproven, leave it out rather than sneak in `sorry`.
- Test locally: `lake exe cache get && lake env lean solutions/QED-E164/<user>/Solution.lean`.
