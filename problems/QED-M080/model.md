# QED-M080 — Largest prime factor of Markov numbers

You are an AI model helping someone attack this open problem. Read all of this before working.

## The problem
Main set · Grade B · QED Extension · Number theory

**Plain words:** Markov numbers are the numbers appearing in positive integer solutions of x^2+y^2+z^2=3xyz. Show that the largest prime factor of a Markov number tends to infinity. Equivalently, for any finite set of primes, only finitely many Markov numbers are built from those primes alone.

**Math:** Let $\mathcal M=\{m\ge1:\exists\,x,y\in\mathbb Z_{>0},\ x^2+y^2+m^2=3xym\}$ and let $P(m)$ denote the largest prime factor of $m$ (with $P(1)=1$). Prove that $P(m)\to\infty$ as $m\to\infty$ in $\mathcal M$; equivalently, for every finite set $S$ of primes, only finitely many $m\in\mathcal M$ are $S$-units.

**Credit:** Extends Corvaja–Zannier, 'On the greatest prime factor of Markov pairs', Rend. Sem. Mat. Univ. Padova 116 (2006).

**References:**
- https://www.numdam.org/item/RSMUP_2006__116__253_0/
- https://arxiv.org/abs/math/0606283
- https://arxiv.org/abs/1607.01530

Difficulty estimate: 4.5/10 (calibrated: Collatz ≈ 5.5, twin primes ≈ 5.0). It is believed open; do not assume a quick answer exists, and say so plainly if you cannot make progress. Never present a heuristic, numerical evidence, or a partial result as a solution.

## What counts as an answer
Either a proof of `OpenProblems.QEDM080.Claim` or a proof of `¬ OpenProblems.QEDM080.Claim` (a disproof), in Lean 4 + Mathlib, using the exact statement in `problems/QED-M080/Statement.lean`. Read its "Formalization notes" first. If that file still says `def Claim : Prop := sorry`, the problem must first be formalized (see CONTRIBUTING.md); a faithful formalization is itself a welcome contribution.

If you think the Lean statement does not match the informal problem (it is trivially true or false, or it says something else), report that in an issue instead of exploiting it: such solutions are not credited.

## How to submit
1. Claim it (optional but encouraged): open an issue titled `Claim QED-M080` at https://github.com/floration/qed/issues/new?template=claim.yml. Comment on it at least once a week or the claim lapses.
2. Add `solutions/QED-M080/<github-username>/Solution.lean`:
```lean
import Mathlib
-- do NOT redefine Claim: CI prepends problems/QED-M080/Statement.lean to your file
theorem solution : OpenProblems.QEDM080.Claim := by   -- or ¬ OpenProblems.QEDM080.Claim
  ...
```
   Large proofs may add more `.lean` files (subfolders allowed) next to Solution.lean; CI concatenates them in path order before Solution.lean. Don't import them.
3. Add `solutions/QED-M080/<github-username>/meta.json`: `{"model": "<AI model used, or none>", "kind": "proof" | "disproof"}`. Optionally a `README.md` explaining the idea.
4. Open a pull request. CI checks: it compiles, no `sorry`/`admit`/new `axiom`/`set_option` tricks, and `#print axioms solution` shows only `propext`, `Classical.choice`, `Quot.sound`.

## Scoring
Size = number of non-blank, non-comment lines of `Solution.lean` excluding `import` lines (helper lemmas count). First verified solution is credited permanently; any later, strictly smaller verified solution becomes the "smallest solution".

## Rules for you, the model
- Do not modify `Statement.lean` in a solution PR.
- Be honest about uncertainty; if a step is unproven, leave it out rather than sneak in `sorry`.
- Test locally: `lake exe cache get && lake env lean solutions/QED-M080/<user>/Solution.lean`.
