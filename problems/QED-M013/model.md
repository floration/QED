# QED-M013 — Spikes at the primes

You are an AI model helping someone attack this open problem. Read all of this before working.

## The problem
Main set · Grade B · QED Curated · Analysis

**Plain words:** Put a bump of fixed height at every prime on the half-line lattice and study the electron (discrete Schrodinger operator). What kind of spectrum does it have inside the free band (-2,2)? If the primes behaved like a random sparse set (Cramer model), the states would be localized (pure point spectrum); is that true for the actual primes?

**Math:** Let $(Hu)(n)=u(n+1)+u(n-1)+\lambda\mathbf 1_{\mathbb P}(n)u(n)$ on $\ell^2(\mathbb N)$ with Dirichlet condition $u(0)=0$, $\lambda\ne0$. Determine the spectral type of $H$ on $(-2,2)$. In particular: is the spectral measure restricted to $(-2,2)$ pure point (with exponentially or sub-exponentially decaying eigenfunctions), or does it have a singular continuous part, e.g. near $E=0$?

**Credit:** C. R. de Oliveira and G. Q. Pellegrino, '(De)Localization in the Prime Schrodinger Operator', 2001, arXiv:cond-mat/0103313.

**References:**
- https://arxiv.org/abs/cond-mat/0103313
- https://ar5iv.arxiv.org/html/cond-mat/0103313
- https://arxiv.org/pdf/1107.1094
- https://arxiv.org/abs/1012.5217

Difficulty estimate: 5.5/10 (calibrated: Collatz ≈ 5.5, twin primes ≈ 5.0). It is believed open; do not assume a quick answer exists, and say so plainly if you cannot make progress. Never present a heuristic, numerical evidence, or a partial result as a solution.

## What counts as an answer
Either a proof of `OpenProblems.QEDM013.Claim` or a proof of `¬ OpenProblems.QEDM013.Claim` (a disproof), in Lean 4 + Mathlib, using the exact statement in `problems/QED-M013/Statement.lean`. Read its "Formalization notes" first. If that file still says `def Claim : Prop := sorry`, the problem must first be formalized (see CONTRIBUTING.md); a faithful formalization is itself a welcome contribution.

If you think the Lean statement does not match the informal problem (it is trivially true or false, or it says something else), report that in an issue instead of exploiting it: such solutions are not credited.

## How to submit
1. Claim it (optional but encouraged): open an issue titled `Claim QED-M013` at https://github.com/floration/qed/issues/new?template=claim.yml. Comment on it at least once a week or the claim lapses.
2. Add `solutions/QED-M013/<github-username>/Solution.lean`:
```lean
import Mathlib
-- do NOT redefine Claim: CI prepends problems/QED-M013/Statement.lean to your file
theorem solution : OpenProblems.QEDM013.Claim := by   -- or ¬ OpenProblems.QEDM013.Claim
  ...
```
   Large proofs may add more `.lean` files (subfolders allowed) next to Solution.lean; CI concatenates them in path order before Solution.lean. Don't import them.
3. Add `solutions/QED-M013/<github-username>/meta.json`: `{"model": "<AI model used, or none>", "kind": "proof" | "disproof"}`. Optionally a `README.md` explaining the idea.
4. Open a pull request. CI checks: it compiles, no `sorry`/`admit`/new `axiom`/`set_option` tricks, and `#print axioms solution` shows only `propext`, `Classical.choice`, `Quot.sound`.

## Scoring
Size = number of non-blank, non-comment lines of `Solution.lean` excluding `import` lines (helper lemmas count). First verified solution is credited permanently; any later, strictly smaller verified solution becomes the "smallest solution".

## Rules for you, the model
- Do not modify `Statement.lean` in a solution PR.
- Be honest about uncertainty; if a step is unproven, leave it out rather than sneak in `sorry`.
- Test locally: `lake exe cache get && lake env lean solutions/QED-M013/<user>/Solution.lean`.
