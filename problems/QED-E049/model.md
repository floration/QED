# QED-E049 — Ropelength lower bound for the trefoil

You are an AI model helping someone attack this open problem. Read all of this before working.

## The problem
Extended set · Grade C · QED Curated · Topology

**Plain words:** Tie a knot in a rope of thickness 1 using as little rope as possible. For the simplest knot, the trefoil, computer experiments find tight knots using about 16.37 units of rope. The last refereed proof shows that every knotted rope needs at least 15.66 units, and a 2026 computer-assisted preprint claims 15.76. Raise the proven lower bound for the trefoil substantially, ideally to 16.

**Math:** For a $C^{1,1}$ closed curve, $\mathrm{Rop}=\mathrm{length}/(2\,\mathrm{reach})$; $R(3_1)=\inf$ over trefoils (attained). Known $15.66\le R(3_1)\lesssim16.372$ (refereed lower bound; numerical value), with an unrefereed 2026 computer-assisted claim $R(K)>15.7561$ for all nontrivial $K$. Formal target: $R(3_1)\ge16$.

**Reviewer note:** Known: Lower: $\mathrm{Rop}\ge15.66$ for every nontrivial knot (Denne–Diao–Sullivan, Geom. Topol. 10 (2006), arXiv:math/0408026), improving 12 (Cantarella–Kusner–Sullivan). Unrefereed: $\mathrm{Rop}(K)>15.75608926$ for every nontrivial $K$ via interval-arithmetic certificates (A. A. Schoen, 'Endpoint Tangents and a New Universal Lower Bound for the Ropelength of Nontrivial Knots', Zenodo, Sep 2026, v5.0.0, not peer reviewed). Klotz, arXiv:2611.14234 (Nov 2026), lists 31.51217852 (radius-normalized, so 15.756 diameter-normalized) for crossing number 3–8 as the current best, citing Schoen. Upper: numerical tight trefoil below 16.372 (DDS abstract). Minimizers exist (Cantarella–Kusner–Sullivan 2002; Gonzalez–Maddocks–Schuricht–von der Mosel 2002).

**Credit:** Denne–Diao–Sullivan (2006) bound; ropelength problem of Cantarella–Kusner–Sullivan and Buck–Simon

**Rests on recent unrefereed work. Check these premises first:**
- The Schoen preprint is unrefereed and has several Zenodo versions; its claimed bound could be wrong, or have been raised in a newer version
- Normalization: diameter convention (15.66 = 31.32 in radius convention)
- 16.372 is numerical, not a certified upper bound

**References:**
- https://arxiv.org/abs/math/0408026
- https://zenodo.org/records/22736870
- https://arxiv.org/abs/2611.14234
- https://en.wikipedia.org/wiki/Ropelength
- https://math.charlotte.edu/wp-content/uploads/sites/909/2024/03/2019_18.pdf

Difficulty estimate: 5.0/10 (calibrated: Collatz ≈ 5.5, twin primes ≈ 5.0). It is believed open; do not assume a quick answer exists, and say so plainly if you cannot make progress. Never present a heuristic, numerical evidence, or a partial result as a solution.

## What counts as an answer
Either a proof of `OpenProblems.QEDE049.Claim` or a proof of `¬ OpenProblems.QEDE049.Claim` (a disproof), in Lean 4 + Mathlib, using the exact statement in `problems/QED-E049/Statement.lean`. Read its "Formalization notes" first. If that file still says `def Claim : Prop := sorry`, the problem must first be formalized (see CONTRIBUTING.md); a faithful formalization is itself a welcome contribution.

If you think the Lean statement does not match the informal problem (it is trivially true or false, or it says something else), report that in an issue instead of exploiting it: such solutions are not credited.

## How to submit
1. Claim it (optional but encouraged): open an issue titled `Claim QED-E049` at https://github.com/floration/qed/issues/new?template=claim.yml. Comment on it at least once a week or the claim lapses.
2. Add `solutions/QED-E049/<github-username>/Solution.lean`:
```lean
import Mathlib
-- do NOT redefine Claim: CI prepends problems/QED-E049/Statement.lean to your file
theorem solution : OpenProblems.QEDE049.Claim := by   -- or ¬ OpenProblems.QEDE049.Claim
  ...
```
3. Add `solutions/QED-E049/<github-username>/meta.json`: `{"model": "<AI model used, or none>", "kind": "proof" | "disproof"}`. Optionally a `README.md` explaining the idea.
4. Open a pull request. CI checks: it compiles, no `sorry`/`admit`/new `axiom`/`set_option` tricks, and `#print axioms solution` shows only `propext`, `Classical.choice`, `Quot.sound`.

## Scoring
Size = number of non-blank, non-comment lines of `Solution.lean` excluding `import` lines (helper lemmas count). First verified solution is credited permanently; any later, strictly smaller verified solution becomes the "smallest solution".

## Rules for you, the model
- Do not modify `Statement.lean` in a solution PR.
- Be honest about uncertainty; if a step is unproven, leave it out rather than sneak in `sorry`.
- Test locally: `lake exe cache get && lake env lean solutions/QED-E049/<user>/Solution.lean`.
