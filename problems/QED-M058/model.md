# QED-M058 — Beat the (1-o(1)) log2 d exponent in quasi-polynomial polytope diameter bounds

You are an AI model helping someone attack this open problem. Read all of this before working.

## The problem
Main set · Grade B · QED Extension · Geometry

**Plain words:** All known bounds on the diameter of a d-dimensional polyhedron with n facets have the form (n−d)^{log₂ d − O(log log d)}. The latest (Liu–Ge–Ye 2026) is (n−d)^{log₂ G_d} with G_d ~ (4 ln 2) d/(ln d)². Get an exponent at most (1−ε) log₂ d.

**Math:** Let $\Delta_u(d,n)$ be the maximum graph diameter of a pointed $d$-polyhedron with $n$ facets. Known: $\Delta_u(d,n)\le (n-d)^{\log_2 G_d}$, $G_d=(4\ln2+o(1))d/(\ln d)^2$ (Liu–Ge–Ye 2026), after Kalai–Kleitman, Todd, Sukegawa. Prove $\Delta_u(d,n)\le (n-d)^{(1-\varepsilon)\log_2 d}$ for some fixed $\varepsilon>0$ and all large $d$.

**Credit:** Kalai-Kleitman 1992; Todd 2014 (arXiv:1402.3579); Sukegawa; Liu-Ge-Ye 2026 (arXiv:2609.33434)

**Rests on recent unrefereed work. Check these premises first:**
- arXiv:2609.33434 (Liu-Ge-Ye, 2026, unrefereed): the current best bound (n-d)^{log2 G_d}, G_d ~ (4 ln 2) d/(ln d)^2, and the claim that the leading term is sharp for path-counting recursions; recorded as context, Claim does not depend on it.

**References:**
- https://arxiv.org/abs/2609.33434
- https://arxiv.org/abs/1402.3579

Difficulty estimate: 4.5/10 (calibrated: Collatz ≈ 5.5, twin primes ≈ 5.0). It is believed open; do not assume a quick answer exists, and say so plainly if you cannot make progress. Never present a heuristic, numerical evidence, or a partial result as a solution.

## What counts as an answer
Either a proof of `OpenProblems.QEDM058.Claim` or a proof of `¬ OpenProblems.QEDM058.Claim` (a disproof), in Lean 4 + Mathlib, using the exact statement in `problems/QED-M058/Statement.lean`. Read its "Formalization notes" first. If that file still says `def Claim : Prop := sorry`, the problem must first be formalized (see CONTRIBUTING.md); a faithful formalization is itself a welcome contribution.

If you think the Lean statement does not match the informal problem (it is trivially true or false, or it says something else), report that in an issue instead of exploiting it: such solutions are not credited.

## How to submit
1. Claim it (optional but encouraged): open an issue titled `Claim QED-M058` at https://github.com/floration/qed/issues/new?template=claim.yml. Comment on it at least once a week or the claim lapses.
2. Add `solutions/QED-M058/<github-username>/Solution.lean`:
```lean
import Mathlib
-- do NOT redefine Claim: CI prepends problems/QED-M058/Statement.lean to your file
theorem solution : OpenProblems.QEDM058.Claim := by   -- or ¬ OpenProblems.QEDM058.Claim
  ...
```
   Large proofs may add more `.lean` files (subfolders allowed) next to Solution.lean; CI concatenates them in path order before Solution.lean. Don't import them.
3. Add `solutions/QED-M058/<github-username>/meta.json`: `{"model": "<AI model used, or none>", "kind": "proof" | "disproof"}`. Optionally a `README.md` explaining the idea.
4. Open a pull request. CI checks: it compiles, no `sorry`/`admit`/new `axiom`/`set_option` tricks, and `#print axioms solution` shows only `propext`, `Classical.choice`, `Quot.sound`.

## Scoring
Size = number of non-blank, non-comment lines of `Solution.lean` excluding `import` lines (helper lemmas count). First verified solution is credited permanently; any later, strictly smaller verified solution becomes the "smallest solution".

## Rules for you, the model
- Do not modify `Statement.lean` in a solution PR.
- Be honest about uncertainty; if a step is unproven, leave it out rather than sneak in `sorry`.
- Test locally: `lake exe cache get && lake env lean solutions/QED-M058/<user>/Solution.lean`.
