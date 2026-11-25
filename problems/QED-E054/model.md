# QED-E054 — Is Grundy's game eventually periodic?

You are an AI model helping someone attack this open problem. Read all of this before working.

## The problem
Extended set · Grade C · QED Curated · Games

**Plain words:** In Grundy's game, players take turns splitting a pile of coins into two smaller piles of different sizes, and whoever cannot move loses. The game's theory reduces to one number per pile size, its Grundy value. These values have been computed for piles of hundreds of billions of coins and show no repeating pattern yet, though Berlekamp, Conway and Guy conjectured that they eventually repeat. Do they?

**Math:** Let $g(0)=g(1)=g(2)=0$ and for $n\ge3$ let $g(n)=\operatorname{mex}\{g(a)\oplus g(b): a+b=n,\ 1\le a<b\}$, where $\oplus$ is bitwise XOR. Is $g$ eventually periodic, i.e. are there $N,p\ge1$ with $g(n+p)=g(n)$ for all $n\ge N$? (Weaker open question: is $g$ bounded?)

**Reviewer note:** Known: Berlekamp–Conway–Guy (Winning Ways) conjecture eventual periodicity; Wikipedia says it is unresolved. Flammenkamp's octal-games page, Table 2 entry for Grundy's game: values computed for all n up to '239', most likely $2^{39}$ with the superscript lost. The largest known value is 297, attained at n = 21544358589, and 1287 rare values are known, the largest at 48399022. Wikipedia's text reads 'first 235 values', most likely $2^{35}$. OEIS A002188. Golomb's periodicity for finite subtraction games does not apply.

**Credit:** Berlekamp, Conway & Guy, Winning Ways; computations by A. Flammenkamp

**Rests on recent unrefereed work. Check these premises first:**
- Computed range: '239' and '235' are superscript-lost renderings (2^39 and 2^35 most likely); not verified from a clean source
- Classic problem with no clear modern angle

**References:**
- https://en.wikipedia.org/wiki/Grundy%27s_game
- https://wwwhomes.uni-bielefeld.de/achim/octal.html
- https://oeis.org/A002188

Difficulty estimate: 6.0/10 (calibrated: Collatz ≈ 5.5, twin primes ≈ 5.0). It is believed open; do not assume a quick answer exists, and say so plainly if you cannot make progress. Never present a heuristic, numerical evidence, or a partial result as a solution.

## What counts as an answer
Either a proof of `OpenProblems.QEDE054.Claim` or a proof of `¬ OpenProblems.QEDE054.Claim` (a disproof), in Lean 4 + Mathlib, using the exact statement in `problems/QED-E054/Statement.lean`. Read its "Formalization notes" first. If that file still says `def Claim : Prop := sorry`, the problem must first be formalized (see CONTRIBUTING.md); a faithful formalization is itself a welcome contribution.

If you think the Lean statement does not match the informal problem (it is trivially true or false, or it says something else), report that in an issue instead of exploiting it: such solutions are not credited.

## How to submit
1. Claim it (optional but encouraged): open an issue titled `Claim QED-E054` at https://github.com/floration/qed/issues/new?template=claim.yml. Comment on it at least once a week or the claim lapses.
2. Add `solutions/QED-E054/<github-username>/Solution.lean`:
```lean
import Mathlib
-- do NOT redefine Claim: CI prepends problems/QED-E054/Statement.lean to your file
theorem solution : OpenProblems.QEDE054.Claim := by   -- or ¬ OpenProblems.QEDE054.Claim
  ...
```
3. Add `solutions/QED-E054/<github-username>/meta.json`: `{"model": "<AI model used, or none>", "kind": "proof" | "disproof"}`. Optionally a `README.md` explaining the idea.
4. Open a pull request. CI checks: it compiles, no `sorry`/`admit`/new `axiom`/`set_option` tricks, and `#print axioms solution` shows only `propext`, `Classical.choice`, `Quot.sound`.

## Scoring
Size = number of non-blank, non-comment lines of `Solution.lean` excluding `import` lines (helper lemmas count). First verified solution is credited permanently; any later, strictly smaller verified solution becomes the "smallest solution".

## Rules for you, the model
- Do not modify `Statement.lean` in a solution PR.
- Be honest about uncertainty; if a step is unproven, leave it out rather than sneak in `sorry`.
- Test locally: `lake exe cache get && lake env lean solutions/QED-E054/<user>/Solution.lean`.
