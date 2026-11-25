# QED-E126 — A regular language of generalized star height two

You are an AI model helping someone attack this open problem. Read all of this before working.

## The problem
Extended set · Grade A · QED Curated · Logic & computability

**Plain words:** Regular expressions built from letters using union, concatenation, complement and Kleene star describe exactly the regular languages. The generalized star height of a language is the smallest nesting depth of stars any such expression needs. Languages that need zero stars (the star-free ones) and languages that need one star (like (aa)*) are known, but nobody knows whether any regular language needs two. Decide whether every regular language has generalized star height at most one.

**Math:** Generalized regular expressions over a finite alphabet $\Sigma$ are built from $\emptyset,\{\varepsilon\},a\ (a\in\Sigma)$ by $E\cup F$, $EF$, $\Sigma^*\setminus E$ and $E^*$, with height $h(E^*)=1+h(E)$, $h$ of atoms $=0$, and $h$ of the other operations the maximum of the arguments' heights. For regular $L\subseteq\Sigma^*$ let $h_\Sigma(L)=\min\{h(E):\mathcal L(E)=L\}$. Decide whether there exist a finite $\Sigma$ and a regular $L\subseteq\Sigma^*$ with $h_\Sigma(L)\ge2$; equivalently, whether $h_\Sigma(L)\le1$ for every regular $L$. Either answer solves the problem.

**Reviewer note:** Context (AI-lab announcement, treated as correct): OpenAI 134: Generalized star height at most three. Every regular language has generalized star height <=3, so the uniform-boundedness question is settled. The board question (does any L have height >=2, i.e. is the maximum 1 or in {2,3}) is still open. Update the known-bounds context.

**Credit:** Classical problem (Eggan 1963 for ordinary star height; generalized version promoted by Brzozowski, Pin, Straubing, Thérien).

**Rests on recent unrefereed work. Check these premises first:**
- The OpenAI <=3 bounds (Sept 2026) are unrefereed; they are context, not premises.
- The statement is well known (low novelty) but not on the board.

**References:**
- https://en.wikipedia.org/wiki/Generalized_star-height_problem
- https://www.irif.fr/~jep/Problemes/starheight.html
- https://arxiv.org/pdf/1603.06236
- https://www.irif.fr/~jep/PDF/StarHeight.pdf

Difficulty estimate: 8.5/10 (anchored scale: 1 ≈ Erdős–Ginzburg–Ziv, 2.5 ≈ the sensitivity conjecture, 5 ≈ bounded prime gaps, 7.5 ≈ the Riemann Hypothesis, 10 ≈ P vs NP). It is believed open; do not assume a quick answer exists, and say so plainly if you cannot make progress. Never present a heuristic, numerical evidence, or a partial result as a solution.

## What counts as an answer
Either a proof of `OpenProblems.QEDE126.Claim` or a proof of `¬ OpenProblems.QEDE126.Claim` (a disproof), in Lean 4 + Mathlib, using the exact statement in `problems/QED-E126/Statement.lean`. Read its "Formalization notes" first. If that file still says `def Claim : Prop := sorry`, the problem must first be formalized (see CONTRIBUTING.md); a faithful formalization is itself a welcome contribution.

If you think the Lean statement does not match the informal problem (it is trivially true or false, or it says something else), report that in an issue instead of exploiting it: such solutions are not credited.

## How to submit
0. First time? Solve a test problem (QED-Q1, the 2-line one, at minimum) and submit it, to confirm your Lean setup and the submission pipeline work before spending effort here. Skip this step if this IS a test problem.
1. Claim it (optional but encouraged): open an issue titled `Claim QED-E126` at https://github.com/floration/qed/issues/new?template=claim.yml. Comment on it at least once a week or the claim lapses.
2. Add `solutions/QED-E126/<github-username>/Solution.lean`:
```lean
import Mathlib
-- do NOT redefine Claim: CI prepends problems/QED-E126/Statement.lean to your file
theorem solution : OpenProblems.QEDE126.Claim := by   -- or ¬ OpenProblems.QEDE126.Claim
  ...
```
   Large proofs may add more `.lean` files (subfolders allowed) next to Solution.lean; CI concatenates them in path order before Solution.lean. Don't import them.
3. Add `solutions/QED-E126/<github-username>/meta.json`: `{"model": "<AI model used, or none>", "kind": "proof" | "disproof"}`. Optionally a `README.md` explaining the idea.
4. Open a pull request. CI checks: it compiles, no `sorry`/`admit`/new `axiom`/`set_option` tricks, and `#print axioms solution` shows only `propext`, `Classical.choice`, `Quot.sound`.

## Scoring
Size = number of non-blank, non-comment lines of `Solution.lean` excluding `import` lines (helper lemmas count). First verified solution is credited permanently; any later, strictly smaller verified solution becomes the "smallest solution".

## Rules for you, the model
- Do not modify `Statement.lean` in a solution PR.
- Be honest about uncertainty; if a step is unproven, leave it out rather than sneak in `sorry`.
- Test locally: `lake exe cache get && lake env lean solutions/QED-E126/<user>/Solution.lean`.
