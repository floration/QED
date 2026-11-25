# QED-E150 — Beat n^2 empty triangles

You are an AI model helping someone attack this open problem. Read all of this before working.

## The problem
Extended set · Grade B · QED Curated · Geometry

**Plain words:** Scatter n points in the plane with no three on a line. A triangle with corners among the points is empty if no other point is inside it. Every such configuration has at least about n^2 empty triangles, and the best constructions have about 1.62 n^2. Show that every configuration actually has at least (1+c) n^2 empty triangles for some fixed c > 0.

**Math:** For a finite $S\subset\mathbb{R}^2$ with no three points collinear, let $e(S)$ be the number of 3-subsets $T\subseteq S$ with $\operatorname{conv}(T)\cap S=T$. Let $h_3(n)=\min_{|S|=n}e(S)$. Prove that there is $c>0$ with $h_3(n)\ge(1+c)\,n^2$ for all sufficiently large $n$. (Known: $n^2-\tfrac{32}{7}n+\tfrac{22}{7}\le h_3(n)\le(1.6195\ldots+o(1))\,n^2$.)

**Credit:** Problem of determining h_3(n) asymptotically (Barany, Valtr and others); bounds by Katchalski-Meir, Dumitrescu, Garcia, Aichholzer et al., Barany-Valtr

**Rests on recent unrefereed work. Check these premises first:**
- An unpublished or less visible improvement of the n^2 lower bound may exist (searches found none)
- Lower bound attributions (Dumitrescu 2000, Garcia 2012) recalled from secondary sources; the 2014 bound is confirmed

**References:**
- https://kam.mff.cuni.cz/kamserie/clanky/2004/s674.pdf
- https://publications.ist.tugraz.at/abstracts/afhhpv-lbnsc-14/index.html
- https://arxiv.org/html/2111.12533
- https://link.springer.com/article/10.1007/s10474-024-01431-0

Difficulty estimate: 5.0/10 (anchored scale: 1 ≈ Erdős–Ginzburg–Ziv, 2.5 ≈ the sensitivity conjecture, 5 ≈ bounded prime gaps, 7.5 ≈ the Riemann Hypothesis, 10 ≈ P vs NP). It is believed open; do not assume a quick answer exists, and say so plainly if you cannot make progress. Never present a heuristic, numerical evidence, or a partial result as a solution.

## What counts as an answer
Either a proof of `OpenProblems.QEDE150.Claim` or a proof of `¬ OpenProblems.QEDE150.Claim` (a disproof), in Lean 4 + Mathlib, using the exact statement in `problems/QED-E150/Statement.lean`. Read its "Formalization notes" first. If that file still says `def Claim : Prop := sorry`, the problem must first be formalized (see CONTRIBUTING.md); a faithful formalization is itself a welcome contribution.

If you think the Lean statement does not match the informal problem (it is trivially true or false, or it says something else), report that in an issue instead of exploiting it: such solutions are not credited.

## How to submit
0. First time? Solve a test problem (QED-Q1, the 2-line one, at minimum) and submit it, to confirm your Lean setup and the submission pipeline work before spending effort here. Skip this step if this IS a test problem.
1. Claim it (optional but encouraged): open an issue titled `Claim QED-E150` at https://github.com/floration/qed/issues/new?template=claim.yml. Comment on it at least once a week or the claim lapses.
2. Add `solutions/QED-E150/<github-username>/Solution.lean`:
```lean
import Mathlib
-- do NOT redefine Claim: CI prepends problems/QED-E150/Statement.lean to your file
theorem solution : OpenProblems.QEDE150.Claim := by   -- or ¬ OpenProblems.QEDE150.Claim
  ...
```
   Large proofs may add more `.lean` files (subfolders allowed) next to Solution.lean; CI concatenates them in path order before Solution.lean. Don't import them.
3. Add `solutions/QED-E150/<github-username>/meta.json`: `{"model": "<AI model used, or none>", "kind": "proof" | "disproof"}`. Optionally a `README.md` explaining the idea.
4. Open a pull request. CI checks: it compiles, no `sorry`/`admit`/new `axiom`/`set_option` tricks, and `#print axioms solution` shows only `propext`, `Classical.choice`, `Quot.sound`.

## Scoring
Size = number of non-blank, non-comment lines of `Solution.lean` excluding `import` lines (helper lemmas count). First verified solution is credited permanently; any later, strictly smaller verified solution becomes the "smallest solution".

## Rules for you, the model
- Do not modify `Statement.lean` in a solution PR.
- Be honest about uncertainty; if a step is unproven, leave it out rather than sneak in `sorry`.
- Test locally: `lake exe cache get && lake env lean solutions/QED-E150/<user>/Solution.lean`.
