# QED-M107 — The Thorp shuffle mixes in O(log n) steps

You are an AI model helping someone attack this open problem. Read all of this before working.

## The problem
Main set · Grade A · QED Curated · Probability

**Plain words:** Take a deck of n = 2^d cards and cut it into two equal halves. For each i, the i-th card of each half are placed next to each other, with a fair coin deciding which goes on top. Repeat. A counting argument shows about 2d shuffles are needed before the deck can be close to uniformly random. Prove that a constant times d shuffles always suffice.

**Math:** Let $n=2^d$, $h=n/2$. For $\xi\in\{0,1\}^h$ let $\sigma_\xi\in S_n$ put the cards from positions $i$ and $i+h$ into positions $2i,2i+1$, in that order if $\xi_i=0$ and swapped if $\xi_i=1$ ($0\le i<h$). Let $\mu_d$ be uniform on $\{\sigma_\xi\}$ and $t_{\rm mix}(d)=\min\{t:\|\mu_d^{*t}-U_{S_n}\|_{TV}\le 1/4\}$. Prove there is an absolute constant $C$ with $t_{\rm mix}(d)\le Cd$ for all $d\ge1$. (Counting the support gives $t_{\rm mix}(d)\ge(2-o(1))d$.)

**Reviewer note:** Known: Lower bound $(2-o(1))d$ from counting (support of $\mu_d^{*t}$ has size at most $2^{tn/2}$). Upper bounds for $n=2^d$: $O(d^{44})$ (Morris 2005, AoP 2008), $O(d^{29})$ (Montenegro-Tetali), $O(d^4)$ (Morris, AoP 37 (2009), arXiv 0802.0339), $O(d^3)$ (Morris, Combin. Probab. Comput. 2013, arXiv 0912.2759), and $C_* d^{5/3}+O(d^{4/3}\log d)$ with $C_*\approx5.15$ (Y. Jiang, arXiv 2610.18884, Oct 2026, unrefereed). No O(d) or $d^{1+o(1)}$ bound is known.

**Credit:** Thorp (1973); problem popularised by Aldous-Diaconis and Morris; bounds by Morris, Montenegro-Tetali, Jiang

**Rests on recent unrefereed work. Check these premises first:**
- The best upper bound d^{5/3} is an unrefereed Oct 2026 preprint (arXiv 2610.18884); the refereed state of the art is O(d^3) (Morris 2013). The open target O(d) does not depend on it.
- The 1/4 threshold is conventional; any fixed epsilon in (0,1) gives an equivalent statement up to constants by submultiplicativity.

**References:**
- https://arxiv.org/abs/2610.18884
- https://arxiv.org/abs/0912.2759
- https://arxiv.org/abs/0802.0339
- https://arxiv.org/abs/math/0507307

Difficulty estimate: 6.5/10 (calibrated: Collatz ≈ 5.5, twin primes ≈ 5.0). It is believed open; do not assume a quick answer exists, and say so plainly if you cannot make progress. Never present a heuristic, numerical evidence, or a partial result as a solution.

## What counts as an answer
Either a proof of `OpenProblems.QEDM107.Claim` or a proof of `¬ OpenProblems.QEDM107.Claim` (a disproof), in Lean 4 + Mathlib, using the exact statement in `problems/QED-M107/Statement.lean`. Read its "Formalization notes" first. If that file still says `def Claim : Prop := sorry`, the problem must first be formalized (see CONTRIBUTING.md); a faithful formalization is itself a welcome contribution.

If you think the Lean statement does not match the informal problem (it is trivially true or false, or it says something else), report that in an issue instead of exploiting it: such solutions are not credited.

## How to submit
1. Claim it (optional but encouraged): open an issue titled `Claim QED-M107` at https://github.com/floration/qed/issues/new?template=claim.yml. Comment on it at least once a week or the claim lapses.
2. Add `solutions/QED-M107/<github-username>/Solution.lean`:
```lean
import Mathlib
-- do NOT redefine Claim: CI prepends problems/QED-M107/Statement.lean to your file
theorem solution : OpenProblems.QEDM107.Claim := by   -- or ¬ OpenProblems.QEDM107.Claim
  ...
```
3. Add `solutions/QED-M107/<github-username>/meta.json`: `{"model": "<AI model used, or none>", "kind": "proof" | "disproof"}`. Optionally a `README.md` explaining the idea.
4. Open a pull request. CI checks: it compiles, no `sorry`/`admit`/new `axiom`/`set_option` tricks, and `#print axioms solution` shows only `propext`, `Classical.choice`, `Quot.sound`.

## Scoring
Size = number of non-blank, non-comment lines of `Solution.lean` excluding `import` lines (helper lemmas count). First verified solution is credited permanently; any later, strictly smaller verified solution becomes the "smallest solution".

## Rules for you, the model
- Do not modify `Statement.lean` in a solution PR.
- Be honest about uncertainty; if a step is unproven, leave it out rather than sneak in `sorry`.
- Test locally: `lake exe cache get && lake env lean solutions/QED-M107/<user>/Solution.lean`.
