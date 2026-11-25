# QED-E148 — Largest lattice 4-polytope with one interior lattice point

You are an AI model helping someone attack this open problem. Read all of this before working.

## The problem
Extended set · Grade A · QED Curated · Geometry

**Plain words:** Take a polytope in 4-dimensional space whose corners all have integer coordinates and which contains exactly one integer point in its interior. How large can its volume be? The best known example is the simplex with vertices 0, 2e1, 3e2, 7e3, 84e4, of volume 147, and it is known to be the largest among simplices. Is it the largest among all such polytopes?

**Math:** Let $P=\operatorname{conv}(V)\subset\mathbb{R}^4$ with $V\subset\mathbb{Z}^4$ finite and $|\operatorname{int}(P)\cap\mathbb{Z}^4|=1$. Prove that $\operatorname{vol}_4(P)\le 147=\tfrac{2(s_4-1)^2}{4!}$, where $s_1=2,s_2=3,s_3=7,s_4=43$ are the Sylvester numbers. Equality holds for $\operatorname{conv}(0,2e_1,3e_2,7e_3,84e_4)$. (Here vol is Euclidean volume, so normalized volume is $3528$. The same bound $2(s_d-1)^2/d!$ is conjectured for every $d\ge4$.)

**Credit:** Conjecture 1.7 in Nill's paper on reflexive simplices; proved for simplices and the reflexive case (Balletti–Kasprzyk–Nill, Forum Math. Sigma 2022, arXiv:1611.02455); the extremal simplex is due to Zaks–Perles–Wills.

**Rests on recent unrefereed work. Check these premises first:**
- Extremal simplex is called the Zaks-Perles-Wills simplex (object name, allowed); the conjecture itself is not person-named
- Uniqueness is irrelevant to the bound; in d=3 the bound is attained by more than one polytope, so check claims of uniqueness separately

**References:**
- https://arxiv.org/abs/1611.02455
- https://arxiv.org/abs/1309.7967
- https://arxiv.org/abs/1803.04852
- https://arxiv.org/abs/2308.12719

Difficulty estimate: 4.5/10 (anchored scale: 1 ≈ Erdős–Ginzburg–Ziv, 2.5 ≈ the sensitivity conjecture, 5 ≈ bounded prime gaps, 7.5 ≈ the Riemann Hypothesis, 10 ≈ P vs NP). It is believed open; do not assume a quick answer exists, and say so plainly if you cannot make progress. Never present a heuristic, numerical evidence, or a partial result as a solution.

## What counts as an answer
Either a proof of `OpenProblems.QEDE148.Claim` or a proof of `¬ OpenProblems.QEDE148.Claim` (a disproof), in Lean 4 + Mathlib, using the exact statement in `problems/QED-E148/Statement.lean`. Read its "Formalization notes" first. If that file still says `def Claim : Prop := sorry`, the problem must first be formalized (see CONTRIBUTING.md); a faithful formalization is itself a welcome contribution.

If you think the Lean statement does not match the informal problem (it is trivially true or false, or it says something else), report that in an issue instead of exploiting it: such solutions are not credited.

## How to submit
0. First time? Solve a test problem (QED-Q1, the 2-line one, at minimum) and submit it, to confirm your Lean setup and the submission pipeline work before spending effort here. Skip this step if this IS a test problem.
1. Claim it (optional but encouraged): open an issue titled `Claim QED-E148` at https://github.com/floration/qed/issues/new?template=claim.yml. Comment on it at least once a week or the claim lapses.
2. Add `solutions/QED-E148/<github-username>/Solution.lean`:
```lean
import Mathlib
-- do NOT redefine Claim: CI prepends problems/QED-E148/Statement.lean to your file
theorem solution : OpenProblems.QEDE148.Claim := by   -- or ¬ OpenProblems.QEDE148.Claim
  ...
```
   Large proofs may add more `.lean` files (subfolders allowed) next to Solution.lean; CI concatenates them in path order before Solution.lean. Don't import them.
3. Add `solutions/QED-E148/<github-username>/meta.json`: `{"model": "<AI model used, or none>", "kind": "proof" | "disproof"}`. Optionally a `README.md` explaining the idea.
4. Open a pull request. CI checks: it compiles, no `sorry`/`admit`/new `axiom`/`set_option` tricks, and `#print axioms solution` shows only `propext`, `Classical.choice`, `Quot.sound`.

## Scoring
Size = number of non-blank, non-comment lines of `Solution.lean` excluding `import` lines (helper lemmas count). First verified solution is credited permanently; any later, strictly smaller verified solution becomes the "smallest solution".

## Rules for you, the model
- Do not modify `Statement.lean` in a solution PR.
- Be honest about uncertainty; if a step is unproven, leave it out rather than sneak in `sorry`.
- Test locally: `lake exe cache get && lake env lean solutions/QED-E148/<user>/Solution.lean`.
