# QED-E042 — Happy ending for heptagons: ES(7)=33

You are an AI model helping someone attack this open problem. Read all of this before working.

## The problem
Extended set · Grade B- · QED Curated · Geometry

**Plain words:** Among any 17 points in the plane with no three on a line, some 6 form a convex hexagon, and 16 points are not enough; this was proved by computer in 2006. Erdős and Szekeres predicted that the right number for convex 7-gons is 33. Prove that every 33 points in general position contain 7 in convex position.

**Math:** Let $ES(k)$ be the least $N$ such that every set of $N$ points in $\mathbb R^2$ with no three collinear contains $k$ points in convex position. Known $ES(k)\ge 2^{k-2}+1$ (Erdős–Szekeres 1961) with equality for $k\le6$; $ES(7)\le 113$. Prove $ES(7)=33$, i.e. every 33-point set in general position contains a convex heptagon (any rigorous improvement of $113$ is also progress).

**Reviewer note:** Known: $ES(6)=17$: Szekeres & Peters, ANZIAM J. 48 (2006). Small-$k$ bound $ES(k)\le\binom{2k-5}{k-2}-\binom{2k-8}{k-3}+2$ (Mojarrad & Vlachos, DCG 2016, arXiv:1510.06255), giving $ES(7)\le113$; earlier $\binom{2k-5}{k-2}+1=127$ (Tóth–Valtr 2005). Asymptotic $ES(k)\le2^{k+O(\sqrt{k\log k})}$: Suk, JAMS 2017 (refined by Holmsen–Mojarrad–Pach–Tardos). Empty hexagon $h(6)=30$: Heule & Scheucher, arXiv:2403.00737 (SoCG 2024). Dumitru, 'Notes on the 33-point Erdős–Szekeres problem', arXiv:2512.24061 (Dec 2025): SAT encoding, partial UNSAT only.

**Credit:** Erdős–Szekeres (1935/1961); Szekeres–Peters (2006); Mojarrad–Vlachos (2016)

**Rests on recent unrefereed work. Check these premises first:**
- a special case of a famous conjecture, but the genuine first open case
- an intermediate bound between 33 and 113 specific to k=7 might exist (none found)
- likely to fall to a large SAT computation; check for a 2026 announcement before publishing

**References:**
- https://arxiv.org/abs/2512.24061
- https://arxiv.org/abs/1510.06255
- https://arxiv.org/abs/2403.00737
- https://en.wikipedia.org/wiki/Happy_ending_problem

Difficulty estimate: 4.5/10 (calibrated: Collatz ≈ 5.5, twin primes ≈ 5.0). It is believed open; do not assume a quick answer exists, and say so plainly if you cannot make progress. Never present a heuristic, numerical evidence, or a partial result as a solution.

## What counts as an answer
Either a proof of `OpenProblems.QEDE042.Claim` or a proof of `¬ OpenProblems.QEDE042.Claim` (a disproof), in Lean 4 + Mathlib, using the exact statement in `problems/QED-E042/Statement.lean`. Read its "Formalization notes" first. If that file still says `def Claim : Prop := sorry`, the problem must first be formalized (see CONTRIBUTING.md); a faithful formalization is itself a welcome contribution.

If you think the Lean statement does not match the informal problem (it is trivially true or false, or it says something else), report that in an issue instead of exploiting it: such solutions are not credited.

## How to submit
1. Claim it (optional but encouraged): open an issue titled `Claim QED-E042` at https://github.com/floration/qed/issues/new?template=claim.yml. Comment on it at least once a week or the claim lapses.
2. Add `solutions/QED-E042/<github-username>/Solution.lean`:
```lean
import Mathlib
-- do NOT redefine Claim: CI prepends problems/QED-E042/Statement.lean to your file
theorem solution : OpenProblems.QEDE042.Claim := by   -- or ¬ OpenProblems.QEDE042.Claim
  ...
```
3. Add `solutions/QED-E042/<github-username>/meta.json`: `{"model": "<AI model used, or none>", "kind": "proof" | "disproof"}`. Optionally a `README.md` explaining the idea.
4. Open a pull request. CI checks: it compiles, no `sorry`/`admit`/new `axiom`/`set_option` tricks, and `#print axioms solution` shows only `propext`, `Classical.choice`, `Quot.sound`.

## Scoring
Size = number of non-blank, non-comment lines of `Solution.lean` excluding `import` lines (helper lemmas count). First verified solution is credited permanently; any later, strictly smaller verified solution becomes the "smallest solution".

## Rules for you, the model
- Do not modify `Statement.lean` in a solution PR.
- Be honest about uncertainty; if a step is unproven, leave it out rather than sneak in `sorry`.
- Test locally: `lake exe cache get && lake env lean solutions/QED-E042/<user>/Solution.lean`.
