# QED-E020 — Thue–Morse Lorenz knots

You are an AI model helping someone attack this open problem. Read all of this before working.

## The problem
Extended set · Grade C · Topology

**Plain words:** Turn the first 2^n letters of the Thue–Morse word into a periodic orbit of the Lorenz flow, and so into a knot K_n. For n >= 4 these knots appear to be hyperbolic. Their volume grows only in proportion to n, the logarithm of the word length, not in proportion to the length itself. Prove that, and find the constant.

**Math:** Let $K_n$ be the Lorenz knot with Lorenz word $t_0t_1\cdots t_{2^n-1}$ (the length-$2^n$ Thue–Morse prefix, $0\mapsto x$, $1\mapsto y$; this word is primitive, since Thue–Morse is overlap-free and $t_{[0,2^n)}=w\bar w$). Prove that $S^3\setminus K_n$ is hyperbolic for all $n\ge4$ and that $\lim_{n\to\infty}\mathrm{vol}(S^3\setminus K_n)/n$ exists and is positive. Determine the limit.

**Reviewer note:** T

Difficulty estimate: 3.4/10 (calibrated: Collatz ≈ 5.5, twin primes ≈ 5.0). It is believed open; do not assume a quick answer exists, and say so plainly if you cannot make progress. Never present a heuristic, numerical evidence, or a partial result as a solution.

## What counts as an answer
Either a proof of `OpenProblems.QEDE020.Claim` or a proof of `¬ OpenProblems.QEDE020.Claim` (a disproof), in Lean 4 + Mathlib, using the exact statement in `problems/QED-E020/Statement.lean`. Read its "Formalization notes" first. If that file still says `def Claim : Prop := sorry`, the problem must first be formalized (see CONTRIBUTING.md); a faithful formalization is itself a welcome contribution.

If you think the Lean statement does not match the informal problem (it is trivially true or false, or it says something else), report that in an issue instead of exploiting it: such solutions are not credited.

## How to submit
0. First time? Solve a test problem (QED-Q1, the 2-line one, at minimum) and submit it, to confirm your Lean setup and the submission pipeline work before spending effort here. Skip this step if this IS a test problem.
1. Claim it (optional but encouraged): open an issue titled `Claim QED-E020` at https://github.com/floration/qed/issues/new?template=claim.yml. Comment on it at least once a week or the claim lapses.
2. Add `solutions/QED-E020/<github-username>/Solution.lean`:
```lean
import Mathlib
-- do NOT redefine Claim: CI prepends problems/QED-E020/Statement.lean to your file
theorem solution : OpenProblems.QEDE020.Claim := by   -- or ¬ OpenProblems.QEDE020.Claim
  ...
```
3. Add `solutions/QED-E020/<github-username>/meta.json`: `{"model": "<AI model used, or none>", "kind": "proof" | "disproof"}`. Optionally a `README.md` explaining the idea.
4. Open a pull request. CI checks: it compiles, no `sorry`/`admit`/new `axiom`/`set_option` tricks, and `#print axioms solution` shows only `propext`, `Classical.choice`, `Quot.sound`.

## Scoring
Size = number of non-blank, non-comment lines of `Solution.lean` excluding `import` lines (helper lemmas count). First verified solution is credited permanently; any later, strictly smaller verified solution becomes the "smallest solution".

## Rules for you, the model
- Do not modify `Statement.lean` in a solution PR.
- Be honest about uncertainty; if a step is unproven, leave it out rather than sneak in `sorry`.
- Test locally: `lake exe cache get && lake env lean solutions/QED-E020/<user>/Solution.lean`.
