# QED-E160 — Random 2-complexes are not simply connected at density c/sqrt(n)

You are an AI model helping someone attack this open problem. Read all of this before working.

## The problem
Extended set · Grade B · QED Curated · Probability

**Plain words:** Take the complete graph on n vertices and add each of its triangles independently with probability p (the Linial-Meshulam random 2-complex). It is known to be simply connected once p is a bit above (9.48 n)^(-1/2), and to have a nontrivial (hyperbolic) fundamental group when p is at most n^(-1/2-eps). Is the threshold really of order n^(-1/2)? Show that for some small constant c > 0, at p = c/sqrt(n) there is with high probability a loop that cannot be contracted.

**Math:** Let $Y\sim Y_2(n,p)$: complete 1-skeleton on $[n]$, each 2-face included independently with probability $p$. Then $\pi_1(Y)\cong\langle g_{ij}\ (1\le i<j\le n)\mid g_{1j}=1\ (2\le j\le n);\ g_{ij}g_{jk}=g_{ik}\ \text{for each 2-face }\{i<j<k\}\in Y\rangle$. Prove: there exists $c>0$ such that $\Pr[\pi_1(Y_2(n,c\,n^{-1/2}))\ne 1]\to1$ as $n\to\infty$. (Known: nontrivial a.a.s. for $p\le n^{-1/2-\varepsilon}$ [BHK]; trivial a.a.s. for $p\ge c\,n^{-1/2}$ with $c>(27/256)^{1/2}\approx0.325$ [Luria--Peled].)

**Credit:** Babson-Hoffman-Kahle (2011); Luria-Peled (2021) conjecture 1.3, of which this is the unnamed weaker order-of-magnitude part.

**Rests on recent unrefereed work. Check these premises first:**
- Could be resolved quietly inside a longer paper on random group presentations; searches found nothing
- The sharp-constant version is a named-authors conjecture; the order-of-magnitude claim is the unnamed weaker form

**References:**
- https://arxiv.org/abs/1806.03351
- https://arxiv.org/abs/0711.2704
- https://arxiv.org/abs/1301.7165

Difficulty estimate: 3.0/10 (calibrated: Collatz ≈ 5.5, twin primes ≈ 5.0). It is believed open; do not assume a quick answer exists, and say so plainly if you cannot make progress. Never present a heuristic, numerical evidence, or a partial result as a solution.

## What counts as an answer
Either a proof of `OpenProblems.QEDE160.Claim` or a proof of `¬ OpenProblems.QEDE160.Claim` (a disproof), in Lean 4 + Mathlib, using the exact statement in `problems/QED-E160/Statement.lean`. Read its "Formalization notes" first. If that file still says `def Claim : Prop := sorry`, the problem must first be formalized (see CONTRIBUTING.md); a faithful formalization is itself a welcome contribution.

If you think the Lean statement does not match the informal problem (it is trivially true or false, or it says something else), report that in an issue instead of exploiting it: such solutions are not credited.

## How to submit
0. First time? Solve a test problem (QED-Q1, the 2-line one, at minimum) and submit it, to confirm your Lean setup and the submission pipeline work before spending effort here. Skip this step if this IS a test problem.
1. Claim it (optional but encouraged): open an issue titled `Claim QED-E160` at https://github.com/floration/qed/issues/new?template=claim.yml. Comment on it at least once a week or the claim lapses.
2. Add `solutions/QED-E160/<github-username>/Solution.lean`:
```lean
import Mathlib
-- do NOT redefine Claim: CI prepends problems/QED-E160/Statement.lean to your file
theorem solution : OpenProblems.QEDE160.Claim := by   -- or ¬ OpenProblems.QEDE160.Claim
  ...
```
   Large proofs may add more `.lean` files (subfolders allowed) next to Solution.lean; CI concatenates them in path order before Solution.lean. Don't import them.
3. Add `solutions/QED-E160/<github-username>/meta.json`: `{"model": "<AI model used, or none>", "kind": "proof" | "disproof"}`. Optionally a `README.md` explaining the idea.
4. Open a pull request. CI checks: it compiles, no `sorry`/`admit`/new `axiom`/`set_option` tricks, and `#print axioms solution` shows only `propext`, `Classical.choice`, `Quot.sound`.

## Scoring
Size = number of non-blank, non-comment lines of `Solution.lean` excluding `import` lines (helper lemmas count). First verified solution is credited permanently; any later, strictly smaller verified solution becomes the "smallest solution".

## Rules for you, the model
- Do not modify `Statement.lean` in a solution PR.
- Be honest about uncertainty; if a step is unproven, leave it out rather than sneak in `sorry`.
- Test locally: `lake exe cache get && lake env lean solutions/QED-E160/<user>/Solution.lean`.
