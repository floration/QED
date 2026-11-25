# QED-E139 — Does the odd greedy algorithm always terminate?

You are an AI model helping someone attack this open problem. Read all of this before working.

## The problem
Extended set · Grade B · QED Curated · Number theory

**Plain words:** Every fraction with an odd denominator can be written as a sum of distinct unit fractions with odd denominators. The odd greedy algorithm tries to find such a sum by repeatedly subtracting the largest unit fraction 1/n, with n odd, that still fits. Does it always stop after finitely many steps when the starting fraction has an odd denominator? In every case tested it does, sometimes only after surprisingly many steps.

**Math:** For $x\in\mathbb Q\cap(0,1)$ with odd denominator, set $x_0=x$. While $x_k>0$, let $n_k$ be the least odd integer with $1/n_k\le x_k$ and set $x_{k+1}=x_k-1/n_k$. Prove or disprove: for every such $x$ there is a $k$ with $x_k=0$.

**Credit:** Stein, Selfridge, Graham (via Guy UPINT; Klee–Wagon 1991); erdosproblems.com #282.

**Rests on recent unrefereed work. Check these premises first:**
- Appears on erdosproblems.com; not itself person-named, but the owner may count 'Erdős problem #282' as person-attributed
- May be considered a 'Collatz-type' problem with little available theory

**References:**
- https://en.wikipedia.org/wiki/Odd_greedy_expansion
- https://google-deepmind.github.io/formal-conjectures/doc/FormalConjectures/ErdosProblems/282.html
- https://arxiv.org/abs/2309.07280
- https://www.mathpages.com/home/kmath478.htm
- https://ics.uci.edu/~eppstein/numth/egypt/3-179.html

Difficulty estimate: 5.5/10 (calibrated: Collatz ≈ 5.5, twin primes ≈ 5.0). It is believed open; do not assume a quick answer exists, and say so plainly if you cannot make progress. Never present a heuristic, numerical evidence, or a partial result as a solution.

## What counts as an answer
Either a proof of `OpenProblems.QEDE139.Claim` or a proof of `¬ OpenProblems.QEDE139.Claim` (a disproof), in Lean 4 + Mathlib, using the exact statement in `problems/QED-E139/Statement.lean`. Read its "Formalization notes" first. If that file still says `def Claim : Prop := sorry`, the problem must first be formalized (see CONTRIBUTING.md); a faithful formalization is itself a welcome contribution.

If you think the Lean statement does not match the informal problem (it is trivially true or false, or it says something else), report that in an issue instead of exploiting it: such solutions are not credited.

## How to submit
0. First time? Solve a test problem (QED-Q1, the 2-line one, at minimum) and submit it, to confirm your Lean setup and the submission pipeline work before spending effort here. Skip this step if this IS a test problem.
1. Claim it (optional but encouraged): open an issue titled `Claim QED-E139` at https://github.com/floration/qed/issues/new?template=claim.yml. Comment on it at least once a week or the claim lapses.
2. Add `solutions/QED-E139/<github-username>/Solution.lean`:
```lean
import Mathlib
-- do NOT redefine Claim: CI prepends problems/QED-E139/Statement.lean to your file
theorem solution : OpenProblems.QEDE139.Claim := by   -- or ¬ OpenProblems.QEDE139.Claim
  ...
```
   Large proofs may add more `.lean` files (subfolders allowed) next to Solution.lean; CI concatenates them in path order before Solution.lean. Don't import them.
3. Add `solutions/QED-E139/<github-username>/meta.json`: `{"model": "<AI model used, or none>", "kind": "proof" | "disproof"}`. Optionally a `README.md` explaining the idea.
4. Open a pull request. CI checks: it compiles, no `sorry`/`admit`/new `axiom`/`set_option` tricks, and `#print axioms solution` shows only `propext`, `Classical.choice`, `Quot.sound`.

## Scoring
Size = number of non-blank, non-comment lines of `Solution.lean` excluding `import` lines (helper lemmas count). First verified solution is credited permanently; any later, strictly smaller verified solution becomes the "smallest solution".

## Rules for you, the model
- Do not modify `Statement.lean` in a solution PR.
- Be honest about uncertainty; if a step is unproven, leave it out rather than sneak in `sorry`.
- Test locally: `lake exe cache get && lake env lean solutions/QED-E139/<user>/Solution.lean`.
