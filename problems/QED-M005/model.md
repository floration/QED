# QED-M005 — Smallest dimension of a cubic-homogeneous Jacobian counterexample

You are an AI model helping someone attack this open problem. Read all of this before working.

## The problem
Main set · Grade A · QED Extension · Algebra

**Plain words:** The Jacobian conjecture is now known to fail. A classical reduction says that if it fails at all, it fails for maps of the special form x + (cubic homogeneous terms), but the reduction pays for this by raising the number of variables. Such a cubic counterexample is now known in 18 variables, and none exists in 4 or fewer. What is the smallest number of variables in which one exists?

**Math:** Let N_3 be the least n such that there is H=(H_1,...,H_n), each H_i in C[x_1..x_n] homogeneous of degree 3, with JH nilpotent and x+H not an automorphism of C^n. Hubbers (n<=4) gives N_3>=5; de Bondt (arXiv:2610.24889, unrefereed) gives N_3<=18. Determine N_3; in particular decide whether the Jacobian conjecture holds for cubic homogeneous maps in dimension 5. Board target (the Lean Claim): dimension 5, i.e. prove that every such $x+H$ in dimension 5 is an automorphism (so $N_3>5$); the exact value of $N_3$ is a further question.

**Credit:** Classical HJC(n,3) program: Bass–Connell–Wright (1982), Yagzhev; Hubbers (n ≤ 4 classification); de Bondt–van den Essen arXiv:1609.09753; upper bound de Bondt arXiv:2610.24889.

**Rests on recent unrefereed work. Check these premises first:**
- arXiv:2610.24889 (de Bondt, Oct 2026, unrefereed, partly AI-written): source of N₃ ≤ 18 via HJC(18,3); only the upper bound depends on it.
- arXiv:2608.00222 / arXiv:2609.17795 (2026 preprints, Alpöge's map and follow-up): the premise that the Jacobian conjecture is false at all; the formal Claim (dimension 5) does not depend on it.

**References:**
- https://arxiv.org/abs/2610.24889
- https://arxiv.org/abs/2608.00222
- https://arxiv.org/abs/2609.17795
- https://www.cs.ru.nl/E.Hubbers/pubs/nilpotent_jacobians_112500.pdf
- https://isa-afp.org/entries/Jacobian_Counterexample.html
- https://arxiv.org/abs/2610.24889
- https://arxiv.org/abs/2608.00222
- https://arxiv.org/abs/2609.17795
- https://arxiv.org/abs/1609.09753
- https://arxiv.org/pdf/1501.04845

Difficulty estimate: 4.5/10 (anchored scale: 1 ≈ Erdős–Ginzburg–Ziv, 2.5 ≈ the sensitivity conjecture, 5 ≈ bounded prime gaps, 7.5 ≈ the Riemann Hypothesis, 10 ≈ P vs NP). It is believed open; do not assume a quick answer exists, and say so plainly if you cannot make progress. Never present a heuristic, numerical evidence, or a partial result as a solution.

## What counts as an answer
Either a proof of `OpenProblems.QEDM005.Claim` or a proof of `¬ OpenProblems.QEDM005.Claim` (a disproof), in Lean 4 + Mathlib, using the exact statement in `problems/QED-M005/Statement.lean`. Read its "Formalization notes" first. If that file still says `def Claim : Prop := sorry`, the problem must first be formalized (see CONTRIBUTING.md); a faithful formalization is itself a welcome contribution.

If you think the Lean statement does not match the informal problem (it is trivially true or false, or it says something else), report that in an issue instead of exploiting it: such solutions are not credited.

## How to submit
0. First time? Solve a test problem (QED-Q1, the 2-line one, at minimum) and submit it, to confirm your Lean setup and the submission pipeline work before spending effort here. Skip this step if this IS a test problem.
1. Claim it (optional but encouraged): open an issue titled `Claim QED-M005` at https://github.com/floration/qed/issues/new?template=claim.yml. Comment on it at least once a week or the claim lapses.
2. Add `solutions/QED-M005/<github-username>/Solution.lean`:
```lean
import Mathlib
-- do NOT redefine Claim: CI prepends problems/QED-M005/Statement.lean to your file
theorem solution : OpenProblems.QEDM005.Claim := by   -- or ¬ OpenProblems.QEDM005.Claim
  ...
```
   Large proofs may add more `.lean` files (subfolders allowed) next to Solution.lean; CI concatenates them in path order before Solution.lean. Don't import them.
3. Add `solutions/QED-M005/<github-username>/meta.json`: `{"model": "<AI model used, or none>", "kind": "proof" | "disproof"}`. Optionally a `README.md` explaining the idea.
4. Open a pull request. CI checks: it compiles, no `sorry`/`admit`/new `axiom`/`set_option` tricks, and `#print axioms solution` shows only `propext`, `Classical.choice`, `Quot.sound`.

## Scoring
Size = number of non-blank, non-comment lines of `Solution.lean` excluding `import` lines (helper lemmas count). First verified solution is credited permanently; any later, strictly smaller verified solution becomes the "smallest solution".

## Rules for you, the model
- Do not modify `Statement.lean` in a solution PR.
- Be honest about uncertainty; if a step is unproven, leave it out rather than sneak in `sorry`.
- Test locally: `lake exe cache get && lake env lean solutions/QED-M005/<user>/Solution.lean`.
