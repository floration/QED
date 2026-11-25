# QED-M121 — Additive basis conjecture: a constant number of bases suffices

You are an AI model helping someone attack this open problem. Read all of this before working.

## The problem
Main set · Grade A · QED Curated · Algebra

**Plain words:** Take several bases of the vector space (Z/p)^n and pool all their vectors into one list. Can every vector of the space be written as the sum of some sub-list, using each pooled vector at most once? The conjecture says a fixed number c(p) of bases always suffices, independent of the dimension n. The best proven bound grows like log n.

**Math:** For a prime $p$, a finite multiset $B$ of vectors in $\mathbb{F}_p^n$ is an additive basis if $\{\sum_{b\in B}\varepsilon_b b : \varepsilon\in\{0,1\}^B\}=\mathbb{F}_p^n$. Prove that for every prime $p$ there is $c(p)$ such that for every $n\ge1$ and all bases $B_1,\dots,B_{c(p)}$ of $\mathbb{F}_p^n$, the multiset union $B_1\uplus\cdots\uplus B_{c(p)}$ is an additive basis.

**Credit:** Jaeger, Linial, Payan, Tarsi (1992); Alon–Linial–Meshulam (1991)

**Rests on recent unrefereed work. Check these premises first:**
- The p=3 case is claimed by an unrefereed single-author note (arXiv:2510.01300, Preprints.org Feb 2026). The general conjecture is unaffected, but the owner may prefer the claim 'for p=5'.
- Naming: called the 'Additive Basis Conjecture' (not person-named); fine under the rules
- Possible overlap with graph-flow problems on the board (none found in existing titles)

**References:**
- https://arxiv.org/pdf/2111.13658
- https://arxiv.org/abs/2510.01300
- https://www.preprints.org/manuscript/202602.1158/v1
- https://arxiv.org/pdf/0812.2613

Difficulty estimate: 7.0/10 (anchored scale: 1 ≈ Erdős–Ginzburg–Ziv, 2.5 ≈ the sensitivity conjecture, 5 ≈ bounded prime gaps, 7.5 ≈ the Riemann Hypothesis, 10 ≈ P vs NP). It is believed open; do not assume a quick answer exists, and say so plainly if you cannot make progress. Never present a heuristic, numerical evidence, or a partial result as a solution.

## What counts as an answer
Either a proof of `OpenProblems.QEDM121.Claim` or a proof of `¬ OpenProblems.QEDM121.Claim` (a disproof), in Lean 4 + Mathlib, using the exact statement in `problems/QED-M121/Statement.lean`. Read its "Formalization notes" first. If that file still says `def Claim : Prop := sorry`, the problem must first be formalized (see CONTRIBUTING.md); a faithful formalization is itself a welcome contribution.

If you think the Lean statement does not match the informal problem (it is trivially true or false, or it says something else), report that in an issue instead of exploiting it: such solutions are not credited.

## How to submit
0. First time? Solve a test problem (QED-Q1, the 2-line one, at minimum) and submit it, to confirm your Lean setup and the submission pipeline work before spending effort here. Skip this step if this IS a test problem.
1. Claim it (optional but encouraged): open an issue titled `Claim QED-M121` at https://github.com/floration/qed/issues/new?template=claim.yml. Comment on it at least once a week or the claim lapses.
2. Add `solutions/QED-M121/<github-username>/Solution.lean`:
```lean
import Mathlib
-- do NOT redefine Claim: CI prepends problems/QED-M121/Statement.lean to your file
theorem solution : OpenProblems.QEDM121.Claim := by   -- or ¬ OpenProblems.QEDM121.Claim
  ...
```
   Large proofs may add more `.lean` files (subfolders allowed) next to Solution.lean; CI concatenates them in path order before Solution.lean. Don't import them.
3. Add `solutions/QED-M121/<github-username>/meta.json`: `{"model": "<AI model used, or none>", "kind": "proof" | "disproof"}`. Optionally a `README.md` explaining the idea.
4. Open a pull request. CI checks: it compiles, no `sorry`/`admit`/new `axiom`/`set_option` tricks, and `#print axioms solution` shows only `propext`, `Classical.choice`, `Quot.sound`.

## Scoring
Size = number of non-blank, non-comment lines of `Solution.lean` excluding `import` lines (helper lemmas count). First verified solution is credited permanently; any later, strictly smaller verified solution becomes the "smallest solution".

## Rules for you, the model
- Do not modify `Statement.lean` in a solution PR.
- Be honest about uncertainty; if a step is unproven, leave it out rather than sneak in `sorry`.
- Test locally: `lake exe cache get && lake env lean solutions/QED-M121/<user>/Solution.lean`.
