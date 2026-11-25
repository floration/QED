# QED-M082 — Lower the exponent 1/2 in Pasten's subexponential abc bound

You are an AI model helping someone attack this open problem. Read all of this before working.

## The problem
Main set · Grade B · QED Extension · Number theory

**Plain words:** Unconditionally, abc is known only in very weak forms. Pasten (2024) proved that if a ≤ c^{1−η} then log c ≤ η^{-1} exp(κ√(log R · log log R)), with R = rad(abc). abc predicts log c ≤ (1+ε) log R + O(1). Replace the square root by any smaller power of log R.

**Math:** For coprime $a+b=c$ with $R=\mathrm{rad}(abc)$, Pasten (Invent. Math. 2024, Thm 1.4) proves: if $a\le c^{1-\eta}$ then $\log c\le \eta^{-1}\exp\big(\kappa\sqrt{\log R\,\log_2 R}\big)$; and $\log c\le q\exp(\kappa\sqrt{\log R\log_2R})$ with $q=\min\{P(a),P(b),P(c)\}$. Prove either statement with $\exp((\log R)^{\theta})$ for some fixed $\theta<1/2$, or $\exp(O(\sqrt{\log R}))$.

**Credit:** Extends H. Pasten, Invent. Math. 2024 (arXiv:2312.03566), Thm 1.4.

**Rests on recent unrefereed work. Check these premises first:**
- arXiv:2609.01327 (2026 preprint): cited in refs; M does not depend on it.

**References:**
- https://arxiv.org/abs/2312.03566
- https://arxiv.org/abs/2609.01327
- https://arxiv.org/abs/2505.10568

Difficulty estimate: 4.0/10 (calibrated: Collatz ≈ 5.5, twin primes ≈ 5.0). It is believed open; do not assume a quick answer exists, and say so plainly if you cannot make progress. Never present a heuristic, numerical evidence, or a partial result as a solution.

## What counts as an answer
Either a proof of `OpenProblems.QEDM082.Claim` or a proof of `¬ OpenProblems.QEDM082.Claim` (a disproof), in Lean 4 + Mathlib, using the exact statement in `problems/QED-M082/Statement.lean`. Read its "Formalization notes" first. If that file still says `def Claim : Prop := sorry`, the problem must first be formalized (see CONTRIBUTING.md); a faithful formalization is itself a welcome contribution.

If you think the Lean statement does not match the informal problem (it is trivially true or false, or it says something else), report that in an issue instead of exploiting it: such solutions are not credited.

## How to submit
1. Claim it (optional but encouraged): open an issue titled `Claim QED-M082` at https://github.com/floration/qed/issues/new?template=claim.yml. Comment on it at least once a week or the claim lapses.
2. Add `solutions/QED-M082/<github-username>/Solution.lean`:
```lean
import Mathlib
-- do NOT redefine Claim: CI prepends problems/QED-M082/Statement.lean to your file
theorem solution : OpenProblems.QEDM082.Claim := by   -- or ¬ OpenProblems.QEDM082.Claim
  ...
```
3. Add `solutions/QED-M082/<github-username>/meta.json`: `{"model": "<AI model used, or none>", "kind": "proof" | "disproof"}`. Optionally a `README.md` explaining the idea.
4. Open a pull request. CI checks: it compiles, no `sorry`/`admit`/new `axiom`/`set_option` tricks, and `#print axioms solution` shows only `propext`, `Classical.choice`, `Quot.sound`.

## Scoring
Size = number of non-blank, non-comment lines of `Solution.lean` excluding `import` lines (helper lemmas count). First verified solution is credited permanently; any later, strictly smaller verified solution becomes the "smallest solution".

## Rules for you, the model
- Do not modify `Statement.lean` in a solution PR.
- Be honest about uncertainty; if a step is unproven, leave it out rather than sneak in `sorry`.
- Test locally: `lake exe cache get && lake env lean solutions/QED-M082/<user>/Solution.lean`.
