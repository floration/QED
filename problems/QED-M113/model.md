# QED-M113 — Big line or six visible points

You are an AI model helping someone attack this open problem. Read all of this before working.

## The problem
Extended set · Grade B · QED Curated · Geometry

**Plain words:** Two points of a finite set in the plane see each other if the segment between them passes through no other point of the set. Prove that for every l there is an N such that any N points in the plane contain either l points on a line or 6 points that all see each other. This is known for 5 points that all see each other (for every l), and since 2026 for 6 such points when l = 4.

**Math:** For finite $P\subset\mathbb R^2$, call $p,q\in P$ visible if $[p,q]\cap P=\{p,q\}$. Claim: for every $\ell\ge 3$ there is $N(\ell)$ such that every $P\subset\mathbb R^2$ with $|P|\ge N(\ell)$ contains $\ell$ collinear points or $6$ pairwise visible points.

**Reviewer note:** Known: Clique <=4, every l: Kara-Por-Wood (Discrete Comput. Geom. 2005). Clique 5, line 4: Addario-Berry et al.; clique 5, every l: Abel, Ballinger, Bose, Collette, Dujmovic, Hurtado, Kominers, Langerman, Por, Wood, Graphs Combin. 27 (2011). Clique 6, line 4: Bonnet arXiv:2608.19468 (N ~ 10^11055931), improved to N<=880 by Cambie arXiv:2609.21035 (v2 Nov 2026). Bhattacharya-Das-Islam-Mohapatra-Sen arXiv:2609.25727: no 4 collinear forces 7 points missing at most one visibility. Structured regimes (points on a cubic, few ordinary lines, irreducible curves): Sarkar arXiv:2605.00918. All other (line, clique) pairs with clique>=6 open, per Bonnet's introduction.

**Credit:** J. Kara, A. Por, D. R. Wood (2005); row clique=6 framed after Abel et al. 2011 and Bonnet/Cambie 2026

**Rests on recent unrefereed work. Check these premises first:**
- very active area in 2026 (four unrefereed preprints); could be resolved soon
- the l=4 results it builds on are unrefereed 2026 preprints, though the Claim itself does not depend on them

**References:**
- https://arxiv.org/abs/2608.19468
- https://arxiv.org/abs/2609.21035
- https://arxiv.org/abs/2609.25727
- https://arxiv.org/abs/2605.00918
- https://wikipedia.com/wiki/Big-line-big-clique_conjecture

Difficulty estimate: 5.0/10 (anchored scale: 1 ≈ Erdős–Ginzburg–Ziv, 2.5 ≈ the sensitivity conjecture, 5 ≈ bounded prime gaps, 7.5 ≈ the Riemann Hypothesis, 10 ≈ P vs NP). It is believed open; do not assume a quick answer exists, and say so plainly if you cannot make progress. Never present a heuristic, numerical evidence, or a partial result as a solution.

## What counts as an answer
Either a proof of `OpenProblems.QEDM113.Claim` or a proof of `¬ OpenProblems.QEDM113.Claim` (a disproof), in Lean 4 + Mathlib, using the exact statement in `problems/QED-M113/Statement.lean`. Read its "Formalization notes" first. If that file still says `def Claim : Prop := sorry`, the problem must first be formalized (see CONTRIBUTING.md); a faithful formalization is itself a welcome contribution.

If you think the Lean statement does not match the informal problem (it is trivially true or false, or it says something else), report that in an issue instead of exploiting it: such solutions are not credited.

## How to submit
0. First time? Solve a test problem (QED-Q1, the 2-line one, at minimum) and submit it, to confirm your Lean setup and the submission pipeline work before spending effort here. Skip this step if this IS a test problem.
1. Claim it (optional but encouraged): open an issue titled `Claim QED-M113` at https://github.com/floration/qed/issues/new?template=claim.yml. Comment on it at least once a week or the claim lapses.
2. Add `solutions/QED-M113/<github-username>/Solution.lean`:
```lean
import Mathlib
-- do NOT redefine Claim: CI prepends problems/QED-M113/Statement.lean to your file
theorem solution : OpenProblems.QEDM113.Claim := by   -- or ¬ OpenProblems.QEDM113.Claim
  ...
```
   Large proofs may add more `.lean` files (subfolders allowed) next to Solution.lean; CI concatenates them in path order before Solution.lean. Don't import them.
3. Add `solutions/QED-M113/<github-username>/meta.json`: `{"model": "<AI model used, or none>", "kind": "proof" | "disproof"}`. Optionally a `README.md` explaining the idea.
4. Open a pull request. CI checks: it compiles, no `sorry`/`admit`/new `axiom`/`set_option` tricks, and `#print axioms solution` shows only `propext`, `Classical.choice`, `Quot.sound`.

## Scoring
Size = number of non-blank, non-comment lines of `Solution.lean` excluding `import` lines (helper lemmas count). First verified solution is credited permanently; any later, strictly smaller verified solution becomes the "smallest solution".

## Rules for you, the model
- Do not modify `Statement.lean` in a solution PR.
- Be honest about uncertainty; if a step is unproven, leave it out rather than sneak in `sorry`.
- Test locally: `lake exe cache get && lake env lean solutions/QED-M113/<user>/Solution.lean`.
