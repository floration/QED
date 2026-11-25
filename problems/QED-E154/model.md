# QED-E154 — Are the fractional parts of (3/2)^n dense?

You are an AI model helping someone attack this open problem. Read all of this before working.

## The problem
Extended set · Grade A · QED Curated · Analysis

**Plain words:** Write down 3/2, 9/4, 27/8, ... and keep only the part after the decimal point. Numerically these fractional parts look uniformly spread over [0,1), but nobody can prove they even come arbitrarily close to every number in [0,1]. Prove that they do.

**Math:** Prove that $\{ \{(3/2)^n\} : n \in \mathbb{N}\}$ is dense in $[0,1]$, where $\{t\} = t - \lfloor t \rfloor$.

**Credit:** Classical (Vijayaraghavan, Mahler, Flatto-Lagarias-Pollington)

**Rests on recent unrefereed work. Check these premises first:**
- Area is borderline: this is uniform distribution / Diophantine analysis rather than core dynamics.
- Famous and extremely hard (low novelty). It should not be confused with the named Mahler Z-number problem, which is related but separate.

**References:**
- https://eudml.org/doc/206742
- https://arxiv.org/abs/2603.16794
- https://arxiv.org/abs/2411.03468v2
- https://en.wikipedia.org/wiki/Mahler%27s_3/2_problem

Difficulty estimate: 9.0/10 (anchored scale: 1 ≈ Erdős–Ginzburg–Ziv, 2.5 ≈ the sensitivity conjecture, 5 ≈ bounded prime gaps, 7.5 ≈ the Riemann Hypothesis, 10 ≈ P vs NP). It is believed open; do not assume a quick answer exists, and say so plainly if you cannot make progress. Never present a heuristic, numerical evidence, or a partial result as a solution.

## What counts as an answer
Either a proof of `OpenProblems.QEDE154.Claim` or a proof of `¬ OpenProblems.QEDE154.Claim` (a disproof), in Lean 4 + Mathlib, using the exact statement in `problems/QED-E154/Statement.lean`. Read its "Formalization notes" first. If that file still says `def Claim : Prop := sorry`, the problem must first be formalized (see CONTRIBUTING.md); a faithful formalization is itself a welcome contribution.

If you think the Lean statement does not match the informal problem (it is trivially true or false, or it says something else), report that in an issue instead of exploiting it: such solutions are not credited.

## How to submit
0. First time? Solve a test problem (QED-Q1, the 2-line one, at minimum) and submit it, to confirm your Lean setup and the submission pipeline work before spending effort here. Skip this step if this IS a test problem.
1. Claim it (optional but encouraged): open an issue titled `Claim QED-E154` at https://github.com/floration/qed/issues/new?template=claim.yml. Comment on it at least once a week or the claim lapses.
2. Add `solutions/QED-E154/<github-username>/Solution.lean`:
```lean
import Mathlib
-- do NOT redefine Claim: CI prepends problems/QED-E154/Statement.lean to your file
theorem solution : OpenProblems.QEDE154.Claim := by   -- or ¬ OpenProblems.QEDE154.Claim
  ...
```
   Large proofs may add more `.lean` files (subfolders allowed) next to Solution.lean; CI concatenates them in path order before Solution.lean. Don't import them.
3. Add `solutions/QED-E154/<github-username>/meta.json`: `{"model": "<AI model used, or none>", "kind": "proof" | "disproof"}`. Optionally a `README.md` explaining the idea.
4. Open a pull request. CI checks: it compiles, no `sorry`/`admit`/new `axiom`/`set_option` tricks, and `#print axioms solution` shows only `propext`, `Classical.choice`, `Quot.sound`.

## Scoring
Size = number of non-blank, non-comment lines of `Solution.lean` excluding `import` lines (helper lemmas count). First verified solution is credited permanently; any later, strictly smaller verified solution becomes the "smallest solution".

## Rules for you, the model
- Do not modify `Statement.lean` in a solution PR.
- Be honest about uncertainty; if a step is unproven, leave it out rather than sneak in `sorry`.
- Test locally: `lake exe cache get && lake env lean solutions/QED-E154/<user>/Solution.lean`.
