# QED-E142 — Three mutually orthogonal Latin squares of order 10

You are an AI model helping someone attack this open problem. Read all of this before working.

## The problem
Extended set · Grade A · QED Curated · Algebra

**Plain words:** Two Latin squares of the same size are orthogonal if, when you lay one on top of the other, every ordered pair of symbols appears exactly once. Euler's 36-officers problem shows no orthogonal pair exists for order 6, but orthogonal pairs of order 10 were found in 1959. Nobody knows whether three Latin squares of order 10 can be pairwise orthogonal.

**Math:** Let $N(n)$ be the maximum number of pairwise orthogonal Latin squares of order $n$. Decide whether $N(10)\ge 3$, i.e. whether there exist $L_1,L_2,L_3:[10]\times[10]\to[10]$, each a Latin square, such that for every $a\ne b$ the map $(i,j)\mapsto (L_a(i,j),L_b(i,j))$ is a bijection $[10]^2\to[10]^2$.

**Credit:** Classical. Recent work by Myrvold, McKay–Meynert–Myrvold, and the 2026 SAT study arXiv:2503.10504

**Rests on recent unrefereed work. Check these premises first:**
- A massive SAT/computer search could settle it at any time (SAT groups are actively working on it)
- Low novelty: very well known

**References:**
- https://www.combinatorics.org/ojs/index.php/eljc/article/view/v33i1p30
- https://arxiv.org/abs/2503.10504
- https://arxiv.org/pdf/2601.22205

Difficulty estimate: 7.0/10 (anchored scale: 1 ≈ Erdős–Ginzburg–Ziv, 2.5 ≈ the sensitivity conjecture, 5 ≈ bounded prime gaps, 7.5 ≈ the Riemann Hypothesis, 10 ≈ P vs NP). It is believed open; do not assume a quick answer exists, and say so plainly if you cannot make progress. Never present a heuristic, numerical evidence, or a partial result as a solution.

## What counts as an answer
Either a proof of `OpenProblems.QEDE142.Claim` or a proof of `¬ OpenProblems.QEDE142.Claim` (a disproof), in Lean 4 + Mathlib, using the exact statement in `problems/QED-E142/Statement.lean`. Read its "Formalization notes" first. If that file still says `def Claim : Prop := sorry`, the problem must first be formalized (see CONTRIBUTING.md); a faithful formalization is itself a welcome contribution.

If you think the Lean statement does not match the informal problem (it is trivially true or false, or it says something else), report that in an issue instead of exploiting it: such solutions are not credited.

## How to submit
0. First time? Solve a test problem (QED-Q1, the 2-line one, at minimum) and submit it, to confirm your Lean setup and the submission pipeline work before spending effort here. Skip this step if this IS a test problem.
1. Claim it (optional but encouraged): open an issue titled `Claim QED-E142` at https://github.com/floration/qed/issues/new?template=claim.yml. Comment on it at least once a week or the claim lapses.
2. Add `solutions/QED-E142/<github-username>/Solution.lean`:
```lean
import Mathlib
-- do NOT redefine Claim: CI prepends problems/QED-E142/Statement.lean to your file
theorem solution : OpenProblems.QEDE142.Claim := by   -- or ¬ OpenProblems.QEDE142.Claim
  ...
```
   Large proofs may add more `.lean` files (subfolders allowed) next to Solution.lean; CI concatenates them in path order before Solution.lean. Don't import them.
3. Add `solutions/QED-E142/<github-username>/meta.json`: `{"model": "<AI model used, or none>", "kind": "proof" | "disproof"}`. Optionally a `README.md` explaining the idea.
4. Open a pull request. CI checks: it compiles, no `sorry`/`admit`/new `axiom`/`set_option` tricks, and `#print axioms solution` shows only `propext`, `Classical.choice`, `Quot.sound`.

## Scoring
Size = number of non-blank, non-comment lines of `Solution.lean` excluding `import` lines (helper lemmas count). First verified solution is credited permanently; any later, strictly smaller verified solution becomes the "smallest solution".

## Rules for you, the model
- Do not modify `Statement.lean` in a solution PR.
- Be honest about uncertainty; if a step is unproven, leave it out rather than sneak in `sorry`.
- Test locally: `lake exe cache get && lake env lean solutions/QED-E142/<user>/Solution.lean`.
