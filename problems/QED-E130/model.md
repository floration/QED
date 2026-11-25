# QED-E130 — Sign uncertainty on the line: reach 1/2

You are an AI model helping someone attack this open problem. Read all of this before working.

## The problem
Extended set · Grade B · QED Curated · Analysis

**Plain words:** If a real even function f on the line has f(0) ≤ 0 and its Fourier transform is also ≤ 0 at the origin, then f and its transform cannot both become permanently nonnegative too soon: with A(f), A(f̂) the radii beyond which each is nonnegative, the product A(f)A(f̂) is bounded below. The best proven lower bound for the square root of this product is 0.45 (2017), while the best examples give about 0.567. Prove the bound 1/2.

**Math:** With $\hat f(\xi)=\int_{\mathbb{R}}f(x)e^{-2\pi i x\xi}dx$, let $\mathcal{A}_+$ be the set of nonzero real-valued even continuous $f\in L^1(\mathbb{R})$ with $\hat f\in L^1(\mathbb{R})$, $f(0)\le0$, $\hat f(0)\le0$, and $f,\hat f$ eventually nonnegative; for real $g$ put $A(g)=\inf\{r>0: g(x)\ge0\text{ for all }|x|\ge r\}$. Prove $A(f)A(\hat f)\ge 1/4$ for all $f\in\mathcal{A}_+$, i.e. $\mathbb{A}_+(1):=\inf_{f\in\mathcal A_+}\sqrt{A(f)A(\hat f)}\ge 1/2$ (currently $0.45\le\mathbb{A}_+(1)\le 0.5671$).

**Credit:** Bourgain-Clozel-Kahane sign uncertainty constant; target 1/2 chosen as first value beyond reach of the 2017 rearrangement method (QED framing).

**Rests on recent unrefereed work. Check these premises first:**
- Threshold 1/2 is a round-number choice, justified only by the 2017 authors' remark that the method yields only third-decimal gains
- Upper bound 0.5671 is from an unrefereed AI-search report; refereed upper bound is 0.594
- Literature sometimes states the result for A(f)A(f̂) (product) vs its square root; keep the product form 1/4

**References:**
- https://arxiv.org/abs/1602.03366
- https://arxiv.org/abs/2505.15994
- https://arxiv.org/abs/2611.08224
- https://arxiv.org/abs/2608.15415

Difficulty estimate: 3.5/10 (calibrated: Collatz ≈ 5.5, twin primes ≈ 5.0). It is believed open; do not assume a quick answer exists, and say so plainly if you cannot make progress. Never present a heuristic, numerical evidence, or a partial result as a solution.

## What counts as an answer
Either a proof of `OpenProblems.QEDE130.Claim` or a proof of `¬ OpenProblems.QEDE130.Claim` (a disproof), in Lean 4 + Mathlib, using the exact statement in `problems/QED-E130/Statement.lean`. Read its "Formalization notes" first. If that file still says `def Claim : Prop := sorry`, the problem must first be formalized (see CONTRIBUTING.md); a faithful formalization is itself a welcome contribution.

If you think the Lean statement does not match the informal problem (it is trivially true or false, or it says something else), report that in an issue instead of exploiting it: such solutions are not credited.

## How to submit
0. First time? Solve a test problem (QED-Q1, the 2-line one, at minimum) and submit it, to confirm your Lean setup and the submission pipeline work before spending effort here. Skip this step if this IS a test problem.
1. Claim it (optional but encouraged): open an issue titled `Claim QED-E130` at https://github.com/floration/qed/issues/new?template=claim.yml. Comment on it at least once a week or the claim lapses.
2. Add `solutions/QED-E130/<github-username>/Solution.lean`:
```lean
import Mathlib
-- do NOT redefine Claim: CI prepends problems/QED-E130/Statement.lean to your file
theorem solution : OpenProblems.QEDE130.Claim := by   -- or ¬ OpenProblems.QEDE130.Claim
  ...
```
   Large proofs may add more `.lean` files (subfolders allowed) next to Solution.lean; CI concatenates them in path order before Solution.lean. Don't import them.
3. Add `solutions/QED-E130/<github-username>/meta.json`: `{"model": "<AI model used, or none>", "kind": "proof" | "disproof"}`. Optionally a `README.md` explaining the idea.
4. Open a pull request. CI checks: it compiles, no `sorry`/`admit`/new `axiom`/`set_option` tricks, and `#print axioms solution` shows only `propext`, `Classical.choice`, `Quot.sound`.

## Scoring
Size = number of non-blank, non-comment lines of `Solution.lean` excluding `import` lines (helper lemmas count). First verified solution is credited permanently; any later, strictly smaller verified solution becomes the "smallest solution".

## Rules for you, the model
- Do not modify `Statement.lean` in a solution PR.
- Be honest about uncertainty; if a step is unproven, leave it out rather than sneak in `sorry`.
- Test locally: `lake exe cache get && lake env lean solutions/QED-E130/<user>/Solution.lean`.
