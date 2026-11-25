# QED-E115 — Rotor-router discs: logarithmic outer error

You are an AI model helping someone attack this open problem. Read all of this before working.

## The problem
Extended set · Grade B · QED Extension · Probability

**Plain words:** Release n chips one at a time at the origin of the square grid. Each grid point has an arrow, all initially pointing east. A chip at an occupied point turns that point's arrow a quarter turn counterclockwise and steps the way it now points, and it stops at the first empty point. The n occupied points form a strikingly round disc of radius about r = sqrt(n/pi): simulations up to about 7*10^10 chips show inner and outer radii differing by less than 1.7. It is proved that no hole lies deeper than C log r inside the circle, but the best bound for outward bulges is about sqrt(r) log r. Prove that no occupied point lies beyond r + C log r.

**Math:** Rotor-router aggregation on $\mathbb Z^2$: rotors $\rho:\mathbb Z^2\to\{E,N,W,S\}$ start identically $E$; chips are added one at a time at $0$; a chip at an occupied site advances that site's rotor one step counterclockwise ($E\to N\to W\to S\to E$) and moves one lattice step in the new direction, stopping at the first unoccupied site it reaches. Let $A_n$ be the set of occupied sites after $n$ chips and $r=\sqrt{n/\pi}$. Prove that there is a constant $C$ with $A_n\subseteq\{z\in\mathbb Z^2:\|z\|_2\le r+C\log(2+r)\}$ for all $n\ge1$. (Levine-Peres prove $\{z:\|z\|_2\le r-C\log(2+r)\}\cap\mathbb Z^2\subseteq A_n$ and $A_n\subseteq\{\|z\|_2\le r+C\sqrt r\log(2+r)\}$ for every initial rotor configuration.)

**Credit:** Propp's roundness question; inner/outer bounds and constant-error question from Levine & Peres (2009). The specific O(log r) outer target is my framing as the natural matching step.

**Rests on recent unrefereed work. Check these premises first:**
- Target O(log r) is my framing; literature frames the question as constant error
- Initial rotor configuration matters for the exact statement

**References:**
- https://arxiv.org/abs/0704.0688
- https://arxiv.org/pdf/0712.4358
- https://arxiv.org/pdf/1006.1003
- https://arxiv.org/pdf/1612.03701
- https://arxiv.org/pdf/1611.00411

Difficulty estimate: 6.0/10 (calibrated: Collatz ≈ 5.5, twin primes ≈ 5.0). It is believed open; do not assume a quick answer exists, and say so plainly if you cannot make progress. Never present a heuristic, numerical evidence, or a partial result as a solution.

## What counts as an answer
Either a proof of `OpenProblems.QEDE115.Claim` or a proof of `¬ OpenProblems.QEDE115.Claim` (a disproof), in Lean 4 + Mathlib, using the exact statement in `problems/QED-E115/Statement.lean`. Read its "Formalization notes" first. If that file still says `def Claim : Prop := sorry`, the problem must first be formalized (see CONTRIBUTING.md); a faithful formalization is itself a welcome contribution.

If you think the Lean statement does not match the informal problem (it is trivially true or false, or it says something else), report that in an issue instead of exploiting it: such solutions are not credited.

## How to submit
0. First time? Solve a test problem (QED-Q1, the 2-line one, at minimum) and submit it, to confirm your Lean setup and the submission pipeline work before spending effort here. Skip this step if this IS a test problem.
1. Claim it (optional but encouraged): open an issue titled `Claim QED-E115` at https://github.com/floration/qed/issues/new?template=claim.yml. Comment on it at least once a week or the claim lapses.
2. Add `solutions/QED-E115/<github-username>/Solution.lean`:
```lean
import Mathlib
-- do NOT redefine Claim: CI prepends problems/QED-E115/Statement.lean to your file
theorem solution : OpenProblems.QEDE115.Claim := by   -- or ¬ OpenProblems.QEDE115.Claim
  ...
```
   Large proofs may add more `.lean` files (subfolders allowed) next to Solution.lean; CI concatenates them in path order before Solution.lean. Don't import them.
3. Add `solutions/QED-E115/<github-username>/meta.json`: `{"model": "<AI model used, or none>", "kind": "proof" | "disproof"}`. Optionally a `README.md` explaining the idea.
4. Open a pull request. CI checks: it compiles, no `sorry`/`admit`/new `axiom`/`set_option` tricks, and `#print axioms solution` shows only `propext`, `Classical.choice`, `Quot.sound`.

## Scoring
Size = number of non-blank, non-comment lines of `Solution.lean` excluding `import` lines (helper lemmas count). First verified solution is credited permanently; any later, strictly smaller verified solution becomes the "smallest solution".

## Rules for you, the model
- Do not modify `Statement.lean` in a solution PR.
- Be honest about uncertainty; if a step is unproven, leave it out rather than sneak in `sorry`.
- Test locally: `lake exe cache get && lake env lean solutions/QED-E115/<user>/Solution.lean`.
