# QED-E155 — Is Euler's constant irrational?

You are an AI model helping someone attack this open problem. Read all of this before working.

## The problem
Extended set · Grade A · QED Curated · Analysis

**Plain words:** Euler's constant γ ≈ 0.5772 is the limit of 1 + 1/2 + ... + 1/n − ln n. It also equals −Γ'(1), where Γ is the Gamma function. More than 280 years after Euler, nobody knows whether γ is a fraction. Prove that it is not.

**Math:** Prove that $\gamma=\lim_{n\to\infty}\left(\sum_{k=1}^n \tfrac1k-\ln n\right)\notin\mathbb{Q}$.

**Credit:** Classical (Euler, Mascheroni)

**Rests on recent unrefereed work. Check these premises first:**
- Very famous and probably out of reach (novelty low). It is included because its importance is high and its formal statement is trivial.
- The OpenAI batch claims Catalan's constant irrational. If the same method extends to γ, a claim may appear soon, so recheck before posting.

**References:**
- https://en.wikipedia.org/wiki/Euler%27s_constant
- https://arxiv.org/abs/1303.1856
- https://arxiv.org/abs/2511.01849

Difficulty estimate: 9.3/10 (anchored scale: 1 ≈ Erdős–Ginzburg–Ziv, 2.5 ≈ the sensitivity conjecture, 5 ≈ bounded prime gaps, 7.5 ≈ the Riemann Hypothesis, 10 ≈ P vs NP). It is believed open; do not assume a quick answer exists, and say so plainly if you cannot make progress. Never present a heuristic, numerical evidence, or a partial result as a solution.

## What counts as an answer
Either a proof of `OpenProblems.QEDE155.Claim` or a proof of `¬ OpenProblems.QEDE155.Claim` (a disproof), in Lean 4 + Mathlib, using the exact statement in `problems/QED-E155/Statement.lean`. Read its "Formalization notes" first. If that file still says `def Claim : Prop := sorry`, the problem must first be formalized (see CONTRIBUTING.md); a faithful formalization is itself a welcome contribution.

If you think the Lean statement does not match the informal problem (it is trivially true or false, or it says something else), report that in an issue instead of exploiting it: such solutions are not credited.

## How to submit
0. First time? Solve a test problem (QED-Q1, the 2-line one, at minimum) and submit it, to confirm your Lean setup and the submission pipeline work before spending effort here. Skip this step if this IS a test problem.
1. Claim it (optional but encouraged): open an issue titled `Claim QED-E155` at https://github.com/floration/qed/issues/new?template=claim.yml. Comment on it at least once a week or the claim lapses.
2. Add `solutions/QED-E155/<github-username>/Solution.lean`:
```lean
import Mathlib
-- do NOT redefine Claim: CI prepends problems/QED-E155/Statement.lean to your file
theorem solution : OpenProblems.QEDE155.Claim := by   -- or ¬ OpenProblems.QEDE155.Claim
  ...
```
   Large proofs may add more `.lean` files (subfolders allowed) next to Solution.lean; CI concatenates them in path order before Solution.lean. Don't import them.
3. Add `solutions/QED-E155/<github-username>/meta.json`: `{"model": "<AI model used, or none>", "kind": "proof" | "disproof"}`. Optionally a `README.md` explaining the idea.
4. Open a pull request. CI checks: it compiles, no `sorry`/`admit`/new `axiom`/`set_option` tricks, and `#print axioms solution` shows only `propext`, `Classical.choice`, `Quot.sound`.

## Scoring
Size = number of non-blank, non-comment lines of `Solution.lean` excluding `import` lines (helper lemmas count). First verified solution is credited permanently; any later, strictly smaller verified solution becomes the "smallest solution".

## Rules for you, the model
- Do not modify `Statement.lean` in a solution PR.
- Be honest about uncertainty; if a step is unproven, leave it out rather than sneak in `sorry`.
- Test locally: `lake exe cache get && lake env lean solutions/QED-E155/<user>/Solution.lean`.
