# QED-E217 — Does a generalized quadrangle of order (4,11) exist?

You are an AI model helping someone attack this open problem. Read all of this before working.

## The problem
Extended set · Grade B · QED Curated · Combinatorics

**Plain words:** A generalized quadrangle of order (s,t) is a point-line geometry in which every line has s+1 points, every point is on t+1 lines, two points share at most one line, and for every point P not on a line L exactly one point of L is collinear with P. For five points per line (s=4), the standard counting conditions allow t in {1,2,4,6,8,11,12,16}, and all but t=11 and t=12 are realised. Decide whether such a quadrangle exists for t=11 (the case t=12 is a separate problem).

**Math:** For t = 11 only: decide whether there exists a finite incidence structure with nonempty point set, every line of size 5, every point on exactly 12 lines, two distinct lines meeting in at most one point, and for every P not on L exactly one Q on L collinear with P. (Case t = 12 to be posed as a separate problem with the same definitions.)

**Credit:** Open problem in Payne–Thas, Finite Generalized Quadrangles; SRG status from A. E. Brouwer's tables.

**Rests on recent unrefereed work. Check these premises first:**
- Two-case question; could be split into GQ(4,11) and GQ(4,12) separately
- Could not locate a 2024-2026 source that explicitly restates 'GQ(4,11), GQ(4,12) open', status inferred from Brouwer's live SRG table (point graphs open) and Payne–Thas

**References:**
- https://aeb.win.tue.nl/graphs/srg/srgtab201-250.html
- https://arxiv.org/abs/2504.09372
- https://arxiv.org/abs/1205.1431
- https://arxiv.org/abs/1909.07609

Difficulty estimate: 3.5/10 (calibrated: Collatz ≈ 5.5, twin primes ≈ 5.0). It is believed open; do not assume a quick answer exists, and say so plainly if you cannot make progress. Never present a heuristic, numerical evidence, or a partial result as a solution.

## What counts as an answer
Either a proof of `OpenProblems.QEDE217.Claim` or a proof of `¬ OpenProblems.QEDE217.Claim` (a disproof), in Lean 4 + Mathlib, using the exact statement in `problems/QED-E217/Statement.lean`. Read its "Formalization notes" first. If that file still says `def Claim : Prop := sorry`, the problem must first be formalized (see CONTRIBUTING.md); a faithful formalization is itself a welcome contribution.

If you think the Lean statement does not match the informal problem (it is trivially true or false, or it says something else), report that in an issue instead of exploiting it: such solutions are not credited.

## How to submit
0. First time? Solve a test problem (QED-Q1, the 2-line one, at minimum) and submit it, to confirm your Lean setup and the submission pipeline work before spending effort here. Skip this step if this IS a test problem.
1. Claim it (optional but encouraged): open an issue titled `Claim QED-E217` at https://github.com/floration/qed/issues/new?template=claim.yml. Comment on it at least once a week or the claim lapses.
2. Add `solutions/QED-E217/<github-username>/Solution.lean`:
```lean
import Mathlib
-- do NOT redefine Claim: CI prepends problems/QED-E217/Statement.lean to your file
theorem solution : OpenProblems.QEDE217.Claim := by   -- or ¬ OpenProblems.QEDE217.Claim
  ...
```
   Large proofs may add more `.lean` files (subfolders allowed) next to Solution.lean; CI concatenates them in path order before Solution.lean. Don't import them.
3. Add `solutions/QED-E217/<github-username>/meta.json`: `{"model": "<AI model used, or none>", "kind": "proof" | "disproof"}`. Optionally a `README.md` explaining the idea.
4. Open a pull request. CI checks: it compiles, no `sorry`/`admit`/new `axiom`/`set_option` tricks, and `#print axioms solution` shows only `propext`, `Classical.choice`, `Quot.sound`.

## Scoring
Size = number of non-blank, non-comment lines of `Solution.lean` excluding `import` lines (helper lemmas count). First verified solution is credited permanently; any later, strictly smaller verified solution becomes the "smallest solution".

## Rules for you, the model
- Do not modify `Statement.lean` in a solution PR.
- Be honest about uncertainty; if a step is unproven, leave it out rather than sneak in `sorry`.
- Test locally: `lake exe cache get && lake env lean solutions/QED-E217/<user>/Solution.lean`.
