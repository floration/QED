# QED-M115 — Returning to the identity in SL(3,Z)

You are an AI model helping someone attack this open problem. Read all of this before working.

## The problem
Extended set · Grade A · QED Curated · Logic & computability

**Plain words:** You are given finitely many 3x3 integer matrices with determinant 1. Can some nonempty product of them (in any order, with repetition) equal the identity matrix? For 2x2 matrices there is an algorithm, and for 4x4 matrices it is known that none exists. Decide whether an algorithm exists for 3x3.

**Math:** Let $\mathcal I_3=\{(M_1,\dots,M_k): k\ge1,\ M_i\in SL(3,\mathbb Z),\ \exists\, m\ge1,\ i_1,\dots,i_m\in\{1,\dots,k\}:\ M_{i_1}\cdots M_{i_m}=I_3\}$, with instances given as finite lists of integer matrices. Problem: is $\mathcal I_3$ decidable? Board Claim: $\mathcal I_3$ is decidable. A proof of undecidability settles the problem negatively.

**Reviewer note:** Known: SL(2,Z): identity and membership decidable (Choffrut-Karhumaki 2005; Bell-Potapov; Potapov-Semukhin for nonsingular 2x2 integer matrices, SODA 2017). 3x3: mortality (zero matrix) undecidable for Z^{3x3} (Paterson 1970), but the identity problem is not covered. SL(4,Z): identity problem undecidable (Bell-Potapov 2010, via F2 x F2). Identity problem decidable for the Heisenberg group H(3,Z) (Ko-Niskanen-Potapov, ICALP 2018, arXiv:1706.04166), for SA(2,Z) (Dong, arXiv:2301.09502), and for 4x4 unitriangular matrices (arXiv:2202.05225). Survey: R. Dong, 'Recent advances in algorithmic problems for semigroups', arXiv:2309.10943 (ACM SIGLOG News 2023): status of all listed problems open for SL(3,Z).

**Credit:** Open problem as recorded by I. Potapov and coauthors and in R. Dong's survey (2023)

**Rests on recent unrefereed work. Check these premises first:**
- Lean decidability statement via ComputablePred on lists of Fin 3 → Fin 3 → ℤ is easy to state; undecidability would need Turing-reduction infrastructure

**References:**
- https://arxiv.org/abs/1706.04166
- https://arxiv.org/abs/2309.10943
- https://arxiv.org/abs/2301.09502
- https://arxiv.org/abs/2202.05225

Difficulty estimate: 7.5/10 (anchored scale: 1 ≈ Erdős–Ginzburg–Ziv, 2.5 ≈ the sensitivity conjecture, 5 ≈ bounded prime gaps, 7.5 ≈ the Riemann Hypothesis, 10 ≈ P vs NP). It is believed open; do not assume a quick answer exists, and say so plainly if you cannot make progress. Never present a heuristic, numerical evidence, or a partial result as a solution.

## What counts as an answer
Either a proof of `OpenProblems.QEDM115.Claim` or a proof of `¬ OpenProblems.QEDM115.Claim` (a disproof), in Lean 4 + Mathlib, using the exact statement in `problems/QED-M115/Statement.lean`. Read its "Formalization notes" first. If that file still says `def Claim : Prop := sorry`, the problem must first be formalized (see CONTRIBUTING.md); a faithful formalization is itself a welcome contribution.

If you think the Lean statement does not match the informal problem (it is trivially true or false, or it says something else), report that in an issue instead of exploiting it: such solutions are not credited.

## How to submit
0. First time? Solve a test problem (QED-Q1, the 2-line one, at minimum) and submit it, to confirm your Lean setup and the submission pipeline work before spending effort here. Skip this step if this IS a test problem.
1. Claim it (optional but encouraged): open an issue titled `Claim QED-M115` at https://github.com/floration/qed/issues/new?template=claim.yml. Comment on it at least once a week or the claim lapses.
2. Add `solutions/QED-M115/<github-username>/Solution.lean`:
```lean
import Mathlib
-- do NOT redefine Claim: CI prepends problems/QED-M115/Statement.lean to your file
theorem solution : OpenProblems.QEDM115.Claim := by   -- or ¬ OpenProblems.QEDM115.Claim
  ...
```
   Large proofs may add more `.lean` files (subfolders allowed) next to Solution.lean; CI concatenates them in path order before Solution.lean. Don't import them.
3. Add `solutions/QED-M115/<github-username>/meta.json`: `{"model": "<AI model used, or none>", "kind": "proof" | "disproof"}`. Optionally a `README.md` explaining the idea.
4. Open a pull request. CI checks: it compiles, no `sorry`/`admit`/new `axiom`/`set_option` tricks, and `#print axioms solution` shows only `propext`, `Classical.choice`, `Quot.sound`.

## Scoring
Size = number of non-blank, non-comment lines of `Solution.lean` excluding `import` lines (helper lemmas count). First verified solution is credited permanently; any later, strictly smaller verified solution becomes the "smallest solution".

## Rules for you, the model
- Do not modify `Statement.lean` in a solution PR.
- Be honest about uncertainty; if a step is unproven, leave it out rather than sneak in `sorry`.
- Test locally: `lake exe cache get && lake env lean solutions/QED-M115/<user>/Solution.lean`.
