# QED-E079 — Is the Petersen graph common?

You are an AI model helping someone attack this open problem. Read all of this before working.

## The problem
Extended set · Grade B · QED Original · Combinatorics

**Plain words:** Color the edges of a huge complete graph red and blue. Does a random coloring minimize the number of single-color copies of the Petersen graph?

**Math:** Let $P$ be the Petersen graph ($10$ vertices, $15$ edges) and $m(P)=\lim_{n\to\infty}\min_{\chi}\frac{\#\{\text{monochromatic copies of }P\text{ in }(K_n,\chi)\}}{\#\{\text{copies of }P\text{ in }K_n\}}$, minimum over red/blue colorings $\chi$ of $E(K_n)$. Is $m(P)=2^{-14}$, i.e. is $P$ common? Equivalently, is $t(P,W)+t(P,1-W)\ge 2^{-14}$ for every graphon $W$? If not, determine $m(P)$.

**Rests on recent unrefereed work. Check these premises first:**
- arXiv:2610.20149 (2026 preprint): cited background on common graphs; M does not depend on it.

**References:**
- https://arxiv.org/pdf/2207.07775
- https://arxiv.org/pdf/2206.04036
- https://arxiv.org/pdf/2012.02057
- https://arxiv.org/pdf/2610.20149
- https://arxiv.org/pdf/2303.09296
- https://arxiv.org/pdf/2206.05800

Difficulty estimate: 3.5/10 (calibrated: Collatz ≈ 5.5, twin primes ≈ 5.0). It is believed open; do not assume a quick answer exists, and say so plainly if you cannot make progress. Never present a heuristic, numerical evidence, or a partial result as a solution.

## What counts as an answer
Either a proof of `OpenProblems.QEDE079.Claim` or a proof of `¬ OpenProblems.QEDE079.Claim` (a disproof), in Lean 4 + Mathlib, using the exact statement in `problems/QED-E079/Statement.lean`. Read its "Formalization notes" first. If that file still says `def Claim : Prop := sorry`, the problem must first be formalized (see CONTRIBUTING.md); a faithful formalization is itself a welcome contribution.

If you think the Lean statement does not match the informal problem (it is trivially true or false, or it says something else), report that in an issue instead of exploiting it: such solutions are not credited.

## How to submit
1. Claim it (optional but encouraged): open an issue titled `Claim QED-E079` at https://github.com/floration/qed/issues/new?template=claim.yml. Comment on it at least once a week or the claim lapses.
2. Add `solutions/QED-E079/<github-username>/Solution.lean`:
```lean
import Mathlib
-- do NOT redefine Claim: CI prepends problems/QED-E079/Statement.lean to your file
theorem solution : OpenProblems.QEDE079.Claim := by   -- or ¬ OpenProblems.QEDE079.Claim
  ...
```
3. Add `solutions/QED-E079/<github-username>/meta.json`: `{"model": "<AI model used, or none>", "kind": "proof" | "disproof"}`. Optionally a `README.md` explaining the idea.
4. Open a pull request. CI checks: it compiles, no `sorry`/`admit`/new `axiom`/`set_option` tricks, and `#print axioms solution` shows only `propext`, `Classical.choice`, `Quot.sound`.

## Scoring
Size = number of non-blank, non-comment lines of `Solution.lean` excluding `import` lines (helper lemmas count). First verified solution is credited permanently; any later, strictly smaller verified solution becomes the "smallest solution".

## Rules for you, the model
- Do not modify `Statement.lean` in a solution PR.
- Be honest about uncertainty; if a step is unproven, leave it out rather than sneak in `sorry`.
- Test locally: `lake exe cache get && lake env lean solutions/QED-E079/<user>/Solution.lean`.
