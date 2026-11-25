# QED-E163 — Planar graphs with no cycles of length 4, 5 or 6: always 3-colourable?

You are an AI model helping someone attack this open problem. Read all of this before working.

## The problem
Extended set · Grade A · QED Curated · Graph theory

**Plain words:** Forbidding short cycles makes planar graphs easier to colour. Planar graphs with no cycles of length 4, 5, 6 or 7 can always be properly 3-coloured, while forbidding only lengths 4 and 5 is not enough (2017 counterexample). Decide the remaining case: is every planar graph with no cycle of length 4, 5 or 6 3-colourable?

**Math:** Let $G$ be a finite simple planar graph with no cycle of length $4$, $5$ or $6$ (triangles and cycles of length $\ge7$ allowed). Must $\chi(G)\le3$? Equivalently, determine $k^*=\min\{k:$ every planar graph with no cycle of length in $\{4,\dots,k\}$ is 3-colourable$\}$, known to satisfy $k^*\in\{6,7\}$.

**Credit:** Question of Erdős (relaxation of Steinberg's problem); listed as open by Dvořák et al., arXiv:2203.08136; partial results Borodin et al. 2005, Liang-Liao-Bai 2026.

**Rests on recent unrefereed work. Check these premises first:**
- Some may view it as the 'Erdős relaxation of Steinberg's conjecture', i.e. attached to person-named problems, though the specific k=6 question is unnamed
- Mathlib has no planarity; formalization needs a combinatorial planarity definition (e.g. via Wagner/Kuratowski minors or rotation systems)

**References:**
- https://arxiv.org/abs/2203.08136
- https://www.sciopen.com/article/10.3934/math.2026530
- https://arxiv.org/abs/1604.05108
- https://arxiv.org/abs/2412.19059
- https://arxiv.org/abs/1506.04629

Difficulty estimate: 5.5/10 (anchored scale: 1 ≈ Erdős–Ginzburg–Ziv, 2.5 ≈ the sensitivity conjecture, 5 ≈ bounded prime gaps, 7.5 ≈ the Riemann Hypothesis, 10 ≈ P vs NP). It is believed open; do not assume a quick answer exists, and say so plainly if you cannot make progress. Never present a heuristic, numerical evidence, or a partial result as a solution.

## What counts as an answer
Either a proof of `OpenProblems.QEDE163.Claim` or a proof of `¬ OpenProblems.QEDE163.Claim` (a disproof), in Lean 4 + Mathlib, using the exact statement in `problems/QED-E163/Statement.lean`. Read its "Formalization notes" first. If that file still says `def Claim : Prop := sorry`, the problem must first be formalized (see CONTRIBUTING.md); a faithful formalization is itself a welcome contribution.

If you think the Lean statement does not match the informal problem (it is trivially true or false, or it says something else), report that in an issue instead of exploiting it: such solutions are not credited.

## How to submit
0. First time? Solve a test problem (QED-Q1, the 2-line one, at minimum) and submit it, to confirm your Lean setup and the submission pipeline work before spending effort here. Skip this step if this IS a test problem.
1. Claim it (optional but encouraged): open an issue titled `Claim QED-E163` at https://github.com/floration/qed/issues/new?template=claim.yml. Comment on it at least once a week or the claim lapses.
2. Add `solutions/QED-E163/<github-username>/Solution.lean`:
```lean
import Mathlib
-- do NOT redefine Claim: CI prepends problems/QED-E163/Statement.lean to your file
theorem solution : OpenProblems.QEDE163.Claim := by   -- or ¬ OpenProblems.QEDE163.Claim
  ...
```
   Large proofs may add more `.lean` files (subfolders allowed) next to Solution.lean; CI concatenates them in path order before Solution.lean. Don't import them.
3. Add `solutions/QED-E163/<github-username>/meta.json`: `{"model": "<AI model used, or none>", "kind": "proof" | "disproof"}`. Optionally a `README.md` explaining the idea.
4. Open a pull request. CI checks: it compiles, no `sorry`/`admit`/new `axiom`/`set_option` tricks, and `#print axioms solution` shows only `propext`, `Classical.choice`, `Quot.sound`.

## Scoring
Size = number of non-blank, non-comment lines of `Solution.lean` excluding `import` lines (helper lemmas count). First verified solution is credited permanently; any later, strictly smaller verified solution becomes the "smallest solution".

## Rules for you, the model
- Do not modify `Statement.lean` in a solution PR.
- Be honest about uncertainty; if a step is unproven, leave it out rather than sneak in `sorry`.
- Test locally: `lake exe cache get && lake env lean solutions/QED-E163/<user>/Solution.lean`.
