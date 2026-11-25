# QED-M083 — One-level density of quadratic Dirichlet L-functions beyond support (−2,2)

You are an AI model helping someone attack this open problem. Read all of this before working.

## The problem
Main set · Grade B · QED Curated · Number theory

**Plain words:** Under GRH, the low-lying zeros of L(s,χ_d) for quadratic characters are known to follow the symplectic random-matrix law only for test functions whose Fourier transform is supported in (−2,2). Go beyond 2.

**Math:** For the family of real primitive characters $\chi_{8d}$, $d$ odd squarefree, $X<d\le 2X$, and even Schwartz $\phi$ with $\operatorname{supp}\hat\phi\subset(-\sigma,\sigma)$, prove under GRH that $\frac1{|\mathcal F|}\sum_d\sum_{\gamma_d}\phi\!\big(\gamma_d\frac{\log X}{2\pi}\big)\to\int\phi(x)\big(1-\frac{\sin 2\pi x}{2\pi x}\big)dx$ for some $\sigma>2$.

**Credit:** Özlük–Snyder (Canad. J. Math. 58, 2006; earlier 1999 work) and Rubinstein (Duke 2001) for support (−2,2); Katz–Sarnak (1999) density conjectures.

**References:**
- https://arxiv.org/abs/2002.11968
- https://msp.org/ant/2023/17-4/ant-v17-n4-p01-p.pdf
- Ozluk-Snyder, Canad. J. Math 58 (2006)
- arXiv:1601.06833
- arXiv:1710.06834
- arXiv:2002.11968

Difficulty estimate: 5.5/10 (calibrated: Collatz ≈ 5.5, twin primes ≈ 5.0). It is believed open; do not assume a quick answer exists, and say so plainly if you cannot make progress. Never present a heuristic, numerical evidence, or a partial result as a solution.

## What counts as an answer
Either a proof of `OpenProblems.QEDM083.Claim` or a proof of `¬ OpenProblems.QEDM083.Claim` (a disproof), in Lean 4 + Mathlib, using the exact statement in `problems/QED-M083/Statement.lean`. Read its "Formalization notes" first. If that file still says `def Claim : Prop := sorry`, the problem must first be formalized (see CONTRIBUTING.md); a faithful formalization is itself a welcome contribution. What is missing: Not formalized: needs sums over L-function zeros with multiplicity.

If you think the Lean statement does not match the informal problem (it is trivially true or false, or it says something else), report that in an issue instead of exploiting it: such solutions are not credited.

## How to submit
1. Claim it (optional but encouraged): open an issue titled `Claim QED-M083` at https://github.com/floration/qed/issues/new?template=claim.yml. Comment on it at least once a week or the claim lapses.
2. Add `solutions/QED-M083/<github-username>/Solution.lean`:
```lean
import Mathlib
-- do NOT redefine Claim: CI prepends problems/QED-M083/Statement.lean to your file
theorem solution : OpenProblems.QEDM083.Claim := by   -- or ¬ OpenProblems.QEDM083.Claim
  ...
```
3. Add `solutions/QED-M083/<github-username>/meta.json`: `{"model": "<AI model used, or none>", "kind": "proof" | "disproof"}`. Optionally a `README.md` explaining the idea.
4. Open a pull request. CI checks: it compiles, no `sorry`/`admit`/new `axiom`/`set_option` tricks, and `#print axioms solution` shows only `propext`, `Classical.choice`, `Quot.sound`.

## Scoring
Size = number of non-blank, non-comment lines of `Solution.lean` excluding `import` lines (helper lemmas count). First verified solution is credited permanently; any later, strictly smaller verified solution becomes the "smallest solution".

## Rules for you, the model
- Do not modify `Statement.lean` in a solution PR.
- Be honest about uncertainty; if a step is unproven, leave it out rather than sneak in `sorry`.
- Test locally: `lake exe cache get && lake env lean solutions/QED-M083/<user>/Solution.lean`.
