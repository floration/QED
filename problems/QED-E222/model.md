# QED-E222 — One firefighter on the UIPT

You are an AI model helping someone attack this open problem. Read all of this before working.

## The problem
Extended set · Grade C · QED Original · Probability

**Plain words:** A fire starts at the root of the uniform infinite planar triangulation and spreads to all neighbouring vertices each turn, while firefighters permanently protect some vertices each turn. Is one firefighter per turn enough to stop it with probability one?

**Math:** Let $(T,\rho)$ be the type II UIPT (Angel–Schramm: local limit of uniform rooted triangulations of the sphere with $n$ vertices, multiple edges allowed, no loops). The fire starts at $\rho$. At each step $t\ge1$ the defender protects $k_t$ vertices, then the fire spreads to all unprotected unburnt neighbours of burning vertices. Prove that with $k_t\equiv1$, almost surely there is a protection strategy that contains the fire (equivalently, by local convergence: for every $\varepsilon>0$ there is $T$ such that, for all large $n$, the uniform $n$-vertex triangulation lets one firefighter per step contain the fire by time $T$ with probability $\ge1-\varepsilon$). More generally determine $k_*$; the formal Claim is the case $k=1$, i.e. $k_*=1$.

**Credit:** QED original (archived Nov 2026, restored after re-review).

**References:**
- https://arxiv.org/abs/1710.02990
- https://projecteuclid.org/euclid.aop/1556784025

Difficulty estimate: 3.4/10 (calibrated: Collatz ≈ 5.5, twin primes ≈ 5.0). It is believed open; do not assume a quick answer exists, and say so plainly if you cannot make progress. Never present a heuristic, numerical evidence, or a partial result as a solution.

## What counts as an answer
Either a proof of `OpenProblems.QEDE222.Claim` or a proof of `¬ OpenProblems.QEDE222.Claim` (a disproof), in Lean 4 + Mathlib, using the exact statement in `problems/QED-E222/Statement.lean`. Read its "Formalization notes" first. If that file still says `def Claim : Prop := sorry`, the problem must first be formalized (see CONTRIBUTING.md); a faithful formalization is itself a welcome contribution.

If you think the Lean statement does not match the informal problem (it is trivially true or false, or it says something else), report that in an issue instead of exploiting it: such solutions are not credited.

## How to submit
0. First time? Solve a test problem (QED-Q1, the 2-line one, at minimum) and submit it, to confirm your Lean setup and the submission pipeline work before spending effort here. Skip this step if this IS a test problem.
1. Claim it (optional but encouraged): open an issue titled `Claim QED-E222` at https://github.com/floration/qed/issues/new?template=claim.yml. Comment on it at least once a week or the claim lapses.
2. Add `solutions/QED-E222/<github-username>/Solution.lean`:
```lean
import Mathlib
-- do NOT redefine Claim: CI prepends problems/QED-E222/Statement.lean to your file
theorem solution : OpenProblems.QEDE222.Claim := by   -- or ¬ OpenProblems.QEDE222.Claim
  ...
```
   Large proofs may add more `.lean` files (subfolders allowed) next to Solution.lean; CI concatenates them in path order before Solution.lean. Don't import them.
3. Add `solutions/QED-E222/<github-username>/meta.json`: `{"model": "<AI model used, or none>", "kind": "proof" | "disproof"}`. Optionally a `README.md` explaining the idea.
4. Open a pull request. CI checks: it compiles, no `sorry`/`admit`/new `axiom`/`set_option` tricks, and `#print axioms solution` shows only `propext`, `Classical.choice`, `Quot.sound`.

## Scoring
Size = number of non-blank, non-comment lines of `Solution.lean` excluding `import` lines (helper lemmas count). First verified solution is credited permanently; any later, strictly smaller verified solution becomes the "smallest solution".

## Rules for you, the model
- Do not modify `Statement.lean` in a solution PR.
- Be honest about uncertainty; if a step is unproven, leave it out rather than sneak in `sorry`.
- Test locally: `lake exe cache get && lake env lean solutions/QED-E222/<user>/Solution.lean`.
