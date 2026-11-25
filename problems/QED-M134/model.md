# QED-M134 — Binary codes near distance 1/2: remove the logarithm

You are an AI model helping someone attack this open problem. Read all of this before working.

## The problem
Main set · Grade A · QED Curated · Coding theory

**Plain words:** Let A(n,d) be the largest number of binary strings of length n that pairwise differ in at least d positions. When d=(1/2-eps)n, random codes give about 2^{(2/ln 2) eps^2 n} strings, but the best upper bounds (the 1977 linear-programming bound and its 2026 refinements) give only 2^{O(eps^2 log(1/eps)) n}. Show that the logarithm is not needed: the rate is at most a constant times eps^2.

**Math:** Let $A_2(n,d)=\max\{|C|:C\subseteq\{0,1\}^n,\ d_H(x,y)\ge d\ \forall x\ne y\in C\}$. Prove that there is an absolute constant $K$ such that for every $\varepsilon\in(0,1/4]$, $\limsup_{n\to\infty}\frac1n\log_2A_2\!\left(n,\lceil(\tfrac12-\varepsilon)n\rceil\right)\le K\varepsilon^2$.

**Credit:** Classical (MRRW 1977 gap); eps-biased formulation Alon et al. (1992)

**Rests on recent unrefereed work. Check these premises first:**
- 2026 MRRW improvements (OpenAI ch.2, Alrabiah-Guruswami, honeycomb arXiv:2608.20287 unrefereed) - checked numerically that kappa_H keeps the eps^2 log(1/eps) order, but the honeycomb bound's near-1/2 behaviour was not analysed in its abstract
- Close to the belief that GV is tight (sometimes attributed to Goppa); this claim is strictly weaker

**References:**
- https://drops.dagstuhl.de/storage/00lipics/lipics-vol383-ccc2026/LIPIcs.CCC.2026.21/LIPIcs.CCC.2026.21.pdf
- https://eccc.weizmann.ac.il/report/2017/041/
- https://arxiv.org/abs/2608.20287
- https://arxiv.org/abs/2303.16619

Difficulty estimate: 8.0/10 (anchored scale: 1 ≈ Erdős–Ginzburg–Ziv, 2.5 ≈ the sensitivity conjecture, 5 ≈ bounded prime gaps, 7.5 ≈ the Riemann Hypothesis, 10 ≈ P vs NP). It is believed open; do not assume a quick answer exists, and say so plainly if you cannot make progress. Never present a heuristic, numerical evidence, or a partial result as a solution.

## What counts as an answer
Either a proof of `OpenProblems.QEDM134.Claim` or a proof of `¬ OpenProblems.QEDM134.Claim` (a disproof), in Lean 4 + Mathlib, using the exact statement in `problems/QED-M134/Statement.lean`. Read its "Formalization notes" first. If that file still says `def Claim : Prop := sorry`, the problem must first be formalized (see CONTRIBUTING.md); a faithful formalization is itself a welcome contribution.

If you think the Lean statement does not match the informal problem (it is trivially true or false, or it says something else), report that in an issue instead of exploiting it: such solutions are not credited.

## How to submit
0. First time? Solve a test problem (QED-Q1, the 2-line one, at minimum) and submit it, to confirm your Lean setup and the submission pipeline work before spending effort here. Skip this step if this IS a test problem.
1. Claim it (optional but encouraged): open an issue titled `Claim QED-M134` at https://github.com/floration/qed/issues/new?template=claim.yml. Comment on it at least once a week or the claim lapses.
2. Add `solutions/QED-M134/<github-username>/Solution.lean`:
```lean
import Mathlib
-- do NOT redefine Claim: CI prepends problems/QED-M134/Statement.lean to your file
theorem solution : OpenProblems.QEDM134.Claim := by   -- or ¬ OpenProblems.QEDM134.Claim
  ...
```
   Large proofs may add more `.lean` files (subfolders allowed) next to Solution.lean; CI concatenates them in path order before Solution.lean. Don't import them.
3. Add `solutions/QED-M134/<github-username>/meta.json`: `{"model": "<AI model used, or none>", "kind": "proof" | "disproof"}`. Optionally a `README.md` explaining the idea.
4. Open a pull request. CI checks: it compiles, no `sorry`/`admit`/new `axiom`/`set_option` tricks, and `#print axioms solution` shows only `propext`, `Classical.choice`, `Quot.sound`.

## Scoring
Size = number of non-blank, non-comment lines of `Solution.lean` excluding `import` lines (helper lemmas count). First verified solution is credited permanently; any later, strictly smaller verified solution becomes the "smallest solution".

## Rules for you, the model
- Do not modify `Statement.lean` in a solution PR.
- Be honest about uncertainty; if a step is unproven, leave it out rather than sneak in `sorry`.
- Test locally: `lake exe cache get && lake env lean solutions/QED-M134/<user>/Solution.lean`.
