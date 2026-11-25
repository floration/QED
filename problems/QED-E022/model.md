# QED-E022 — Four-colour triangle Ramsey number R(3,3,3,3)

You are an AI model helping someone attack this open problem. Read all of this before working.

## The problem
Extended set · Grade B- · QED Curated · Combinatorics

**Plain words:** Colour every edge of a complete graph with one of four colours. How many vertices force a single-coloured triangle? The answer is known to lie between 51 and 60 (the 60 coming from a 2026 computer-assisted preprint), and is conjectured to be 51. Prove that 51 vertices already force one, or find a four-colouring of 51 vertices with no single-coloured triangle. Further questions (not part of the formal claim): any improvement of the upper bound, e.g. below 60, or a rigorous proof of 60.

**Math:** Let $R_4(3)=R(3,3,3,3)$ be the least $n$ such that every 4-edge-colouring of $K_n$ contains a monochromatic triangle. Known: $51\le R_4(3)\le 62$ (refereed), and $\le 60$ in a 2026 computer-assisted preprint. Claim: every 4-edge-colouring of $K_{51}$ contains a monochromatic triangle, i.e. $R_4(3)\le51$ and hence $R_4(3)=51$ (conjectured). Prove or disprove; a disproof is a 4-colouring of $K_{51}$ with no monochromatic triangle (giving $R_4(3)\ge52$). Further questions (not part of the formal claim): lower the upper bound (below 60, or confirm 60 rigorously).

**Reviewer note:** Known: Lower 51: F. Chung (1973). Upper 62: Fettes-Kramer-Radziszowski, Ars Combin. 72 (2004). Upper 60: M. Tatarevic, arXiv:2610.36648 (2026 preprint). It reduces to 296,081 SAT instances (UNSAT by Kissat and CaDiCaL); the reductions are in Lean/Mathlib, but the SAT exclusions are taken as a premise; extensive AI assistance is disclosed. Boza, arXiv:2603.10851 (2026), improves other multicolour bounds and cites 62 for R_4(3).

**Credit:** Radziszowski survey; Chung (1973); Fettes-Kramer-Radziszowski (2004); Tatarevic (2026 preprint).

**Rests on recent unrefereed work. Check these premises first:**
- The bound 60 is an unrefereed 2026 preprint resting on unverified SAT runs; the safe published bound is 62
- Problem may be stated with whichever upper bound the board accepts

**References:**
- https://arxiv.org/abs/2610.36648
- https://www.cs.rit.edu/~spr/COURSES/CCOMP/r3333.pdf
- https://arxiv.org/abs/2603.10851
- https://arxiv.org/abs/1912.05353

Difficulty estimate: 5.5/10 (anchored scale: 1 ≈ Erdős–Ginzburg–Ziv, 2.5 ≈ the sensitivity conjecture, 5 ≈ bounded prime gaps, 7.5 ≈ the Riemann Hypothesis, 10 ≈ P vs NP). It is believed open; do not assume a quick answer exists, and say so plainly if you cannot make progress. Never present a heuristic, numerical evidence, or a partial result as a solution.

## What counts as an answer
Either a proof of `OpenProblems.QEDE022.Claim` or a proof of `¬ OpenProblems.QEDE022.Claim` (a disproof), in Lean 4 + Mathlib, using the exact statement in `problems/QED-E022/Statement.lean`. Read its "Formalization notes" first. If that file still says `def Claim : Prop := sorry`, the problem must first be formalized (see CONTRIBUTING.md); a faithful formalization is itself a welcome contribution.

If you think the Lean statement does not match the informal problem (it is trivially true or false, or it says something else), report that in an issue instead of exploiting it: such solutions are not credited.

## How to submit
0. First time? Solve a test problem (QED-Q1, the 2-line one, at minimum) and submit it, to confirm your Lean setup and the submission pipeline work before spending effort here. Skip this step if this IS a test problem.
1. Claim it (optional but encouraged): open an issue titled `Claim QED-E022` at https://github.com/floration/qed/issues/new?template=claim.yml. Comment on it at least once a week or the claim lapses.
2. Add `solutions/QED-E022/<github-username>/Solution.lean`:
```lean
import Mathlib
-- do NOT redefine Claim: CI prepends problems/QED-E022/Statement.lean to your file
theorem solution : OpenProblems.QEDE022.Claim := by   -- or ¬ OpenProblems.QEDE022.Claim
  ...
```
   Large proofs may add more `.lean` files (subfolders allowed) next to Solution.lean; CI concatenates them in path order before Solution.lean. Don't import them.
3. Add `solutions/QED-E022/<github-username>/meta.json`: `{"model": "<AI model used, or none>", "kind": "proof" | "disproof"}`. Optionally a `README.md` explaining the idea.
4. Open a pull request. CI checks: it compiles, no `sorry`/`admit`/new `axiom`/`set_option` tricks, and `#print axioms solution` shows only `propext`, `Classical.choice`, `Quot.sound`.

## Scoring
Size = number of non-blank, non-comment lines of `Solution.lean` excluding `import` lines (helper lemmas count). First verified solution is credited permanently; any later, strictly smaller verified solution becomes the "smallest solution".

## Rules for you, the model
- Do not modify `Statement.lean` in a solution PR.
- Be honest about uncertainty; if a step is unproven, leave it out rather than sneak in `sorry`.
- Test locally: `lake exe cache get && lake env lean solutions/QED-E022/<user>/Solution.lean`.
