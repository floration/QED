# QED-M128 — Monochromatic rectangles in low-rank Boolean matrices: beating 2^{-sqrt r}

You are an AI model helping someone attack this open problem. Read all of this before working.

## The problem
Main set · Grade A · QED Curated · Complexity

**Plain words:** Take any m-by-n matrix of 0s and 1s whose real rank is r. It is known that it always contains an all-0 or all-1 submatrix (some rows times some columns) covering at least a 2^{-O(sqrt r)} fraction of the entries. Can sqrt r be replaced by r^c for some c < 1/2? By a standard reduction this is the same as a communication protocol of cost O(r^c), beating the current sqrt(rank) bound on the way to the log-rank conjecture.

**Math:** Do there exist constants $c<1/2$ and $C>0$ such that for all $m,n\ge1$ and every $M\in\{0,1\}^{m\times n}$ with $r=\operatorname{rank}_{\mathbb R}(M)\ge1$ there are $A\subseteq[m]$, $B\subseteq[n]$, $b\in\{0,1\}$ with $M_{ij}=b$ for all $(i,j)\in A\times B$ and $|A||B|\ge mn\,2^{-Cr^{c}}$? (By the Nisan--Wigderson/Lovett recursion this is equivalent, up to constants, to $D(M)=O(\operatorname{rank}(M)^{c})$ for all Boolean $M$.)

**Credit:** Weakening of the log-rank conjecture (Lovász–Saks 1988); rectangle formulation Nisan–Wigderson 1995; sqrt barrier from Lovett 2016 and Sudakov–Tomon 2024.

**Rests on recent unrefereed work. Check these premises first:**
- This is an unnamed weakening of a person-associated famous conjecture (log-rank, Lovász–Saks); permitted under the sub-question rule but scorer may judge it a famous problem in disguise
- Exponent target c<1/2 is natural (first polynomial improvement) but any such result would be a major breakthrough: very hard

**References:**
- https://arxiv.org/abs/2311.18524
- https://arxiv.org/abs/1306.1877
- https://arxiv.org/abs/2510.02583
- https://drops.dagstuhl.de/entities/document/10.4230/LIPIcs.CCC.2026.7
- https://lacker.io/complexity/problems/log-rank-sqrt-vs-polylog.html

Difficulty estimate: 8.0/10 (calibrated: Collatz ≈ 5.5, twin primes ≈ 5.0). It is believed open; do not assume a quick answer exists, and say so plainly if you cannot make progress. Never present a heuristic, numerical evidence, or a partial result as a solution.

## What counts as an answer
Either a proof of `OpenProblems.QEDM128.Claim` or a proof of `¬ OpenProblems.QEDM128.Claim` (a disproof), in Lean 4 + Mathlib, using the exact statement in `problems/QED-M128/Statement.lean`. Read its "Formalization notes" first. If that file still says `def Claim : Prop := sorry`, the problem must first be formalized (see CONTRIBUTING.md); a faithful formalization is itself a welcome contribution.

If you think the Lean statement does not match the informal problem (it is trivially true or false, or it says something else), report that in an issue instead of exploiting it: such solutions are not credited.

## How to submit
0. First time? Solve a test problem (QED-Q1, the 2-line one, at minimum) and submit it, to confirm your Lean setup and the submission pipeline work before spending effort here. Skip this step if this IS a test problem.
1. Claim it (optional but encouraged): open an issue titled `Claim QED-M128` at https://github.com/floration/qed/issues/new?template=claim.yml. Comment on it at least once a week or the claim lapses.
2. Add `solutions/QED-M128/<github-username>/Solution.lean`:
```lean
import Mathlib
-- do NOT redefine Claim: CI prepends problems/QED-M128/Statement.lean to your file
theorem solution : OpenProblems.QEDM128.Claim := by   -- or ¬ OpenProblems.QEDM128.Claim
  ...
```
   Large proofs may add more `.lean` files (subfolders allowed) next to Solution.lean; CI concatenates them in path order before Solution.lean. Don't import them.
3. Add `solutions/QED-M128/<github-username>/meta.json`: `{"model": "<AI model used, or none>", "kind": "proof" | "disproof"}`. Optionally a `README.md` explaining the idea.
4. Open a pull request. CI checks: it compiles, no `sorry`/`admit`/new `axiom`/`set_option` tricks, and `#print axioms solution` shows only `propext`, `Classical.choice`, `Quot.sound`.

## Scoring
Size = number of non-blank, non-comment lines of `Solution.lean` excluding `import` lines (helper lemmas count). First verified solution is credited permanently; any later, strictly smaller verified solution becomes the "smallest solution".

## Rules for you, the model
- Do not modify `Statement.lean` in a solution PR.
- Be honest about uncertainty; if a step is unproven, leave it out rather than sneak in `sorry`.
- Test locally: `lake exe cache get && lake env lean solutions/QED-M128/<user>/Solution.lean`.
