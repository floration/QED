# QED-E056 — Do minimum-order k-chromatic graphs of girth at least g have girth exactly g?

You are an AI model helping someone attack this open problem. Read all of this before working.

## The problem
Extended set · Grade B · QED Extension · Graph theory

**Plain words:** Let n_g(k) be the fewest vertices of a graph that needs k colours and has no cycle shorter than g. Exoo and Goedgebeur asked whether a smallest such graph must have a cycle of length exactly g; equivalently, whether n_g(k) strictly increases with g. For k = 3 this fails (the 5-cycle is smallest for both g = 4 and g = 5), so the question is for k >= 4. The analogous statement for cages is a classical theorem of Erdos and Sachs.

**Math:** Let $n_g(k)=\min\{|V(G)|:\chi(G)=k,\ \mathrm{girth}(G)\ge g\}$. Decide whether $n_g(k)<n_{g+1}(k)$ for all $k\ge 4$ and $g\ge 3$; equivalently, whether every graph with $\chi=k$, girth $\ge g$ and exactly $n_g(k)$ vertices has girth exactly $g$.

**Reviewer note:** Known: Posed as Question 1 in Exoo–Goedgebeur, 'Bounds for the smallest k-chromatic graphs of given girth', DMTCS 21(3) (2019) #9 (arXiv 1805.06713). Known exact values: n_3(k)=k (K_k), n_4(4)=11 (Grötzsch/Chvátal), n_5(4)=21, n_4(5)=22 (Jensen–Royle); bounds 26 ≤ n_6(4) ≤ 66 (Rampone, arXiv 2608.23652, 2026: 29 ≤ n_6(4) ≤ 64), 30 ≤ n_7(4) ≤ 171, 29 ≤ n_5(5) ≤ 80, 32 ≤ n_4(6) ≤ 40 (Goedgebeur, J. Graph Theory 2020, arXiv 1707.07581). Implied strict cases: n_3(k)<n_4(k) for k ≥ 3 (K_k is the unique smallest), n_4(4)<n_5(4)<n_6(4), n_4(5)<n_5(5).

**Credit:** G. Exoo and J. Goedgebeur (2019), Question 1; restriction to k ≥ 4 added here

**Rests on recent unrefereed work. Check these premises first:**
- Could be resolved by a single computation once n_6(4) or n_4(6) is pinned down, if a counterexample exists; a positive answer needs a real idea
- Restriction k ≥ 4 is ours (the paper's literal question fails for k = 3); vetter should confirm this is the intended question
- Rampone 2026 bounds are an unrefereed preprint; not used by the statement
- Possible elementary resolution: the vertex-identification argument above settles cases with large diameter; a cleverer local operation might settle all cases

**References:**
- https://arxiv.org/abs/1805.06713
- https://dmtcs.episciences.org/5259
- https://arxiv.org/abs/1707.07581
- https://arxiv.org/abs/2608.23652

Difficulty estimate: 6.0/10 (calibrated: Collatz ≈ 5.5, twin primes ≈ 5.0). It is believed open; do not assume a quick answer exists, and say so plainly if you cannot make progress. Never present a heuristic, numerical evidence, or a partial result as a solution.

## What counts as an answer
Either a proof of `OpenProblems.QEDE056.Claim` or a proof of `¬ OpenProblems.QEDE056.Claim` (a disproof), in Lean 4 + Mathlib, using the exact statement in `problems/QED-E056/Statement.lean`. Read its "Formalization notes" first. If that file still says `def Claim : Prop := sorry`, the problem must first be formalized (see CONTRIBUTING.md); a faithful formalization is itself a welcome contribution.

If you think the Lean statement does not match the informal problem (it is trivially true or false, or it says something else), report that in an issue instead of exploiting it: such solutions are not credited.

## How to submit
0. First time? Solve a test problem (QED-Q1, the 2-line one, at minimum) and submit it, to confirm your Lean setup and the submission pipeline work before spending effort here. Skip this step if this IS a test problem.
1. Claim it (optional but encouraged): open an issue titled `Claim QED-E056` at https://github.com/floration/qed/issues/new?template=claim.yml. Comment on it at least once a week or the claim lapses.
2. Add `solutions/QED-E056/<github-username>/Solution.lean`:
```lean
import Mathlib
-- do NOT redefine Claim: CI prepends problems/QED-E056/Statement.lean to your file
theorem solution : OpenProblems.QEDE056.Claim := by   -- or ¬ OpenProblems.QEDE056.Claim
  ...
```
3. Add `solutions/QED-E056/<github-username>/meta.json`: `{"model": "<AI model used, or none>", "kind": "proof" | "disproof"}`. Optionally a `README.md` explaining the idea.
4. Open a pull request. CI checks: it compiles, no `sorry`/`admit`/new `axiom`/`set_option` tricks, and `#print axioms solution` shows only `propext`, `Classical.choice`, `Quot.sound`.

## Scoring
Size = number of non-blank, non-comment lines of `Solution.lean` excluding `import` lines (helper lemmas count). First verified solution is credited permanently; any later, strictly smaller verified solution becomes the "smallest solution".

## Rules for you, the model
- Do not modify `Statement.lean` in a solution PR.
- Be honest about uncertainty; if a step is unproven, leave it out rather than sneak in `sorry`.
- Test locally: `lake exe cache get && lake env lean solutions/QED-E056/<user>/Solution.lean`.
