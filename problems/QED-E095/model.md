# QED-E095 — First-order convergence law for random Latin squares

You are an AI model helping someone attack this open problem. Read all of this before working.

## The problem
Extended set · Grade A · QED Original · Logic & computability

**Plain words:** Pick a Latin square of order n uniformly at random and read it as a multiplication table x∘y on n symbols. Does every first-order statement about this table have a limiting probability as n grows? A zero-one law fails: the number of x with x∘x=x should be asymptotically Poisson(1), so the probability that one exists should tend to 1−1/e rather than 0 or 1.

**Math:** Let $L_n$ be uniform among Latin squares on $[n]$ and $\mathcal Q_n=([n],\circ)$ with $x\circ y=L_n(x,y)$. Prove or disprove: for every first-order sentence $\varphi$ in the language $\{\circ,=\}$, $\lim_{n\to\infty}\Pr[\mathcal Q_n\models\varphi]$ exists. (A 0-1 law should fail: by symbol-relabelling symmetry, $\mathbb E\#\{x:x\circ x=x\}=1$ exactly, and this count is conjecturally Poisson(1).) Expected route, as for Lynch's random unary functions: (i) w.h.p. the bounded-depth term closure of any bounded tuple is free except for coincidences counted by balanced configurations ($v$ elements, $v$ independent equations); (ii) a joint Poisson limit for the counts of all such balanced configurations, e.g. cycles of $x\mapsto x\circ x$. A disproof would need a definable sparse statistic with no limit law.

**QED results so far (reviewer-derived; check before relying on them):** Caution: route (i) as originally proposed has a flaw. The extension property 'every finite partial configuration extends in every consistent way w.h.p.' is false. A new x with x∘a1=b1 and x∘a2=b2 has expected count n·n^{-2}→0, because x∘a=b already determines x. The structure is functionally sparse (Lynch-type), not G(n,1/2)-type, so the route was rewritten.

**Rests on recent unrefereed work. Check these premises first:**
- arXiv:2606.18174 (Allsop-Morris, 2026 preprint): cited only as evidence that even the Poisson(1) idempotent law is unproved; the statement assumes nothing from it.

**References:**
- https://arxiv.org/abs/2509.13125
- https://arxiv.org/pdf/2011.07572
- https://arxiv.org/pdf/2106.11932
- https://arxiv.org/abs/2402.02567
- https://arxiv.org/abs/2509.13125
- https://arxiv.org/abs/2606.18174
- https://arxiv.org/pdf/2202.05088
- https://arxiv.org/pdf/2106.11932

Difficulty estimate: 3.5/10 (calibrated: Collatz ≈ 5.5, twin primes ≈ 5.0). It is believed open; do not assume a quick answer exists, and say so plainly if you cannot make progress. Never present a heuristic, numerical evidence, or a partial result as a solution.

## What counts as an answer
Either a proof of `OpenProblems.QEDE095.Claim` or a proof of `¬ OpenProblems.QEDE095.Claim` (a disproof), in Lean 4 + Mathlib, using the exact statement in `problems/QED-E095/Statement.lean`. Read its "Formalization notes" first. If that file still says `def Claim : Prop := sorry`, the problem must first be formalized (see CONTRIBUTING.md); a faithful formalization is itself a welcome contribution.

If you think the Lean statement does not match the informal problem (it is trivially true or false, or it says something else), report that in an issue instead of exploiting it: such solutions are not credited.

## How to submit
1. Claim it (optional but encouraged): open an issue titled `Claim QED-E095` at https://github.com/floration/qed/issues/new?template=claim.yml. Comment on it at least once a week or the claim lapses.
2. Add `solutions/QED-E095/<github-username>/Solution.lean`:
```lean
import Mathlib
-- do NOT redefine Claim: CI prepends problems/QED-E095/Statement.lean to your file
theorem solution : OpenProblems.QEDE095.Claim := by   -- or ¬ OpenProblems.QEDE095.Claim
  ...
```
3. Add `solutions/QED-E095/<github-username>/meta.json`: `{"model": "<AI model used, or none>", "kind": "proof" | "disproof"}`. Optionally a `README.md` explaining the idea.
4. Open a pull request. CI checks: it compiles, no `sorry`/`admit`/new `axiom`/`set_option` tricks, and `#print axioms solution` shows only `propext`, `Classical.choice`, `Quot.sound`.

## Scoring
Size = number of non-blank, non-comment lines of `Solution.lean` excluding `import` lines (helper lemmas count). First verified solution is credited permanently; any later, strictly smaller verified solution becomes the "smallest solution".

## Rules for you, the model
- Do not modify `Statement.lean` in a solution PR.
- Be honest about uncertainty; if a step is unproven, leave it out rather than sneak in `sorry`.
- Test locally: `lake exe cache get && lake env lean solutions/QED-E095/<user>/Solution.lean`.
