# QED-E018 — Random Wang tiles

You are an AI model helping someone attack this open problem. Read all of this before working.

## The problem
Extended set · Grade C · Probability

**Plain words:** (Corrected.) Draw n Wang tiles whose four edge colours are chosen uniformly at random from c colours, and let c grow with n ≈ λc². How likely is the set to tile the plane? Show the probability has a limit F(λ) and find the critical λ above which tiling is almost certain.

**Math:** Let $T_1,\dots,T_n$ be i.i.d. Wang tiles, each with its four edge colours i.i.d. uniform in $[c]$ and no rotations allowed. Let $n=\lfloor\lambda c^2\rfloor$ and $c\to\infty$. Prove or disprove: $F(\lambda)=\lim_{c\to\infty}\Pr(\{T_i\}\text{ tiles }\mathbb Z^2)$ exists for every $\lambda>0$, and $\lambda_c=\inf\{\lambda:F(\lambda)=1\}=1$, i.e. $F(\lambda)=1$ for $\lambda>1$ and $F(\lambda)<1$ for $0<\lambda<1$ (as the first-moment heuristic suggests). Further goal: determine $F$ on $(0,\lambda_c)$.

**Reviewer note:** A

**QED results so far (reviewer-derived; check before relying on them):** Elementary partial result (external audit, Nov 2026): liminf_c tileProb >= 1-e^{-lambda}, since a tile with equal left/right and equal top/bottom colours tiles Z^2 alone, and each tile is such with probability 1/c^2. Tiling can occur without such a tile, so this is a lower bound only.

Difficulty estimate: 4.0/10 (anchored scale: 1 ≈ Erdős–Ginzburg–Ziv, 2.5 ≈ the sensitivity conjecture, 5 ≈ bounded prime gaps, 7.5 ≈ the Riemann Hypothesis, 10 ≈ P vs NP). It is believed open; do not assume a quick answer exists, and say so plainly if you cannot make progress. Never present a heuristic, numerical evidence, or a partial result as a solution.

## What counts as an answer
Either a proof of `OpenProblems.QEDE018.Claim` or a proof of `¬ OpenProblems.QEDE018.Claim` (a disproof), in Lean 4 + Mathlib, using the exact statement in `problems/QED-E018/Statement.lean`. Read its "Formalization notes" first. If that file still says `def Claim : Prop := sorry`, the problem must first be formalized (see CONTRIBUTING.md); a faithful formalization is itself a welcome contribution.

If you think the Lean statement does not match the informal problem (it is trivially true or false, or it says something else), report that in an issue instead of exploiting it: such solutions are not credited.

## How to submit
0. First time? Solve a test problem (QED-Q1, the 2-line one, at minimum) and submit it, to confirm your Lean setup and the submission pipeline work before spending effort here. Skip this step if this IS a test problem.
1. Claim it (optional but encouraged): open an issue titled `Claim QED-E018` at https://github.com/floration/qed/issues/new?template=claim.yml. Comment on it at least once a week or the claim lapses.
2. Add `solutions/QED-E018/<github-username>/Solution.lean`:
```lean
import Mathlib
-- do NOT redefine Claim: CI prepends problems/QED-E018/Statement.lean to your file
theorem solution : OpenProblems.QEDE018.Claim := by   -- or ¬ OpenProblems.QEDE018.Claim
  ...
```
   Large proofs may add more `.lean` files (subfolders allowed) next to Solution.lean; CI concatenates them in path order before Solution.lean. Don't import them.
3. Add `solutions/QED-E018/<github-username>/meta.json`: `{"model": "<AI model used, or none>", "kind": "proof" | "disproof"}`. Optionally a `README.md` explaining the idea.
4. Open a pull request. CI checks: it compiles, no `sorry`/`admit`/new `axiom`/`set_option` tricks, and `#print axioms solution` shows only `propext`, `Classical.choice`, `Quot.sound`.

## Scoring
Size = number of non-blank, non-comment lines of `Solution.lean` excluding `import` lines (helper lemmas count). First verified solution is credited permanently; any later, strictly smaller verified solution becomes the "smallest solution".

## Rules for you, the model
- Do not modify `Statement.lean` in a solution PR.
- Be honest about uncertainty; if a step is unproven, leave it out rather than sneak in `sorry`.
- Test locally: `lake exe cache get && lake env lean solutions/QED-E018/<user>/Solution.lean`.
