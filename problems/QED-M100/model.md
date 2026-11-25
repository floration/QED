# QED-M100 — Alternating quotients of knot groups

You are an AI model helping someone attack this open problem. Read all of this before working.

## The problem
Main set · Grade A · QED Extension · Topology

**Plain words:** The trefoil's group maps onto every alternating group A_n with n>=9, because modulo its centre it is the modular group. Show that every nontrivial knot group maps onto A_n for all large enough n. Further questions (not part of the formal claim): bound the last exception in terms of the knot; or, weaker, show it for infinitely many n.

**Math:** Let $K\subset S^3$ be a nontrivial (tame) knot and $G_K=\pi_1(S^3\setminus K)$. Claim: for every nontrivial $K$ there is $N(K)$ such that $G_K$ surjects onto $A_n$ for all $n\ge N(K)$. Prove or disprove (a disproof is a nontrivial knot whose group fails to surject onto $A_n$ for infinitely many $n$). Data (exhaustive search over pairs of conjugate even permutations, meridians $x,y$ with $wx=yw$): for the trefoil ($w=xy$) a surjection exists exactly for $n=5$ and $n\ge9$, since every surjection kills the centre and factors through $\mathrm{PSL}_2(\mathbb Z)\cong C_2*C_3$, and Miller proved $(2,3)$-generation of $A_n$ for $n\ne3,6,7,8$. For the figure-eight knot ($w=x^{-1}yxy^{-1}$) a surjection exists for $n=6,9,10$ and not for $n=5,7,8$. Further questions (not part of the formal claim): bound $N(K)$ in terms of the crossing number; weaker, prove that $G_K$ surjects onto $A_n$ for infinitely many $n$, or even for one $n\ge5$; is $N(4_1)=9$, i.e. does $G_{4_1}$ surject onto $A_n$ for every $n\ge9$? Board target (the Lean Claim): existence of $N(K)$ for every nontrivial polygonal knot; no bound on $N(K)$ in terms of crossing number is asked.

**Credit:** Dunfield-Thurston, Finite covers of random 3-manifolds, Invent. Math. 2006 (arXiv:math/0502567), question on alternating quotients; Everitt / Liebeck-Shalev for Fuchsian groups

**QED results so far (reviewer-derived; check before relying on them):** Computer-verified in a fresh script: trefoil (xyx=yxy) surjects onto A5 but not A6 or A7. Figure-eight (w=x^-1yxy^-1) surjects onto A4 and A6 but not A5, A7 or A8, and has no S3 quotient, as det=5 requires. n>=9 not rerun (would take more than 30s). The trefoil argument (centre maps trivially, factor through C2*C3, Miller's (2,3)-generation) is correct.

**References:**
- https://arxiv.org/pdf/math/0502567
- https://arxiv.org/pdf/1010.2726
- https://arxiv.org/abs/math/9907148v1
- https://www.ams.org/proc/1980-078-01/S0002-9939-1980-0548101-9/
- https://arxiv.org/pdf/math/0502567
- https://arxiv.org/pdf/1010.2726
- https://arxiv.org/abs/2203.01140
- https://arxiv.org/abs/1505.06364
- https://doi.org/10.1017/S0305004119000173

Difficulty estimate: 4.0/10 (anchored scale: 1 ≈ Erdős–Ginzburg–Ziv, 2.5 ≈ the sensitivity conjecture, 5 ≈ bounded prime gaps, 7.5 ≈ the Riemann Hypothesis, 10 ≈ P vs NP). It is believed open; do not assume a quick answer exists, and say so plainly if you cannot make progress. Never present a heuristic, numerical evidence, or a partial result as a solution.

## What counts as an answer
Either a proof of `OpenProblems.QEDM100.Claim` or a proof of `¬ OpenProblems.QEDM100.Claim` (a disproof), in Lean 4 + Mathlib, using the exact statement in `problems/QED-M100/Statement.lean`. Read its "Formalization notes" first. If that file still says `def Claim : Prop := sorry`, the problem must first be formalized (see CONTRIBUTING.md); a faithful formalization is itself a welcome contribution.

If you think the Lean statement does not match the informal problem (it is trivially true or false, or it says something else), report that in an issue instead of exploiting it: such solutions are not credited.

## How to submit
0. First time? Solve a test problem (QED-Q1, the 2-line one, at minimum) and submit it, to confirm your Lean setup and the submission pipeline work before spending effort here. Skip this step if this IS a test problem.
1. Claim it (optional but encouraged): open an issue titled `Claim QED-M100` at https://github.com/floration/qed/issues/new?template=claim.yml. Comment on it at least once a week or the claim lapses.
2. Add `solutions/QED-M100/<github-username>/Solution.lean`:
```lean
import Mathlib
-- do NOT redefine Claim: CI prepends problems/QED-M100/Statement.lean to your file
theorem solution : OpenProblems.QEDM100.Claim := by   -- or ¬ OpenProblems.QEDM100.Claim
  ...
```
   Large proofs may add more `.lean` files (subfolders allowed) next to Solution.lean; CI concatenates them in path order before Solution.lean. Don't import them.
3. Add `solutions/QED-M100/<github-username>/meta.json`: `{"model": "<AI model used, or none>", "kind": "proof" | "disproof"}`. Optionally a `README.md` explaining the idea.
4. Open a pull request. CI checks: it compiles, no `sorry`/`admit`/new `axiom`/`set_option` tricks, and `#print axioms solution` shows only `propext`, `Classical.choice`, `Quot.sound`.

## Scoring
Size = number of non-blank, non-comment lines of `Solution.lean` excluding `import` lines (helper lemmas count). First verified solution is credited permanently; any later, strictly smaller verified solution becomes the "smallest solution".

## Rules for you, the model
- Do not modify `Statement.lean` in a solution PR.
- Be honest about uncertainty; if a step is unproven, leave it out rather than sneak in `sorry`.
- Test locally: `lake exe cache get && lake env lean solutions/QED-M100/<user>/Solution.lean`.
