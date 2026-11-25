# QED-M131 — Is the 4-sphere algorithmically recognizable?

You are an AI model helping someone attack this open problem. Read all of this before working.

## The problem
Main set · Grade A · QED Curated · Topology

**Plain words:** A triangulated 4-dimensional shape can be given as a finite list of 5-element vertex sets. Is there an algorithm that decides whether such a list describes the piecewise-linear 4-sphere? The question is solved (yes) in dimension 3 and known to be undecidable in every dimension 5 and above; dimension 4 is the single open case.

**Math:** A bistellar move on a finite pure 4-dimensional simplicial complex $K$ (vertices in $\mathbb N$, given by facets) replaces $A*\partial B$ by $\partial A*B$, where $A\cap B=\emptyset$, $|A\cup B|=6$, $|A|,|B|\ge1$, $A\in K$, $\mathrm{lk}_K(A)=\partial B$ and $B\notin K$ (for $|B|=1$: a fresh vertex). Let $\mathcal S$ be the set of finite complexes isomorphic to one obtained from $\partial\Delta^5$ by finitely many bistellar moves; by Pachner's theorem these are exactly the combinatorial triangulations of the PL 4-sphere. Decide whether $\mathcal S$ is a decidable set. Board claim (either direction accepted): give an algorithm deciding membership in $\mathcal S$, or prove that none exists.

**Credit:** Classical question (Novikov era); current statements in Tancer arXiv:2310.07421 and Friedl–Hirsch–Kegel arXiv:2603.23630.

**Rests on recent unrefereed work. Check these premises first:**
- Equivalence of the bistellar-move definition with PL homeomorphism rests on Pachner's theorem (refereed, 1991); the board statement is self-contained and does not depend on it.
- Must state the move definition carefully (link condition B ∉ K and fresh vertices for the 1→6 move); a sloppy move set could change the set S.
- Friedl–Hirsch–Kegel 2026 is a preprint; openness is also stated in refereed sources (Tancer).

**References:**
- https://arxiv.org/abs/2310.07421
- https://arxiv.org/abs/2603.23630
- https://arxiv.org/abs/1405.3848
- https://en.wikipedia.org/wiki/Simplicial_complex_recognition_problem

Difficulty estimate: 8.5/10 (anchored scale: 1 ≈ Erdős–Ginzburg–Ziv, 2.5 ≈ the sensitivity conjecture, 5 ≈ bounded prime gaps, 7.5 ≈ the Riemann Hypothesis, 10 ≈ P vs NP). It is believed open; do not assume a quick answer exists, and say so plainly if you cannot make progress. Never present a heuristic, numerical evidence, or a partial result as a solution.

## What counts as an answer
Either a proof of `OpenProblems.QEDM131.Claim` or a proof of `¬ OpenProblems.QEDM131.Claim` (a disproof), in Lean 4 + Mathlib, using the exact statement in `problems/QED-M131/Statement.lean`. Read its "Formalization notes" first. If that file still says `def Claim : Prop := sorry`, the problem must first be formalized (see CONTRIBUTING.md); a faithful formalization is itself a welcome contribution.

If you think the Lean statement does not match the informal problem (it is trivially true or false, or it says something else), report that in an issue instead of exploiting it: such solutions are not credited.

## How to submit
0. First time? Solve a test problem (QED-Q1, the 2-line one, at minimum) and submit it, to confirm your Lean setup and the submission pipeline work before spending effort here. Skip this step if this IS a test problem.
1. Claim it (optional but encouraged): open an issue titled `Claim QED-M131` at https://github.com/floration/qed/issues/new?template=claim.yml. Comment on it at least once a week or the claim lapses.
2. Add `solutions/QED-M131/<github-username>/Solution.lean`:
```lean
import Mathlib
-- do NOT redefine Claim: CI prepends problems/QED-M131/Statement.lean to your file
theorem solution : OpenProblems.QEDM131.Claim := by   -- or ¬ OpenProblems.QEDM131.Claim
  ...
```
   Large proofs may add more `.lean` files (subfolders allowed) next to Solution.lean; CI concatenates them in path order before Solution.lean. Don't import them.
3. Add `solutions/QED-M131/<github-username>/meta.json`: `{"model": "<AI model used, or none>", "kind": "proof" | "disproof"}`. Optionally a `README.md` explaining the idea.
4. Open a pull request. CI checks: it compiles, no `sorry`/`admit`/new `axiom`/`set_option` tricks, and `#print axioms solution` shows only `propext`, `Classical.choice`, `Quot.sound`.

## Scoring
Size = number of non-blank, non-comment lines of `Solution.lean` excluding `import` lines (helper lemmas count). First verified solution is credited permanently; any later, strictly smaller verified solution becomes the "smallest solution".

## Rules for you, the model
- Do not modify `Statement.lean` in a solution PR.
- Be honest about uncertainty; if a step is unproven, leave it out rather than sneak in `sorry`.
- Test locally: `lake exe cache get && lake env lean solutions/QED-M131/<user>/Solution.lean`.
