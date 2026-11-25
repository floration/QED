# QED-E128 — Only 2^{O(n^2)} triangulated 3-spheres on n vertices?

You are an AI model helping someone attack this open problem. Read all of this before working.

## The problem
Extended set · Grade B · QED Extension · Topology

**Plain words:** Count the triangulations of the 3-dimensional sphere on n labelled vertices. Constructions give at least 2^{cn^2} of them, while the only upper bound, from counting all possible sets of tetrahedra, is 2^{Cn^2 log n}. Decide which is the truth: is the count at most 2^{Cn^2}, or does the log n factor really occur?

**Math:** Let $s(n)$ be the number of simplicial complexes $K$ on vertex set $[n]$ (every vertex used) with $|K|\cong S^3$. Known: $2^{\Omega(n^2)}\le s(n)\le 2^{O(n^2\log n)}$. Decide whether $\log_2 s(n)=O(n^2)$ (i.e. $\exists C\ \forall n:\ s(n)\le 2^{Cn^2}$) or $\log_2 s(n)/n^2\to\infty$ along some subsequence.

**Credit:** Gap stated by Kalai (1988), Pfeifle–Ziegler (2004), Nevo–Wilson (2013), Nevo–Santos–Wilson (2016).

**Rests on recent unrefereed work. Check these premises first:**
- Closing this specific log factor is a natural open gap but not singled out as a numbered open problem in the sources; Nevo–Santos–Wilson call their lower bound 'close to' the upper bound.
- Durhuus–Pavelka (Nov 2026) is unrefereed; used only for context on the facet version.

**References:**
- https://arxiv.org/abs/1311.1641
- https://arxiv.org/abs/1408.3501
- https://arxiv.org/abs/math/0212004
- https://arxiv.org/abs/2611.16518
- https://arxiv.org/pdf/2104.04476

Difficulty estimate: 6.5/10 (anchored scale: 1 ≈ Erdős–Ginzburg–Ziv, 2.5 ≈ the sensitivity conjecture, 5 ≈ bounded prime gaps, 7.5 ≈ the Riemann Hypothesis, 10 ≈ P vs NP). It is believed open; do not assume a quick answer exists, and say so plainly if you cannot make progress. Never present a heuristic, numerical evidence, or a partial result as a solution.

## What counts as an answer
Either a proof of `OpenProblems.QEDE128.Claim` or a proof of `¬ OpenProblems.QEDE128.Claim` (a disproof), in Lean 4 + Mathlib, using the exact statement in `problems/QED-E128/Statement.lean`. Read its "Formalization notes" first. If that file still says `def Claim : Prop := sorry`, the problem must first be formalized (see CONTRIBUTING.md); a faithful formalization is itself a welcome contribution.

If you think the Lean statement does not match the informal problem (it is trivially true or false, or it says something else), report that in an issue instead of exploiting it: such solutions are not credited.

## How to submit
0. First time? Solve a test problem (QED-Q1, the 2-line one, at minimum) and submit it, to confirm your Lean setup and the submission pipeline work before spending effort here. Skip this step if this IS a test problem.
1. Claim it (optional but encouraged): open an issue titled `Claim QED-E128` at https://github.com/floration/qed/issues/new?template=claim.yml. Comment on it at least once a week or the claim lapses.
2. Add `solutions/QED-E128/<github-username>/Solution.lean`:
```lean
import Mathlib
-- do NOT redefine Claim: CI prepends problems/QED-E128/Statement.lean to your file
theorem solution : OpenProblems.QEDE128.Claim := by   -- or ¬ OpenProblems.QEDE128.Claim
  ...
```
   Large proofs may add more `.lean` files (subfolders allowed) next to Solution.lean; CI concatenates them in path order before Solution.lean. Don't import them.
3. Add `solutions/QED-E128/<github-username>/meta.json`: `{"model": "<AI model used, or none>", "kind": "proof" | "disproof"}`. Optionally a `README.md` explaining the idea.
4. Open a pull request. CI checks: it compiles, no `sorry`/`admit`/new `axiom`/`set_option` tricks, and `#print axioms solution` shows only `propext`, `Classical.choice`, `Quot.sound`.

## Scoring
Size = number of non-blank, non-comment lines of `Solution.lean` excluding `import` lines (helper lemmas count). First verified solution is credited permanently; any later, strictly smaller verified solution becomes the "smallest solution".

## Rules for you, the model
- Do not modify `Statement.lean` in a solution PR.
- Be honest about uncertainty; if a step is unproven, leave it out rather than sneak in `sorry`.
- Test locally: `lake exe cache get && lake env lean solutions/QED-E128/<user>/Solution.lean`.
