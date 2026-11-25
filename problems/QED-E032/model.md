# QED-E032 — Covering systems with a large minimum modulus

You are an AI model helping someone attack this open problem. Read all of this before working.

## The problem
Extended set · Grade B- · QED Curated · Number theory

**Plain words:** A covering system is a finite list of arithmetic progressions a_i mod m_i, all with different moduli, such that every integer lies in at least one of them. Erdős asked whether the smallest modulus can be made as large as you like; Hough proved it cannot. The largest smallest modulus anyone has actually achieved is 42, while the best proof only shows it is at most 14,000. Find a covering with smallest modulus at least 43, or prove a much smaller upper bound.

**Math:** Let $M^*$ be the largest integer $M$ for which there exist $k\ge1$, distinct integers $M\le m_1<\dots<m_k$ and residues $a_i$ with $\bigcup_i (a_i+m_i\mathbb Z)=\mathbb Z$. Known: $42\le M^*<14000$ (and $\le 13278$ by a further computer-assisted calculation, same preprint). Decide whether $M^*\ge 43$, and more generally narrow the gap (e.g. prove $M^*\le 1000$).

**Reviewer note:** Known: Lower 42: Owens, 'A covering system with minimum modulus 42' (BYU thesis 2014); still the record per the survey arXiv:2208.09720 and the constructions table in arXiv:2611.15110. Upper bounds: Hough 10^16 (Annals 2015); Balister-Bollobas-Morris-Sahasrabudhe-Tiba 616,000 (2022); Dai-Li-Li-Yi, 'On the moduli of distinct covering systems', arXiv:2611.15110 (Nov 2026 preprint): < 14000 (13278 with extra computation). Squarefree moduli: Cummings-Filaseta-Trifonov <= 118 (arXiv:2211.08548), lowered to <= 7 by Dai-Li-Li-Yi.

**Credit:** Erdős (minimum modulus problem); Hough; Balister–Bollobás–Morris–Sahasrabudhe–Tiba; Owens (42); Dai–Li–Li–Yi (14000)

**Rests on recent unrefereed work. Check these premises first:**
- 14000 bound is a Nov 2026 preprint, not yet refereed; refereed bound is 616,000
- a construction with minimum modulus > 42 might exist unpublished

**References:**
- https://arxiv.org/abs/2611.15110
- https://arxiv.org/abs/2208.09720
- https://arxiv.org/abs/2211.08548
- https://arxiv.org/abs/1307.0874

Difficulty estimate: 4.0/10 (calibrated: Collatz ≈ 5.5, twin primes ≈ 5.0). It is believed open; do not assume a quick answer exists, and say so plainly if you cannot make progress. Never present a heuristic, numerical evidence, or a partial result as a solution.

## What counts as an answer
Either a proof of `OpenProblems.QEDE032.Claim` or a proof of `¬ OpenProblems.QEDE032.Claim` (a disproof), in Lean 4 + Mathlib, using the exact statement in `problems/QED-E032/Statement.lean`. Read its "Formalization notes" first. If that file still says `def Claim : Prop := sorry`, the problem must first be formalized (see CONTRIBUTING.md); a faithful formalization is itself a welcome contribution.

If you think the Lean statement does not match the informal problem (it is trivially true or false, or it says something else), report that in an issue instead of exploiting it: such solutions are not credited.

## How to submit
1. Claim it (optional but encouraged): open an issue titled `Claim QED-E032` at https://github.com/floration/qed/issues/new?template=claim.yml. Comment on it at least once a week or the claim lapses.
2. Add `solutions/QED-E032/<github-username>/Solution.lean`:
```lean
import Mathlib
-- do NOT redefine Claim: CI prepends problems/QED-E032/Statement.lean to your file
theorem solution : OpenProblems.QEDE032.Claim := by   -- or ¬ OpenProblems.QEDE032.Claim
  ...
```
3. Add `solutions/QED-E032/<github-username>/meta.json`: `{"model": "<AI model used, or none>", "kind": "proof" | "disproof"}`. Optionally a `README.md` explaining the idea.
4. Open a pull request. CI checks: it compiles, no `sorry`/`admit`/new `axiom`/`set_option` tricks, and `#print axioms solution` shows only `propext`, `Classical.choice`, `Quot.sound`.

## Scoring
Size = number of non-blank, non-comment lines of `Solution.lean` excluding `import` lines (helper lemmas count). First verified solution is credited permanently; any later, strictly smaller verified solution becomes the "smallest solution".

## Rules for you, the model
- Do not modify `Statement.lean` in a solution PR.
- Be honest about uncertainty; if a step is unproven, leave it out rather than sneak in `sorry`.
- Test locally: `lake exe cache get && lake env lean solutions/QED-E032/<user>/Solution.lean`.
