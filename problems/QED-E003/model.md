# QED-E003 — Keller monodromy is everything

You are an AI model helping someone attack this open problem. Read all of this before working.

## The problem
Extended set · Grade C · Algebra

**Plain words:** Since 2026 there are polynomial maps of 3-space with constant nonzero Jacobian that are not invertible (counterexamples to the Jacobian conjecture), and every number n >= 3 of points in a generic fibre occurs. Show that for every n the fibre points can be permuted in every possible way by going around loops, i.e. the monodromy group can be the full symmetric group S_n.

**Math:** Prove that for every $n\ge4$ with $n\not\equiv3\pmod 4$ and $n$ not of the form $kd$ with $k$ odd $\ge3$ and $d\ge3$ (first cases $n=4,5,6,8,10,13,14,16,17$), there is a polynomial map $F:\mathbb C^3\to\mathbb C^3$ with $\det JF\in\mathbb C^{\times}$, geometric degree $[\mathbb C(x):\mathbb C(F)]=n$, and geometric monodromy group (Galois group of the Galois closure of $\mathbb C(x)/\mathbb C(F)$) equal to $S_n$. (Other $n$ are done by Kistner-Shaska, arXiv 2608.02863, Thms 6.1, 6.5.)

**Reviewer note:** O

**References:**
- https://arxiv.org/pdf/2608.02863
- https://arxiv.org/pdf/2609.33491
- https://arxiv.org/pdf/2607.20210
- https://arxiv.org/pdf/2608.00222
- https://raw.githubusercontent.com/algal/jacobianfun/main/RESEARCH.md

Difficulty estimate: 2.0/10 (anchored scale: 1 ≈ Erdős–Ginzburg–Ziv, 2.5 ≈ the sensitivity conjecture, 5 ≈ bounded prime gaps, 7.5 ≈ the Riemann Hypothesis, 10 ≈ P vs NP). It is believed open; do not assume a quick answer exists, and say so plainly if you cannot make progress. Never present a heuristic, numerical evidence, or a partial result as a solution.

## What counts as an answer
Either a proof of `OpenProblems.QEDE003.Claim` or a proof of `¬ OpenProblems.QEDE003.Claim` (a disproof), in Lean 4 + Mathlib, using the exact statement in `problems/QED-E003/Statement.lean`. Read its "Formalization notes" first. If that file still says `def Claim : Prop := sorry`, the problem must first be formalized (see CONTRIBUTING.md); a faithful formalization is itself a welcome contribution.

If you think the Lean statement does not match the informal problem (it is trivially true or false, or it says something else), report that in an issue instead of exploiting it: such solutions are not credited.

## How to submit
0. First time? Solve a test problem (QED-Q1, the 2-line one, at minimum) and submit it, to confirm your Lean setup and the submission pipeline work before spending effort here. Skip this step if this IS a test problem.
1. Claim it (optional but encouraged): open an issue titled `Claim QED-E003` at https://github.com/floration/qed/issues/new?template=claim.yml. Comment on it at least once a week or the claim lapses.
2. Add `solutions/QED-E003/<github-username>/Solution.lean`:
```lean
import Mathlib
-- do NOT redefine Claim: CI prepends problems/QED-E003/Statement.lean to your file
theorem solution : OpenProblems.QEDE003.Claim := by   -- or ¬ OpenProblems.QEDE003.Claim
  ...
```
   Large proofs may add more `.lean` files (subfolders allowed) next to Solution.lean; CI concatenates them in path order before Solution.lean. Don't import them.
3. Add `solutions/QED-E003/<github-username>/meta.json`: `{"model": "<AI model used, or none>", "kind": "proof" | "disproof"}`. Optionally a `README.md` explaining the idea.
4. Open a pull request. CI checks: it compiles, no `sorry`/`admit`/new `axiom`/`set_option` tricks, and `#print axioms solution` shows only `propext`, `Classical.choice`, `Quot.sound`.

## Scoring
Size = number of non-blank, non-comment lines of `Solution.lean` excluding `import` lines (helper lemmas count). First verified solution is credited permanently; any later, strictly smaller verified solution becomes the "smallest solution".

## Rules for you, the model
- Do not modify `Statement.lean` in a solution PR.
- Be honest about uncertainty; if a step is unproven, leave it out rather than sneak in `sorry`.
- Test locally: `lake exe cache get && lake env lean solutions/QED-E003/<user>/Solution.lean`.
