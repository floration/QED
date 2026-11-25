# QED-M081 — Lower the exponent 0.7785 for A4-quartic fields

You are an AI model helping someone attack this open problem. Read all of this before working.

## The problem
Main set · Grade B · QED Curated · Number theory

**Plain words:** Malle predicts about X^{1/2} log X quartic fields with Galois group A4 and discriminant up to X. Loughran–Paterson (2025) proved the matching lower bound. The best upper bound is still about X^{0.7785}. Lower the exponent.

**Math:** Let N_{A4}(X) count quartic L/Q with Gal(L~/Q)=A4 and |Delta_L|<=X. Known: X^{1/2} log X << N_{A4}(X) << X^{0.7784...+eps} (Loughran-Paterson arXiv:2510.05248 Thm 1.1; BSTTTZ JAMS 2020 Thm 1.4). Prove N_{A4}(X) << X^{beta} for some beta<0.7784 (ideally beta=1/2+eps).

**Credit:** Bhargava, Shankar, Taniguchi, Thorne, Tsimerman, Zhao, 'Bounds on 2-torsion in class groups of number fields and integral points on elliptic curves', JAMS 2020 (arXiv:1701.02458, Thm 1.4); Loughran-Paterson arXiv:2510.05248

**Rests on recent unrefereed work. Check these premises first:**
- arXiv:2510.05248 (Loughran-Paterson, 2025 preprint): lower bound X^{1/2} log X and the statement that 0.7784... is the current record; the Claim itself depends only on the refereed BSTTTZ exponent.
- arXiv:2602.23619 (Alberts-Bucur, 2026 preprint): cited only for the status 'no 2026 improvement'.

**References:**
- https://arxiv.org/abs/2510.05248
- https://arxiv.org/abs/2501.18574
- https://arxiv.org/abs/2502.04261
- arXiv:2510.05248
- arXiv:1701.02458 (BSTTTZ Thm 1.4)
- arXiv:2502.04261
- arXiv:2602.23619

Difficulty estimate: 4.0/10 (calibrated: Collatz ≈ 5.5, twin primes ≈ 5.0). It is believed open; do not assume a quick answer exists, and say so plainly if you cannot make progress. Never present a heuristic, numerical evidence, or a partial result as a solution.

## What counts as an answer
Either a proof of `OpenProblems.QEDM081.Claim` or a proof of `¬ OpenProblems.QEDM081.Claim` (a disproof), in Lean 4 + Mathlib, using the exact statement in `problems/QED-M081/Statement.lean`. Read its "Formalization notes" first. If that file still says `def Claim : Prop := sorry`, the problem must first be formalized (see CONTRIBUTING.md); a faithful formalization is itself a welcome contribution.

If you think the Lean statement does not match the informal problem (it is trivially true or false, or it says something else), report that in an issue instead of exploiting it: such solutions are not credited.

## How to submit
1. Claim it (optional but encouraged): open an issue titled `Claim QED-M081` at https://github.com/floration/qed/issues/new?template=claim.yml. Comment on it at least once a week or the claim lapses.
2. Add `solutions/QED-M081/<github-username>/Solution.lean`:
```lean
import Mathlib
-- do NOT redefine Claim: CI prepends problems/QED-M081/Statement.lean to your file
theorem solution : OpenProblems.QEDM081.Claim := by   -- or ¬ OpenProblems.QEDM081.Claim
  ...
```
3. Add `solutions/QED-M081/<github-username>/meta.json`: `{"model": "<AI model used, or none>", "kind": "proof" | "disproof"}`. Optionally a `README.md` explaining the idea.
4. Open a pull request. CI checks: it compiles, no `sorry`/`admit`/new `axiom`/`set_option` tricks, and `#print axioms solution` shows only `propext`, `Classical.choice`, `Quot.sound`.

## Scoring
Size = number of non-blank, non-comment lines of `Solution.lean` excluding `import` lines (helper lemmas count). First verified solution is credited permanently; any later, strictly smaller verified solution becomes the "smallest solution".

## Rules for you, the model
- Do not modify `Statement.lean` in a solution PR.
- Be honest about uncertainty; if a step is unproven, leave it out rather than sneak in `sorry`.
- Test locally: `lake exe cache get && lake env lean solutions/QED-M081/<user>/Solution.lean`.
