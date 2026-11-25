# QED-E114 — Planar self-avoiding walk spreads at least diffusively

You are an AI model helping someone attack this open problem. Read all of this before working.

## The problem
Extended set · Grade A · QED Curated · Probability

**Plain words:** Pick one of the self-avoiding n-step walks on the square grid from the origin uniformly at random, and let R_n^2 be the average squared distance of its endpoint from the origin. Intuition says avoiding yourself only pushes you outward, so R_n^2 should be at least of order n, the value for ordinary random walk; physicists expect n^{3/2}. Yet nobody can prove even R_n^2 >= c n for some c > 0: the best proven lower bound is of order n^{2/3}.

**Math:** Let $\mathrm{SAW}_n$ be the set of $n$-step self-avoiding walks on $\mathbb Z^2$ starting at $0$ and $\langle|\omega(n)|^2\rangle_n=|\mathrm{SAW}_n|^{-1}\sum_{\omega\in\mathrm{SAW}_n}\|\omega_n\|_2^2$. Prove $\liminf_{n\to\infty}\langle|\omega(n)|^2\rangle_n/n>0$, equivalently: there is $c>0$ with $\langle|\omega(n)|^2\rangle_n\ge c\,n$ for all $n\ge1$.

**Credit:** Madras & Slade, The Self-Avoiding Walk (1993); Bauerschmidt, Duminil-Copin, Goodman, Slade, Lectures on Self-Avoiding Walks (2012), Sec. 1.5.2.

**Rests on recent unrefereed work. Check these premises first:**
- Schmidt-Sellke (Feb 2026, unrefereed) technique for self-repelling walks might extend; check before posting
- Low novelty: well-known open problem among SAW specialists

**References:**
- https://arxiv.org/pdf/1206.2092
- https://www.cambridge.org/core/journals/canadian-mathematical-bulletin/article/lower-bound-for-the-endtoend-distance-of-the-selfavoiding-walk/20FEE9753A890F944CA297F7C2C32354
- https://arxiv.org/pdf/1205.0401
- https://arxiv.org/abs/2602.14497
- https://arxiv.org/pdf/2610.40520
- https://arxiv.org/pdf/2207.08433

Difficulty estimate: 7.0/10 (anchored scale: 1 ≈ Erdős–Ginzburg–Ziv, 2.5 ≈ the sensitivity conjecture, 5 ≈ bounded prime gaps, 7.5 ≈ the Riemann Hypothesis, 10 ≈ P vs NP). It is believed open; do not assume a quick answer exists, and say so plainly if you cannot make progress. Never present a heuristic, numerical evidence, or a partial result as a solution.

## What counts as an answer
Either a proof of `OpenProblems.QEDE114.Claim` or a proof of `¬ OpenProblems.QEDE114.Claim` (a disproof), in Lean 4 + Mathlib, using the exact statement in `problems/QED-E114/Statement.lean`. Read its "Formalization notes" first. If that file still says `def Claim : Prop := sorry`, the problem must first be formalized (see CONTRIBUTING.md); a faithful formalization is itself a welcome contribution.

If you think the Lean statement does not match the informal problem (it is trivially true or false, or it says something else), report that in an issue instead of exploiting it: such solutions are not credited.

## How to submit
0. First time? Solve a test problem (QED-Q1, the 2-line one, at minimum) and submit it, to confirm your Lean setup and the submission pipeline work before spending effort here. Skip this step if this IS a test problem.
1. Claim it (optional but encouraged): open an issue titled `Claim QED-E114` at https://github.com/floration/qed/issues/new?template=claim.yml. Comment on it at least once a week or the claim lapses.
2. Add `solutions/QED-E114/<github-username>/Solution.lean`:
```lean
import Mathlib
-- do NOT redefine Claim: CI prepends problems/QED-E114/Statement.lean to your file
theorem solution : OpenProblems.QEDE114.Claim := by   -- or ¬ OpenProblems.QEDE114.Claim
  ...
```
   Large proofs may add more `.lean` files (subfolders allowed) next to Solution.lean; CI concatenates them in path order before Solution.lean. Don't import them.
3. Add `solutions/QED-E114/<github-username>/meta.json`: `{"model": "<AI model used, or none>", "kind": "proof" | "disproof"}`. Optionally a `README.md` explaining the idea.
4. Open a pull request. CI checks: it compiles, no `sorry`/`admit`/new `axiom`/`set_option` tricks, and `#print axioms solution` shows only `propext`, `Classical.choice`, `Quot.sound`.

## Scoring
Size = number of non-blank, non-comment lines of `Solution.lean` excluding `import` lines (helper lemmas count). First verified solution is credited permanently; any later, strictly smaller verified solution becomes the "smallest solution".

## Rules for you, the model
- Do not modify `Statement.lean` in a solution PR.
- Be honest about uncertainty; if a step is unproven, leave it out rather than sneak in `sorry`.
- Test locally: `lake exe cache get && lake env lean solutions/QED-E114/<user>/Solution.lean`.
