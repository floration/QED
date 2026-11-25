# QED-M136 — The MDS conjecture over fields of odd characteristic

You are an AI model helping someone attack this open problem. Read all of this before working.

## The problem
Main set · Grade A · QED Curated · Combinatorics

**Plain words:** An arc in F_q^k is a set of vectors in which every k of them are linearly independent. Arcs are the same thing as linear MDS codes, the codes that meet the Singleton bound, and Reed-Solomon codes give arcs of size q+1. Show that q+1 is always the maximum when q is odd and 2 ≤ k ≤ q. This is known when q is prime (Ball 2012). A 2026 preprint claims it for all k outside a middle window of roughly q/(2p−3) dimensions, where p is the characteristic; the smallest open case would then be q=27 with 12 ≤ k ≤ 17.

**Math:** Let $q$ be an odd prime power and $2\le k\le q$. Prove that if $S\subseteq\mathbb{F}_q^k$ is a set of vectors such that every $k$ distinct elements of $S$ are linearly independent, then $|S|\le q+1$.

**Credit:** MDS conjecture (Segre 1955 problem as reformulated in coding theory); progress by Ball, Ball–De Beule, X. Fan (2026).

**Rests on recent unrefereed work. Check these premises first:**
- Relies on unrefereed Oct 2026 preprints (Fan; Chen–Huang) for the current boundary; these do not change the statement, only the framing
- Very active area: the remaining window may be closed soon
- Historically associated with Segre, but the problem's standard name is not a person's

**References:**
- https://arxiv.org/abs/2610.03740
- https://arxiv.org/abs/2610.28208
- https://arxiv.org/pdf/1908.10772
- https://arxiv.org/pdf/1511.03623
- https://mathworld.wolfram.com/MDSConjecture.html

Difficulty estimate: 7.5/10 (anchored scale: 1 ≈ Erdős–Ginzburg–Ziv, 2.5 ≈ the sensitivity conjecture, 5 ≈ bounded prime gaps, 7.5 ≈ the Riemann Hypothesis, 10 ≈ P vs NP). It is believed open; do not assume a quick answer exists, and say so plainly if you cannot make progress. Never present a heuristic, numerical evidence, or a partial result as a solution.

## What counts as an answer
Either a proof of `OpenProblems.QEDM136.Claim` or a proof of `¬ OpenProblems.QEDM136.Claim` (a disproof), in Lean 4 + Mathlib, using the exact statement in `problems/QED-M136/Statement.lean`. Read its "Formalization notes" first. If that file still says `def Claim : Prop := sorry`, the problem must first be formalized (see CONTRIBUTING.md); a faithful formalization is itself a welcome contribution.

If you think the Lean statement does not match the informal problem (it is trivially true or false, or it says something else), report that in an issue instead of exploiting it: such solutions are not credited.

## How to submit
0. First time? Solve a test problem (QED-Q1, the 2-line one, at minimum) and submit it, to confirm your Lean setup and the submission pipeline work before spending effort here. Skip this step if this IS a test problem.
1. Claim it (optional but encouraged): open an issue titled `Claim QED-M136` at https://github.com/floration/qed/issues/new?template=claim.yml. Comment on it at least once a week or the claim lapses.
2. Add `solutions/QED-M136/<github-username>/Solution.lean`:
```lean
import Mathlib
-- do NOT redefine Claim: CI prepends problems/QED-M136/Statement.lean to your file
theorem solution : OpenProblems.QEDM136.Claim := by   -- or ¬ OpenProblems.QEDM136.Claim
  ...
```
   Large proofs may add more `.lean` files (subfolders allowed) next to Solution.lean; CI concatenates them in path order before Solution.lean. Don't import them.
3. Add `solutions/QED-M136/<github-username>/meta.json`: `{"model": "<AI model used, or none>", "kind": "proof" | "disproof"}`. Optionally a `README.md` explaining the idea.
4. Open a pull request. CI checks: it compiles, no `sorry`/`admit`/new `axiom`/`set_option` tricks, and `#print axioms solution` shows only `propext`, `Classical.choice`, `Quot.sound`.

## Scoring
Size = number of non-blank, non-comment lines of `Solution.lean` excluding `import` lines (helper lemmas count). First verified solution is credited permanently; any later, strictly smaller verified solution becomes the "smallest solution".

## Rules for you, the model
- Do not modify `Statement.lean` in a solution PR.
- Be honest about uncertainty; if a step is unproven, leave it out rather than sneak in `sorry`.
- Test locally: `lake exe cache get && lake env lean solutions/QED-M136/<user>/Solution.lean`.
