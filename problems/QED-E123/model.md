# QED-E123 — Threshold bias of the Maker-Breaker triangle game

You are an AI model helping someone attack this open problem. Read all of this before working.

## The problem
Extended set · Grade B · QED Curated · Games

**Plain words:** On the edges of the complete graph K_n, Maker claims one edge per turn and Breaker claims q edges per turn; Maker wins if she ever owns a triangle. Let q_0(n) be the smallest q for which Breaker wins. It is known that q_0(n) lies between about 1.414 sqrt(n) and 1.633 sqrt(n). What is the right constant, conjecturally sqrt(2)? As a concrete step, can either bound be improved by a constant factor?

**Math:** Let $q_0(n)$ be the least $q$ such that Breaker wins the $(1:q)$ Maker-Breaker triangle game on $E(K_n)$ (Maker first). Known: $(\sqrt2-o(1))\sqrt n\le q_0(n)\le(\sqrt{8/3}+o(1))\sqrt n$. Prove that one of the two bounds can be improved by a constant factor: either there is $c'<\sqrt{8/3}$ with $q_0(n)\le c'\sqrt n$ for all large $n$, or there is $\varepsilon>0$ with $q_0(n)\ge(\sqrt2+\varepsilon)\sqrt n$ for all large $n$.

**Credit:** Chvátal and Erdős (1978); Balogh–Samotij; Glazik–Srivastav

**Rests on recent unrefereed work. Check these premises first:**
- The game is often called the 'Chvátal–Erdős triangle game' (person-named object), but the constant question is not a named conjecture
- 'Improve either bound' form: both directions are hard, but scorer may prefer exact determination
- Supporting 2026 budget-variant result is an unrefereed preprint (context only)

**References:**
- https://arxiv.org/abs/1812.01382
- https://arxiv.org/abs/2609.38138
- https://arxiv.org/abs/2607.01294
- https://www.combinatorics.org/ojs/index.php/eljc/article/view/v18i1p72

Difficulty estimate: 6.0/10 (calibrated: Collatz ≈ 5.5, twin primes ≈ 5.0). It is believed open; do not assume a quick answer exists, and say so plainly if you cannot make progress. Never present a heuristic, numerical evidence, or a partial result as a solution.

## What counts as an answer
Either a proof of `OpenProblems.QEDE123.Claim` or a proof of `¬ OpenProblems.QEDE123.Claim` (a disproof), in Lean 4 + Mathlib, using the exact statement in `problems/QED-E123/Statement.lean`. Read its "Formalization notes" first. If that file still says `def Claim : Prop := sorry`, the problem must first be formalized (see CONTRIBUTING.md); a faithful formalization is itself a welcome contribution.

If you think the Lean statement does not match the informal problem (it is trivially true or false, or it says something else), report that in an issue instead of exploiting it: such solutions are not credited.

## How to submit
0. First time? Solve a test problem (QED-Q1, the 2-line one, at minimum) and submit it, to confirm your Lean setup and the submission pipeline work before spending effort here. Skip this step if this IS a test problem.
1. Claim it (optional but encouraged): open an issue titled `Claim QED-E123` at https://github.com/floration/qed/issues/new?template=claim.yml. Comment on it at least once a week or the claim lapses.
2. Add `solutions/QED-E123/<github-username>/Solution.lean`:
```lean
import Mathlib
-- do NOT redefine Claim: CI prepends problems/QED-E123/Statement.lean to your file
theorem solution : OpenProblems.QEDE123.Claim := by   -- or ¬ OpenProblems.QEDE123.Claim
  ...
```
   Large proofs may add more `.lean` files (subfolders allowed) next to Solution.lean; CI concatenates them in path order before Solution.lean. Don't import them.
3. Add `solutions/QED-E123/<github-username>/meta.json`: `{"model": "<AI model used, or none>", "kind": "proof" | "disproof"}`. Optionally a `README.md` explaining the idea.
4. Open a pull request. CI checks: it compiles, no `sorry`/`admit`/new `axiom`/`set_option` tricks, and `#print axioms solution` shows only `propext`, `Classical.choice`, `Quot.sound`.

## Scoring
Size = number of non-blank, non-comment lines of `Solution.lean` excluding `import` lines (helper lemmas count). First verified solution is credited permanently; any later, strictly smaller verified solution becomes the "smallest solution".

## Rules for you, the model
- Do not modify `Statement.lean` in a solution PR.
- Be honest about uncertainty; if a step is unproven, leave it out rather than sneak in `sorry`.
- Test locally: `lake exe cache get && lake env lean solutions/QED-E123/<user>/Solution.lean`.
