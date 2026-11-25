# QED-E001 — Galois groups of Keller fibers

You are an AI model helping someone attack this open problem. Read all of this before working.

## The problem
Extended set · Grade C · Algebra

**Plain words:** Gallagher (2026) built, for every n>=3, a polynomial map C^3->C^3 with constant nonzero Jacobian whose general fibre has exactly n points. Determine the symmetry (monodromy/Galois) group of how those n points are permuted.

**Math:** Let $H_n:\mathbb C^3\to\mathbb C^3$ be Gallagher's Keller map of geometric degree $n$ (A. Gallagher, \emph{An infinite family of counterexamples to the Jacobian Conjecture in dimension three}, Zenodo 2026, doi:10.5281/zenodo.21479195), so $[\mathbb C(x,y,z):H_n^*\mathbb C(X,Y,Z)]=n$. For each $n\ge3$ determine the Galois group of the Galois closure of $\mathbb C(x,y,z)/H_n^*\mathbb C(X,Y,Z)$ (equivalently the monodromy group of the $n$-sheeted covering over a general point), as a permutation group of degree $n$; and the arithmetic group over $\mathbb Q$.

**Reviewer note:** O

**References:**
- https://arxiv.org/pdf/2608.00222
- https://arxiv.org/pdf/2608.02863
- https://arxiv.org/pdf/2607.20210
- https://arxiv.org/pdf/2609.33491
- https://doi.org/10.5281/zenodo.21479195

Difficulty estimate: 1.9/10 (calibrated: Collatz ≈ 5.5, twin primes ≈ 5.0). It is believed open; do not assume a quick answer exists, and say so plainly if you cannot make progress. Never present a heuristic, numerical evidence, or a partial result as a solution.

## What counts as an answer
Either a proof of `OpenProblems.QEDE001.Claim` or a proof of `¬ OpenProblems.QEDE001.Claim` (a disproof), in Lean 4 + Mathlib, using the exact statement in `problems/QED-E001/Statement.lean`. Read its "Formalization notes" first. If that file still says `def Claim : Prop := sorry`, the problem must first be formalized (see CONTRIBUTING.md); a faithful formalization is itself a welcome contribution.

If you think the Lean statement does not match the informal problem (it is trivially true or false, or it says something else), report that in an issue instead of exploiting it: such solutions are not credited.

## How to submit
1. Claim it (optional but encouraged): open an issue titled `Claim QED-E001` at https://github.com/floration/qed/issues/new?template=claim.yml. Comment on it at least once a week or the claim lapses.
2. Add `solutions/QED-E001/<github-username>/Solution.lean`:
```lean
import Mathlib
-- do NOT redefine Claim: CI prepends problems/QED-E001/Statement.lean to your file
theorem solution : OpenProblems.QEDE001.Claim := by   -- or ¬ OpenProblems.QEDE001.Claim
  ...
```
   Large proofs may add more `.lean` files (subfolders allowed) next to Solution.lean; CI concatenates them in path order before Solution.lean. Don't import them.
3. Add `solutions/QED-E001/<github-username>/meta.json`: `{"model": "<AI model used, or none>", "kind": "proof" | "disproof"}`. Optionally a `README.md` explaining the idea.
4. Open a pull request. CI checks: it compiles, no `sorry`/`admit`/new `axiom`/`set_option` tricks, and `#print axioms solution` shows only `propext`, `Classical.choice`, `Quot.sound`.

## Scoring
Size = number of non-blank, non-comment lines of `Solution.lean` excluding `import` lines (helper lemmas count). First verified solution is credited permanently; any later, strictly smaller verified solution becomes the "smallest solution".

## Rules for you, the model
- Do not modify `Statement.lean` in a solution PR.
- Be honest about uncertainty; if a step is unproven, leave it out rather than sneak in `sorry`.
- Test locally: `lake exe cache get && lake env lean solutions/QED-E001/<user>/Solution.lean`.
