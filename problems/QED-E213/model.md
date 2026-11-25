# QED-E213 — Half of the binary digits of Champernowne's constant are 1

You are an AI model helping someone attack this open problem. Read all of this before working.

## The problem
Extended set · Grade B · QED Curated · Number theory

**Plain words:** Champernowne's constant C = 0.123456789101112... (write the positive integers one after another in decimal) was proved normal in base 10 in 1933: every block of decimal digits appears with the expected frequency. Nothing is known about its expansion in bases that are not powers of 10. Prove the first instance: in the binary expansion of C, the proportion of 1s among the first N digits tends to 1/2.

**Math:** Let $C=\sum_{k\ge1}d_k10^{-k}$ where $d_1d_2d_3\ldots=123456789101112\ldots$ is the concatenation of the decimal representations of $1,2,3,\ldots$, and let $b_n=\lfloor 2^nC\rfloor\bmod 2$ for $n\ge1$. Prove that $\lim_{N\to\infty}\frac1N\#\{1\le n\le N:\ b_n=1\}=\frac12$.

**Credit:** Open question recorded by V. Becher and N. Graus; constant due to D. G. Champernowne (1933).

**Rests on recent unrefereed work. Check these premises first:**
- Numerical frequency at 3×10^5 bits is 0.4978, slightly below 1/2; convergence may be very slow (or, in principle, the claim false) - the problem is honest either way, but a disproof would be extremely surprising
- Low novelty: normality of classical constants in other bases is a well-known folklore question

**References:**
- https://staff.dc.uba.ar/becher/papers/champ.pdf
- https://cecm-wayback.dcr.sfu.ca/~pborwein/PAPERS/P211.pdf
- https://en.wikipedia.org/wiki/Champernowne_constant
- https://arxiv.org/abs/1710.09313

Difficulty estimate: 6.5/10 (calibrated: Collatz ≈ 5.5, twin primes ≈ 5.0). It is believed open; do not assume a quick answer exists, and say so plainly if you cannot make progress. Never present a heuristic, numerical evidence, or a partial result as a solution.

## What counts as an answer
Either a proof of `OpenProblems.QEDE213.Claim` or a proof of `¬ OpenProblems.QEDE213.Claim` (a disproof), in Lean 4 + Mathlib, using the exact statement in `problems/QED-E213/Statement.lean`. Read its "Formalization notes" first. If that file still says `def Claim : Prop := sorry`, the problem must first be formalized (see CONTRIBUTING.md); a faithful formalization is itself a welcome contribution.

If you think the Lean statement does not match the informal problem (it is trivially true or false, or it says something else), report that in an issue instead of exploiting it: such solutions are not credited.

## How to submit
0. First time? Solve a test problem (QED-Q1, the 2-line one, at minimum) and submit it, to confirm your Lean setup and the submission pipeline work before spending effort here. Skip this step if this IS a test problem.
1. Claim it (optional but encouraged): open an issue titled `Claim QED-E213` at https://github.com/floration/qed/issues/new?template=claim.yml. Comment on it at least once a week or the claim lapses.
2. Add `solutions/QED-E213/<github-username>/Solution.lean`:
```lean
import Mathlib
-- do NOT redefine Claim: CI prepends problems/QED-E213/Statement.lean to your file
theorem solution : OpenProblems.QEDE213.Claim := by   -- or ¬ OpenProblems.QEDE213.Claim
  ...
```
   Large proofs may add more `.lean` files (subfolders allowed) next to Solution.lean; CI concatenates them in path order before Solution.lean. Don't import them.
3. Add `solutions/QED-E213/<github-username>/meta.json`: `{"model": "<AI model used, or none>", "kind": "proof" | "disproof"}`. Optionally a `README.md` explaining the idea.
4. Open a pull request. CI checks: it compiles, no `sorry`/`admit`/new `axiom`/`set_option` tricks, and `#print axioms solution` shows only `propext`, `Classical.choice`, `Quot.sound`.

## Scoring
Size = number of non-blank, non-comment lines of `Solution.lean` excluding `import` lines (helper lemmas count). First verified solution is credited permanently; any later, strictly smaller verified solution becomes the "smallest solution".

## Rules for you, the model
- Do not modify `Statement.lean` in a solution PR.
- Be honest about uncertainty; if a step is unproven, leave it out rather than sneak in `sorry`.
- Test locally: `lake exe cache get && lake env lean solutions/QED-E213/<user>/Solution.lean`.
