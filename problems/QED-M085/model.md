# QED-M085 — Second moment of 3-torsion in imaginary quadratic class groups

You are an AI model helping someone attack this open problem. Read all of this before working.

## The problem
Main set · Grade B · QED Curated · Number theory

**Plain words:** Davenport–Heilbronn showed the average of |Cl(K)[3]| over imaginary quadratic fields is 2, as Cohen–Lenstra predicts. Cohen–Lenstra also predict the average of |Cl(K)[3]|² is 6. Prove this, or at least that the average is bounded.

**Math:** Let $K$ range over imaginary quadratic fields with $|D_K|<X$. Cohen–Lenstra ($\mathbb E\,\#\mathrm{Sur}(\mathrm{Cl}_K,H)=1$ for $H=(\mathbb Z/3)^2$) predict $\frac{1}{\#\{K\}}\sum_K|\mathrm{Cl}_K[3]|^2\to 6$. Prove this limit, or prove $\sum_K|\mathrm{Cl}_K[3]|^2\ll X$.

**Credit:** Cohen, Lenstra, 'Heuristics on class groups of number fields', LNM 1068 (1984); Davenport-Heilbronn (1971) for the first moment

**References:**
- https://arxiv.org/abs/2606.06024

Difficulty estimate: 5.0/10 (calibrated: Collatz ≈ 5.5, twin primes ≈ 5.0). It is believed open; do not assume a quick answer exists, and say so plainly if you cannot make progress. Never present a heuristic, numerical evidence, or a partial result as a solution.

## What counts as an answer
Either a proof of `OpenProblems.QEDM085.Claim` or a proof of `¬ OpenProblems.QEDM085.Claim` (a disproof), in Lean 4 + Mathlib, using the exact statement in `problems/QED-M085/Statement.lean`. Read its "Formalization notes" first. If that file still says `def Claim : Prop := sorry`, the problem must first be formalized (see CONTRIBUTING.md); a faithful formalization is itself a welcome contribution.

If you think the Lean statement does not match the informal problem (it is trivially true or false, or it says something else), report that in an issue instead of exploiting it: such solutions are not credited.

## How to submit
1. Claim it (optional but encouraged): open an issue titled `Claim QED-M085` at https://github.com/floration/qed/issues/new?template=claim.yml. Comment on it at least once a week or the claim lapses.
2. Add `solutions/QED-M085/<github-username>/Solution.lean`:
```lean
import Mathlib
-- do NOT redefine Claim: CI prepends problems/QED-M085/Statement.lean to your file
theorem solution : OpenProblems.QEDM085.Claim := by   -- or ¬ OpenProblems.QEDM085.Claim
  ...
```
   Large proofs may add more `.lean` files (subfolders allowed) next to Solution.lean; CI concatenates them in path order before Solution.lean. Don't import them.
3. Add `solutions/QED-M085/<github-username>/meta.json`: `{"model": "<AI model used, or none>", "kind": "proof" | "disproof"}`. Optionally a `README.md` explaining the idea.
4. Open a pull request. CI checks: it compiles, no `sorry`/`admit`/new `axiom`/`set_option` tricks, and `#print axioms solution` shows only `propext`, `Classical.choice`, `Quot.sound`.

## Scoring
Size = number of non-blank, non-comment lines of `Solution.lean` excluding `import` lines (helper lemmas count). First verified solution is credited permanently; any later, strictly smaller verified solution becomes the "smallest solution".

## Rules for you, the model
- Do not modify `Statement.lean` in a solution PR.
- Be honest about uncertainty; if a step is unproven, leave it out rather than sneak in `sorry`.
- Test locally: `lake exe cache get && lake env lean solutions/QED-M085/<user>/Solution.lean`.
