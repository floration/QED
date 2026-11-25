# QED-E204 — Solve x^2 + y^5 = z^7, the smallest open generalized Fermat equation

You are an AI model helping someone attack this open problem. Read all of this before working.

## The problem
Extended set · Grade B · QED Curated · Number theory

**Plain words:** Equations x^p + y^q = z^r with 1/p+1/q+1/r < 1 are expected to have only finitely many solutions in coprime integers, and many individual exponent triples have been solved. A 2024 survey identifies (2,5,7) as the unsolved triple with the smallest exponent sum. Show that x^2 + y^5 = z^7 has no solution in nonzero coprime integers.

**Math:** Prove that there are no $x,y,z\in\mathbb Z$ with $xyz\neq0$, $\gcd(x,y,z)=1$ and $x^2+y^5=z^7$. (Since 5 and 7 are odd and signs are allowed, this covers every arrangement of the exponents, e.g. $x^5+y^7=z^2$.)

**Credit:** Sub-case of the generalized Fermat (Fermat–Catalan) problem; identification of (2,5,7) as smallest open case from Grechuk et al. survey arXiv:2412.11933

**Rests on recent unrefereed work. Check these premises first:**
- Unrefereed IUT-based claim (Zhou, arXiv:2510.05448) may list (2,5,7) among 'solved' signatures; not accepted
- Survey's 'smallest sum' claim as of Dec 2024/2025 versions; a 2026 solution could exist unnoticed (searched, none found)
- Possible overlap with archived board item N-281 'A mixed Fermat equation' (content unknown)

**References:**
- https://arxiv.org/pdf/2412.11933v1
- https://arxiv.org/pdf/2609.26996
- https://arxiv.org/pdf/2512.04936
- https://arxiv.org/abs/2503.14510
- https://arxiv.org/pdf/1506.02860

Difficulty estimate: 6.0/10 (anchored scale: 1 ≈ Erdős–Ginzburg–Ziv, 2.5 ≈ the sensitivity conjecture, 5 ≈ bounded prime gaps, 7.5 ≈ the Riemann Hypothesis, 10 ≈ P vs NP). It is believed open; do not assume a quick answer exists, and say so plainly if you cannot make progress. Never present a heuristic, numerical evidence, or a partial result as a solution.

## What counts as an answer
Either a proof of `OpenProblems.QEDE204.Claim` or a proof of `¬ OpenProblems.QEDE204.Claim` (a disproof), in Lean 4 + Mathlib, using the exact statement in `problems/QED-E204/Statement.lean`. Read its "Formalization notes" first. If that file still says `def Claim : Prop := sorry`, the problem must first be formalized (see CONTRIBUTING.md); a faithful formalization is itself a welcome contribution.

If you think the Lean statement does not match the informal problem (it is trivially true or false, or it says something else), report that in an issue instead of exploiting it: such solutions are not credited.

## How to submit
0. First time? Solve a test problem (QED-Q1, the 2-line one, at minimum) and submit it, to confirm your Lean setup and the submission pipeline work before spending effort here. Skip this step if this IS a test problem.
1. Claim it (optional but encouraged): open an issue titled `Claim QED-E204` at https://github.com/floration/qed/issues/new?template=claim.yml. Comment on it at least once a week or the claim lapses.
2. Add `solutions/QED-E204/<github-username>/Solution.lean`:
```lean
import Mathlib
-- do NOT redefine Claim: CI prepends problems/QED-E204/Statement.lean to your file
theorem solution : OpenProblems.QEDE204.Claim := by   -- or ¬ OpenProblems.QEDE204.Claim
  ...
```
   Large proofs may add more `.lean` files (subfolders allowed) next to Solution.lean; CI concatenates them in path order before Solution.lean. Don't import them.
3. Add `solutions/QED-E204/<github-username>/meta.json`: `{"model": "<AI model used, or none>", "kind": "proof" | "disproof"}`. Optionally a `README.md` explaining the idea.
4. Open a pull request. CI checks: it compiles, no `sorry`/`admit`/new `axiom`/`set_option` tricks, and `#print axioms solution` shows only `propext`, `Classical.choice`, `Quot.sound`.

## Scoring
Size = number of non-blank, non-comment lines of `Solution.lean` excluding `import` lines (helper lemmas count). First verified solution is credited permanently; any later, strictly smaller verified solution becomes the "smallest solution".

## Rules for you, the model
- Do not modify `Statement.lean` in a solution PR.
- Be honest about uncertainty; if a step is unproven, leave it out rather than sneak in `sorry`.
- Test locally: `lake exe cache get && lake env lean solutions/QED-E204/<user>/Solution.lean`.
