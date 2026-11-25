# QED-M026 — The complex of planar graphs

You are an AI model helping someone attack this open problem. Read all of this before working.

## The problem
Main set · Grade B · QED Original · Combinatorics

**Plain words:** Planar graphs on n labelled vertices form a simplicial complex, because deleting an edge keeps a graph planar. It is pure, since every maximal planar graph has 3n-6 edges. Its homology turns out not to be that of a wedge of top-dimensional spheres: already for n=6 it is concentrated two degrees lower and has 2-torsion. Determine its homology.

**Math:** Let $\Pi_n$ be the simplicial complex on vertex set $E(K_n)$ whose faces are edge sets of planar graphs; it is pure of dimension $3n-7$. Determine $\tilde H_*(\Pi_n;\mathbb Z)$, or at least $\tilde H_*(\Pi_n;\mathbb Q)$, for all $n$. Known: $\Pi_4$ is a simplex, $\Pi_5=\partial\Delta^9\cong S^8$. For $n=6$ (computed exactly): $\tilde H_*(\Pi_6;\mathbb Q)$ is $\mathbb Q^{15}$ in degree $9=3n-9$ and $0$ elsewhere; $\tilde H_*(\Pi_6;\mathbb F_2)$ is $\mathbb F_2^{15},\mathbb F_2,\mathbb F_2$ in degrees $9,10,11$, so $\tilde H_{10}(\Pi_6;\mathbb Z)$ has $2$-torsion and $\Pi_6$ is not a wedge of spheres. The mod-2 top class is the sum of all triangulations: every face of dimension $3n-8$ of $\Pi_6$ lies in an even number (2 or 4) of facets. Questions: (a) is $\tilde H_*(\Pi_n;\mathbb Q)$ concentrated in degree $3n-9$ for all $n\ge6$, and what is its rank and $S_n$-module structure? (b) Is $\tilde H_{3n-7}(\Pi_n;\mathbb F_2)\ne0$ for all $n\ge5$? Is all torsion 2-torsion?

**References:**
- https://arxiv.org/pdf/2012.01679
- https://doi.org/10.1007/978-3-540-75859-4_7

Difficulty estimate: 3.0/10 (calibrated: Collatz ≈ 5.5, twin primes ≈ 5.0). It is believed open; do not assume a quick answer exists, and say so plainly if you cannot make progress. Never present a heuristic, numerical evidence, or a partial result as a solution.

## What counts as an answer
Either a proof of `OpenProblems.QEDM026.Claim` or a proof of `¬ OpenProblems.QEDM026.Claim` (a disproof), in Lean 4 + Mathlib, using the exact statement in `problems/QED-M026/Statement.lean`. Read its "Formalization notes" first. If that file still says `def Claim : Prop := sorry`, the problem must first be formalized (see CONTRIBUTING.md); a faithful formalization is itself a welcome contribution.

If you think the Lean statement does not match the informal problem (it is trivially true or false, or it says something else), report that in an issue instead of exploiting it: such solutions are not credited.

## How to submit
1. Claim it (optional but encouraged): open an issue titled `Claim QED-M026` at https://github.com/floration/qed/issues/new?template=claim.yml. Comment on it at least once a week or the claim lapses.
2. Add `solutions/QED-M026/<github-username>/Solution.lean`:
```lean
import Mathlib
-- do NOT redefine Claim: CI prepends problems/QED-M026/Statement.lean to your file
theorem solution : OpenProblems.QEDM026.Claim := by   -- or ¬ OpenProblems.QEDM026.Claim
  ...
```
   Large proofs may add more `.lean` files (subfolders allowed) next to Solution.lean; CI concatenates them in path order before Solution.lean. Don't import them.
3. Add `solutions/QED-M026/<github-username>/meta.json`: `{"model": "<AI model used, or none>", "kind": "proof" | "disproof"}`. Optionally a `README.md` explaining the idea.
4. Open a pull request. CI checks: it compiles, no `sorry`/`admit`/new `axiom`/`set_option` tricks, and `#print axioms solution` shows only `propext`, `Classical.choice`, `Quot.sound`.

## Scoring
Size = number of non-blank, non-comment lines of `Solution.lean` excluding `import` lines (helper lemmas count). First verified solution is credited permanently; any later, strictly smaller verified solution becomes the "smallest solution".

## Rules for you, the model
- Do not modify `Statement.lean` in a solution PR.
- Be honest about uncertainty; if a step is unproven, leave it out rather than sneak in `sorry`.
- Test locally: `lake exe cache get && lake env lean solutions/QED-M026/<user>/Solution.lean`.
