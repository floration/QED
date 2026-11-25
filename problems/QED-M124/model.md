# QED-M124 — The 1/3–2/3 conjecture for width-three posets

You are an AI model helping someone attack this open problem. Read all of this before working.

## The problem
Main set · Grade A · QED Extension · Combinatorics

**Plain words:** Take a finite partial order and pick one of its linear extensions (total orders compatible with it) uniformly at random. The 1/3–2/3 conjecture says that, unless the order is already total, some pair x, y has probability between 1/3 and 2/3 that x comes before y. It is known for width 2 (no three pairwise incomparable elements) and, since 2026, for all posets of width above some unspecified constant. Prove it for every poset of width 3.

**Math:** For a finite poset $P$, let $e(P)$ be its number of linear extensions and, for $x\ne y$, let $p(x\prec y)$ be the fraction of linear extensions in which $x$ precedes $y$. Prove that every finite poset of width exactly $3$ contains $x,y$ with $\tfrac13\le p(x\prec y)\le\tfrac23$.

**Credit:** 1/3–2/3 conjecture: S. S. Kislitsyn (1968), M. Fredman (1975), N. Linial (1984); width-3 subcase singled out as the first open bounded-width case after the 2026 large-width results of Aires, Chan, Kahn, Pak, Panova.

**Rests on recent unrefereed work. Check these premises first:**
- The 'large width is settled' framing rests on unrefereed 2026 preprints (Aires; Aires-Chan-Pak-Panova); the width-3 question itself is open independent of them
- Must double-check no explicit-threshold bounded-width result (e.g. in arXiv:2609.30888 Thm 1.5 or 2510.26134) covers width 3 with all ranges

**References:**
- https://arxiv.org/abs/2609.30888
- https://arxiv.org/abs/2509.11549
- https://arxiv.org/abs/2510.26134
- https://en.wikipedia.org/wiki/1/3%E2%80%932/3_conjecture
- https://arxiv.org/abs/1706.04985

Difficulty estimate: 5.0/10 (calibrated: Collatz ≈ 5.5, twin primes ≈ 5.0). It is believed open; do not assume a quick answer exists, and say so plainly if you cannot make progress. Never present a heuristic, numerical evidence, or a partial result as a solution.

## What counts as an answer
Either a proof of `OpenProblems.QEDM124.Claim` or a proof of `¬ OpenProblems.QEDM124.Claim` (a disproof), in Lean 4 + Mathlib, using the exact statement in `problems/QED-M124/Statement.lean`. Read its "Formalization notes" first. If that file still says `def Claim : Prop := sorry`, the problem must first be formalized (see CONTRIBUTING.md); a faithful formalization is itself a welcome contribution.

If you think the Lean statement does not match the informal problem (it is trivially true or false, or it says something else), report that in an issue instead of exploiting it: such solutions are not credited.

## How to submit
0. First time? Solve a test problem (QED-Q1, the 2-line one, at minimum) and submit it, to confirm your Lean setup and the submission pipeline work before spending effort here. Skip this step if this IS a test problem.
1. Claim it (optional but encouraged): open an issue titled `Claim QED-M124` at https://github.com/floration/qed/issues/new?template=claim.yml. Comment on it at least once a week or the claim lapses.
2. Add `solutions/QED-M124/<github-username>/Solution.lean`:
```lean
import Mathlib
-- do NOT redefine Claim: CI prepends problems/QED-M124/Statement.lean to your file
theorem solution : OpenProblems.QEDM124.Claim := by   -- or ¬ OpenProblems.QEDM124.Claim
  ...
```
   Large proofs may add more `.lean` files (subfolders allowed) next to Solution.lean; CI concatenates them in path order before Solution.lean. Don't import them.
3. Add `solutions/QED-M124/<github-username>/meta.json`: `{"model": "<AI model used, or none>", "kind": "proof" | "disproof"}`. Optionally a `README.md` explaining the idea.
4. Open a pull request. CI checks: it compiles, no `sorry`/`admit`/new `axiom`/`set_option` tricks, and `#print axioms solution` shows only `propext`, `Classical.choice`, `Quot.sound`.

## Scoring
Size = number of non-blank, non-comment lines of `Solution.lean` excluding `import` lines (helper lemmas count). First verified solution is credited permanently; any later, strictly smaller verified solution becomes the "smallest solution".

## Rules for you, the model
- Do not modify `Statement.lean` in a solution PR.
- Be honest about uncertainty; if a step is unproven, leave it out rather than sneak in `sorry`.
- Test locally: `lake exe cache get && lake env lean solutions/QED-M124/<user>/Solution.lean`.
