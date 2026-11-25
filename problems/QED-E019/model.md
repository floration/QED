# QED-E019 — Period-doubling torus bundles

You are an AI model helping someone attack this open problem. Read all of this before working.

## The problem
Extended set · Grade C · Topology · formerly N-618

**Plain words:** Build a once-punctured torus bundle by reading the period-doubling word as a product of the two basic shear matrices. Show its hyperbolic volume per letter settles to a limit as the word grows.

**Math:** Let $W_n\in\{a,b\}^{2^n}$ be the length-$2^n$ prefix of the fixed point of $a\mapsto ab,\ b\mapsto aa$ ($n\ge1$). Let $\phi_n\in SL_2(\mathbb{Z})$ be the product obtained from $W_n$ via $a\mapsto R=\begin{pmatrix}1&1\\0&1\end{pmatrix}$, $b\mapsto L=\begin{pmatrix}1&0\\1&1\end{pmatrix}$, and let $M_n$ be the once-punctured torus bundle with monodromy $\phi_n$ (hyperbolic since $W_n$ contains both letters). Prove that $\lim_{n\to\infty}\mathrm{vol}(M_n)/2^n$ exists.

**Reviewer note:** L

**References:**
- https://web3.arxiv.org/abs/1905.04935
- https://msp.org/gt/2006/10-3/gt-v10-n3-p01-p.pdf
- https://arxiv.org/abs/2607.25319

Difficulty estimate: 2.2/10 (calibrated: Collatz ≈ 5.5, twin primes ≈ 5.0). It is believed open; do not assume a quick answer exists, and say so plainly if you cannot make progress. Never present a heuristic, numerical evidence, or a partial result as a solution.

## What counts as an answer
Either a proof of `OpenProblems.QEDE019.Claim` or a proof of `¬ OpenProblems.QEDE019.Claim` (a disproof), in Lean 4 + Mathlib, using the exact statement in `problems/QED-E019/Statement.lean`. Read its "Formalization notes" first. If that file still says `def Claim : Prop := sorry`, the problem must first be formalized (see CONTRIBUTING.md); a faithful formalization is itself a welcome contribution.

If you think the Lean statement does not match the informal problem (it is trivially true or false, or it says something else), report that in an issue instead of exploiting it: such solutions are not credited.

## How to submit
1. Claim it (optional but encouraged): open an issue titled `Claim QED-E019` at https://github.com/floration/qed/issues/new?template=claim.yml. Comment on it at least once a week or the claim lapses.
2. Add `solutions/QED-E019/<github-username>/Solution.lean`:
```lean
import Mathlib
-- do NOT redefine Claim: CI prepends problems/QED-E019/Statement.lean to your file
theorem solution : OpenProblems.QEDE019.Claim := by   -- or ¬ OpenProblems.QEDE019.Claim
  ...
```
3. Add `solutions/QED-E019/<github-username>/meta.json`: `{"model": "<AI model used, or none>", "kind": "proof" | "disproof"}`. Optionally a `README.md` explaining the idea.
4. Open a pull request. CI checks: it compiles, no `sorry`/`admit`/new `axiom`/`set_option` tricks, and `#print axioms solution` shows only `propext`, `Classical.choice`, `Quot.sound`.

## Scoring
Size = number of non-blank, non-comment lines of `Solution.lean` excluding `import` lines (helper lemmas count). First verified solution is credited permanently; any later, strictly smaller verified solution becomes the "smallest solution".

## Rules for you, the model
- Do not modify `Statement.lean` in a solution PR.
- Be honest about uncertainty; if a step is unproven, leave it out rather than sneak in `sorry`.
- Test locally: `lake exe cache get && lake env lean solutions/QED-E019/<user>/Solution.lean`.
