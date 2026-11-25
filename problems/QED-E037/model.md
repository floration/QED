# QED-E037 — How many groups of order 2048?

You are an AI model helping someone attack this open problem. Read all of this before working.

## The problem
Extended set · Grade C · QED Curated · Algebra

**Plain words:** The number of groups is known exactly for every order below 2048; order 1024 alone has about 49 billion. For order 2048 = 2^11 the exact number of groups is still unknown, and only a lower bound of about 1.774 × 10^15 is proved. Determine the number, or at least prove that it is below 1.78 × 10^15, as experts expect.

**Math:** Let $g(n)$ be the number of isomorphism classes of groups of order $n$. Determine $g(2^{11})$. Known: $g(2^{11})\ge 1\,774\,274\,116\,992\,170$, the number of groups of order $2^{11}$ of $2$-class $2$ (exponent-$2$ Frattini quotient class 2). Natural intermediate target: prove $g(2^{11})<1.78\times10^{15}$, i.e. that the class-2 groups determine the first three significant digits.

**Reviewer note:** Known: $g(n)$ known for all $n<2048$ (Besche–Eick–O'Brien, 'The groups of order at most 2000', ERA-AMS 2001, plus later orders); $g(2^{10})=49\,487\,365\,422$ (later corrected to $49\,487\,367\,289$ in OEIS A000001). Lower bound $g(2^{11})\ge1\,774\,274\,116\,992\,170$ (Eick–O'Brien, 'Enumerating p-groups', J. Austral. Math. Soc. 1999; quoted in Conway–Dietrich–O'Brien, Math. Intelligencer 2008). No explicit nontrivial upper bound specific to $2^{11}$ located; general Higman–Sims bounds are far off.

**Credit:** Besche–Eick–O'Brien; Eick–O'Brien; Conway–Dietrich–O'Brien

**Rests on recent unrefereed work. Check these premises first:**
- mainly a large computation; exact value may need counting-without-listing techniques rather than new theory
- the 1.78e15 target encodes an expert expectation (first three digits), not a proved heuristic
- g(2^10) value: check the corrected OEIS figure before publishing

**References:**
- https://groupprops.subwiki.org/wiki/Groups_of_order_2048
- https://www.math.auckland.ac.nz/~obrien/research/gnu.pdf
- https://mathoverflow.net/questions/349355/has-gnu2048-been-found
- https://oeis.org/A000001

Difficulty estimate: 4.0/10 (calibrated: Collatz ≈ 5.5, twin primes ≈ 5.0). It is believed open; do not assume a quick answer exists, and say so plainly if you cannot make progress. Never present a heuristic, numerical evidence, or a partial result as a solution.

## What counts as an answer
Either a proof of `OpenProblems.QEDE037.Claim` or a proof of `¬ OpenProblems.QEDE037.Claim` (a disproof), in Lean 4 + Mathlib, using the exact statement in `problems/QED-E037/Statement.lean`. Read its "Formalization notes" first. If that file still says `def Claim : Prop := sorry`, the problem must first be formalized (see CONTRIBUTING.md); a faithful formalization is itself a welcome contribution.

If you think the Lean statement does not match the informal problem (it is trivially true or false, or it says something else), report that in an issue instead of exploiting it: such solutions are not credited.

## How to submit
0. First time? Solve a test problem (QED-Q1, the 2-line one, at minimum) and submit it, to confirm your Lean setup and the submission pipeline work before spending effort here. Skip this step if this IS a test problem.
1. Claim it (optional but encouraged): open an issue titled `Claim QED-E037` at https://github.com/floration/qed/issues/new?template=claim.yml. Comment on it at least once a week or the claim lapses.
2. Add `solutions/QED-E037/<github-username>/Solution.lean`:
```lean
import Mathlib
-- do NOT redefine Claim: CI prepends problems/QED-E037/Statement.lean to your file
theorem solution : OpenProblems.QEDE037.Claim := by   -- or ¬ OpenProblems.QEDE037.Claim
  ...
```
   Large proofs may add more `.lean` files (subfolders allowed) next to Solution.lean; CI concatenates them in path order before Solution.lean. Don't import them.
3. Add `solutions/QED-E037/<github-username>/meta.json`: `{"model": "<AI model used, or none>", "kind": "proof" | "disproof"}`. Optionally a `README.md` explaining the idea.
4. Open a pull request. CI checks: it compiles, no `sorry`/`admit`/new `axiom`/`set_option` tricks, and `#print axioms solution` shows only `propext`, `Classical.choice`, `Quot.sound`.

## Scoring
Size = number of non-blank, non-comment lines of `Solution.lean` excluding `import` lines (helper lemmas count). First verified solution is credited permanently; any later, strictly smaller verified solution becomes the "smallest solution".

## Rules for you, the model
- Do not modify `Statement.lean` in a solution PR.
- Be honest about uncertainty; if a step is unproven, leave it out rather than sneak in `sorry`.
- Test locally: `lake exe cache get && lake env lean solutions/QED-E037/<user>/Solution.lean`.
