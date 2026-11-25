# QED-E212 — Every sextic Salem number has an eventually periodic expansion of 1

You are an AI model helping someone attack this open problem. Read all of this before working.

## The problem
Extended set · Grade B · QED Curated · Dynamics

**Plain words:** For beta > 1, the map T(x) = beta x - floor(beta x) gives greedy base-beta digits; beta is a Parry number if the T-orbit of 1 is finite. A Salem number is an algebraic integer beta > 1 whose other conjugates lie in the closed unit disc, at least one on the unit circle. Boyd proved every degree-4 Salem number is Parry. Prove the same for degree 6.

**Math:** Let $\beta>1$ be a Salem number of degree $6$ (an algebraic integer with minimal polynomial of degree 6 whose other roots satisfy $|z|\le1$, at least one with $|z|=1$), and $T_\beta(x)=\beta x-\lfloor\beta x\rfloor$ on $[0,1)$. Prove that $\{T_\beta^{\,n}(\beta-\lfloor\beta\rfloor):n\ge0\}$ is finite. (First test case: the root $>1$ of $x^6-3x^5-x^4-7x^3-x^2-3x+1$, whose orbit length exceeds $7.7\times10^{10}$ if finite.)

**Credit:** Question for degree 6 raised and heuristically supported by D. W. Boyd, Math. Comp. 1996; part of the general K. Schmidt (1980) question whether all Salem numbers are Parry numbers.

**Rests on recent unrefereed work. Check these premises first:**
- Truth uncertain: heuristics favour 'yes' but only probabilistically; a single non-Parry sextic Salem number would refute it (that would also be a major result)
- Sub-question of the person-named Schmidt conjecture (all Salem numbers); the degree-6 restriction is an unnamed partial question

**References:**
- https://www.ams.org/journals/mcom/1996-65-214/S0025-5718-96-00700-4
- https://arxiv.org/abs/1912.10386
- https://arxiv.org/abs/1408.0195
- https://arxiv.org/abs/2504.10787
- https://arxiv.org/abs/2206.06675

Difficulty estimate: 6.5/10 (anchored scale: 1 ≈ Erdős–Ginzburg–Ziv, 2.5 ≈ the sensitivity conjecture, 5 ≈ bounded prime gaps, 7.5 ≈ the Riemann Hypothesis, 10 ≈ P vs NP). It is believed open; do not assume a quick answer exists, and say so plainly if you cannot make progress. Never present a heuristic, numerical evidence, or a partial result as a solution.

## What counts as an answer
Either a proof of `OpenProblems.QEDE212.Claim` or a proof of `¬ OpenProblems.QEDE212.Claim` (a disproof), in Lean 4 + Mathlib, using the exact statement in `problems/QED-E212/Statement.lean`. Read its "Formalization notes" first. If that file still says `def Claim : Prop := sorry`, the problem must first be formalized (see CONTRIBUTING.md); a faithful formalization is itself a welcome contribution.

If you think the Lean statement does not match the informal problem (it is trivially true or false, or it says something else), report that in an issue instead of exploiting it: such solutions are not credited.

## How to submit
0. First time? Solve a test problem (QED-Q1, the 2-line one, at minimum) and submit it, to confirm your Lean setup and the submission pipeline work before spending effort here. Skip this step if this IS a test problem.
1. Claim it (optional but encouraged): open an issue titled `Claim QED-E212` at https://github.com/floration/qed/issues/new?template=claim.yml. Comment on it at least once a week or the claim lapses.
2. Add `solutions/QED-E212/<github-username>/Solution.lean`:
```lean
import Mathlib
-- do NOT redefine Claim: CI prepends problems/QED-E212/Statement.lean to your file
theorem solution : OpenProblems.QEDE212.Claim := by   -- or ¬ OpenProblems.QEDE212.Claim
  ...
```
   Large proofs may add more `.lean` files (subfolders allowed) next to Solution.lean; CI concatenates them in path order before Solution.lean. Don't import them.
3. Add `solutions/QED-E212/<github-username>/meta.json`: `{"model": "<AI model used, or none>", "kind": "proof" | "disproof"}`. Optionally a `README.md` explaining the idea.
4. Open a pull request. CI checks: it compiles, no `sorry`/`admit`/new `axiom`/`set_option` tricks, and `#print axioms solution` shows only `propext`, `Classical.choice`, `Quot.sound`.

## Scoring
Size = number of non-blank, non-comment lines of `Solution.lean` excluding `import` lines (helper lemmas count). First verified solution is credited permanently; any later, strictly smaller verified solution becomes the "smallest solution".

## Rules for you, the model
- Do not modify `Statement.lean` in a solution PR.
- Be honest about uncertainty; if a step is unproven, leave it out rather than sneak in `sorry`.
- Test locally: `lake exe cache get && lake env lean solutions/QED-E212/<user>/Solution.lean`.
