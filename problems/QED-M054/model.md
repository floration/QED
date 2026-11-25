# QED-M054 — Positive metric entropy of the Chirikov standard map at an explicit moderate parameter

You are an AI model helping someone attack this open problem. Read all of this before working.

## The problem
Main set · Grade A · QED Curated · Dynamics

**Plain words:** Sinai conjectured that the standard map has positive metric entropy for every parameter k>0. After a 2026 AI-generated non-effective proof for large k, Slijepčević proved it for every k ≥ exp(2^{50000}). Bring the threshold down to a physically meaningful range, e.g. all k ≥ 10^6, or even a single explicit k ≤ 100.

**Math:** Let f_k(x,y)=(x+y+k sin(2 pi x), y+k sin(2 pi x)) on T^2=R^2/Z^2 (Slijepcevic's normalization; Chirikov's K equals 2 pi k), and h_m(f_k) the metric entropy w.r.t. area. Known: log(2 pi k+4)-2^{430} <= h_m(f_k) <= log(2 pi k+4) for k>=exp(2^{50000}) (Slijepcevic 2026). Prove h_m(f_k)>0 for all k>=10^6, or for at least one explicit k<=100.

**Reviewer note:** Context (AI-lab announcement, treated as correct): OpenAI 146: Positive metric entropy for the standard map (Positive Metric Entropy for the Standard Map at Large Parameters). Proves h_m(f_k)>0 for all k>=k_0 in the same normalization, but k_0 is not explicit (ineffective). The board asks for all k>=10^6 or one explicit k<=100, so it is not met. The 'Known' line should cite this all-large-k result alongside Slijepcevic's explicit exp(2^50000) threshold.

**Credit:** Ya. G. Sinai (conjecture, 1994); Slijepcevic 2026, arXiv:2611.09361

**Rests on recent unrefereed work. Check these premises first:**
- arXiv:2611.09361 (Slijepcevic, Nov 2026 preprint): the known result h_m(f_k) >= log(2 pi k+4) - 2^430 for k >= exp(2^50000), quoted as background only.
- OpenAI preprint (unrefereed, credited in 2611.09361): non-effective positivity for large k, background only.

**References:**
- https://arxiv.org/abs/2611.09361
- https://arxiv.org/abs/2507.11375
- https://arxiv.org/abs/2003.09329
- arXiv:2611.09361
- arXiv:2003.09329
- arXiv:2507.11375

Difficulty estimate: 4.5/10 (calibrated: Collatz ≈ 5.5, twin primes ≈ 5.0). It is believed open; do not assume a quick answer exists, and say so plainly if you cannot make progress. Never present a heuristic, numerical evidence, or a partial result as a solution.

## What counts as an answer
Either a proof of `OpenProblems.QEDM054.Claim` or a proof of `¬ OpenProblems.QEDM054.Claim` (a disproof), in Lean 4 + Mathlib, using the exact statement in `problems/QED-M054/Statement.lean`. Read its "Formalization notes" first. If that file still says `def Claim : Prop := sorry`, the problem must first be formalized (see CONTRIBUTING.md); a faithful formalization is itself a welcome contribution.

If you think the Lean statement does not match the informal problem (it is trivially true or false, or it says something else), report that in an issue instead of exploiting it: such solutions are not credited.

## How to submit
0. First time? Solve a test problem (QED-Q1, the 2-line one, at minimum) and submit it, to confirm your Lean setup and the submission pipeline work before spending effort here. Skip this step if this IS a test problem.
1. Claim it (optional but encouraged): open an issue titled `Claim QED-M054` at https://github.com/floration/qed/issues/new?template=claim.yml. Comment on it at least once a week or the claim lapses.
2. Add `solutions/QED-M054/<github-username>/Solution.lean`:
```lean
import Mathlib
-- do NOT redefine Claim: CI prepends problems/QED-M054/Statement.lean to your file
theorem solution : OpenProblems.QEDM054.Claim := by   -- or ¬ OpenProblems.QEDM054.Claim
  ...
```
   Large proofs may add more `.lean` files (subfolders allowed) next to Solution.lean; CI concatenates them in path order before Solution.lean. Don't import them.
3. Add `solutions/QED-M054/<github-username>/meta.json`: `{"model": "<AI model used, or none>", "kind": "proof" | "disproof"}`. Optionally a `README.md` explaining the idea.
4. Open a pull request. CI checks: it compiles, no `sorry`/`admit`/new `axiom`/`set_option` tricks, and `#print axioms solution` shows only `propext`, `Classical.choice`, `Quot.sound`.

## Scoring
Size = number of non-blank, non-comment lines of `Solution.lean` excluding `import` lines (helper lemmas count). First verified solution is credited permanently; any later, strictly smaller verified solution becomes the "smallest solution".

## Rules for you, the model
- Do not modify `Statement.lean` in a solution PR.
- Be honest about uncertainty; if a step is unproven, leave it out rather than sneak in `sorry`.
- Test locally: `lake exe cache get && lake env lean solutions/QED-M054/<user>/Solution.lean`.
