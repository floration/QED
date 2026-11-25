# QED-E023 — Does the Steiner system S(2,6,51) exist?

You are an AI model helping someone attack this open problem. Read all of this before working.

## The problem
Extended set · Grade B- · QED Curated · Combinatorics

**Plain words:** Can you choose 6-element groups from 51 objects so that every pair of objects lies together in exactly one group (that would take 85 groups)? The arithmetic allows it, but no one has built one or proved it impossible. This is the smallest such undecided case for groups of size 6.

**Math:** Decide whether there is a family $\mathcal B$ of $6$-subsets of a $51$-set $V$ such that every $2$-subset of $V$ lies in exactly one member of $\mathcal B$ (a $2$-$(51,6,1)$ design; necessarily $|\mathcal B|=85$ and each point is in $10$ blocks).

**Reviewer note:** Known: Necessary conditions v ≡ 1, 6 (mod 15). The Handbook of Combinatorial Designs (Abel-Greig) listed 29 undecided v. Banakh-Hetman-Ravsky, arXiv:2511.05191 (2025), construct S(2,6,226) and S(2,6,441), leaving 27 open: 51, 61, 81, 166, 231, 256, 261, 286, 316, 321, 346, 351, 376, 406, 411, 436, 471, 501, 561, 591, 616, 646, 651, 676, 771, 796, 801. S(2,6,46) does not exist (Houghten-Thiel-Janssen-Lam, 2001, exhaustive computation).

**Credit:** Handbook of Combinatorial Designs (Abel-Greig table); Banakh-Hetman-Ravsky (2025).

**Rests on recent unrefereed work. Check these premises first:**
- Exact open list taken from arXiv:2511.05191 as summarised; 51 being open should be double-checked against Abel's latest tables
- Exhaustive search may be far harder than v=46 so the problem could be practically intractable

**References:**
- https://arxiv.org/abs/2511.05191v2
- https://arxiv.org/html/2504.04293v2
- https://arxiv.org/abs/2401.08274v2

Difficulty estimate: 4.5/10 (calibrated: Collatz ≈ 5.5, twin primes ≈ 5.0). It is believed open; do not assume a quick answer exists, and say so plainly if you cannot make progress. Never present a heuristic, numerical evidence, or a partial result as a solution.

## What counts as an answer
Either a proof of `OpenProblems.QEDE023.Claim` or a proof of `¬ OpenProblems.QEDE023.Claim` (a disproof), in Lean 4 + Mathlib, using the exact statement in `problems/QED-E023/Statement.lean`. Read its "Formalization notes" first. If that file still says `def Claim : Prop := sorry`, the problem must first be formalized (see CONTRIBUTING.md); a faithful formalization is itself a welcome contribution.

If you think the Lean statement does not match the informal problem (it is trivially true or false, or it says something else), report that in an issue instead of exploiting it: such solutions are not credited.

## How to submit
1. Claim it (optional but encouraged): open an issue titled `Claim QED-E023` at https://github.com/floration/qed/issues/new?template=claim.yml. Comment on it at least once a week or the claim lapses.
2. Add `solutions/QED-E023/<github-username>/Solution.lean`:
```lean
import Mathlib
-- do NOT redefine Claim: CI prepends problems/QED-E023/Statement.lean to your file
theorem solution : OpenProblems.QEDE023.Claim := by   -- or ¬ OpenProblems.QEDE023.Claim
  ...
```
   Large proofs may add more `.lean` files (subfolders allowed) next to Solution.lean; CI concatenates them in path order before Solution.lean. Don't import them.
3. Add `solutions/QED-E023/<github-username>/meta.json`: `{"model": "<AI model used, or none>", "kind": "proof" | "disproof"}`. Optionally a `README.md` explaining the idea.
4. Open a pull request. CI checks: it compiles, no `sorry`/`admit`/new `axiom`/`set_option` tricks, and `#print axioms solution` shows only `propext`, `Classical.choice`, `Quot.sound`.

## Scoring
Size = number of non-blank, non-comment lines of `Solution.lean` excluding `import` lines (helper lemmas count). First verified solution is credited permanently; any later, strictly smaller verified solution becomes the "smallest solution".

## Rules for you, the model
- Do not modify `Statement.lean` in a solution PR.
- Be honest about uncertainty; if a step is unproven, leave it out rather than sneak in `sorry`.
- Test locally: `lake exe cache get && lake env lean solutions/QED-E023/<user>/Solution.lean`.
