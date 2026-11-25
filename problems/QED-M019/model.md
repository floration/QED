# QED-M019 — Codes avoiding square distances

You are an AI model helping someone attack this open problem. Read all of this before working.

## The problem
Main set · Grade A · QED Original · Combinatorics

**Plain words:** Find the largest set of binary strings of length n in which no two differ in a perfect-square number of positions. Does it grow exponentially in n, and if so at what rate? This is a hypercube version of Sarkozy's theorem on square differences.

**Math:** Let $A(n)=\max\{|C|: C\subseteq\{0,1\}^n,\ d_H(x,y)\notin\{1,4,9,16,\dots\}\ \forall x\ne y\in C\}$. Decide whether $A(n)=2^{o(n)}$. More precisely, determine $\liminf_n\frac1n\log_2A(n)$ and $\limsup_n\frac1n\log_2A(n)$ (in particular whether they are equal).

**QED results so far (reviewer-derived; check before relying on them):** Small values A(1..7)=1,2,4,5,10,12,14 re-verified by exact max-clique. Frankl-Rodl rate<1 argument is correct. The claim that codes with all distances between consecutive squares are polynomial is only correct for windows at linear distance. Constant-weight codes with w~k^2/2, w~n^{2/3}, and pairwise intersections <k have all distances in (k^2,(k+1)^2).

**References:**
- https://arxiv.org/pdf/2504.12296v3
- https://arxiv.org/pdf/1402.6294
- https://people.maths.ox.ac.uk/keevash/papers/franklrodl-journal.pdf
- https://arxiv.org/pdf/2604.05607
- https://arxiv.org/pdf/2305.00433
- https://arxiv.org/pdf/2611.04523
- https://arxiv.org/pdf/2604.05607
- https://arxiv.org/pdf/2506.18782
- https://people.maths.ox.ac.uk/keevash/papers/franklrodl-journal.pdf

Difficulty estimate: 4.5/10 (calibrated: Collatz ≈ 5.5, twin primes ≈ 5.0). It is believed open; do not assume a quick answer exists, and say so plainly if you cannot make progress. Never present a heuristic, numerical evidence, or a partial result as a solution.

## What counts as an answer
Either a proof of `OpenProblems.QEDM019.Claim` or a proof of `¬ OpenProblems.QEDM019.Claim` (a disproof), in Lean 4 + Mathlib, using the exact statement in `problems/QED-M019/Statement.lean`. Read its "Formalization notes" first. If that file still says `def Claim : Prop := sorry`, the problem must first be formalized (see CONTRIBUTING.md); a faithful formalization is itself a welcome contribution.

If you think the Lean statement does not match the informal problem (it is trivially true or false, or it says something else), report that in an issue instead of exploiting it: such solutions are not credited.

## How to submit
1. Claim it (optional but encouraged): open an issue titled `Claim QED-M019` at https://github.com/floration/qed/issues/new?template=claim.yml. Comment on it at least once a week or the claim lapses.
2. Add `solutions/QED-M019/<github-username>/Solution.lean`:
```lean
import Mathlib
-- do NOT redefine Claim: CI prepends problems/QED-M019/Statement.lean to your file
theorem solution : OpenProblems.QEDM019.Claim := by   -- or ¬ OpenProblems.QEDM019.Claim
  ...
```
   Large proofs may add more `.lean` files (subfolders allowed) next to Solution.lean; CI concatenates them in path order before Solution.lean. Don't import them.
3. Add `solutions/QED-M019/<github-username>/meta.json`: `{"model": "<AI model used, or none>", "kind": "proof" | "disproof"}`. Optionally a `README.md` explaining the idea.
4. Open a pull request. CI checks: it compiles, no `sorry`/`admit`/new `axiom`/`set_option` tricks, and `#print axioms solution` shows only `propext`, `Classical.choice`, `Quot.sound`.

## Scoring
Size = number of non-blank, non-comment lines of `Solution.lean` excluding `import` lines (helper lemmas count). First verified solution is credited permanently; any later, strictly smaller verified solution becomes the "smallest solution".

## Rules for you, the model
- Do not modify `Statement.lean` in a solution PR.
- Be honest about uncertainty; if a step is unproven, leave it out rather than sneak in `sorry`.
- Test locally: `lake exe cache get && lake env lean solutions/QED-M019/<user>/Solution.lean`.
