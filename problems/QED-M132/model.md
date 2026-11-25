# QED-M132 — The 4/3 integrality gap of the subtour LP for metric TSP

You are an AI model helping someone attack this open problem. Read all of this before working.

## The problem
Main set · Grade A · QED Curated · Combinatorics

**Plain words:** Take n cities with distances that satisfy the triangle inequality. The subtour LP relaxes 'pick a tour' to 'put fractional weights on the roads so every city has total weight 2, and every split of the cities into two groups is crossed by total weight at least 2'. Is the cheapest tour always at most 4/3 times the cheapest fractional solution? Known examples show 4/3 cannot be lowered; the best proven factor is only slightly below 3/2.

**Math:** Let $n\ge3$ and let $c:\binom{[n]}{2}\to\mathbb R_{\ge0}$ satisfy $c_{uw}\le c_{uv}+c_{vw}$. Let $x\in\mathbb R_{\ge0}^{\binom{[n]}{2}}$ satisfy $x(\delta(v))=2$ for all $v\in[n]$ and $x(\delta(S))\ge2$ for all $\emptyset\ne S\subsetneq[n]$. Prove that some Hamiltonian cycle $H$ on $[n]$ has $c(H)\le\frac43\sum_e c_ex_e$. (Equivalently: the integrality ratio of the subtour/Held--Karp relaxation of metric TSP equals $4/3$; the lower bound $4/3$ is known.)

**Credit:** Folklore '4/3 conjecture' (Goemans 1995; Williamson 1990s); statement source: Karlin–Klein–Oveis Gharan 2022; Cook–Hougardy–Petrich 2026.

**Rests on recent unrefereed work. Check these premises first:**
- Very famous problem (low novelty, high importance)
- Cook–Hougardy–Petrich computations are an unrefereed 2026 preprint (only used as supporting evidence)

**References:**
- https://arxiv.org/abs/2105.10043
- https://arxiv.org/abs/2603.12995
- https://arxiv.org/abs/2507.07003

Difficulty estimate: 4.5/10 (calibrated: Collatz ≈ 5.5, twin primes ≈ 5.0). It is believed open; do not assume a quick answer exists, and say so plainly if you cannot make progress. Never present a heuristic, numerical evidence, or a partial result as a solution.

## What counts as an answer
Either a proof of `OpenProblems.QEDM132.Claim` or a proof of `¬ OpenProblems.QEDM132.Claim` (a disproof), in Lean 4 + Mathlib, using the exact statement in `problems/QED-M132/Statement.lean`. Read its "Formalization notes" first. If that file still says `def Claim : Prop := sorry`, the problem must first be formalized (see CONTRIBUTING.md); a faithful formalization is itself a welcome contribution.

If you think the Lean statement does not match the informal problem (it is trivially true or false, or it says something else), report that in an issue instead of exploiting it: such solutions are not credited.

## How to submit
0. First time? Solve a test problem (QED-Q1, the 2-line one, at minimum) and submit it, to confirm your Lean setup and the submission pipeline work before spending effort here. Skip this step if this IS a test problem.
1. Claim it (optional but encouraged): open an issue titled `Claim QED-M132` at https://github.com/floration/qed/issues/new?template=claim.yml. Comment on it at least once a week or the claim lapses.
2. Add `solutions/QED-M132/<github-username>/Solution.lean`:
```lean
import Mathlib
-- do NOT redefine Claim: CI prepends problems/QED-M132/Statement.lean to your file
theorem solution : OpenProblems.QEDM132.Claim := by   -- or ¬ OpenProblems.QEDM132.Claim
  ...
```
   Large proofs may add more `.lean` files (subfolders allowed) next to Solution.lean; CI concatenates them in path order before Solution.lean. Don't import them.
3. Add `solutions/QED-M132/<github-username>/meta.json`: `{"model": "<AI model used, or none>", "kind": "proof" | "disproof"}`. Optionally a `README.md` explaining the idea.
4. Open a pull request. CI checks: it compiles, no `sorry`/`admit`/new `axiom`/`set_option` tricks, and `#print axioms solution` shows only `propext`, `Classical.choice`, `Quot.sound`.

## Scoring
Size = number of non-blank, non-comment lines of `Solution.lean` excluding `import` lines (helper lemmas count). First verified solution is credited permanently; any later, strictly smaller verified solution becomes the "smallest solution".

## Rules for you, the model
- Do not modify `Statement.lean` in a solution PR.
- Be honest about uncertainty; if a step is unproven, leave it out rather than sneak in `sorry`.
- Test locally: `lake exe cache get && lake env lean solutions/QED-M132/<user>/Solution.lean`.
