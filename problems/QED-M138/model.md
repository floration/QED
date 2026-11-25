# QED-M138 — Diameter of the three-pile shuffle group

You are an AI model helping someone attack this open problem. Read all of this before working.

## The problem
Main set · Grade B · QED Original · Combinatorics

**Plain words:** Cut a deck of 3n cards into three equal piles and interleave them, choosing any of the 6 orders of the piles at each step. When n is not a power of 3 these moves can produce every (even) arrangement. How many shuffles are needed, in the worst case, to reach every reachable arrangement? Is it of order n log n, as counting suggests, or polynomially larger?

**Math:** For $\sigma\in S_3$ let $g_\sigma\in S_{3n}$ map position $kn+j$ ($k\in\{0,1,2\}$, $0\le j<n$) to $3j+\sigma(k)$, and let $G_{3,3n}=\langle g_\sigma:\sigma\in S_3\rangle$. For $n$ not a power of $3$ (where $G_{3,3n}\supseteq A_{3n}$), let $D(n)$ be the diameter of the (undirected) Cayley graph $\mathrm{Cay}(G_{3,3n},\{g_\sigma^{\pm1}\})$. Counting gives $D(n)=\Omega(n\log n)$. Determine whether $D(n)=O(n\log n)$; failing that, determine the growth exponent $\lim\log D(n)/\log n$ (in particular, prove $D(n)\le n^{C}$ for an absolute $C$).

**Credit:** QED original (archived Nov 2026, restored after re-review).

**References:**
- https://arxiv.org/abs/2304.01037
- https://arxiv.org/abs/2307.15012
- https://arxiv.org/abs/1908.05128
- https://aimath.org/~morrison/Research/shuffles

Difficulty estimate: 3.0/10 (anchored scale: 1 ≈ Erdős–Ginzburg–Ziv, 2.5 ≈ the sensitivity conjecture, 5 ≈ bounded prime gaps, 7.5 ≈ the Riemann Hypothesis, 10 ≈ P vs NP). It is believed open; do not assume a quick answer exists, and say so plainly if you cannot make progress. Never present a heuristic, numerical evidence, or a partial result as a solution.

## What counts as an answer
Either a proof of `OpenProblems.QEDM138.Claim` or a proof of `¬ OpenProblems.QEDM138.Claim` (a disproof), in Lean 4 + Mathlib, using the exact statement in `problems/QED-M138/Statement.lean`. Read its "Formalization notes" first. If that file still says `def Claim : Prop := sorry`, the problem must first be formalized (see CONTRIBUTING.md); a faithful formalization is itself a welcome contribution.

If you think the Lean statement does not match the informal problem (it is trivially true or false, or it says something else), report that in an issue instead of exploiting it: such solutions are not credited.

## How to submit
0. First time? Solve a test problem (QED-Q1, the 2-line one, at minimum) and submit it, to confirm your Lean setup and the submission pipeline work before spending effort here. Skip this step if this IS a test problem.
1. Claim it (optional but encouraged): open an issue titled `Claim QED-M138` at https://github.com/floration/qed/issues/new?template=claim.yml. Comment on it at least once a week or the claim lapses.
2. Add `solutions/QED-M138/<github-username>/Solution.lean`:
```lean
import Mathlib
-- do NOT redefine Claim: CI prepends problems/QED-M138/Statement.lean to your file
theorem solution : OpenProblems.QEDM138.Claim := by   -- or ¬ OpenProblems.QEDM138.Claim
  ...
```
   Large proofs may add more `.lean` files (subfolders allowed) next to Solution.lean; CI concatenates them in path order before Solution.lean. Don't import them.
3. Add `solutions/QED-M138/<github-username>/meta.json`: `{"model": "<AI model used, or none>", "kind": "proof" | "disproof"}`. Optionally a `README.md` explaining the idea.
4. Open a pull request. CI checks: it compiles, no `sorry`/`admit`/new `axiom`/`set_option` tricks, and `#print axioms solution` shows only `propext`, `Classical.choice`, `Quot.sound`.

## Scoring
Size = number of non-blank, non-comment lines of `Solution.lean` excluding `import` lines (helper lemmas count). First verified solution is credited permanently; any later, strictly smaller verified solution becomes the "smallest solution".

## Rules for you, the model
- Do not modify `Statement.lean` in a solution PR.
- Be honest about uncertainty; if a step is unproven, leave it out rather than sneak in `sorry`.
- Test locally: `lake exe cache get && lake env lean solutions/QED-M138/<user>/Solution.lean`.
