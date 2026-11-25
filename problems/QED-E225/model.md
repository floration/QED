# QED-E225 — Is the hat-tiling spectrum a Cantor set?

You are an AI model helping someone attack this open problem. Read all of this before working.

## The problem
Extended set · Grade C · QED Original · Physics

**Plain words:** Put a quantum particle on the vertices of a hat tiling, hopping along tile edges with equal amplitude. Decide whether the set of allowed energies is a Cantor set (closed, with no intervals); if it is, decide whether it has Lebesgue measure zero.

**Math:** Let $\mathcal T$ be a tiling of $\mathbb R^2$ by isometric copies (reflections allowed) of the Smith--Myers--Kaplan--Goodman-Strauss hat, and let $G_{\mathcal T}$ be its vertex--edge graph (vertices: the 13 polygon corners of each tile; edges: the boundary segments between consecutive vertices). Let $A_{\mathcal T}$ be the adjacency operator on $\ell^2(V(G_{\mathcal T}))$ and $\Sigma_{\mathcal T}$ its spectrum (expected to be independent of $\mathcal T$ by minimality of the hull). (a) Decide whether $\Sigma_{\mathcal T}$ is nowhere dense, i.e. contains no interval, for every hat tiling $\mathcal T$. (b) If so, decide whether $|\Sigma_{\mathcal T}|=0$.

**Credit:** QED original (archived Nov 2026, restored after re-review).

**References:**
- https://arxiv.org/abs/2307.11054
- https://arxiv.org/abs/2303.10798

Difficulty estimate: 6.0/10 (anchored scale: 1 ≈ Erdős–Ginzburg–Ziv, 2.5 ≈ the sensitivity conjecture, 5 ≈ bounded prime gaps, 7.5 ≈ the Riemann Hypothesis, 10 ≈ P vs NP). It is believed open; do not assume a quick answer exists, and say so plainly if you cannot make progress. Never present a heuristic, numerical evidence, or a partial result as a solution.

## What counts as an answer
Either a proof of `OpenProblems.QEDE225.Claim` or a proof of `¬ OpenProblems.QEDE225.Claim` (a disproof), in Lean 4 + Mathlib, using the exact statement in `problems/QED-E225/Statement.lean`. Read its "Formalization notes" first. If that file still says `def Claim : Prop := sorry`, the problem must first be formalized (see CONTRIBUTING.md); a faithful formalization is itself a welcome contribution.

If you think the Lean statement does not match the informal problem (it is trivially true or false, or it says something else), report that in an issue instead of exploiting it: such solutions are not credited.

## How to submit
0. First time? Solve a test problem (QED-Q1, the 2-line one, at minimum) and submit it, to confirm your Lean setup and the submission pipeline work before spending effort here. Skip this step if this IS a test problem.
1. Claim it (optional but encouraged): open an issue titled `Claim QED-E225` at https://github.com/floration/qed/issues/new?template=claim.yml. Comment on it at least once a week or the claim lapses.
2. Add `solutions/QED-E225/<github-username>/Solution.lean`:
```lean
import Mathlib
-- do NOT redefine Claim: CI prepends problems/QED-E225/Statement.lean to your file
theorem solution : OpenProblems.QEDE225.Claim := by   -- or ¬ OpenProblems.QEDE225.Claim
  ...
```
   Large proofs may add more `.lean` files (subfolders allowed) next to Solution.lean; CI concatenates them in path order before Solution.lean. Don't import them.
3. Add `solutions/QED-E225/<github-username>/meta.json`: `{"model": "<AI model used, or none>", "kind": "proof" | "disproof"}`. Optionally a `README.md` explaining the idea.
4. Open a pull request. CI checks: it compiles, no `sorry`/`admit`/new `axiom`/`set_option` tricks, and `#print axioms solution` shows only `propext`, `Classical.choice`, `Quot.sound`.

## Scoring
Size = number of non-blank, non-comment lines of `Solution.lean` excluding `import` lines (helper lemmas count). First verified solution is credited permanently; any later, strictly smaller verified solution becomes the "smallest solution".

## Rules for you, the model
- Do not modify `Statement.lean` in a solution PR.
- Be honest about uncertainty; if a step is unproven, leave it out rather than sneak in `sorry`.
- Test locally: `lake exe cache get && lake env lean solutions/QED-E225/<user>/Solution.lean`.
