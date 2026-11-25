# N-640 — Heat with a cosine reaction

You are an AI model helping someone attack this open problem. Read all of this before working.

## The problem
Grade B · QED Extension · PDE

**Plain words:** In u_t = u_xx + cos(x) u^2 the reaction term averages to zero over a period, but a second-order (homogenization) effect produces an effective +u^3 term, which in one dimension is exactly Fujita's borderline exponent where every positive solution of u_t = u_xx + u^3 blows up. Does every positive solution of the cosine equation blow up in finite time?

**Math:** Let $d\ge1$, $a\in C^\infty(\mathbb R^d)$ be $\mathbb Z^d$-periodic with $\int_{[0,1]^d}a=0$, $a\not\equiv0$. Consider $u_t=\Delta u+a(x)u^p$, $u(\cdot,0)=u_0\in C_c(\mathbb R^d)$, $u_0\ge0$, $u_0\not\equiv0$. Prove: (i) if $1<p\le1+1/d$, every such solution blows up in finite time; (ii) if $p>1+1/d$, solutions with sufficiently small $u_0$ are global. Test case: $d=1$, $p=2$, $a=\cos(2\pi x)$ (equivalently $a=\cos x$ with $2\pi$-periodicity).

**Credit:** H. Fujita 1966 (critical exponent); R. Pinsky 1997 (weighted Fujita problem, a >= 0)

**References:**
- https://portal.mardi4nfdi.de/wiki/Publication:678039
- https://arxiv.org/pdf/2212.12491
- https://arxiv.org/pdf/0805.1313
- https://par.nsf.gov/servlets/purl/10513150

Difficulty estimate: 3.0/10 (calibrated: Collatz ≈ 5.5, twin primes ≈ 5.0). It is believed open; do not assume a quick answer exists, and say so plainly if you cannot make progress. Never present a heuristic, numerical evidence, or a partial result as a solution.

## What counts as an answer
Either a proof of `OpenProblems.N640.Claim` or a proof of `¬ OpenProblems.N640.Claim` (a disproof), in Lean 4 + Mathlib, using the exact statement in `problems/N-640/Statement.lean`. Read its "Formalization notes" first. If that file still says `def Claim : Prop := sorry`, the problem must first be formalized (see CONTRIBUTING.md); a faithful formalization is itself a welcome contribution.

If you think the Lean statement does not match the informal problem (it is trivially true or false, or it says something else), report that in an issue instead of exploiting it: such solutions are not credited.

## How to submit
1. Claim it (optional but encouraged): open an issue titled `Claim N-640` at https://github.com/floration/qed/issues/new?template=claim.yml. Comment on it at least once a week or the claim lapses.
2. Add `solutions/N-640/<github-username>/Solution.lean`:
```lean
import Mathlib
-- do NOT redefine Claim: CI prepends problems/N-640/Statement.lean to your file
theorem solution : OpenProblems.N640.Claim := by   -- or ¬ OpenProblems.N640.Claim
  ...
```
3. Add `solutions/N-640/<github-username>/meta.json`: `{"model": "<AI model used, or none>", "kind": "proof" | "disproof"}`. Optionally a `README.md` explaining the idea.
4. Open a pull request. CI checks: it compiles, no `sorry`/`admit`/new `axiom`/`set_option` tricks, and `#print axioms solution` shows only `propext`, `Classical.choice`, `Quot.sound`.

## Scoring
Size = number of non-blank, non-comment lines of `Solution.lean` excluding `import` lines (helper lemmas count). First verified solution is credited permanently; any later, strictly smaller verified solution becomes the "smallest solution".

## Rules for you, the model
- Do not modify `Statement.lean` in a solution PR.
- Be honest about uncertainty; if a step is unproven, leave it out rather than sneak in `sorry`.
- Test locally: `lake exe cache get && lake env lean solutions/N-640/<user>/Solution.lean`.
