# QED-E125 — A subcubic bound for reset words

You are an AI model helping someone attack this open problem. Read all of this before working.

## The problem
Extended set · Grade A · QED Curated · Logic & computability

**Plain words:** A finite automaton is synchronizing if some input word sends every state to one and the same state; the shortest such word is called a reset word. For automata with n states the shortest reset word is conjectured to have length at most (n-1)^2, but the best proven bound is still about n^3/6. Prove any bound that is asymptotically smaller than n^3.

**Math:** For a complete DFA $\mathcal A=(Q,\Sigma,\delta)$ over a finite alphabet $\Sigma$, call $w\in\Sigma^*$ reset if $|\delta(Q,w)|=1$; let $\mathrm{rt}(\mathcal A)$ be the length of a shortest reset word, and $C(n)=\max\{\mathrm{rt}(\mathcal A): |Q|=n,\ \mathcal A\text{ synchronizing},\ \Sigma\text{ finite}\}$ (finite, since $\mathrm{rt}(\mathcal A)<2^n$). Prove $C(n)=o(n^3)$. (Known: $(n-1)^2\le C(n)\le(7/48+15625/798768)\,n^3+o(n^3)\approx0.1654\,n^3$.)

**Credit:** Unnamed weakening of the Černý conjecture; bounds by Pin, Frankl, Szykuła, Shitov.

**Rests on recent unrefereed work. Check these premises first:**
- Must ensure no 2026 preprint claims a subcubic or quadratic general bound (none found).
- Some may view it as a famous problem in disguise, but it is a strictly weaker, separately-stated open question.

**References:**
- https://arxiv.org/html/2508.15655v4
- https://arxiv.org/abs/1901.06542
- https://arxiv.org/abs/1702.05455
- https://arxiv.org/abs/2407.08135

Difficulty estimate: 7.0/10 (anchored scale: 1 ≈ Erdős–Ginzburg–Ziv, 2.5 ≈ the sensitivity conjecture, 5 ≈ bounded prime gaps, 7.5 ≈ the Riemann Hypothesis, 10 ≈ P vs NP). It is believed open; do not assume a quick answer exists, and say so plainly if you cannot make progress. Never present a heuristic, numerical evidence, or a partial result as a solution.

## What counts as an answer
Either a proof of `OpenProblems.QEDE125.Claim` or a proof of `¬ OpenProblems.QEDE125.Claim` (a disproof), in Lean 4 + Mathlib, using the exact statement in `problems/QED-E125/Statement.lean`. Read its "Formalization notes" first. If that file still says `def Claim : Prop := sorry`, the problem must first be formalized (see CONTRIBUTING.md); a faithful formalization is itself a welcome contribution.

If you think the Lean statement does not match the informal problem (it is trivially true or false, or it says something else), report that in an issue instead of exploiting it: such solutions are not credited.

## How to submit
0. First time? Solve a test problem (QED-Q1, the 2-line one, at minimum) and submit it, to confirm your Lean setup and the submission pipeline work before spending effort here. Skip this step if this IS a test problem.
1. Claim it (optional but encouraged): open an issue titled `Claim QED-E125` at https://github.com/floration/qed/issues/new?template=claim.yml. Comment on it at least once a week or the claim lapses.
2. Add `solutions/QED-E125/<github-username>/Solution.lean`:
```lean
import Mathlib
-- do NOT redefine Claim: CI prepends problems/QED-E125/Statement.lean to your file
theorem solution : OpenProblems.QEDE125.Claim := by   -- or ¬ OpenProblems.QEDE125.Claim
  ...
```
   Large proofs may add more `.lean` files (subfolders allowed) next to Solution.lean; CI concatenates them in path order before Solution.lean. Don't import them.
3. Add `solutions/QED-E125/<github-username>/meta.json`: `{"model": "<AI model used, or none>", "kind": "proof" | "disproof"}`. Optionally a `README.md` explaining the idea.
4. Open a pull request. CI checks: it compiles, no `sorry`/`admit`/new `axiom`/`set_option` tricks, and `#print axioms solution` shows only `propext`, `Classical.choice`, `Quot.sound`.

## Scoring
Size = number of non-blank, non-comment lines of `Solution.lean` excluding `import` lines (helper lemmas count). First verified solution is credited permanently; any later, strictly smaller verified solution becomes the "smallest solution".

## Rules for you, the model
- Do not modify `Statement.lean` in a solution PR.
- Be honest about uncertainty; if a step is unproven, leave it out rather than sneak in `sorry`.
- Test locally: `lake exe cache get && lake env lean solutions/QED-E125/<user>/Solution.lean`.
