# QED-E172 — Six cubes suffice for all large integers

You are an AI model helping someone attack this open problem. Read all of this before working.

## The problem
Extended set · Grade A · QED Curated · Number theory

**Plain words:** Linnik proved in 1943 that every sufficiently large integer is a sum of at most seven cubes of non-negative integers, and it is believed that four cubes suffice from some point on. Nobody has proved even that six cubes suffice. Prove that every sufficiently large integer is a sum of six cubes of non-negative integers.

**Math:** Prove that there exists $N_0$ such that every integer $n\ge N_0$ can be written as $n=x_1^3+\cdots+x_6^3$ with $x_1,\dots,x_6\in\mathbb Z_{\ge0}$; equivalently $G(3)\le6$, where $G(3)$ is the least $s$ such that all sufficiently large integers are sums of $s$ non-negative cubes. (Known: $4\le G(3)\le7$.)

**Credit:** Classical sub-question of Waring's problem for cubes (Linnik 1943 bound; see Vaughan–Wooley survey 'Waring's problem: a survey', 2002).

**Rests on recent unrefereed work. Check these premises first:**
- The overall problem is named (Waring's problem); this is the unnamed intermediate step G(3)≤6, which the scorer should check against the naming rule
- The conjectured last exceptions (8042 for six cubes, 1290740 for five) are from computations recalled from the literature; my own check confirms 8042 up to 3·10^5

**References:**
- https://en.wikipedia.org/wiki/Waring%27s_problem
- https://www.math.purdue.edu/~twooley/publ/2001%20wp36.pdf
- https://ar5iv.labs.arxiv.org/html/0903.4503
- https://arxiv.org/abs/1004.2670

Difficulty estimate: 8.5/10 (anchored scale: 1 ≈ Erdős–Ginzburg–Ziv, 2.5 ≈ the sensitivity conjecture, 5 ≈ bounded prime gaps, 7.5 ≈ the Riemann Hypothesis, 10 ≈ P vs NP). It is believed open; do not assume a quick answer exists, and say so plainly if you cannot make progress. Never present a heuristic, numerical evidence, or a partial result as a solution.

## What counts as an answer
Either a proof of `OpenProblems.QEDE172.Claim` or a proof of `¬ OpenProblems.QEDE172.Claim` (a disproof), in Lean 4 + Mathlib, using the exact statement in `problems/QED-E172/Statement.lean`. Read its "Formalization notes" first. If that file still says `def Claim : Prop := sorry`, the problem must first be formalized (see CONTRIBUTING.md); a faithful formalization is itself a welcome contribution.

If you think the Lean statement does not match the informal problem (it is trivially true or false, or it says something else), report that in an issue instead of exploiting it: such solutions are not credited.

## How to submit
0. First time? Solve a test problem (QED-Q1, the 2-line one, at minimum) and submit it, to confirm your Lean setup and the submission pipeline work before spending effort here. Skip this step if this IS a test problem.
1. Claim it (optional but encouraged): open an issue titled `Claim QED-E172` at https://github.com/floration/qed/issues/new?template=claim.yml. Comment on it at least once a week or the claim lapses.
2. Add `solutions/QED-E172/<github-username>/Solution.lean`:
```lean
import Mathlib
-- do NOT redefine Claim: CI prepends problems/QED-E172/Statement.lean to your file
theorem solution : OpenProblems.QEDE172.Claim := by   -- or ¬ OpenProblems.QEDE172.Claim
  ...
```
   Large proofs may add more `.lean` files (subfolders allowed) next to Solution.lean; CI concatenates them in path order before Solution.lean. Don't import them.
3. Add `solutions/QED-E172/<github-username>/meta.json`: `{"model": "<AI model used, or none>", "kind": "proof" | "disproof"}`. Optionally a `README.md` explaining the idea.
4. Open a pull request. CI checks: it compiles, no `sorry`/`admit`/new `axiom`/`set_option` tricks, and `#print axioms solution` shows only `propext`, `Classical.choice`, `Quot.sound`.

## Scoring
Size = number of non-blank, non-comment lines of `Solution.lean` excluding `import` lines (helper lemmas count). First verified solution is credited permanently; any later, strictly smaller verified solution becomes the "smallest solution".

## Rules for you, the model
- Do not modify `Statement.lean` in a solution PR.
- Be honest about uncertainty; if a step is unproven, leave it out rather than sneak in `sorry`.
- Test locally: `lake exe cache get && lake env lean solutions/QED-E172/<user>/Solution.lean`.
