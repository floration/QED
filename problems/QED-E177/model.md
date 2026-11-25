# QED-E177 — Decision-tree depth below the cube of degree

You are an AI model helping someone attack this open problem. Read all of this before working.

## The problem
Extended set · Grade A · QED Curated · Complexity

**Plain words:** Every Boolean function f on n bits is uniquely a real multilinear polynomial; let deg(f) be its degree and D(f) the fewest adaptive bit queries that always determine f(x). Since 2004 we know D(f) <= deg(f)^3, while the largest known gap is only about quadratic. Lower the exponent 3: show D(f) <= C·deg(f)^{3-ε} for some fixed ε > 0.

**Math:** For $f:\{0,1\}^n\to\{0,1\}$ let $D(f)$ be the minimum depth of a deterministic decision tree computing $f$, and $\deg(f)$ the degree of the unique multilinear polynomial over $\mathbb R$ agreeing with $f$. Prove there exist $\varepsilon>0$ and $C$ such that $D(f)\le C\,\deg(f)^{3-\varepsilon}$ for all $n$ and all $f$. (Stronger, also open: $D(f)=O(\deg(f)^2)$, which would be tight up to log factors by pointer functions.)

**Credit:** Open question going back to Nisan–Szegedy/Nisan–Smolensky; stated e.g. in Midrijanis (2004), Mande–Sanyal (2023), ABKRT (2021).

**Rests on recent unrefereed work. Check these premises first:**
- Stated as 'break the cube' rather than the tight quadratic target; the tight O(deg^2) version is also open and could be offered as a stronger variant
- Potential overlap in spirit with the sensitivity-vs-block-sensitivity candidate from the same batch (both are polynomial-relation exponents)

**References:**
- https://arxiv.org/abs/2209.08042
- https://www.arxiv.org/pdf/2601.08727
- https://eccc.weizmann.ac.il/report/2026/005/
- https://arxiv.org/abs/1506.04719

Difficulty estimate: 7.0/10 (calibrated: Collatz ≈ 5.5, twin primes ≈ 5.0). It is believed open; do not assume a quick answer exists, and say so plainly if you cannot make progress. Never present a heuristic, numerical evidence, or a partial result as a solution.

## What counts as an answer
Either a proof of `OpenProblems.QEDE177.Claim` or a proof of `¬ OpenProblems.QEDE177.Claim` (a disproof), in Lean 4 + Mathlib, using the exact statement in `problems/QED-E177/Statement.lean`. Read its "Formalization notes" first. If that file still says `def Claim : Prop := sorry`, the problem must first be formalized (see CONTRIBUTING.md); a faithful formalization is itself a welcome contribution.

If you think the Lean statement does not match the informal problem (it is trivially true or false, or it says something else), report that in an issue instead of exploiting it: such solutions are not credited.

## How to submit
0. First time? Solve a test problem (QED-Q1, the 2-line one, at minimum) and submit it, to confirm your Lean setup and the submission pipeline work before spending effort here. Skip this step if this IS a test problem.
1. Claim it (optional but encouraged): open an issue titled `Claim QED-E177` at https://github.com/floration/qed/issues/new?template=claim.yml. Comment on it at least once a week or the claim lapses.
2. Add `solutions/QED-E177/<github-username>/Solution.lean`:
```lean
import Mathlib
-- do NOT redefine Claim: CI prepends problems/QED-E177/Statement.lean to your file
theorem solution : OpenProblems.QEDE177.Claim := by   -- or ¬ OpenProblems.QEDE177.Claim
  ...
```
   Large proofs may add more `.lean` files (subfolders allowed) next to Solution.lean; CI concatenates them in path order before Solution.lean. Don't import them.
3. Add `solutions/QED-E177/<github-username>/meta.json`: `{"model": "<AI model used, or none>", "kind": "proof" | "disproof"}`. Optionally a `README.md` explaining the idea.
4. Open a pull request. CI checks: it compiles, no `sorry`/`admit`/new `axiom`/`set_option` tricks, and `#print axioms solution` shows only `propext`, `Classical.choice`, `Quot.sound`.

## Scoring
Size = number of non-blank, non-comment lines of `Solution.lean` excluding `import` lines (helper lemmas count). First verified solution is credited permanently; any later, strictly smaller verified solution becomes the "smallest solution".

## Rules for you, the model
- Do not modify `Statement.lean` in a solution PR.
- Be honest about uncertainty; if a step is unproven, leave it out rather than sneak in `sorry`.
- Test locally: `lake exe cache get && lake env lean solutions/QED-E177/<user>/Solution.lean`.
