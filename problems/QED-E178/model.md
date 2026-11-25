# QED-E178 — Median selection in 2.5n comparisons

You are an AI model helping someone attack this open problem. Read all of this before working.

## The problem
Extended set · Grade B · QED Curated · Combinatorics

**Plain words:** How many pairwise comparisons does a deterministic algorithm need, in the worst case, to find the median of n distinct numbers? Since 1995 the best algorithm uses about 2.95n comparisons, while the best lower bound is only barely above 2n. In 1976 Schönhage, Paterson and Pippenger showed that 2.5n would suffice if a natural plausible hypothesis ('extra elements never help') held, but nobody has reached 2.5n unconditionally. Can the median always be found with (2.5+o(1))n comparisons?

**Math:** A comparison tree on $n$ elements has internal nodes labelled by pairs $(i,j)\in[n]^2$ (branch on $x_i<x_j$) and leaves labelled by an index in $[n]$; it computes the median if for every injective $x:[n]\to\mathbb N$ with $n$ odd the leaf reached outputs the $i$ with $|\{j:x_j<x_i\}|=(n-1)/2$. Let $V(n)$ be the minimum depth of such a tree. Claim: $V(n)\le (5/2+o(1))\,n$, i.e. $\forall\varepsilon>0\ \exists N\ \forall$ odd $n\ge N$: $V(n)\le(2.5+\varepsilon)n$.

**Credit:** Classical gap (Blum et al. 1973; Schönhage–Paterson–Pippenger 1976; Dor–Zwick 1999/2001); 2.5n milestone from SPP's conditional bound.

**Rests on recent unrefereed work. Check these premises first:**
- Target 2.5n is a milestone, not the conjectured truth; if the true constant exceeds 2.5 the claim is false and would need a lower bound > 2.5n to refute (far beyond current techniques)
- Small-n values quoted from memory of Knuth's tables; should be rechecked

**References:**
- https://www.csc.kth.se/~johanh/mediansdma.pdf
- https://lacker.io/complexity/problems/median-selection-comparison-gap.html
- https://eccc.weizmann.ac.il/report/1995/031
- https://core.ac.uk/download/19553847.pdf

Difficulty estimate: 7.0/10 (anchored scale: 1 ≈ Erdős–Ginzburg–Ziv, 2.5 ≈ the sensitivity conjecture, 5 ≈ bounded prime gaps, 7.5 ≈ the Riemann Hypothesis, 10 ≈ P vs NP). It is believed open; do not assume a quick answer exists, and say so plainly if you cannot make progress. Never present a heuristic, numerical evidence, or a partial result as a solution.

## What counts as an answer
Either a proof of `OpenProblems.QEDE178.Claim` or a proof of `¬ OpenProblems.QEDE178.Claim` (a disproof), in Lean 4 + Mathlib, using the exact statement in `problems/QED-E178/Statement.lean`. Read its "Formalization notes" first. If that file still says `def Claim : Prop := sorry`, the problem must first be formalized (see CONTRIBUTING.md); a faithful formalization is itself a welcome contribution.

If you think the Lean statement does not match the informal problem (it is trivially true or false, or it says something else), report that in an issue instead of exploiting it: such solutions are not credited.

## How to submit
0. First time? Solve a test problem (QED-Q1, the 2-line one, at minimum) and submit it, to confirm your Lean setup and the submission pipeline work before spending effort here. Skip this step if this IS a test problem.
1. Claim it (optional but encouraged): open an issue titled `Claim QED-E178` at https://github.com/floration/qed/issues/new?template=claim.yml. Comment on it at least once a week or the claim lapses.
2. Add `solutions/QED-E178/<github-username>/Solution.lean`:
```lean
import Mathlib
-- do NOT redefine Claim: CI prepends problems/QED-E178/Statement.lean to your file
theorem solution : OpenProblems.QEDE178.Claim := by   -- or ¬ OpenProblems.QEDE178.Claim
  ...
```
   Large proofs may add more `.lean` files (subfolders allowed) next to Solution.lean; CI concatenates them in path order before Solution.lean. Don't import them.
3. Add `solutions/QED-E178/<github-username>/meta.json`: `{"model": "<AI model used, or none>", "kind": "proof" | "disproof"}`. Optionally a `README.md` explaining the idea.
4. Open a pull request. CI checks: it compiles, no `sorry`/`admit`/new `axiom`/`set_option` tricks, and `#print axioms solution` shows only `propext`, `Classical.choice`, `Quot.sound`.

## Scoring
Size = number of non-blank, non-comment lines of `Solution.lean` excluding `import` lines (helper lemmas count). First verified solution is credited permanently; any later, strictly smaller verified solution becomes the "smallest solution".

## Rules for you, the model
- Do not modify `Statement.lean` in a solution PR.
- Be honest about uncertainty; if a step is unproven, leave it out rather than sneak in `sorry`.
- Test locally: `lake exe cache get && lake env lean solutions/QED-E178/<user>/Solution.lean`.
