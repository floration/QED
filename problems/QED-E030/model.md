# QED-E030 — Order of magnitude of ex(n, C_8)

You are an AI model helping someone attack this open problem. Read all of this before working.

## The problem
Extended set · Grade B- · QED Curated · Combinatorics

**Plain words:** How many edges can a graph on n vertices have without containing a cycle of length 8? It is known to be at most about n^{5/4}, but the best constructions are smaller by a polynomial factor, unlike lengths 4, 6 and 10 where matching constructions exist. Find a C_8-free graph with about n^{5/4} edges, or prove a smaller upper bound.

**Math:** Determine whether $\mathrm{ex}(n,C_8)=\Theta(n^{5/4})$. Known: $\Omega(n^{6/5})\le\mathrm{ex}(n,C_8)\le O(n^{5/4})$. (In general $\mathrm{ex}(n,C_{2k})=O(n^{1+1/k})$ by Bondy-Simonovits, with matching order known only for $k\in\{2,3,5\}$; the lower bound $n^{6/5}$ comes from generalized hexagons and equals the Lazebnik-Ustimenko-Woldar bound $n^{1+2/(3k-3+\epsilon)}$ with $k=4,\epsilon=1$.) Equivalently: is there $c>0$ and $C_8$-free graphs with $\ge c\,n^{5/4}$ edges for infinitely many $n$? Any exponent above $6/5$ would also be progress.

**Reviewer note:** Known: Upper O(n^{5/4}): Bondy-Simonovits (1974); constants improved by Verstraete, Pikhurko, Bukh-Jiang. Lower Omega(n^{6/5}): incidence graph of a generalized hexagon (girth 12), matching Lazebnik-Ustimenko-Woldar n^{1+2/(3k-3+ε)} at k=4, ε=1; see Furedi-Simonovits, arXiv:1306.5167. Order known only for C_4, C_6, C_10 (Benson, Wenger, generalized polygons). 2026 work on C_8 (arXiv:2607.03856 generalized Turán; arXiv:2607.16103 planar Turán) does not touch the ordinary exponent.

**Credit:** Erdos; Bondy-Simonovits; Furedi-Simonovits survey.

**Rests on recent unrefereed work. Check these premises first:**
- Famous long-standing problem; may be judged better suited to the main set or too hard

**References:**
- https://arxiv.org/abs/1306.5167
- https://fanchung.ucsd.edu/erdosprb/erdos/newproblems/TuranEvenCycleLowerBound.html
- https://arxiv.org/abs/2607.03856
- https://arxiv.org/abs/2607.16103

Difficulty estimate: 6.5/10 (calibrated: Collatz ≈ 5.5, twin primes ≈ 5.0). It is believed open; do not assume a quick answer exists, and say so plainly if you cannot make progress. Never present a heuristic, numerical evidence, or a partial result as a solution.

## What counts as an answer
Either a proof of `OpenProblems.QEDE030.Claim` or a proof of `¬ OpenProblems.QEDE030.Claim` (a disproof), in Lean 4 + Mathlib, using the exact statement in `problems/QED-E030/Statement.lean`. Read its "Formalization notes" first. If that file still says `def Claim : Prop := sorry`, the problem must first be formalized (see CONTRIBUTING.md); a faithful formalization is itself a welcome contribution.

If you think the Lean statement does not match the informal problem (it is trivially true or false, or it says something else), report that in an issue instead of exploiting it: such solutions are not credited.

## How to submit
1. Claim it (optional but encouraged): open an issue titled `Claim QED-E030` at https://github.com/floration/qed/issues/new?template=claim.yml. Comment on it at least once a week or the claim lapses.
2. Add `solutions/QED-E030/<github-username>/Solution.lean`:
```lean
import Mathlib
-- do NOT redefine Claim: CI prepends problems/QED-E030/Statement.lean to your file
theorem solution : OpenProblems.QEDE030.Claim := by   -- or ¬ OpenProblems.QEDE030.Claim
  ...
```
3. Add `solutions/QED-E030/<github-username>/meta.json`: `{"model": "<AI model used, or none>", "kind": "proof" | "disproof"}`. Optionally a `README.md` explaining the idea.
4. Open a pull request. CI checks: it compiles, no `sorry`/`admit`/new `axiom`/`set_option` tricks, and `#print axioms solution` shows only `propext`, `Classical.choice`, `Quot.sound`.

## Scoring
Size = number of non-blank, non-comment lines of `Solution.lean` excluding `import` lines (helper lemmas count). First verified solution is credited permanently; any later, strictly smaller verified solution becomes the "smallest solution".

## Rules for you, the model
- Do not modify `Statement.lean` in a solution PR.
- Be honest about uncertainty; if a step is unproven, leave it out rather than sneak in `sorry`.
- Test locally: `lake exe cache get && lake env lean solutions/QED-E030/<user>/Solution.lean`.
