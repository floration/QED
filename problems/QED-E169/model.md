# QED-E169 — Ehrhart positivity of the Birkhoff polytope

You are an AI model helping someone attack this open problem. Read all of this before working.

## The problem
Extended set · Grade B · QED Curated · Combinatorics

**Plain words:** Let H_n(t) be the number of n x n matrices of nonnegative integers whose rows and columns all sum to t (semi-magic squares). For fixed n, H_n(t) is a polynomial in t of degree (n-1)^2. Are all of its coefficients positive, for every n?

**Math:** Let $H_n(t)=\#\{A\in\mathbb Z_{\ge0}^{n\times n}:\ A\mathbf 1=A^{T}\mathbf 1=t\mathbf 1\}$, the Ehrhart polynomial of the Birkhoff polytope $B_n$. Prove or disprove: for every $n\ge1$, every coefficient of $t^i$ in $H_n(t)$, $0\le i\le (n-1)^2$, is strictly positive.

**Credit:** Conjecture attributed to R. Stanley; surveyed in F. Liu, 'On positivity of Ehrhart polynomials' (arXiv:1711.09962)

**Rests on recent unrefereed work. Check these premises first:**
- Naming: the survey attributes it to Stanley, and the Nov 2026 preprint calls a related leading-coefficient statement 'Stanley's conjecture'. The owner may treat this as person-named.
- Low novelty, since it is a well-known conjecture.
- The 2611.25973 asymptotic result is unrefereed and very recent; its full text was not read because of a rate limit.

**References:**
- https://arxiv.org/abs/1711.09962
- https://arxiv.org/abs/math/0202267
- https://arxiv.org/abs/2611.25973
- https://arxiv.org/abs/2307.10852

Difficulty estimate: 6.5/10 (anchored scale: 1 ≈ Erdős–Ginzburg–Ziv, 2.5 ≈ the sensitivity conjecture, 5 ≈ bounded prime gaps, 7.5 ≈ the Riemann Hypothesis, 10 ≈ P vs NP). It is believed open; do not assume a quick answer exists, and say so plainly if you cannot make progress. Never present a heuristic, numerical evidence, or a partial result as a solution.

## What counts as an answer
Either a proof of `OpenProblems.QEDE169.Claim` or a proof of `¬ OpenProblems.QEDE169.Claim` (a disproof), in Lean 4 + Mathlib, using the exact statement in `problems/QED-E169/Statement.lean`. Read its "Formalization notes" first. If that file still says `def Claim : Prop := sorry`, the problem must first be formalized (see CONTRIBUTING.md); a faithful formalization is itself a welcome contribution.

If you think the Lean statement does not match the informal problem (it is trivially true or false, or it says something else), report that in an issue instead of exploiting it: such solutions are not credited.

## How to submit
0. First time? Solve a test problem (QED-Q1, the 2-line one, at minimum) and submit it, to confirm your Lean setup and the submission pipeline work before spending effort here. Skip this step if this IS a test problem.
1. Claim it (optional but encouraged): open an issue titled `Claim QED-E169` at https://github.com/floration/qed/issues/new?template=claim.yml. Comment on it at least once a week or the claim lapses.
2. Add `solutions/QED-E169/<github-username>/Solution.lean`:
```lean
import Mathlib
-- do NOT redefine Claim: CI prepends problems/QED-E169/Statement.lean to your file
theorem solution : OpenProblems.QEDE169.Claim := by   -- or ¬ OpenProblems.QEDE169.Claim
  ...
```
   Large proofs may add more `.lean` files (subfolders allowed) next to Solution.lean; CI concatenates them in path order before Solution.lean. Don't import them.
3. Add `solutions/QED-E169/<github-username>/meta.json`: `{"model": "<AI model used, or none>", "kind": "proof" | "disproof"}`. Optionally a `README.md` explaining the idea.
4. Open a pull request. CI checks: it compiles, no `sorry`/`admit`/new `axiom`/`set_option` tricks, and `#print axioms solution` shows only `propext`, `Classical.choice`, `Quot.sound`.

## Scoring
Size = number of non-blank, non-comment lines of `Solution.lean` excluding `import` lines (helper lemmas count). First verified solution is credited permanently; any later, strictly smaller verified solution becomes the "smallest solution".

## Rules for you, the model
- Do not modify `Statement.lean` in a solution PR.
- Be honest about uncertainty; if a step is unproven, leave it out rather than sneak in `sorry`.
- Test locally: `lake exe cache get && lake env lean solutions/QED-E169/<user>/Solution.lean`.
