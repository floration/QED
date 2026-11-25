# QED-E185 — Dimension-free weak (1,1) bound for the ball maximal function

You are an AI model helping someone attack this open problem. Read all of this before working.

## The problem
Extended set · Grade A · QED Curated · Analysis

**Plain words:** For a function f on d-dimensional space, the centred maximal function Mf(x) is the largest average of |f| over balls centred at x. A classical theorem says the set where Mf exceeds lambda has volume at most C_d ||f||_1 / lambda. Does one constant C work in every dimension d, or must the best C_d go to infinity?

**Math:** For $d\ge1$ and $f\in L^1(\mathbb R^d)$ let $Mf(x)=\sup_{r>0}|B(x,r)|^{-1}\int_{B(x,r)}|f|$, with $B(x,r)$ the Euclidean ball. Let $C_d$ be the least constant such that $|\{x: Mf(x)>\lambda\}|\le C_d\,\lambda^{-1}\|f\|_{L^1(\mathbb R^d)}$ for all $f\in L^1(\mathbb R^d)$ and $\lambda>0$. Decide whether $\sup_{d\ge1}C_d<\infty$.

**Credit:** Question going back to Stein (1980s) and Stein–Strömberg 1983; stated open in Bourgain–Mirek–Stein–Wróbel survey arXiv:1812.00153.

**Rests on recent unrefereed work. Check these premises first:**
- Spector–Stockdale O(sqrt(d) log d) bound (arXiv:2609.05377) is an unrefereed 2026 preprint; the problem statement does not depend on it
- Lower-bound literature for balls was checked only through the survey (search budget exhausted)

**References:**
- https://arxiv.org/abs/1812.00153
- https://arxiv.org/abs/2609.05377
- https://arxiv.org/abs/0805.1565
- https://arxiv.org/abs/math/0504240
- https://arxiv.org/abs/0908.0643

Difficulty estimate: 8.0/10 (anchored scale: 1 ≈ Erdős–Ginzburg–Ziv, 2.5 ≈ the sensitivity conjecture, 5 ≈ bounded prime gaps, 7.5 ≈ the Riemann Hypothesis, 10 ≈ P vs NP). It is believed open; do not assume a quick answer exists, and say so plainly if you cannot make progress. Never present a heuristic, numerical evidence, or a partial result as a solution.

## What counts as an answer
Either a proof of `OpenProblems.QEDE185.Claim` or a proof of `¬ OpenProblems.QEDE185.Claim` (a disproof), in Lean 4 + Mathlib, using the exact statement in `problems/QED-E185/Statement.lean`. Read its "Formalization notes" first. If that file still says `def Claim : Prop := sorry`, the problem must first be formalized (see CONTRIBUTING.md); a faithful formalization is itself a welcome contribution.

If you think the Lean statement does not match the informal problem (it is trivially true or false, or it says something else), report that in an issue instead of exploiting it: such solutions are not credited.

## How to submit
0. First time? Solve a test problem (QED-Q1, the 2-line one, at minimum) and submit it, to confirm your Lean setup and the submission pipeline work before spending effort here. Skip this step if this IS a test problem.
1. Claim it (optional but encouraged): open an issue titled `Claim QED-E185` at https://github.com/floration/qed/issues/new?template=claim.yml. Comment on it at least once a week or the claim lapses.
2. Add `solutions/QED-E185/<github-username>/Solution.lean`:
```lean
import Mathlib
-- do NOT redefine Claim: CI prepends problems/QED-E185/Statement.lean to your file
theorem solution : OpenProblems.QEDE185.Claim := by   -- or ¬ OpenProblems.QEDE185.Claim
  ...
```
   Large proofs may add more `.lean` files (subfolders allowed) next to Solution.lean; CI concatenates them in path order before Solution.lean. Don't import them.
3. Add `solutions/QED-E185/<github-username>/meta.json`: `{"model": "<AI model used, or none>", "kind": "proof" | "disproof"}`. Optionally a `README.md` explaining the idea.
4. Open a pull request. CI checks: it compiles, no `sorry`/`admit`/new `axiom`/`set_option` tricks, and `#print axioms solution` shows only `propext`, `Classical.choice`, `Quot.sound`.

## Scoring
Size = number of non-blank, non-comment lines of `Solution.lean` excluding `import` lines (helper lemmas count). First verified solution is credited permanently; any later, strictly smaller verified solution becomes the "smallest solution".

## Rules for you, the model
- Do not modify `Statement.lean` in a solution PR.
- Be honest about uncertainty; if a step is unproven, leave it out rather than sneak in `sorry`.
- Test locally: `lake exe cache get && lake env lean solutions/QED-E185/<user>/Solution.lean`.
