# QED-M050 — Is the Mandelbrot set decidable at Gaussian rationals?

You are an AI model helping someone attack this open problem. Read all of this before working.

## The problem
Main set · Grade A · QED Curated · Dynamics · formerly N-681

**Plain words:** Is there an algorithm that takes a complex number with rational real and imaginary parts and decides whether it lies in the Mandelbrot set? Escaping points can be confirmed, and so can points that have an attracting or neutral cycle of some period, since for each period that is an exact algebraic check. The trouble is points on the boundary where every cycle repels. No such Gaussian rational is known, but none has been ruled out.

**Math:** Let $M=\{c\in\mathbb C:(f_c^{n}(0))_{n\ge0}\text{ bounded}\}$, $f_c(z)=z^2+c$. Prove or disprove that $M\cap\mathbb Q(i)$ is a decidable subset of $\mathbb Q(i)$. $\mathbb Q(i)\setminus M$ is r.e. For each $n$, the existence of an $n$-cycle with multiplier of modulus $\le1$ is decidable for algebraic $c$ (Tarski), and such a cycle forces $c\in M$. $M\cap\mathbb Z[i]$ is a finite, explicitly computable set (it contains the Misiurewicz points $-2,\pm i$, whose cycles are all repelling). So a positive answer would follow from (*): every $c\in(M\cap\mathbb Q(i))\setminus\mathbb Z[i]$ has a non-repelling cycle. Prove or disprove (*). (Example: $c=(37+16i)/100$ lies on the main cardioid with multiplier $(3+4i)/5$, a Siegel parameter.)

**Credit:** P. Potgieter, arXiv:cs/0604003 (2006), Sec. 2.3.

**QED results so far (reviewer-derived; check before relying on them):** The reduction is correct apart from one flaw. A non-repelling cycle implies c in M, since by Fatou all cycles are repelling when c is outside M. The example arithmetic checks out: mu/2-mu^2/4=(37+16i)/100. But (*) as stated is FALSE. c=-2 and c=+-i are Gaussian-integer Misiurewicz parameters in M with all cycles repelling (c=i: 0->i->-1+i->-i->-1+i). The fix excludes Z[i], where membership is a finite check.

**References:**
- https://arxiv.org/pdf/cs/0604003
- https://arxiv.org/pdf/1703.06459
- https://arxiv.org/pdf/cs/0509042
- https://en.wikipedia.org/wiki/Mandelbrot_set
- https://arxiv.org/abs/cs/0604003
- https://arxiv.org/pdf/1703.06459

Difficulty estimate: 4.5/10 (calibrated: Collatz ≈ 5.5, twin primes ≈ 5.0). It is believed open; do not assume a quick answer exists, and say so plainly if you cannot make progress. Never present a heuristic, numerical evidence, or a partial result as a solution.

## What counts as an answer
Either a proof of `OpenProblems.QEDM050.Claim` or a proof of `¬ OpenProblems.QEDM050.Claim` (a disproof), in Lean 4 + Mathlib, using the exact statement in `problems/QED-M050/Statement.lean`. Read its "Formalization notes" first. If that file still says `def Claim : Prop := sorry`, the problem must first be formalized (see CONTRIBUTING.md); a faithful formalization is itself a welcome contribution.

If you think the Lean statement does not match the informal problem (it is trivially true or false, or it says something else), report that in an issue instead of exploiting it: such solutions are not credited.

## How to submit
1. Claim it (optional but encouraged): open an issue titled `Claim QED-M050` at https://github.com/floration/qed/issues/new?template=claim.yml. Comment on it at least once a week or the claim lapses.
2. Add `solutions/QED-M050/<github-username>/Solution.lean`:
```lean
import Mathlib
-- do NOT redefine Claim: CI prepends problems/QED-M050/Statement.lean to your file
theorem solution : OpenProblems.QEDM050.Claim := by   -- or ¬ OpenProblems.QEDM050.Claim
  ...
```
3. Add `solutions/QED-M050/<github-username>/meta.json`: `{"model": "<AI model used, or none>", "kind": "proof" | "disproof"}`. Optionally a `README.md` explaining the idea.
4. Open a pull request. CI checks: it compiles, no `sorry`/`admit`/new `axiom`/`set_option` tricks, and `#print axioms solution` shows only `propext`, `Classical.choice`, `Quot.sound`.

## Scoring
Size = number of non-blank, non-comment lines of `Solution.lean` excluding `import` lines (helper lemmas count). First verified solution is credited permanently; any later, strictly smaller verified solution becomes the "smallest solution".

## Rules for you, the model
- Do not modify `Statement.lean` in a solution PR.
- Be honest about uncertainty; if a step is unproven, leave it out rather than sneak in `sorry`.
- Test locally: `lake exe cache get && lake env lean solutions/QED-M050/<user>/Solution.lean`.
