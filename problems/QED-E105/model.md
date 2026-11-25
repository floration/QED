# QED-E105 — Push the Goldston–Gonek–Özlük–Snyder lower bound for Montgomery's F(alpha) beyond alpha = 1

You are an AI model helping someone attack this open problem. Read all of this before working.

## The problem
Extended set · Grade B · QED Extension · Number theory

**Plain words:** Montgomery's function F(α) is known for |α|≤1; his theorem assumed RH, which is now proved (Alpöge 2026), so it is unconditional. Goldston–Gonek–Özlük–Snyder proved F(α) ≥ 3/2−|α|−ε on 1≤|α|≤3/2 assuming GRH for Dirichlet L-functions, which Alpöge also proved in Nov 2026, so their bound now holds unconditionally. The conjecture says F(α)=1 there. Improve this lower bound.

**Math:** Assume GRH for all Dirichlet $L$-functions (now a theorem, Alpöge 2026; kept as a hypothesis to match the Lean statement). Prove that for some $\delta>0$ and all $\alpha\in[1,1+\delta]$, $\liminf_{T\to\infty}F(\alpha,T)\ge \tfrac32-\alpha+\delta$, or prove $\liminf_T \int_{1}^{3/2}F(\alpha,T)\,d\alpha>1/8$ (the value forced by the GGOS bound).

**Credit:** Goldston, Gonek, Özlük, Snyder (2000), 'On the pair correlation of zeros of the Riemann zeta-function', Proc. London Math. Soc.

**Rests on recent unrefereed work. Check these premises first:**
- RH is a theorem (Alpöge, Lean library released 20 Nov 2026, certified 21 Nov 2026 by the Lean FRO/Mathlib Initiative against Mathlib's RiemannHypothesis). GRH for Dirichlet L-functions is treated as proved on the strength of Alpöge's announcement (alpo.ge/remark.pdf) and his Lean archive; the public certification names only RH, so the Dirichlet part has not yet been certified independently. Hecke, Dedekind and other L-functions remain open.

**References:**
- https://www.cambridge.org/core/journals/proceedings-of-the-london-mathematical-society/article/on-the-pair-correlation-of-zeros-of-the-riemann-zetafunction/29A91CBF07210A94E8EEFEAFFBB9FDEE
- https://arxiv.org/abs/2508.10857
- https://myweb.ecu.edu/baluyots24/alternativehyp.pdf

Difficulty estimate: 6.5/10 (anchored scale: 1 ≈ Erdős–Ginzburg–Ziv, 2.5 ≈ the sensitivity conjecture, 5 ≈ bounded prime gaps, 7.5 ≈ the Riemann Hypothesis, 10 ≈ P vs NP). It is believed open; do not assume a quick answer exists, and say so plainly if you cannot make progress. Never present a heuristic, numerical evidence, or a partial result as a solution.

## What counts as an answer
Either a proof of `OpenProblems.QEDE105.Claim` or a proof of `¬ OpenProblems.QEDE105.Claim` (a disproof), in Lean 4 + Mathlib, using the exact statement in `problems/QED-E105/Statement.lean`. Read its "Formalization notes" first. If that file still says `def Claim : Prop := sorry`, the problem must first be formalized (see CONTRIBUTING.md); a faithful formalization is itself a welcome contribution.

If you think the Lean statement does not match the informal problem (it is trivially true or false, or it says something else), report that in an issue instead of exploiting it: such solutions are not credited.

## How to submit
0. First time? Solve a test problem (QED-Q1, the 2-line one, at minimum) and submit it, to confirm your Lean setup and the submission pipeline work before spending effort here. Skip this step if this IS a test problem.
1. Claim it (optional but encouraged): open an issue titled `Claim QED-E105` at https://github.com/floration/qed/issues/new?template=claim.yml. Comment on it at least once a week or the claim lapses.
2. Add `solutions/QED-E105/<github-username>/Solution.lean`:
```lean
import Mathlib
-- do NOT redefine Claim: CI prepends problems/QED-E105/Statement.lean to your file
theorem solution : OpenProblems.QEDE105.Claim := by   -- or ¬ OpenProblems.QEDE105.Claim
  ...
```
   Large proofs may add more `.lean` files (subfolders allowed) next to Solution.lean; CI concatenates them in path order before Solution.lean. Don't import them.
3. Add `solutions/QED-E105/<github-username>/meta.json`: `{"model": "<AI model used, or none>", "kind": "proof" | "disproof"}`. Optionally a `README.md` explaining the idea.
4. Open a pull request. CI checks: it compiles, no `sorry`/`admit`/new `axiom`/`set_option` tricks, and `#print axioms solution` shows only `propext`, `Classical.choice`, `Quot.sound`.

## Scoring
Size = number of non-blank, non-comment lines of `Solution.lean` excluding `import` lines (helper lemmas count). First verified solution is credited permanently; any later, strictly smaller verified solution becomes the "smallest solution".

## Rules for you, the model
- Do not modify `Statement.lean` in a solution PR.
- Be honest about uncertainty; if a step is unproven, leave it out rather than sneak in `sorry`.
- Test locally: `lake exe cache get && lake env lean solutions/QED-E105/<user>/Solution.lean`.
