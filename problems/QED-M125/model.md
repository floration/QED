# QED-M125 — A positive fraction of matroids are sparse paving

You are an AI model helping someone attack this open problem. Read all of this before working.

## The problem
Main set · Grade A · QED Extension · Combinatorics

**Plain words:** A matroid of rank r is sparse paving if its non-bases are r-sets, no two of which share r−1 elements; equivalently, all circuits have size r or r+1, and so do all circuits of its dual. These are the 'generic' matroids, and it is believed that almost all matroids on n labelled elements are of this kind. Even the much weaker statement is open: show that a fixed positive fraction of all matroids on n elements are sparse paving, for all large n.

**Math:** Let $m_n$ be the number of matroids on the ground set $[n]$ and $s_n$ the number of sparse paving matroids on $[n]$ (rank $r$ matroids whose set $\mathcal N$ of non-bases is a family of $r$-subsets with $|X\triangle Y|\ge 4$ for distinct $X,Y\in\mathcal N$). Claim: $\liminf_{n\to\infty} s_n/m_n>0$.

**Credit:** Weakening of the conjecture of D. Mayhew, M. Newman, D. Welsh, G. Whittle (Europ. J. Combin. 2011), after H. Crapo and G.-C. Rota; log-scale result by R. Pendavingh and J. van der Pol.

**Rests on recent unrefereed work. Check these premises first:**
- Adjacent to a person-named conjecture (MNWW): this is an unnamed weakening, allowed by owner rules but should be presented as such
- Some may view positive-fraction as nearly as hard as ratio → 1 (difficulty high)

**References:**
- https://arxiv.org/abs/1411.0935
- https://arxiv.org/abs/1602.04763
- https://arxiv.org/abs/2509.02832
- https://arxiv.org/pdf/2111.11577

Difficulty estimate: 6.5/10 (anchored scale: 1 ≈ Erdős–Ginzburg–Ziv, 2.5 ≈ the sensitivity conjecture, 5 ≈ bounded prime gaps, 7.5 ≈ the Riemann Hypothesis, 10 ≈ P vs NP). It is believed open; do not assume a quick answer exists, and say so plainly if you cannot make progress. Never present a heuristic, numerical evidence, or a partial result as a solution.

## What counts as an answer
Either a proof of `OpenProblems.QEDM125.Claim` or a proof of `¬ OpenProblems.QEDM125.Claim` (a disproof), in Lean 4 + Mathlib, using the exact statement in `problems/QED-M125/Statement.lean`. Read its "Formalization notes" first. If that file still says `def Claim : Prop := sorry`, the problem must first be formalized (see CONTRIBUTING.md); a faithful formalization is itself a welcome contribution.

If you think the Lean statement does not match the informal problem (it is trivially true or false, or it says something else), report that in an issue instead of exploiting it: such solutions are not credited.

## How to submit
0. First time? Solve a test problem (QED-Q1, the 2-line one, at minimum) and submit it, to confirm your Lean setup and the submission pipeline work before spending effort here. Skip this step if this IS a test problem.
1. Claim it (optional but encouraged): open an issue titled `Claim QED-M125` at https://github.com/floration/qed/issues/new?template=claim.yml. Comment on it at least once a week or the claim lapses.
2. Add `solutions/QED-M125/<github-username>/Solution.lean`:
```lean
import Mathlib
-- do NOT redefine Claim: CI prepends problems/QED-M125/Statement.lean to your file
theorem solution : OpenProblems.QEDM125.Claim := by   -- or ¬ OpenProblems.QEDM125.Claim
  ...
```
   Large proofs may add more `.lean` files (subfolders allowed) next to Solution.lean; CI concatenates them in path order before Solution.lean. Don't import them.
3. Add `solutions/QED-M125/<github-username>/meta.json`: `{"model": "<AI model used, or none>", "kind": "proof" | "disproof"}`. Optionally a `README.md` explaining the idea.
4. Open a pull request. CI checks: it compiles, no `sorry`/`admit`/new `axiom`/`set_option` tricks, and `#print axioms solution` shows only `propext`, `Classical.choice`, `Quot.sound`.

## Scoring
Size = number of non-blank, non-comment lines of `Solution.lean` excluding `import` lines (helper lemmas count). First verified solution is credited permanently; any later, strictly smaller verified solution becomes the "smallest solution".

## Rules for you, the model
- Do not modify `Statement.lean` in a solution PR.
- Be honest about uncertainty; if a step is unproven, leave it out rather than sneak in `sorry`.
- Test locally: `lake exe cache get && lake env lean solutions/QED-M125/<user>/Solution.lean`.
