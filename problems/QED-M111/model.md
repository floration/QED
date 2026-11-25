# QED-M111 — An APN permutation of GF(2^8)

You are an AI model helping someone attack this open problem. Read all of this before working.

## The problem
Main set · Grade A · QED Curated · Algebra

**Plain words:** A function f on the field with 256 elements is almost perfect nonlinear (APN) if, for every nonzero shift a, the difference f(x+a)+f(x) takes each value at most twice. APN bijections would be ideal S-boxes against differential attacks. In even dimension the only APN bijections known live on 64 elements (found in 2009). Does an APN bijection of GF(2^8) exist?

**Math:** Does there exist a bijection $f:\mathbb F_{2^8}\to\mathbb F_{2^8}$ such that for all $a\in\mathbb F_{2^8}^{\times}$ and all $b\in\mathbb F_{2^8}$, $\#\{x\in\mathbb F_{2^8}: f(x+a)+f(x)=b\}\le 2$?

**Reviewer note:** Known: There are no APN permutations for n=4 (Hou; exhaustive). Browning–Dillon–McQuistan–Wolfe 2010 found an APN permutation for n=6 (CCZ-equivalent to the Kim function). Hou, Nyberg and others showed that power (monomial) APN permutations do not exist in even dimension. Classical results (attributed to Nyberg / Seberry–Zhang–Zheng; I did not re-verify the source here) exclude quadratic APN permutations in even dimension. Millions of quadratic APN functions in dimension 8 are known (arXiv 2508.04644; ePrint 2026/2799), none CCZ-equivalent to a permutation as far as tested. arXiv 2611.10269 and ePrint 2026/2800 rule out the family $x^3+a^{-1}\mathrm{Tr}(a^3x^9)$ for all even $n\le24$. Recent papers treat existence for even $n\ge8$ as open.

**Credit:** The 'big APN problem' (Dillon et al.; open since the 2009 n=6 discovery). Not named after a person.

**Rests on recent unrefereed work. Check these premises first:**
- Several 2026 sources are preprints, but the open status is long established in refereed literature.
- Exhaustive search is infeasible (256! bijections), so a resolution needs ideas. A sufficiently clever structured search could still find an example.
- The attribution of the even-dimension quadratic non-existence result was not re-verified in this round.

**References:**
- https://eprint.iacr.org/2026/2799
- https://eprint.iacr.org/2026/2800
- https://arxiv.org/abs/2611.10269
- https://arxiv.org/abs/2508.04644

Difficulty estimate: 6.0/10 (calibrated: Collatz ≈ 5.5, twin primes ≈ 5.0). It is believed open; do not assume a quick answer exists, and say so plainly if you cannot make progress. Never present a heuristic, numerical evidence, or a partial result as a solution.

## What counts as an answer
Either a proof of `OpenProblems.QEDM111.Claim` or a proof of `¬ OpenProblems.QEDM111.Claim` (a disproof), in Lean 4 + Mathlib, using the exact statement in `problems/QED-M111/Statement.lean`. Read its "Formalization notes" first. If that file still says `def Claim : Prop := sorry`, the problem must first be formalized (see CONTRIBUTING.md); a faithful formalization is itself a welcome contribution.

If you think the Lean statement does not match the informal problem (it is trivially true or false, or it says something else), report that in an issue instead of exploiting it: such solutions are not credited.

## How to submit
0. First time? Solve a test problem (QED-Q1, the 2-line one, at minimum) and submit it, to confirm your Lean setup and the submission pipeline work before spending effort here. Skip this step if this IS a test problem.
1. Claim it (optional but encouraged): open an issue titled `Claim QED-M111` at https://github.com/floration/qed/issues/new?template=claim.yml. Comment on it at least once a week or the claim lapses.
2. Add `solutions/QED-M111/<github-username>/Solution.lean`:
```lean
import Mathlib
-- do NOT redefine Claim: CI prepends problems/QED-M111/Statement.lean to your file
theorem solution : OpenProblems.QEDM111.Claim := by   -- or ¬ OpenProblems.QEDM111.Claim
  ...
```
3. Add `solutions/QED-M111/<github-username>/meta.json`: `{"model": "<AI model used, or none>", "kind": "proof" | "disproof"}`. Optionally a `README.md` explaining the idea.
4. Open a pull request. CI checks: it compiles, no `sorry`/`admit`/new `axiom`/`set_option` tricks, and `#print axioms solution` shows only `propext`, `Classical.choice`, `Quot.sound`.

## Scoring
Size = number of non-blank, non-comment lines of `Solution.lean` excluding `import` lines (helper lemmas count). First verified solution is credited permanently; any later, strictly smaller verified solution becomes the "smallest solution".

## Rules for you, the model
- Do not modify `Statement.lean` in a solution PR.
- Be honest about uncertainty; if a step is unproven, leave it out rather than sneak in `sorry`.
- Test locally: `lake exe cache get && lake env lean solutions/QED-M111/<user>/Solution.lean`.
