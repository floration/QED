# QED-E168 — Real-rooted h*-polynomials of hypersimplices

You are an AI model helping someone attack this open problem. Read all of this before working.

## The problem
Extended set · Grade B · QED Curated · Combinatorics

**Plain words:** The hypersimplex Δ(k,n) is the slice of the unit cube [0,1]^n by the hyperplane x_1+...+x_n = k. Count the lattice points in its t-fold dilate for every t. These counts are packaged into a polynomial h*(z) with nonnegative integer coefficients. For k = 2 this polynomial is known to have only real roots. Is that true for every k and n?

**Math:** Let $L_{k,n}(t)=\#\{x\in\{0,\dots,t\}^n:\ \sum x_i=kt\}$ and define $h^*_{k,n}(z)$ by $\sum_{t\ge0}L_{k,n}(t)z^t=h^*_{k,n}(z)/(1-z)^n$. Claim: for all $1\le k\le n-1$, every root of $h^*_{k,n}$ is real. Weaker open target: the coefficients of $h^*_{k,n}$ are unimodal for all k, n.

**Credit:** Natural surviving special case of Ferroni's matroid-polytope real-rootedness conjecture (see Ferroni–Jochemko–Schröter, arXiv:2106.08183); unimodality version from De Loera–Haws–Köppe

**Rests on recent unrefereed work. Check these premises first:**
- The disproof of the general matroid conjecture is an unrefereed 2026 preprint (arXiv:2609.37439).
- Unimodality or real-rootedness for some k ≥ 3 may already follow from a known formula (for example Li's descent/excedance description) in a source not found here.
- Search budget ran out before a last check of 2025–26 hypersimplex-specific papers.

**References:**
- https://arxiv.org/pdf/2202.11808
- https://arxiv.org/abs/2106.08183
- https://arxiv.org/abs/2609.37439
- https://dmtcs.episciences.org/12798/pdf
- https://arxiv.org/abs/1911.10146
- https://arxiv.org/pdf/2412.06524v2

Difficulty estimate: 5.0/10 (calibrated: Collatz ≈ 5.5, twin primes ≈ 5.0). It is believed open; do not assume a quick answer exists, and say so plainly if you cannot make progress. Never present a heuristic, numerical evidence, or a partial result as a solution.

## What counts as an answer
Either a proof of `OpenProblems.QEDE168.Claim` or a proof of `¬ OpenProblems.QEDE168.Claim` (a disproof), in Lean 4 + Mathlib, using the exact statement in `problems/QED-E168/Statement.lean`. Read its "Formalization notes" first. If that file still says `def Claim : Prop := sorry`, the problem must first be formalized (see CONTRIBUTING.md); a faithful formalization is itself a welcome contribution.

If you think the Lean statement does not match the informal problem (it is trivially true or false, or it says something else), report that in an issue instead of exploiting it: such solutions are not credited.

## How to submit
0. First time? Solve a test problem (QED-Q1, the 2-line one, at minimum) and submit it, to confirm your Lean setup and the submission pipeline work before spending effort here. Skip this step if this IS a test problem.
1. Claim it (optional but encouraged): open an issue titled `Claim QED-E168` at https://github.com/floration/qed/issues/new?template=claim.yml. Comment on it at least once a week or the claim lapses.
2. Add `solutions/QED-E168/<github-username>/Solution.lean`:
```lean
import Mathlib
-- do NOT redefine Claim: CI prepends problems/QED-E168/Statement.lean to your file
theorem solution : OpenProblems.QEDE168.Claim := by   -- or ¬ OpenProblems.QEDE168.Claim
  ...
```
   Large proofs may add more `.lean` files (subfolders allowed) next to Solution.lean; CI concatenates them in path order before Solution.lean. Don't import them.
3. Add `solutions/QED-E168/<github-username>/meta.json`: `{"model": "<AI model used, or none>", "kind": "proof" | "disproof"}`. Optionally a `README.md` explaining the idea.
4. Open a pull request. CI checks: it compiles, no `sorry`/`admit`/new `axiom`/`set_option` tricks, and `#print axioms solution` shows only `propext`, `Classical.choice`, `Quot.sound`.

## Scoring
Size = number of non-blank, non-comment lines of `Solution.lean` excluding `import` lines (helper lemmas count). First verified solution is credited permanently; any later, strictly smaller verified solution becomes the "smallest solution".

## Rules for you, the model
- Do not modify `Statement.lean` in a solution PR.
- Be honest about uncertainty; if a step is unproven, leave it out rather than sneak in `sorry`.
- Test locally: `lake exe cache get && lake env lean solutions/QED-E168/<user>/Solution.lean`.
