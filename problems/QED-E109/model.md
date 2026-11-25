# QED-E109 — Liouville theorem for Lane-Emden with a shifted nonlinearity

You are an AI model helping someone attack this open problem. Read all of this before working.

## The problem
Extended set · Grade B · QED Original · PDE

**Plain words:** Gidas-Spruck: -Delta u = u^p has no positive solution on R^n for subcritical p. Replace u^p by the value of u^p at a shifted point x+e. Is there still no positive solution, for every subcritical p?

**Math:** Let $n\ge3$, $1<p<\frac{n+2}{n-2}$, $e\in\mathbb R^n\setminus\{0\}$. Prove or disprove: there is no positive $u\in C^2(\mathbb R^n)$ with $-\Delta u(x)=u(x+e)^p$ for all $x$. (For $1<p<\frac n{n-2}$ the standard Mitidieri–Pohozaev test-function argument applies, since the shift is negligible at large scales; the open range is $\frac n{n-2}\le p<\frac{n+2}{n-2}$. One may also ask whether positive solutions exist for $p\ge\frac{n+2}{n-2}$.)

**References:**
- https://www.arxiv.org/abs/1706.03467

Difficulty estimate: 3.0/10 (calibrated: Collatz ≈ 5.5, twin primes ≈ 5.0). It is believed open; do not assume a quick answer exists, and say so plainly if you cannot make progress. Never present a heuristic, numerical evidence, or a partial result as a solution.

## What counts as an answer
Either a proof of `OpenProblems.QEDE109.Claim` or a proof of `¬ OpenProblems.QEDE109.Claim` (a disproof), in Lean 4 + Mathlib, using the exact statement in `problems/QED-E109/Statement.lean`. Read its "Formalization notes" first. If that file still says `def Claim : Prop := sorry`, the problem must first be formalized (see CONTRIBUTING.md); a faithful formalization is itself a welcome contribution.

If you think the Lean statement does not match the informal problem (it is trivially true or false, or it says something else), report that in an issue instead of exploiting it: such solutions are not credited.

## How to submit
0. First time? Solve a test problem (QED-Q1, the 2-line one, at minimum) and submit it, to confirm your Lean setup and the submission pipeline work before spending effort here. Skip this step if this IS a test problem.
1. Claim it (optional but encouraged): open an issue titled `Claim QED-E109` at https://github.com/floration/qed/issues/new?template=claim.yml. Comment on it at least once a week or the claim lapses.
2. Add `solutions/QED-E109/<github-username>/Solution.lean`:
```lean
import Mathlib
-- do NOT redefine Claim: CI prepends problems/QED-E109/Statement.lean to your file
theorem solution : OpenProblems.QEDE109.Claim := by   -- or ¬ OpenProblems.QEDE109.Claim
  ...
```
   Large proofs may add more `.lean` files (subfolders allowed) next to Solution.lean; CI concatenates them in path order before Solution.lean. Don't import them.
3. Add `solutions/QED-E109/<github-username>/meta.json`: `{"model": "<AI model used, or none>", "kind": "proof" | "disproof"}`. Optionally a `README.md` explaining the idea.
4. Open a pull request. CI checks: it compiles, no `sorry`/`admit`/new `axiom`/`set_option` tricks, and `#print axioms solution` shows only `propext`, `Classical.choice`, `Quot.sound`.

## Scoring
Size = number of non-blank, non-comment lines of `Solution.lean` excluding `import` lines (helper lemmas count). First verified solution is credited permanently; any later, strictly smaller verified solution becomes the "smallest solution".

## Rules for you, the model
- Do not modify `Statement.lean` in a solution PR.
- Be honest about uncertainty; if a step is unproven, leave it out rather than sneak in `sorry`.
- Test locally: `lake exe cache get && lake env lean solutions/QED-E109/<user>/Solution.lean`.
