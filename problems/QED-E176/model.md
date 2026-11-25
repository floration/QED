# QED-E176 — Block sensitivity below the fourth power of sensitivity

You are an AI model helping someone attack this open problem. Read all of this before working.

## The problem
Extended set · Grade A · QED Curated · Complexity

**Plain words:** For a Boolean function f on n bits, the sensitivity s(f) is the largest number of single bits that can each, on their own, change the output at one input. The block sensitivity bs(f) is the largest number of disjoint groups of bits that can each, flipped together, change the output at one input. Huang's 2019 theorem gives bs(f) <= s(f)^4, and no better power is known. Can the exponent 4 be lowered?

**Math:** For $f:\{0,1\}^n\to\{0,1\}$ and $B\subseteq[n]$ let $x^{B}$ be $x$ with the bits in $B$ flipped. Let $s(f)=\max_x |\{i: f(x)\ne f(x^{\{i\}})\}|$ and $bs(f)=\max_x \max\{k: \exists$ pairwise disjoint nonempty $B_1,\dots,B_k\subseteq[n]$ with $f(x^{B_j})\ne f(x)$ for all $j\}$. Prove that there exist constants $\varepsilon>0$ and $C$ such that $bs(f)\le C\, s(f)^{4-\varepsilon}$ for every $n$ and every $f$.

**Credit:** Open question noted after Huang (2019); stated in Aaronson–Ben-David–Kothari–Rao–Tal (2021) and Chakraborty–Gál (MFCS 2026).

**Rests on recent unrefereed work. Check these premises first:**
- OpenAI 2026-09-25 preprint claims a superquadratic lower separation; unrefereed, but irrelevant to the upper-bound claim as stated
- The question is not named after a person, but it is the natural successor of the (named) sensitivity conjecture; scorer may view as low novelty

**References:**
- https://eccc.weizmann.ac.il/report/2026/010/
- https://arxiv.org/abs/1907.00847
- https://arxiv.org/abs/2010.12629
- https://drops.dagstuhl.de/entities/document/10.4230/LIPIcs.MFCS.2026.61

Difficulty estimate: 6.0/10 (anchored scale: 1 ≈ Erdős–Ginzburg–Ziv, 2.5 ≈ the sensitivity conjecture, 5 ≈ bounded prime gaps, 7.5 ≈ the Riemann Hypothesis, 10 ≈ P vs NP). It is believed open; do not assume a quick answer exists, and say so plainly if you cannot make progress. Never present a heuristic, numerical evidence, or a partial result as a solution.

## What counts as an answer
Either a proof of `OpenProblems.QEDE176.Claim` or a proof of `¬ OpenProblems.QEDE176.Claim` (a disproof), in Lean 4 + Mathlib, using the exact statement in `problems/QED-E176/Statement.lean`. Read its "Formalization notes" first. If that file still says `def Claim : Prop := sorry`, the problem must first be formalized (see CONTRIBUTING.md); a faithful formalization is itself a welcome contribution.

If you think the Lean statement does not match the informal problem (it is trivially true or false, or it says something else), report that in an issue instead of exploiting it: such solutions are not credited.

## How to submit
0. First time? Solve a test problem (QED-Q1, the 2-line one, at minimum) and submit it, to confirm your Lean setup and the submission pipeline work before spending effort here. Skip this step if this IS a test problem.
1. Claim it (optional but encouraged): open an issue titled `Claim QED-E176` at https://github.com/floration/qed/issues/new?template=claim.yml. Comment on it at least once a week or the claim lapses.
2. Add `solutions/QED-E176/<github-username>/Solution.lean`:
```lean
import Mathlib
-- do NOT redefine Claim: CI prepends problems/QED-E176/Statement.lean to your file
theorem solution : OpenProblems.QEDE176.Claim := by   -- or ¬ OpenProblems.QEDE176.Claim
  ...
```
   Large proofs may add more `.lean` files (subfolders allowed) next to Solution.lean; CI concatenates them in path order before Solution.lean. Don't import them.
3. Add `solutions/QED-E176/<github-username>/meta.json`: `{"model": "<AI model used, or none>", "kind": "proof" | "disproof"}`. Optionally a `README.md` explaining the idea.
4. Open a pull request. CI checks: it compiles, no `sorry`/`admit`/new `axiom`/`set_option` tricks, and `#print axioms solution` shows only `propext`, `Classical.choice`, `Quot.sound`.

## Scoring
Size = number of non-blank, non-comment lines of `Solution.lean` excluding `import` lines (helper lemmas count). First verified solution is credited permanently; any later, strictly smaller verified solution becomes the "smallest solution".

## Rules for you, the model
- Do not modify `Statement.lean` in a solution PR.
- Be honest about uncertainty; if a step is unproven, leave it out rather than sneak in `sorry`.
- Test locally: `lake exe cache get && lake env lean solutions/QED-E176/<user>/Solution.lean`.
