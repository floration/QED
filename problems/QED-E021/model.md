# QED-E021 — Is R(3,10) equal to 40 or 41?

You are an AI model helping someone attack this open problem. Read all of this before working.

## The problem
Extended set · Grade B- · QED Curated · Combinatorics

**Plain words:** The Ramsey number R(3,10) is the fewest people at a party that guarantees either 3 mutual acquaintances or 10 mutual strangers. It is known to be 40 or 41, and nobody knows which. Settle it: either build a 40-vertex triangle-free graph with no 10 pairwise non-adjacent vertices, or show none exists.

**Math:** Let $R(3,10)$ be the least $n$ such that every graph on $n$ vertices contains $K_3$ or an independent set of size $10$. Known: $40\le R(3,10)\le 41$. Decide whether there exists a triangle-free graph $G$ on $40$ vertices with $\alpha(G)\le 9$ (equivalently whether $R(3,10)=41$).

**Reviewer note:** Known: Lower bound 40: Exoo (1989), a (3,10)-graph on 39 vertices. Upper bound 41: V. Angeltveit, 'R(3,10) <= 41', arXiv:2401.00392, Electron. J. Combin. 32(4) (2025) P4.30, improving 42 (Goedgebeur-Radziszowski 2013). Pandey-Ravi, arXiv:2601.03572 (Jan 2026), study structural properties of hypothetical critical graphs, quoting the older range 40-42 and assuming R(3,10)=42; they do not settle the value. No 2025-2026 resolution found.

**Credit:** Radziszowski dynamic survey 'Small Ramsey Numbers'; Angeltveit (2023/2025).

**Rests on recent unrefereed work. Check these premises first:**
- Angeltveit's upper bound is computer-assisted; if it had an error the range would revert to 40-42
- An unpublished construction or nonexistence proof could exist

**References:**
- https://arxiv.org/abs/2401.00392
- https://www.combinatorics.org/ojs/index.php/eljc/article/view/v32i4p30
- https://arxiv.org/abs/2601.03572v1

Difficulty estimate: 3.5/10 (calibrated: Collatz ≈ 5.5, twin primes ≈ 5.0). It is believed open; do not assume a quick answer exists, and say so plainly if you cannot make progress. Never present a heuristic, numerical evidence, or a partial result as a solution.

## What counts as an answer
Either a proof of `OpenProblems.QEDE021.Claim` or a proof of `¬ OpenProblems.QEDE021.Claim` (a disproof), in Lean 4 + Mathlib, using the exact statement in `problems/QED-E021/Statement.lean`. Read its "Formalization notes" first. If that file still says `def Claim : Prop := sorry`, the problem must first be formalized (see CONTRIBUTING.md); a faithful formalization is itself a welcome contribution.

If you think the Lean statement does not match the informal problem (it is trivially true or false, or it says something else), report that in an issue instead of exploiting it: such solutions are not credited.

## How to submit
1. Claim it (optional but encouraged): open an issue titled `Claim QED-E021` at https://github.com/floration/qed/issues/new?template=claim.yml. Comment on it at least once a week or the claim lapses.
2. Add `solutions/QED-E021/<github-username>/Solution.lean`:
```lean
import Mathlib
-- do NOT redefine Claim: CI prepends problems/QED-E021/Statement.lean to your file
theorem solution : OpenProblems.QEDE021.Claim := by   -- or ¬ OpenProblems.QEDE021.Claim
  ...
```
   Large proofs may add more `.lean` files (subfolders allowed) next to Solution.lean; CI concatenates them in path order before Solution.lean. Don't import them.
3. Add `solutions/QED-E021/<github-username>/meta.json`: `{"model": "<AI model used, or none>", "kind": "proof" | "disproof"}`. Optionally a `README.md` explaining the idea.
4. Open a pull request. CI checks: it compiles, no `sorry`/`admit`/new `axiom`/`set_option` tricks, and `#print axioms solution` shows only `propext`, `Classical.choice`, `Quot.sound`.

## Scoring
Size = number of non-blank, non-comment lines of `Solution.lean` excluding `import` lines (helper lemmas count). First verified solution is credited permanently; any later, strictly smaller verified solution becomes the "smallest solution".

## Rules for you, the model
- Do not modify `Statement.lean` in a solution PR.
- Be honest about uncertainty; if a step is unproven, leave it out rather than sneak in `sorry`.
- Test locally: `lake exe cache get && lake env lean solutions/QED-E021/<user>/Solution.lean`.
