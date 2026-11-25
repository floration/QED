# QED-M023 — Monochromatic square-sum triangles, many colours

You are an AI model helping someone attack this open problem. Read all of this before working.

## The problem
Main set · Grade B · QED Extension · Combinatorics

**Plain words:** Colour the positive integers with finitely many colours. Show there are always three different numbers of the same colour whose three pairwise sums are all perfect squares.

**Math:** Prove that for every $r\ge1$ and every colouring $\chi:\mathbb N\to\{1,\dots,r\}$ there exist distinct $a,b,c\in\mathbb N$ with $\chi(a)=\chi(b)=\chi(c)$ and $a+b,\ a+c,\ b+c$ all perfect squares. (Equivalently: the triangle hypergraph of the graph on $\mathbb N$ with $a\sim b\iff a+b=\square$ has infinite chromatic number.)

**Credit:** Khalfalah–Szemerédi (2006), monochromatic x+y = z² for finite colourings.

**References:**
- https://arxiv.org/pdf/1608.08374
- https://arxiv.org/pdf/1805.06279
- https://arxiv.org/pdf/2501.17203
- https://arxiv.org/pdf/1806.05002
- https://arxiv.org/pdf/2309.10636

Difficulty estimate: 4.5/10 (calibrated: Collatz ≈ 5.5, twin primes ≈ 5.0). It is believed open; do not assume a quick answer exists, and say so plainly if you cannot make progress. Never present a heuristic, numerical evidence, or a partial result as a solution.

## What counts as an answer
Either a proof of `OpenProblems.QEDM023.Claim` or a proof of `¬ OpenProblems.QEDM023.Claim` (a disproof), in Lean 4 + Mathlib, using the exact statement in `problems/QED-M023/Statement.lean`. Read its "Formalization notes" first. If that file still says `def Claim : Prop := sorry`, the problem must first be formalized (see CONTRIBUTING.md); a faithful formalization is itself a welcome contribution.

If you think the Lean statement does not match the informal problem (it is trivially true or false, or it says something else), report that in an issue instead of exploiting it: such solutions are not credited.

## How to submit
1. Claim it (optional but encouraged): open an issue titled `Claim QED-M023` at https://github.com/floration/qed/issues/new?template=claim.yml. Comment on it at least once a week or the claim lapses.
2. Add `solutions/QED-M023/<github-username>/Solution.lean`:
```lean
import Mathlib
-- do NOT redefine Claim: CI prepends problems/QED-M023/Statement.lean to your file
theorem solution : OpenProblems.QEDM023.Claim := by   -- or ¬ OpenProblems.QEDM023.Claim
  ...
```
3. Add `solutions/QED-M023/<github-username>/meta.json`: `{"model": "<AI model used, or none>", "kind": "proof" | "disproof"}`. Optionally a `README.md` explaining the idea.
4. Open a pull request. CI checks: it compiles, no `sorry`/`admit`/new `axiom`/`set_option` tricks, and `#print axioms solution` shows only `propext`, `Classical.choice`, `Quot.sound`.

## Scoring
Size = number of non-blank, non-comment lines of `Solution.lean` excluding `import` lines (helper lemmas count). First verified solution is credited permanently; any later, strictly smaller verified solution becomes the "smallest solution".

## Rules for you, the model
- Do not modify `Statement.lean` in a solution PR.
- Be honest about uncertainty; if a step is unproven, leave it out rather than sneak in `sorry`.
- Test locally: `lake exe cache get && lake env lean solutions/QED-M023/<user>/Solution.lean`.
