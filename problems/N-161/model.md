# N-161 — Wind-driven fire confinement threshold

You are an AI model helping someone attack this open problem. Read all of this before working.

## The problem
Grade B · QED Extension · Analysis

**Plain words:** A fire spreads from a point, faster downwind: speed a + b cos(theta) in direction theta (0<=b<a). Firefighters build a barrier at speed sigma. Let sigma*(a,b) be the smallest speed that can confine the fire. Known: 1.626(a-b) <= sigma* <= 2 max (a+b cos theta) sin theta. Improve either bound, especially in the strong-wind limit b/a -> 1, where the lower bound tends to 0 but the upper bound stays near 2.6a.

**Math:** With F_b = conv{r e^{i theta}: 0<=r<=1+b cos theta}, R_0 the open unit disc and Bressan-admissible barriers, prove that for some fixed b in (0,1) the fire can be confined with some sigma < 2 max_theta (1+b cos theta) sin theta, i.e. Bressan's anisotropic upper bound is not sharp.

**Credit:** A. Bressan, Differential inclusions and the control of forest fires, J. Differential Equations 2007 (non-isotropic Thm 5)

**QED results so far (reviewer-derived; check before relying on them):** sigma*(a,b) >= Lambda*(a-b), Lambda ~ 1.62621 (isotropic lower bound, arXiv 2610.36919, Thm 4.1). Proof: F contains the disc of radius a-b. Bressan's comparison lemma moves blocking from F to that disc, and rescaling time reduces to unit speed. sigma*(a,b) <= 2 max_{theta in [0,pi]} (a+b cos theta) sin theta (Bressan, Thm 5, non-isotropic case; applies because rho is even and nonincreasing on [0,pi]). This equals 2a at b=0 and tends to (3 sqrt3/2) a as b->a.

**Rests on recent unrefereed work. Check these premises first:**
- arXiv:2610.36919 (2026 preprint): isotropic lower bound Lambda ~ 1.6262 (Thm 4.1), used for the lower bound recorded in the notes.

**References:**
- https://arxiv.org/pdf/2610.36919
- https://cvgmt.sns.it/media/doc/paper/4904/opt-barrier.pdf
- https://pure.psu.edu/en/publications/dynamic-blocking-problems-for-a-model-of-fire-propagation/
- https://arxiv.org/pdf/2508.05324
- https://www.math.uzh.ch/en/fileadmin/user/delellis/publikation/FireCPAM.pdf
- https://beckassets.blob.core.windows.net/product/readingsample/11192202/9781461453888_excerpt_001.pdf

Difficulty estimate: 3.3/10 (calibrated: Collatz ≈ 5.5, twin primes ≈ 5.0). It is believed open; do not assume a quick answer exists, and say so plainly if you cannot make progress. Never present a heuristic, numerical evidence, or a partial result as a solution.

## What counts as an answer
Either a proof of `OpenProblems.N161.Claim` or a proof of `¬ OpenProblems.N161.Claim` (a disproof), in Lean 4 + Mathlib, using the exact statement in `problems/N-161/Statement.lean`. Read its "Formalization notes" first. If that file still says `def Claim : Prop := sorry`, the problem must first be formalized (see CONTRIBUTING.md); a faithful formalization is itself a welcome contribution.

If you think the Lean statement does not match the informal problem (it is trivially true or false, or it says something else), report that in an issue instead of exploiting it: such solutions are not credited.

## How to submit
1. Claim it (optional but encouraged): open an issue titled `Claim N-161` at https://github.com/floration/qed/issues/new?template=claim.yml. Comment on it at least once a week or the claim lapses.
2. Add `solutions/N-161/<github-username>/Solution.lean`:
```lean
import Mathlib
-- do NOT redefine Claim: CI prepends problems/N-161/Statement.lean to your file
theorem solution : OpenProblems.N161.Claim := by   -- or ¬ OpenProblems.N161.Claim
  ...
```
3. Add `solutions/N-161/<github-username>/meta.json`: `{"model": "<AI model used, or none>", "kind": "proof" | "disproof"}`. Optionally a `README.md` explaining the idea.
4. Open a pull request. CI checks: it compiles, no `sorry`/`admit`/new `axiom`/`set_option` tricks, and `#print axioms solution` shows only `propext`, `Classical.choice`, `Quot.sound`.

## Scoring
Size = number of non-blank, non-comment lines of `Solution.lean` excluding `import` lines (helper lemmas count). First verified solution is credited permanently; any later, strictly smaller verified solution becomes the "smallest solution".

## Rules for you, the model
- Do not modify `Statement.lean` in a solution PR.
- Be honest about uncertainty; if a step is unproven, leave it out rather than sneak in `sorry`.
- Test locally: `lake exe cache get && lake env lean solutions/N-161/<user>/Solution.lean`.
