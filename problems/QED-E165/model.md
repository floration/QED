# QED-E165 — Inducibility of the 4-vertex path

You are an AI model helping someone attack this open problem. Read all of this before working.

## The problem
Extended set · Grade B · QED Curated · Graph theory

**Plain words:** Pick 4 vertices at random from a large graph; how likely is it that they induce exactly a path a-b-c-d (with no other edges among them)? The inducibility of P4 is the largest this probability can be in the limit. For every other graph on 4 vertices the answer is known, but for P4 it is only known to lie between about 0.2014 and 0.2033. Determine it.

**Math:** For a graph $G$ on $n\ge4$ vertices let $d(G)$ be the fraction of 4-subsets of $V(G)$ that induce a copy of $P_4$, and let $\lambda_{P_4}=\lim_{n\to\infty}\max_{|G|=n} d(G)$ (the maxima are non-increasing in $n$, so the limit exists). Known: $1173/5824=0.20140\ldots\le\lambda_{P_4}\le 0.20332375$. Determine $\lambda_{P_4}$; in particular decide whether $\lambda_{P_4}=1173/5824$.

**Credit:** Inducibility: Pippenger-Golumbic (1975); P4 bounds: Exoo, Even-Zohar-Linial (2015), Vaughan (flag algebras); status confirmed by Bodnár-Pikhurko (EJC 2026).

**Rests on recent unrefereed work. Check these premises first:**
- The exact value may be irrational or of a non-blow-up form, so 'decide whether = 1173/5824' may be answered negatively without determining the value; the claim targets the exact value
- Upper-bound improvements by larger flag-algebra computations alone would be computational rather than conceptual

**References:**
- https://arxiv.org/abs/1312.1205
- https://www.combinatorics.org/ojs/index.php/eljc/article/download/v33i2p39/pdf/
- https://arxiv.org/abs/2610.33850
- https://arxiv.org/abs/2507.01596

Difficulty estimate: 5.5/10 (calibrated: Collatz ≈ 5.5, twin primes ≈ 5.0). It is believed open; do not assume a quick answer exists, and say so plainly if you cannot make progress. Never present a heuristic, numerical evidence, or a partial result as a solution.

## What counts as an answer
Either a proof of `OpenProblems.QEDE165.Claim` or a proof of `¬ OpenProblems.QEDE165.Claim` (a disproof), in Lean 4 + Mathlib, using the exact statement in `problems/QED-E165/Statement.lean`. Read its "Formalization notes" first. If that file still says `def Claim : Prop := sorry`, the problem must first be formalized (see CONTRIBUTING.md); a faithful formalization is itself a welcome contribution.

If you think the Lean statement does not match the informal problem (it is trivially true or false, or it says something else), report that in an issue instead of exploiting it: such solutions are not credited.

## How to submit
0. First time? Solve a test problem (QED-Q1, the 2-line one, at minimum) and submit it, to confirm your Lean setup and the submission pipeline work before spending effort here. Skip this step if this IS a test problem.
1. Claim it (optional but encouraged): open an issue titled `Claim QED-E165` at https://github.com/floration/qed/issues/new?template=claim.yml. Comment on it at least once a week or the claim lapses.
2. Add `solutions/QED-E165/<github-username>/Solution.lean`:
```lean
import Mathlib
-- do NOT redefine Claim: CI prepends problems/QED-E165/Statement.lean to your file
theorem solution : OpenProblems.QEDE165.Claim := by   -- or ¬ OpenProblems.QEDE165.Claim
  ...
```
   Large proofs may add more `.lean` files (subfolders allowed) next to Solution.lean; CI concatenates them in path order before Solution.lean. Don't import them.
3. Add `solutions/QED-E165/<github-username>/meta.json`: `{"model": "<AI model used, or none>", "kind": "proof" | "disproof"}`. Optionally a `README.md` explaining the idea.
4. Open a pull request. CI checks: it compiles, no `sorry`/`admit`/new `axiom`/`set_option` tricks, and `#print axioms solution` shows only `propext`, `Classical.choice`, `Quot.sound`.

## Scoring
Size = number of non-blank, non-comment lines of `Solution.lean` excluding `import` lines (helper lemmas count). First verified solution is credited permanently; any later, strictly smaller verified solution becomes the "smallest solution".

## Rules for you, the model
- Do not modify `Statement.lean` in a solution PR.
- Be honest about uncertainty; if a step is unproven, leave it out rather than sneak in `sorry`.
- Test locally: `lake exe cache get && lake env lean solutions/QED-E165/<user>/Solution.lean`.
