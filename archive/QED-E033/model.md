# QED-E033 — Ideal Prouhet–Tarry–Escott solution of size 11

You are an AI model helping someone attack this open problem. Read all of this before working.

## The problem
Extended set · Grade B- · QED Curated · Number theory

**Plain words:** Find two different lists of 11 integers whose sums agree, whose sums of squares agree, and so on all the way up to their sums of 10th powers. Such 'ideal' pairs are known for every list size up to 10 and for size 12, but size 11 has never been found, nor proved impossible.

**Math:** Do there exist multisets $\{a_1,\dots,a_{11}\}\neq\{b_1,\dots,b_{11}\}$ of integers with $\sum_i a_i^j=\sum_i b_i^j$ for $j=1,\dots,10$? Equivalently, is there an ideal PTE solution of degree $10$, i.e. $\prod_{i=1}^{11}(x-a_i)-\prod_{i=1}^{11}(x-b_i)$ a nonzero constant?

**Reviewer note:** Known: Ideal solutions known for degrees $n\le 9$ and $n=11$ (sizes $\le10$ and $12$); survey arXiv:2506.11429 (2025). Degree-11 (size-12) symmetric solution: Kuosa, Meyrignac, Chen Shuwen (1999). Borwein–Lisoněk–Percival, 'Computational investigations of the PTE problem', Math. Comp. 72 (2003): unsuccessful searches for degree 10 and 12 within their search class. Caley, PhD thesis (Waterloo 2012): constants $C_n$ and divisibility constraints. Inagaki–Matsumura–Sawa–Uchida, arXiv:2603.11100 (Mar 2026): characterization of ideal PTE_1 solutions via designs, no degree-10 solution.

**Credit:** Prouhet, Tarry, Escott; frontier noted by Borwein–Lisoněk–Percival and the 2025 PTE survey

**Rests on recent unrefereed work. Check these premises first:**
- the general ideal-PTE conjecture is classical; this is its smallest open case, not a new question
- heuristics do not strongly favour existence at degree 10; a negative answer would need an obstruction

**References:**
- https://arxiv.org/abs/2506.11429
- https://www.ams.org/mcom/2003-72-244/S0025-5718-02-01504-1/
- https://arxiv.org/abs/2304.11254
- https://arxiv.org/abs/2603.11100
- https://uwspace.uwaterloo.ca/bitstream/10012/7205/1/Caley_Timothy.pdf

Difficulty estimate: 5.0/10 (calibrated: Collatz ≈ 5.5, twin primes ≈ 5.0). It is believed open; do not assume a quick answer exists, and say so plainly if you cannot make progress. Never present a heuristic, numerical evidence, or a partial result as a solution.

## What counts as an answer
Either a proof of `OpenProblems.QEDE033.Claim` or a proof of `¬ OpenProblems.QEDE033.Claim` (a disproof), in Lean 4 + Mathlib, using the exact statement in `problems/QED-E033/Statement.lean`. Read its "Formalization notes" first. If that file still says `def Claim : Prop := sorry`, the problem must first be formalized (see CONTRIBUTING.md); a faithful formalization is itself a welcome contribution.

If you think the Lean statement does not match the informal problem (it is trivially true or false, or it says something else), report that in an issue instead of exploiting it: such solutions are not credited.

## How to submit
1. Claim it (optional but encouraged): open an issue titled `Claim QED-E033` at https://github.com/floration/qed/issues/new?template=claim.yml. Comment on it at least once a week or the claim lapses.
2. Add `solutions/QED-E033/<github-username>/Solution.lean`:
```lean
import Mathlib
-- do NOT redefine Claim: CI prepends problems/QED-E033/Statement.lean to your file
theorem solution : OpenProblems.QEDE033.Claim := by   -- or ¬ OpenProblems.QEDE033.Claim
  ...
```
3. Add `solutions/QED-E033/<github-username>/meta.json`: `{"model": "<AI model used, or none>", "kind": "proof" | "disproof"}`. Optionally a `README.md` explaining the idea.
4. Open a pull request. CI checks: it compiles, no `sorry`/`admit`/new `axiom`/`set_option` tricks, and `#print axioms solution` shows only `propext`, `Classical.choice`, `Quot.sound`.

## Scoring
Size = number of non-blank, non-comment lines of `Solution.lean` excluding `import` lines (helper lemmas count). First verified solution is credited permanently; any later, strictly smaller verified solution becomes the "smallest solution".

## Rules for you, the model
- Do not modify `Statement.lean` in a solution PR.
- Be honest about uncertainty; if a step is unproven, leave it out rather than sneak in `sorry`.
- Test locally: `lake exe cache get && lake env lean solutions/QED-E033/<user>/Solution.lean`.
