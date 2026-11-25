# QED-E039 — Cover any 3D convex body with 13 smaller copies

You are an AI model helping someone attack this open problem. Read all of this before working.

## The problem
Extended set · Grade B- · QED Curated · Geometry

**Plain words:** Take any bounded convex solid in space. How many strictly smaller copies of it (scaled down, translated, not rotated) are always enough to cover it? A cube needs 8, and Hadwiger conjectured 8 always suffice. The best proved number is 14. Prove that 13 always suffice.

**Math:** For a convex body $K\subset\mathbb R^3$ let $H(K)$ be the least $m$ such that $K\subseteq\bigcup_{i=1}^m (\lambda K + t_i)$ for some $0<\lambda<1$, $t_i\in\mathbb R^3$ (equivalently the illumination number). Let $H_3=\sup_K H(K)$. Known $8\le H_3\le 14$. Prove $H_3\le 13$.

**Reviewer note:** Known: $H_3\le14$: A. Prymak, 'A new bound for Hadwiger's covering problem in $\mathbb E^3$', SIAM J. Discrete Math. 37 (2023) 17–24, arXiv:2112.10698. Earlier $H_3\le16$: Papadoperakis, Geom. Dedicata 75 (1999); $H_3\le20$: Lassak (1984). Lower bound 8 (cube). Centrally symmetric case $=8$ (Lassak). Cap bodies in $\mathbb R^3$ have illumination number 6 (arXiv:2507.08712, 2025). Arman–Bondarenko–Prymak, Canad. Math. Bull. 68 (2025), arXiv:2404.00547: small dimensions $\ge5$, no change for $n=3$.

**Credit:** Levi, Hadwiger (1957), Gohberg–Markus; Prymak (2023)

**Rests on recent unrefereed work. Check these premises first:**
- a 2026 preprint lowering 14 could exist outside the search results

**References:**
- https://arxiv.org/abs/2112.10698
- https://teorth.github.io/optimizationproblems/constants/39a.html
- https://arxiv.org/abs/2404.00547
- https://arxiv.org/abs/2507.08712

Difficulty estimate: 5.0/10 (calibrated: Collatz ≈ 5.5, twin primes ≈ 5.0). It is believed open; do not assume a quick answer exists, and say so plainly if you cannot make progress. Never present a heuristic, numerical evidence, or a partial result as a solution.

## What counts as an answer
Either a proof of `OpenProblems.QEDE039.Claim` or a proof of `¬ OpenProblems.QEDE039.Claim` (a disproof), in Lean 4 + Mathlib, using the exact statement in `problems/QED-E039/Statement.lean`. Read its "Formalization notes" first. If that file still says `def Claim : Prop := sorry`, the problem must first be formalized (see CONTRIBUTING.md); a faithful formalization is itself a welcome contribution.

If you think the Lean statement does not match the informal problem (it is trivially true or false, or it says something else), report that in an issue instead of exploiting it: such solutions are not credited.

## How to submit
1. Claim it (optional but encouraged): open an issue titled `Claim QED-E039` at https://github.com/floration/qed/issues/new?template=claim.yml. Comment on it at least once a week or the claim lapses.
2. Add `solutions/QED-E039/<github-username>/Solution.lean`:
```lean
import Mathlib
-- do NOT redefine Claim: CI prepends problems/QED-E039/Statement.lean to your file
theorem solution : OpenProblems.QEDE039.Claim := by   -- or ¬ OpenProblems.QEDE039.Claim
  ...
```
3. Add `solutions/QED-E039/<github-username>/meta.json`: `{"model": "<AI model used, or none>", "kind": "proof" | "disproof"}`. Optionally a `README.md` explaining the idea.
4. Open a pull request. CI checks: it compiles, no `sorry`/`admit`/new `axiom`/`set_option` tricks, and `#print axioms solution` shows only `propext`, `Classical.choice`, `Quot.sound`.

## Scoring
Size = number of non-blank, non-comment lines of `Solution.lean` excluding `import` lines (helper lemmas count). First verified solution is credited permanently; any later, strictly smaller verified solution becomes the "smallest solution".

## Rules for you, the model
- Do not modify `Statement.lean` in a solution PR.
- Be honest about uncertainty; if a step is unproven, leave it out rather than sneak in `sorry`.
- Test locally: `lake exe cache get && lake env lean solutions/QED-E039/<user>/Solution.lean`.
