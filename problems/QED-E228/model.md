# QED-E228 — Consecutive primes alternating between 1 and 3 mod 4

You are an AI model helping someone attack this open problem. Read all of this before working.

## The problem
Extended set · Grade B · QED Original · Number theory

**Plain words:** Prime numbers other than 2 leave remainder 1 or 3 when divided by 4. Shiu proved that arbitrarily long runs of consecutive primes all with the same remainder occur. Show that, for every k, there are infinitely many runs of k consecutive primes whose remainders alternate 1, 3, 1, 3, .... Even k = 3 (a prime that is 3 mod 4 sandwiched between two primes that are 1 mod 4) is open.

**Math:** Let $p_n$ be the $n$-th prime. Prove that for every $k\ge3$ there are infinitely many $n$ with $p_{n+i}\equiv 2-(-1)^{i}\pmod 4$ for $0\le i<k$ (i.e. the residues run $1,3,1,3,\dots$). The first open case is $k=3$: infinitely many $n$ with $(p_n,p_{n+1},p_{n+2})\equiv(1,3,1)\pmod 4$.

**Credit:** QED original (archived Nov 2026, restored after re-review).

**References:**
- https://arxiv.org/abs/2409.12819
- https://arxiv.org/abs/1311.7003
- https://arxiv.org/abs/1603.03720

Difficulty estimate: 4.6/10 (calibrated: Collatz ≈ 5.5, twin primes ≈ 5.0). It is believed open; do not assume a quick answer exists, and say so plainly if you cannot make progress. Never present a heuristic, numerical evidence, or a partial result as a solution.

## What counts as an answer
Either a proof of `OpenProblems.QEDE228.Claim` or a proof of `¬ OpenProblems.QEDE228.Claim` (a disproof), in Lean 4 + Mathlib, using the exact statement in `problems/QED-E228/Statement.lean`. Read its "Formalization notes" first. If that file still says `def Claim : Prop := sorry`, the problem must first be formalized (see CONTRIBUTING.md); a faithful formalization is itself a welcome contribution.

If you think the Lean statement does not match the informal problem (it is trivially true or false, or it says something else), report that in an issue instead of exploiting it: such solutions are not credited.

## How to submit
0. First time? Solve a test problem (QED-Q1, the 2-line one, at minimum) and submit it, to confirm your Lean setup and the submission pipeline work before spending effort here. Skip this step if this IS a test problem.
1. Claim it (optional but encouraged): open an issue titled `Claim QED-E228` at https://github.com/floration/qed/issues/new?template=claim.yml. Comment on it at least once a week or the claim lapses.
2. Add `solutions/QED-E228/<github-username>/Solution.lean`:
```lean
import Mathlib
-- do NOT redefine Claim: CI prepends problems/QED-E228/Statement.lean to your file
theorem solution : OpenProblems.QEDE228.Claim := by   -- or ¬ OpenProblems.QEDE228.Claim
  ...
```
   Large proofs may add more `.lean` files (subfolders allowed) next to Solution.lean; CI concatenates them in path order before Solution.lean. Don't import them.
3. Add `solutions/QED-E228/<github-username>/meta.json`: `{"model": "<AI model used, or none>", "kind": "proof" | "disproof"}`. Optionally a `README.md` explaining the idea.
4. Open a pull request. CI checks: it compiles, no `sorry`/`admit`/new `axiom`/`set_option` tricks, and `#print axioms solution` shows only `propext`, `Classical.choice`, `Quot.sound`.

## Scoring
Size = number of non-blank, non-comment lines of `Solution.lean` excluding `import` lines (helper lemmas count). First verified solution is credited permanently; any later, strictly smaller verified solution becomes the "smallest solution".

## Rules for you, the model
- Do not modify `Statement.lean` in a solution PR.
- Be honest about uncertainty; if a step is unproven, leave it out rather than sneak in `sorry`.
- Test locally: `lake exe cache get && lake env lean solutions/QED-E228/<user>/Solution.lean`.
