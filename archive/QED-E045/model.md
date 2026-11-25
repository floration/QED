# QED-E045 — Dirac–Motzkin below the Green–Tao threshold

You are an AI model helping someone attack this open problem. Read all of this before working.

## The problem
Extended set · Grade C · QED Curated · Geometry

**Plain words:** Given n points in the plane, not all on one line, an ordinary line is a line through exactly two of them. Green and Tao proved that for all sufficiently large n there are at least n/2 ordinary lines, but they never made 'sufficiently large' explicit. The best bound proved for every n is 6n/13. Prove n/2 for every n except the two known exceptions, 7 and 13, or at least beat 6n/13 for all n ≥ 14.

**Math:** For finite non-collinear $P\subset\mathbb R^2$ with $|P|=n$, let $t_2(P)$ be the number of lines meeting $P$ in exactly two points. Prove $t_2(P)\ge n/2$ for all $n\notin\{7,13\}$. By Green–Tao this is known for $n\ge n_0$, so the content is the finite range $n<n_0$ (or making $n_0$ explicit and verifying below it). Weaker target: find $c>6/13$ with $t_2(P)\ge cn$ for all $n\ge 14$.

**Reviewer note:** Known: $t_2\ge 3n/7$: Kelly–Moser (1958). $t_2\ge 6n/13$ for $n\ne 7$: Csima–Sawyer, DCG 9 (1993). For $n\ge n_0$: $t_2\ge n/2$ for even $n$ and $t_2\ge 3\lfloor n/4\rfloor$ for odd $n$, both sharp (Green–Tao, DCG 50 (2013), arXiv:1208.4714). Exceptions: $n=7$ ($t_2=3$, Kelly–Moser) and $n=13$ ($t_2=6$, Crowe–McKee). Recent related work, which does not improve this: arXiv:2610.21415 (2026, ordinary lines in $\mathbb C^3$) and Dumitrescu–Pach, EJC 33(3) P3.33 (2026).

**Credit:** Dirac (1951), Motzkin; Csima–Sawyer (1993); Green–Tao (2013)

**Rests on recent unrefereed work. Check these premises first:**
- Green–Tao's n₀ may have been made explicit somewhere (thesis or follow-up); not found
- Famous conjecture's residual range; the weaker target is the realistic extended-set ask

**References:**
- https://arxiv.org/abs/1208.4714
- https://doi.org/10.1007/BF02189318
- https://arxiv.org/pdf/2610.21415
- https://www.combinatorics.org/ojs/index.php/eljc/article/download/v33i3p33/pdf/

Difficulty estimate: 5.0/10 (calibrated: Collatz ≈ 5.5, twin primes ≈ 5.0). It is believed open; do not assume a quick answer exists, and say so plainly if you cannot make progress. Never present a heuristic, numerical evidence, or a partial result as a solution.

## What counts as an answer
Either a proof of `OpenProblems.QEDE045.Claim` or a proof of `¬ OpenProblems.QEDE045.Claim` (a disproof), in Lean 4 + Mathlib, using the exact statement in `problems/QED-E045/Statement.lean`. Read its "Formalization notes" first. If that file still says `def Claim : Prop := sorry`, the problem must first be formalized (see CONTRIBUTING.md); a faithful formalization is itself a welcome contribution.

If you think the Lean statement does not match the informal problem (it is trivially true or false, or it says something else), report that in an issue instead of exploiting it: such solutions are not credited.

## How to submit
1. Claim it (optional but encouraged): open an issue titled `Claim QED-E045` at https://github.com/floration/qed/issues/new?template=claim.yml. Comment on it at least once a week or the claim lapses.
2. Add `solutions/QED-E045/<github-username>/Solution.lean`:
```lean
import Mathlib
-- do NOT redefine Claim: CI prepends problems/QED-E045/Statement.lean to your file
theorem solution : OpenProblems.QEDE045.Claim := by   -- or ¬ OpenProblems.QEDE045.Claim
  ...
```
3. Add `solutions/QED-E045/<github-username>/meta.json`: `{"model": "<AI model used, or none>", "kind": "proof" | "disproof"}`. Optionally a `README.md` explaining the idea.
4. Open a pull request. CI checks: it compiles, no `sorry`/`admit`/new `axiom`/`set_option` tricks, and `#print axioms solution` shows only `propext`, `Classical.choice`, `Quot.sound`.

## Scoring
Size = number of non-blank, non-comment lines of `Solution.lean` excluding `import` lines (helper lemmas count). First verified solution is credited permanently; any later, strictly smaller verified solution becomes the "smallest solution".

## Rules for you, the model
- Do not modify `Statement.lean` in a solution PR.
- Be honest about uncertainty; if a step is unproven, leave it out rather than sneak in `sorry`.
- Test locally: `lake exe cache get && lake env lean solutions/QED-E045/<user>/Solution.lean`.
