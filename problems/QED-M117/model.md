# QED-M117 — An exponential improvement of the diagonal Ramsey lower bound

You are an AI model helping someone attack this open problem. Read all of this before working.

## The problem
Main set · Grade A · QED Curated · Combinatorics

**Plain words:** The Ramsey number R(k) is the least N such that every red/blue colouring of the edges of the complete graph K_N contains a one-coloured K_k. Erdos's 1947 random-colouring argument gives R(k) > (sqrt 2)^k, and in nearly 80 years only the constant factor in front has improved. Is there a fixed eps > 0 with R(k) > (sqrt 2 + eps)^k for all large k?

**Math:** Prove that there exists $\varepsilon>0$ such that $R(k,k)\ge(\sqrt2+\varepsilon)^k$ for all sufficiently large $k$; equivalently, for every large $k$ there is a graph on $N\ge(\sqrt2+\varepsilon)^k$ vertices with no clique and no independent set of size $k$. (Best known: $R(k,k)\ge(1+o(1))\frac{\sqrt2}{e}\,k\,2^{k/2}$, Spencer 1975.)

**Credit:** Erdős (1947 bound and question); Spencer (1975)

**Rests on recent unrefereed work. Check these premises first:**
- Extremely famous and hard: low novelty, may be judged a famous problem stated directly
- Not a person-named conjecture (Erdős offered a prize for the limit of R(k)^{1/k}, a stronger question)
- Context only: refereed status of Ma–Shen–Xie (arXiv 2025, covered by Quanta 2026) not verified; 2605.25843 is an unrefereed 2026 preprint

**References:**
- https://arxiv.org/abs/2507.12926
- https://arxiv.org/abs/2605.25843
- https://arxiv.org/abs/2601.05221
- https://annals.math.princeton.edu/2026/203-3/p04
- https://arxiv.org/abs/2303.09521

Difficulty estimate: 8.0/10 (anchored scale: 1 ≈ Erdős–Ginzburg–Ziv, 2.5 ≈ the sensitivity conjecture, 5 ≈ bounded prime gaps, 7.5 ≈ the Riemann Hypothesis, 10 ≈ P vs NP). It is believed open; do not assume a quick answer exists, and say so plainly if you cannot make progress. Never present a heuristic, numerical evidence, or a partial result as a solution.

## What counts as an answer
Either a proof of `OpenProblems.QEDM117.Claim` or a proof of `¬ OpenProblems.QEDM117.Claim` (a disproof), in Lean 4 + Mathlib, using the exact statement in `problems/QED-M117/Statement.lean`. Read its "Formalization notes" first. If that file still says `def Claim : Prop := sorry`, the problem must first be formalized (see CONTRIBUTING.md); a faithful formalization is itself a welcome contribution.

If you think the Lean statement does not match the informal problem (it is trivially true or false, or it says something else), report that in an issue instead of exploiting it: such solutions are not credited.

## How to submit
0. First time? Solve a test problem (QED-Q1, the 2-line one, at minimum) and submit it, to confirm your Lean setup and the submission pipeline work before spending effort here. Skip this step if this IS a test problem.
1. Claim it (optional but encouraged): open an issue titled `Claim QED-M117` at https://github.com/floration/qed/issues/new?template=claim.yml. Comment on it at least once a week or the claim lapses.
2. Add `solutions/QED-M117/<github-username>/Solution.lean`:
```lean
import Mathlib
-- do NOT redefine Claim: CI prepends problems/QED-M117/Statement.lean to your file
theorem solution : OpenProblems.QEDM117.Claim := by   -- or ¬ OpenProblems.QEDM117.Claim
  ...
```
   Large proofs may add more `.lean` files (subfolders allowed) next to Solution.lean; CI concatenates them in path order before Solution.lean. Don't import them.
3. Add `solutions/QED-M117/<github-username>/meta.json`: `{"model": "<AI model used, or none>", "kind": "proof" | "disproof"}`. Optionally a `README.md` explaining the idea.
4. Open a pull request. CI checks: it compiles, no `sorry`/`admit`/new `axiom`/`set_option` tricks, and `#print axioms solution` shows only `propext`, `Classical.choice`, `Quot.sound`.

## Scoring
Size = number of non-blank, non-comment lines of `Solution.lean` excluding `import` lines (helper lemmas count). First verified solution is credited permanently; any later, strictly smaller verified solution becomes the "smallest solution".

## Rules for you, the model
- Do not modify `Statement.lean` in a solution PR.
- Be honest about uncertainty; if a step is unproven, leave it out rather than sneak in `sorry`.
- Test locally: `lake exe cache get && lake env lean solutions/QED-M117/<user>/Solution.lean`.
