# QED-E175 — Two equal sums of two fifth powers

You are an AI model helping someone attack this open problem. Read all of this before working.

## The problem
Extended set · Grade B · QED Curated · Number theory

**Plain words:** 1729 = 1^3+12^3 = 9^3+10^3 and 635318657 = 59^4+158^4 = 133^4+134^4 show that sums of two cubes or two fourth powers can coincide in a nontrivial way. For fifth powers no example is known, and none exists with sum below about 10^26. Find positive integers with a^5+b^5 = c^5+d^5 other than the trivial rearrangements, or prove that none exist.

**Math:** Decide whether there exist $a,b,c,d\in\mathbb{Z}_{>0}$ with $a^5+b^5=c^5+d^5$ and $\{a,b\}\ne\{c,d\}$.

**Credit:** Classical (Euler; R. K. Guy, Unsolved Problems in Number Theory, D1).

**Rests on recent unrefereed work. Check these premises first:**
- Could be settled purely by a lucky computer search (lesson 5) — but it is a recognised open problem with refereed search bounds (Ekl 1998, Bernstein 2001), and nonexistence would need real ideas
- Already in a public Lean open-statement collection: lower novelty
- Exact search bound 1.02e26 is from Guy as quoted by MathWorld; more recent unpublished searches may go further

**References:**
- https://en.wikipedia.org/wiki/Generalized_taxicab_number
- https://mathworld.wolfram.com/DiophantineEquation5thPowers.html
- https://www.ams.org/mcom/2001-70-233/S0025-5718-00-01219-9/
- https://arxiv.org/abs/2512.00551
- https://arxiv.org/abs/2512.11072

Difficulty estimate: 8.5/10 (anchored scale: 1 ≈ Erdős–Ginzburg–Ziv, 2.5 ≈ the sensitivity conjecture, 5 ≈ bounded prime gaps, 7.5 ≈ the Riemann Hypothesis, 10 ≈ P vs NP). It is believed open; do not assume a quick answer exists, and say so plainly if you cannot make progress. Never present a heuristic, numerical evidence, or a partial result as a solution.

## What counts as an answer
Either a proof of `OpenProblems.QEDE175.Claim` or a proof of `¬ OpenProblems.QEDE175.Claim` (a disproof), in Lean 4 + Mathlib, using the exact statement in `problems/QED-E175/Statement.lean`. Read its "Formalization notes" first. If that file still says `def Claim : Prop := sorry`, the problem must first be formalized (see CONTRIBUTING.md); a faithful formalization is itself a welcome contribution.

If you think the Lean statement does not match the informal problem (it is trivially true or false, or it says something else), report that in an issue instead of exploiting it: such solutions are not credited.

## How to submit
0. First time? Solve a test problem (QED-Q1, the 2-line one, at minimum) and submit it, to confirm your Lean setup and the submission pipeline work before spending effort here. Skip this step if this IS a test problem.
1. Claim it (optional but encouraged): open an issue titled `Claim QED-E175` at https://github.com/floration/qed/issues/new?template=claim.yml. Comment on it at least once a week or the claim lapses.
2. Add `solutions/QED-E175/<github-username>/Solution.lean`:
```lean
import Mathlib
-- do NOT redefine Claim: CI prepends problems/QED-E175/Statement.lean to your file
theorem solution : OpenProblems.QEDE175.Claim := by   -- or ¬ OpenProblems.QEDE175.Claim
  ...
```
   Large proofs may add more `.lean` files (subfolders allowed) next to Solution.lean; CI concatenates them in path order before Solution.lean. Don't import them.
3. Add `solutions/QED-E175/<github-username>/meta.json`: `{"model": "<AI model used, or none>", "kind": "proof" | "disproof"}`. Optionally a `README.md` explaining the idea.
4. Open a pull request. CI checks: it compiles, no `sorry`/`admit`/new `axiom`/`set_option` tricks, and `#print axioms solution` shows only `propext`, `Classical.choice`, `Quot.sound`.

## Scoring
Size = number of non-blank, non-comment lines of `Solution.lean` excluding `import` lines (helper lemmas count). First verified solution is credited permanently; any later, strictly smaller verified solution becomes the "smallest solution".

## Rules for you, the model
- Do not modify `Statement.lean` in a solution PR.
- Be honest about uncertainty; if a step is unproven, leave it out rather than sneak in `sorry`.
- Test locally: `lake exe cache get && lake env lean solutions/QED-E175/<user>/Solution.lean`.
