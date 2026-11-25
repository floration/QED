# QED-E034 — Two sixth powers equal to four

You are an AI model helping someone attack this open problem. Read all of this before working.

## The problem
Extended set · Grade C · QED Curated · Number theory

**Plain words:** Can the sum of two sixth powers of positive integers equal the sum of four sixth powers? For sixth powers, three-equals-three examples are plentiful and two-equals-five examples are known, but nobody has found a two-equals-four example or proved there are none.

**Math:** Does $x_1^6+x_2^6=y_1^6+y_2^6+y_3^6+y_4^6$ have a solution in positive integers? (Any such solution is automatically nontrivial: cancelling a common term would leave a $6.1.3$ solution, itself unknown.) This is a boundary case $m+n=k$ of the Lander–Parkin–Selfridge conjecture for $k=6$, where only $6.3.3$ solutions are known.

**Reviewer note:** Known: MathWorld, 'Diophantine Equation--6th Powers': 'No solutions are known to the 6.2.3 or 6.2.4 equations'; 'No 6.1.n solutions are known for n<=6' (Lander–Parkin–Selfridge 1967; Guy, UPINT); Ekl (1996/1998) found no 6.2.2 solutions with sums below about $7.25\times10^{26}$. Smallest 6.2.5 solutions: Resta & Meyrignac, Math. Comp. 72 (2003). Parametric 6.3.3 solutions are classical (e.g. Brudno, Math. Comp. 1976). No refereed search bound specific to 6.2.4 found.

**Credit:** Lander–Parkin–Selfridge (1967); Ekl; Resta–Meyrignac

**Rests on recent unrefereed work. Check these premises first:**
- MathWorld's 'no 6.2.4 known' is unattributed and may lag distributed searches (EulerNet, Wróblewski's tables)
- no refereed search limit specific to 6.2.4 located

**References:**
- https://mathworld.wolfram.com/DiophantineEquation6thPowers.html
- https://en.wikipedia.org/wiki/Euler%27s_sum_of_powers_conjecture
- https://www.ams.org/mcom/2003-72-242/S0025-5718-02-01445-X/
- https://www.ams.org/mcom/1976-30-135/S0025-5718-1976-0406923-6/

Difficulty estimate: 4.5/10 (calibrated: Collatz ≈ 5.5, twin primes ≈ 5.0). It is believed open; do not assume a quick answer exists, and say so plainly if you cannot make progress. Never present a heuristic, numerical evidence, or a partial result as a solution.

## What counts as an answer
Either a proof of `OpenProblems.QEDE034.Claim` or a proof of `¬ OpenProblems.QEDE034.Claim` (a disproof), in Lean 4 + Mathlib, using the exact statement in `problems/QED-E034/Statement.lean`. Read its "Formalization notes" first. If that file still says `def Claim : Prop := sorry`, the problem must first be formalized (see CONTRIBUTING.md); a faithful formalization is itself a welcome contribution.

If you think the Lean statement does not match the informal problem (it is trivially true or false, or it says something else), report that in an issue instead of exploiting it: such solutions are not credited.

## How to submit
1. Claim it (optional but encouraged): open an issue titled `Claim QED-E034` at https://github.com/floration/qed/issues/new?template=claim.yml. Comment on it at least once a week or the claim lapses.
2. Add `solutions/QED-E034/<github-username>/Solution.lean`:
```lean
import Mathlib
-- do NOT redefine Claim: CI prepends problems/QED-E034/Statement.lean to your file
theorem solution : OpenProblems.QEDE034.Claim := by   -- or ¬ OpenProblems.QEDE034.Claim
  ...
```
   Large proofs may add more `.lean` files (subfolders allowed) next to Solution.lean; CI concatenates them in path order before Solution.lean. Don't import them.
3. Add `solutions/QED-E034/<github-username>/meta.json`: `{"model": "<AI model used, or none>", "kind": "proof" | "disproof"}`. Optionally a `README.md` explaining the idea.
4. Open a pull request. CI checks: it compiles, no `sorry`/`admit`/new `axiom`/`set_option` tricks, and `#print axioms solution` shows only `propext`, `Classical.choice`, `Quot.sound`.

## Scoring
Size = number of non-blank, non-comment lines of `Solution.lean` excluding `import` lines (helper lemmas count). First verified solution is credited permanently; any later, strictly smaller verified solution becomes the "smallest solution".

## Rules for you, the model
- Do not modify `Statement.lean` in a solution PR.
- Be honest about uncertainty; if a step is unproven, leave it out rather than sneak in `sorry`.
- Test locally: `lake exe cache get && lake env lean solutions/QED-E034/<user>/Solution.lean`.
