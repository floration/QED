# QED-E198 — Is the Shannon capacity of the 7-cycle below its Lovász theta?

You are an AI model helping someone attack this open problem. Read all of this before working.

## The problem
Extended set · Grade A · QED Curated · Information theory

**Plain words:** The Shannon capacity Θ(G) of a graph measures how many messages per channel use can be sent with zero error when G records which symbols can be confused. For the 7-cycle the best lower bound is about 3.2588 (2026 computer constructions) and the only upper bound is still Lovász's 1979 theta number 7cos(π/7)/(1+cos(π/7)) ≈ 3.3177. Decide whether Θ(C_7) is strictly smaller than this theta value.

**Math:** For a graph $G$ let $\Theta(G)=\sup_{k\ge1}\alpha(G^{\boxtimes k})^{1/k}$, $\boxtimes$ the strong product. Decide whether $\Theta(C_7)<\vartheta(C_7)=\dfrac{7\cos(\pi/7)}{1+\cos(\pi/7)}$; equivalently (since $\Theta\le\vartheta$), whether $\Theta(C_7)=\vartheta(C_7)$ fails.

**Credit:** Lovász (1979) / Shannon (1956); status per Tao's optimization-constants list (2026)

**Rests on recent unrefereed work. Check these premises first:**
- Lower bound actively moving on Tao's list (2026, partly AI-produced and unrefereed); the posed question concerns the untouched upper side
- Well-known; low novelty

**References:**
- https://arxiv.org/html/2509.24600v3
- https://arxiv.org/pdf/2607.29681
- https://arxiv.org/pdf/2608.30273
- https://arxiv.org/abs/1808.07438

Difficulty estimate: 8.5/10 (calibrated: Collatz ≈ 5.5, twin primes ≈ 5.0). It is believed open; do not assume a quick answer exists, and say so plainly if you cannot make progress. Never present a heuristic, numerical evidence, or a partial result as a solution.

## What counts as an answer
Either a proof of `OpenProblems.QEDE198.Claim` or a proof of `¬ OpenProblems.QEDE198.Claim` (a disproof), in Lean 4 + Mathlib, using the exact statement in `problems/QED-E198/Statement.lean`. Read its "Formalization notes" first. If that file still says `def Claim : Prop := sorry`, the problem must first be formalized (see CONTRIBUTING.md); a faithful formalization is itself a welcome contribution.

If you think the Lean statement does not match the informal problem (it is trivially true or false, or it says something else), report that in an issue instead of exploiting it: such solutions are not credited.

## How to submit
0. First time? Solve a test problem (QED-Q1, the 2-line one, at minimum) and submit it, to confirm your Lean setup and the submission pipeline work before spending effort here. Skip this step if this IS a test problem.
1. Claim it (optional but encouraged): open an issue titled `Claim QED-E198` at https://github.com/floration/qed/issues/new?template=claim.yml. Comment on it at least once a week or the claim lapses.
2. Add `solutions/QED-E198/<github-username>/Solution.lean`:
```lean
import Mathlib
-- do NOT redefine Claim: CI prepends problems/QED-E198/Statement.lean to your file
theorem solution : OpenProblems.QEDE198.Claim := by   -- or ¬ OpenProblems.QEDE198.Claim
  ...
```
   Large proofs may add more `.lean` files (subfolders allowed) next to Solution.lean; CI concatenates them in path order before Solution.lean. Don't import them.
3. Add `solutions/QED-E198/<github-username>/meta.json`: `{"model": "<AI model used, or none>", "kind": "proof" | "disproof"}`. Optionally a `README.md` explaining the idea.
4. Open a pull request. CI checks: it compiles, no `sorry`/`admit`/new `axiom`/`set_option` tricks, and `#print axioms solution` shows only `propext`, `Classical.choice`, `Quot.sound`.

## Scoring
Size = number of non-blank, non-comment lines of `Solution.lean` excluding `import` lines (helper lemmas count). First verified solution is credited permanently; any later, strictly smaller verified solution becomes the "smallest solution".

## Rules for you, the model
- Do not modify `Statement.lean` in a solution PR.
- Be honest about uncertainty; if a step is unproven, leave it out rather than sneak in `sorry`.
- Test locally: `lake exe cache get && lake env lean solutions/QED-E198/<user>/Solution.lean`.
