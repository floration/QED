# QED-E043 — Kissing number in five dimensions: at most 43

You are an AI model helping someone attack this open problem. Read all of this before working.

## The problem
Extended set · Grade B- · QED Curated · Geometry

**Plain words:** How many unit balls can touch a central unit ball in 5-dimensional space without overlapping? A configuration with 40 has been known since 1873, and the best proved upper limit, from large semidefinite computations, is 44 (the computed bound is about 44.998). Prove that 44 is impossible.

**Math:** Let $\tau_5$ be the maximum size of a set $X\subset S^4$ with $\langle x,y\rangle\le 1/2$ for all distinct $x,y\in X$. Known $40\le\tau_5\le44$. Prove $\tau_5\le 43$.

**Reviewer note:** Known: Lower 40: $D_5$ root system (Korkine–Zolotareff 1873); non-isometric 40-configurations by Leech (1967) and Cohn–Rajagopal (arXiv:2412.00937). Upper: Coxeter 48; Odlyzko–Sloane 46.345 (1979); 45 Bachoc–Vallentin (2008); 44 Mittelmann & Vallentin, Experiment. Math. 19 (2010), arXiv:0902.1105 (SDP value ≈44.998). New SDP upper bounds in dimensions 11–23 (de Laat, Leijenhorst et al.) do not touch $n=5$.

**Credit:** Mittelmann–Vallentin (2010); Bachoc–Vallentin (2008)

**Rests on recent unrefereed work. Check these premises first:**
- a recent k-point SDP computation might already give 43 or lower without wide notice
- the 3-point SDP value is ≈44.998, so 43 needs a genuinely stronger relaxation or structural input

**References:**
- https://teorth.github.io/optimizationproblems/constants/29a.html
- https://arxiv.org/abs/0902.1105
- https://arxiv.org/abs/2412.00937
- https://www.cwi.nl/en/news/new-upper-bounds-for-kissing-in-higher-dimensions/

Difficulty estimate: 6.0/10 (anchored scale: 1 ≈ Erdős–Ginzburg–Ziv, 2.5 ≈ the sensitivity conjecture, 5 ≈ bounded prime gaps, 7.5 ≈ the Riemann Hypothesis, 10 ≈ P vs NP). It is believed open; do not assume a quick answer exists, and say so plainly if you cannot make progress. Never present a heuristic, numerical evidence, or a partial result as a solution.

## What counts as an answer
Either a proof of `OpenProblems.QEDE043.Claim` or a proof of `¬ OpenProblems.QEDE043.Claim` (a disproof), in Lean 4 + Mathlib, using the exact statement in `problems/QED-E043/Statement.lean`. Read its "Formalization notes" first. If that file still says `def Claim : Prop := sorry`, the problem must first be formalized (see CONTRIBUTING.md); a faithful formalization is itself a welcome contribution.

If you think the Lean statement does not match the informal problem (it is trivially true or false, or it says something else), report that in an issue instead of exploiting it: such solutions are not credited.

## How to submit
0. First time? Solve a test problem (QED-Q1, the 2-line one, at minimum) and submit it, to confirm your Lean setup and the submission pipeline work before spending effort here. Skip this step if this IS a test problem.
1. Claim it (optional but encouraged): open an issue titled `Claim QED-E043` at https://github.com/floration/qed/issues/new?template=claim.yml. Comment on it at least once a week or the claim lapses.
2. Add `solutions/QED-E043/<github-username>/Solution.lean`:
```lean
import Mathlib
-- do NOT redefine Claim: CI prepends problems/QED-E043/Statement.lean to your file
theorem solution : OpenProblems.QEDE043.Claim := by   -- or ¬ OpenProblems.QEDE043.Claim
  ...
```
   Large proofs may add more `.lean` files (subfolders allowed) next to Solution.lean; CI concatenates them in path order before Solution.lean. Don't import them.
3. Add `solutions/QED-E043/<github-username>/meta.json`: `{"model": "<AI model used, or none>", "kind": "proof" | "disproof"}`. Optionally a `README.md` explaining the idea.
4. Open a pull request. CI checks: it compiles, no `sorry`/`admit`/new `axiom`/`set_option` tricks, and `#print axioms solution` shows only `propext`, `Classical.choice`, `Quot.sound`.

## Scoring
Size = number of non-blank, non-comment lines of `Solution.lean` excluding `import` lines (helper lemmas count). First verified solution is credited permanently; any later, strictly smaller verified solution becomes the "smallest solution".

## Rules for you, the model
- Do not modify `Statement.lean` in a solution PR.
- Be honest about uncertainty; if a step is unproven, leave it out rather than sneak in `sorry`.
- Test locally: `lake exe cache get && lake env lean solutions/QED-E043/<user>/Solution.lean`.
