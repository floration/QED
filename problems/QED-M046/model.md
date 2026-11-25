# QED-M046 — Deciding rationality of PL rotation numbers

You are an AI model helping someone attack this open problem. Read all of this before working.

## The problem
Main set · Grade B · QED Extension · Dynamics

**Plain words:** A circle homeomorphism made of finitely many straight pieces, with rational break points and slopes, has a rotation number. Rational rotation numbers can be confirmed by finding a rational periodic orbit. Irrational ones occur too: Belk–Hyde–Moore found √2−1 with slopes 3/2, 2/3, 1. Is there an algorithm that always decides which case holds?

**Math:** Let $\mathcal P$ be the set of orientation-preserving PL homeomorphisms of $\mathbb R/\mathbb Z$ with finitely many rational break points, rational slopes and $f(0)\in\mathbb Q$, encoded by these data. Is $\{f\in\mathcal P:\rho(f)\in\mathbb Q\}$ decidable? (It is computably enumerable: if $\rho(f)=p/q$, the zero set of the lift $F^q(x)-x-p$ is a nonempty finite union of rational points and rational intervals.)

**Credit:** Belk, Hyde, Moore (2022), arXiv:2211.05825, Questions 3–4.

**References:**
- https://arxiv.org/abs/2211.05825
- https://arxiv.org/abs/math/0604109
- https://arxiv.org/pdf/1609.00771
- https://arxiv.org/pdf/2505.13689

Difficulty estimate: 4.0/10 (calibrated: Collatz ≈ 5.5, twin primes ≈ 5.0). It is believed open; do not assume a quick answer exists, and say so plainly if you cannot make progress. Never present a heuristic, numerical evidence, or a partial result as a solution.

## What counts as an answer
Either a proof of `OpenProblems.QEDM046.Claim` or a proof of `¬ OpenProblems.QEDM046.Claim` (a disproof), in Lean 4 + Mathlib, using the exact statement in `problems/QED-M046/Statement.lean`. Read its "Formalization notes" first. If that file still says `def Claim : Prop := sorry`, the problem must first be formalized (see CONTRIBUTING.md); a faithful formalization is itself a welcome contribution.

If you think the Lean statement does not match the informal problem (it is trivially true or false, or it says something else), report that in an issue instead of exploiting it: such solutions are not credited.

## How to submit
1. Claim it (optional but encouraged): open an issue titled `Claim QED-M046` at https://github.com/floration/qed/issues/new?template=claim.yml. Comment on it at least once a week or the claim lapses.
2. Add `solutions/QED-M046/<github-username>/Solution.lean`:
```lean
import Mathlib
-- do NOT redefine Claim: CI prepends problems/QED-M046/Statement.lean to your file
theorem solution : OpenProblems.QEDM046.Claim := by   -- or ¬ OpenProblems.QEDM046.Claim
  ...
```
3. Add `solutions/QED-M046/<github-username>/meta.json`: `{"model": "<AI model used, or none>", "kind": "proof" | "disproof"}`. Optionally a `README.md` explaining the idea.
4. Open a pull request. CI checks: it compiles, no `sorry`/`admit`/new `axiom`/`set_option` tricks, and `#print axioms solution` shows only `propext`, `Classical.choice`, `Quot.sound`.

## Scoring
Size = number of non-blank, non-comment lines of `Solution.lean` excluding `import` lines (helper lemmas count). First verified solution is credited permanently; any later, strictly smaller verified solution becomes the "smallest solution".

## Rules for you, the model
- Do not modify `Statement.lean` in a solution PR.
- Be honest about uncertainty; if a step is unproven, leave it out rather than sneak in `sorry`.
- Test locally: `lake exe cache get && lake env lean solutions/QED-M046/<user>/Solution.lean`.
