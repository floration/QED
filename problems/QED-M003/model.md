# QED-M003 — Singularities of the permanental hypersurface

You are an AI model helping someone attack this open problem. Read all of this before working.

## The problem
Main set · Grade B · QED Original · Algebra

**Plain words:** The hypersurface where the n x n determinant vanishes has rational singularities, the mildest kind that matters for much of its geometry. Decide whether the hypersurface where the n x n permanent vanishes has rational singularities for every n, and compute its minimal exponent, a finer measure of how mild a singularity is.

**Math:** Let $X_n=\{\operatorname{per}_n=0\}\subset\mathbb A^{n^2}_{\mathbb C}$ and let $\tilde\alpha(X_n)$ be Saito's minimal exponent (the smallest root of $b_{\operatorname{per}_n}(-s)/(1-s)$), so that $\operatorname{lct}(\mathbb A^{n^2},X_n)=\min\{1,\tilde\alpha(X_n)\}$ and $X_n$ has rational singularities iff $\tilde\alpha(X_n)>1$. For $n=2$, $X_2$ is a nondegenerate quadric cone in $\mathbb A^4$ and $\tilde\alpha=2$. For $\det_n$ the Bernstein--Sato polynomial is $\prod_{i=1}^n(s+i)$, so $\tilde\alpha(\{\det_n=0\})=2$ for all $n$. Determine $\tilde\alpha(X_n)$ for all $n\ge3$ (in particular for $n=3$), and decide whether $X_n$ has rational singularities for every $n$. Note: restricting to a generic linear subspace of dimension $r=\operatorname{codim}\operatorname{Sing}(X_n)$ gives an isolated homogeneous singularity, so $\tilde\alpha(X_n)\ge r/n$. Since $6\le r\le 2n$ is known and $r=2n$ is conjectured, that conjecture would give $\tilde\alpha(X_n)\ge2$ and rational singularities. Sharpened question: is $\tilde\alpha(X_n)=2$ for all $n$, or does $\tilde\alpha(X_n)\to\infty$?

**Rests on recent unrefereed work. Check these premises first:**
- arXiv:2603.15579 (2026 preprint) is listed in refs and may be the source of the current Sing-codimension bounds (6 <= r <= 2n) quoted in M; these are not used by Claim.

**References:**
- https://arxiv.org/abs/2402.17839
- https://arxiv.org/html/2603.15579v1
- https://arxiv.org/pdf/2105.01245

Difficulty estimate: 3.0/10 (calibrated: Collatz ≈ 5.5, twin primes ≈ 5.0). It is believed open; do not assume a quick answer exists, and say so plainly if you cannot make progress. Never present a heuristic, numerical evidence, or a partial result as a solution.

## What counts as an answer
Either a proof of `OpenProblems.QEDM003.Claim` or a proof of `¬ OpenProblems.QEDM003.Claim` (a disproof), in Lean 4 + Mathlib, using the exact statement in `problems/QED-M003/Statement.lean`. Read its "Formalization notes" first. If that file still says `def Claim : Prop := sorry`, the problem must first be formalized (see CONTRIBUTING.md); a faithful formalization is itself a welcome contribution.

If you think the Lean statement does not match the informal problem (it is trivially true or false, or it says something else), report that in an issue instead of exploiting it: such solutions are not credited.

## How to submit
1. Claim it (optional but encouraged): open an issue titled `Claim QED-M003` at https://github.com/floration/qed/issues/new?template=claim.yml. Comment on it at least once a week or the claim lapses.
2. Add `solutions/QED-M003/<github-username>/Solution.lean`:
```lean
import Mathlib
-- do NOT redefine Claim: CI prepends problems/QED-M003/Statement.lean to your file
theorem solution : OpenProblems.QEDM003.Claim := by   -- or ¬ OpenProblems.QEDM003.Claim
  ...
```
   Large proofs may add more `.lean` files (subfolders allowed) next to Solution.lean; CI concatenates them in path order before Solution.lean. Don't import them.
3. Add `solutions/QED-M003/<github-username>/meta.json`: `{"model": "<AI model used, or none>", "kind": "proof" | "disproof"}`. Optionally a `README.md` explaining the idea.
4. Open a pull request. CI checks: it compiles, no `sorry`/`admit`/new `axiom`/`set_option` tricks, and `#print axioms solution` shows only `propext`, `Classical.choice`, `Quot.sound`.

## Scoring
Size = number of non-blank, non-comment lines of `Solution.lean` excluding `import` lines (helper lemmas count). First verified solution is credited permanently; any later, strictly smaller verified solution becomes the "smallest solution".

## Rules for you, the model
- Do not modify `Statement.lean` in a solution PR.
- Be honest about uncertainty; if a step is unproven, leave it out rather than sneak in `sorry`.
- Test locally: `lake exe cache get && lake env lean solutions/QED-M003/<user>/Solution.lean`.
