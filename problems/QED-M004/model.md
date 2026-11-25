# QED-M004 — Smallest degree of a Keller counterexample in dimension 3

You are an AI model helping someone attack this open problem. Read all of this before working.

## The problem
Main set · Grade B · QED Original · Algebra

**Plain words:** In 2026 the Jacobian conjecture was refuted in three variables. The first explicit counterexample (Alpöge's map) has polynomial degree 7. Wang's theorem says degree 2 is impossible. What is the smallest degree a counterexample in three variables can have? In particular, is there one of degree 3, 4 or 5?

**Math:** Let $d_3$ be the least $d$ such that some polynomial map $F:\mathbb C^3\to\mathbb C^3$ with $\max_i\deg F_i=d$ and $\det DF\in\mathbb C^\times$ is not an automorphism. Wang's theorem gives $d_3\ge3$, and Alpöge's map gives $d_3\le7$. Determine $d_3$. In particular, decide whether $d_3\le5$.

**Rests on recent unrefereed work. Check these premises first:**
- Alpöge counterexample (2026 preprints in refs, e.g. arXiv:2608.00222; formally checked in Isabelle AFP 'Jacobian_Counterexample'): gives d_3 <= 7, i.e. that d_3 is finite. The Claim (d_3 <= 5) does not depend on it.
- Other 2026 preprints (2609.17795, 2607.20210, 2607.22198, 2610.24889, 2607.21572, 2609.33491): further counterexamples of degree >= 7 in dim 3 and low-degree ones in dims 4-12; background.

**References:**
- https://arxiv.org/pdf/2608.00222
- https://arxiv.org/pdf/2609.17795
- https://arxiv.org/pdf/2607.20210
- https://arxiv.org/pdf/2607.22198
- https://isa-afp.org/entries/Jacobian_Counterexample.html
- https://en.wikipedia.org/wiki/Jacobian_conjecture
- https://arxiv.org/pdf/2610.24889
- https://arxiv.org/pdf/2607.21572
- https://arxiv.org/pdf/2609.33491

Difficulty estimate: 3.0/10 (calibrated: Collatz ≈ 5.5, twin primes ≈ 5.0). It is believed open; do not assume a quick answer exists, and say so plainly if you cannot make progress. Never present a heuristic, numerical evidence, or a partial result as a solution.

## What counts as an answer
Either a proof of `OpenProblems.QEDM004.Claim` or a proof of `¬ OpenProblems.QEDM004.Claim` (a disproof), in Lean 4 + Mathlib, using the exact statement in `problems/QED-M004/Statement.lean`. Read its "Formalization notes" first. If that file still says `def Claim : Prop := sorry`, the problem must first be formalized (see CONTRIBUTING.md); a faithful formalization is itself a welcome contribution.

If you think the Lean statement does not match the informal problem (it is trivially true or false, or it says something else), report that in an issue instead of exploiting it: such solutions are not credited.

## How to submit
0. First time? Solve a test problem (QED-Q1, the 2-line one, at minimum) and submit it, to confirm your Lean setup and the submission pipeline work before spending effort here. Skip this step if this IS a test problem.
1. Claim it (optional but encouraged): open an issue titled `Claim QED-M004` at https://github.com/floration/qed/issues/new?template=claim.yml. Comment on it at least once a week or the claim lapses.
2. Add `solutions/QED-M004/<github-username>/Solution.lean`:
```lean
import Mathlib
-- do NOT redefine Claim: CI prepends problems/QED-M004/Statement.lean to your file
theorem solution : OpenProblems.QEDM004.Claim := by   -- or ¬ OpenProblems.QEDM004.Claim
  ...
```
   Large proofs may add more `.lean` files (subfolders allowed) next to Solution.lean; CI concatenates them in path order before Solution.lean. Don't import them.
3. Add `solutions/QED-M004/<github-username>/meta.json`: `{"model": "<AI model used, or none>", "kind": "proof" | "disproof"}`. Optionally a `README.md` explaining the idea.
4. Open a pull request. CI checks: it compiles, no `sorry`/`admit`/new `axiom`/`set_option` tricks, and `#print axioms solution` shows only `propext`, `Classical.choice`, `Quot.sound`.

## Scoring
Size = number of non-blank, non-comment lines of `Solution.lean` excluding `import` lines (helper lemmas count). First verified solution is credited permanently; any later, strictly smaller verified solution becomes the "smallest solution".

## Rules for you, the model
- Do not modify `Statement.lean` in a solution PR.
- Be honest about uncertainty; if a step is unproven, leave it out rather than sneak in `sorry`.
- Test locally: `lake exe cache get && lake env lean solutions/QED-M004/<user>/Solution.lean`.
