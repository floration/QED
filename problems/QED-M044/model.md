# QED-M044 — Chaos in the double pendulum at every energy

You are an AI model helping someone attack this open problem. Read all of this before working.

## The problem
Main set · Grade B · QED Original · Dynamics · formerly N-652

**Plain words:** The planar double pendulum with equal masses and equal arms looks chaotic at moderate energies but almost regular at very low and very high energies. Prove that it has genuine (positive-entropy) chaos at every energy above the rest state.

**Math:** Let $H(\theta_1,\theta_2,p_1,p_2)$ be the Hamiltonian of the planar double pendulum with $m_1=m_2=\ell_1=\ell_2=g=1$ on $T^*\mathbb T^2$, with minimum value $E_0$ (the hanging rest state). Prove that for every $E>E_0$ the Hamiltonian flow restricted to $\{H=E\}$ has positive topological entropy.

**References:**
- https://arxiv.org/pdf/2312.13436
- https://arxiv.org/pdf/2403.07000

Difficulty estimate: 4.5/10 (calibrated: Collatz ≈ 5.5, twin primes ≈ 5.0). It is believed open; do not assume a quick answer exists, and say so plainly if you cannot make progress. Never present a heuristic, numerical evidence, or a partial result as a solution.

## What counts as an answer
Either a proof of `OpenProblems.QEDM044.Claim` or a proof of `¬ OpenProblems.QEDM044.Claim` (a disproof), in Lean 4 + Mathlib, using the exact statement in `problems/QED-M044/Statement.lean`. Read its "Formalization notes" first. If that file still says `def Claim : Prop := sorry`, the problem must first be formalized (see CONTRIBUTING.md); a faithful formalization is itself a welcome contribution.

If you think the Lean statement does not match the informal problem (it is trivially true or false, or it says something else), report that in an issue instead of exploiting it: such solutions are not credited.

## How to submit
1. Claim it (optional but encouraged): open an issue titled `Claim QED-M044` at https://github.com/floration/qed/issues/new?template=claim.yml. Comment on it at least once a week or the claim lapses.
2. Add `solutions/QED-M044/<github-username>/Solution.lean`:
```lean
import Mathlib
-- do NOT redefine Claim: CI prepends problems/QED-M044/Statement.lean to your file
theorem solution : OpenProblems.QEDM044.Claim := by   -- or ¬ OpenProblems.QEDM044.Claim
  ...
```
3. Add `solutions/QED-M044/<github-username>/meta.json`: `{"model": "<AI model used, or none>", "kind": "proof" | "disproof"}`. Optionally a `README.md` explaining the idea.
4. Open a pull request. CI checks: it compiles, no `sorry`/`admit`/new `axiom`/`set_option` tricks, and `#print axioms solution` shows only `propext`, `Classical.choice`, `Quot.sound`.

## Scoring
Size = number of non-blank, non-comment lines of `Solution.lean` excluding `import` lines (helper lemmas count). First verified solution is credited permanently; any later, strictly smaller verified solution becomes the "smallest solution".

## Rules for you, the model
- Do not modify `Statement.lean` in a solution PR.
- Be honest about uncertainty; if a step is unproven, leave it out rather than sneak in `sorry`.
- Test locally: `lake exe cache get && lake env lean solutions/QED-M044/<user>/Solution.lean`.
