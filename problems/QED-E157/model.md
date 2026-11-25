# QED-E157 — Square-free words from lists of size three

You are an AI model helping someone attack this open problem. Read all of this before working.

## The problem
Extended set · Grade A · QED Curated · Combinatorics

**Plain words:** Thue showed in 1906 that there is an infinite word over three letters with no square, that is, no block immediately repeated (like 'abab'). Now suppose each position i has its own list A_i of three allowed symbols, chosen by an adversary from an unbounded alphabet. Is there always an infinite square-free word whose i-th letter lies in A_i? Lists of size 4 are known to suffice, and size 3 suffices when all lists are drawn from only four symbols.

**Math:** Claim: for every sequence $(A_i)_{i\ge1}$ of sets $A_i\subseteq\mathbb N$ with $|A_i|=3$, there exists $w:\mathbb N_{\ge1}\to\mathbb N$ with $w(i)\in A_i$ for all $i$, such that there are no $i,k\ge1$ with $w(i+j)=w(i+k+j)$ for all $0\le j<k$. (By compactness, this is equivalent to the same statement for every finite length; that is, the Thue choice number of the path is $3$.)

**Credit:** Posed by J. Grytczuk, J. Przybyło and X. Zhu (2011) in the context of nonrepetitive list colouring; see M. Rosenfeld (2022), V. Bui and M. Rosenfeld (2025).

**Rests on recent unrefereed work. Check these premises first:**
- Occasionally referred to as a conjecture of Grytczuk–Przybyło–Zhu; the usual name is 'the Thue choice number of the path is 3' (object named after Thue), so naming rule is likely satisfied but should be checked

**References:**
- https://arxiv.org/abs/2104.09965
- https://arxiv.org/abs/2512.03670
- https://arxiv.org/abs/1508.02559
- https://arxiv.org/abs/1601.01886

Difficulty estimate: 5.5/10 (calibrated: Collatz ≈ 5.5, twin primes ≈ 5.0). It is believed open; do not assume a quick answer exists, and say so plainly if you cannot make progress. Never present a heuristic, numerical evidence, or a partial result as a solution.

## What counts as an answer
Either a proof of `OpenProblems.QEDE157.Claim` or a proof of `¬ OpenProblems.QEDE157.Claim` (a disproof), in Lean 4 + Mathlib, using the exact statement in `problems/QED-E157/Statement.lean`. Read its "Formalization notes" first. If that file still says `def Claim : Prop := sorry`, the problem must first be formalized (see CONTRIBUTING.md); a faithful formalization is itself a welcome contribution.

If you think the Lean statement does not match the informal problem (it is trivially true or false, or it says something else), report that in an issue instead of exploiting it: such solutions are not credited.

## How to submit
0. First time? Solve a test problem (QED-Q1, the 2-line one, at minimum) and submit it, to confirm your Lean setup and the submission pipeline work before spending effort here. Skip this step if this IS a test problem.
1. Claim it (optional but encouraged): open an issue titled `Claim QED-E157` at https://github.com/floration/qed/issues/new?template=claim.yml. Comment on it at least once a week or the claim lapses.
2. Add `solutions/QED-E157/<github-username>/Solution.lean`:
```lean
import Mathlib
-- do NOT redefine Claim: CI prepends problems/QED-E157/Statement.lean to your file
theorem solution : OpenProblems.QEDE157.Claim := by   -- or ¬ OpenProblems.QEDE157.Claim
  ...
```
   Large proofs may add more `.lean` files (subfolders allowed) next to Solution.lean; CI concatenates them in path order before Solution.lean. Don't import them.
3. Add `solutions/QED-E157/<github-username>/meta.json`: `{"model": "<AI model used, or none>", "kind": "proof" | "disproof"}`. Optionally a `README.md` explaining the idea.
4. Open a pull request. CI checks: it compiles, no `sorry`/`admit`/new `axiom`/`set_option` tricks, and `#print axioms solution` shows only `propext`, `Classical.choice`, `Quot.sound`.

## Scoring
Size = number of non-blank, non-comment lines of `Solution.lean` excluding `import` lines (helper lemmas count). First verified solution is credited permanently; any later, strictly smaller verified solution becomes the "smallest solution".

## Rules for you, the model
- Do not modify `Statement.lean` in a solution PR.
- Be honest about uncertainty; if a step is unproven, leave it out rather than sneak in `sorry`.
- Test locally: `lake exe cache get && lake env lean solutions/QED-E157/<user>/Solution.lean`.
