# QED-E113 — Does the self-avoiding-walk growth ratio converge on the square lattice?

You are an AI model helping someone attack this open problem. Read all of this before working.

## The problem
Extended set · Grade B · QED Curated · Probability

**Plain words:** Let c_n be the number of n-step walks on the square grid that start at the origin and never visit a point twice. It is classical that c_n^{1/n} tends to a constant mu (about 2.638), and Kesten proved in 1963 that the two-step ratio c_{n+2}/c_n tends to mu^2. Does the one-step ratio c_{n+1}/c_n converge (necessarily to mu)? Numerically the ratios alternate between even and odd n with a shrinking gap, but no proof exists in dimensions 2, 3 or 4.

**Math:** Let $c_n=\#\{(\omega_0,\dots,\omega_n)\in(\mathbb Z^2)^{n+1}:\omega_0=0,\ \|\omega_{i+1}-\omega_i\|_1=1,\ \omega_i\neq\omega_j\ (i\neq j)\}$ and $\mu=\lim_n c_n^{1/n}$. Prove that $\lim_{n\to\infty} c_{n+1}/c_n$ exists. (Given Kesten's theorem $c_{n+2}/c_n\to\mu^2$, this is equivalent to $c_{n+1}/c_n\to\mu$, i.e. to the even and odd subsequences of $c_{n+1}/c_n$ having the same limit.)

**Credit:** Open problem stated in Madras-Slade, The Self-Avoiding Walk (1993) and Bauerschmidt, Duminil-Copin, Goodman, Slade, Lectures on Self-Avoiding Walks (2012), Sec. 1.3.

**Rests on recent unrefereed work. Check these premises first:**
- Well known to specialists, so novelty is modest
- Could conceivably be equivalent in difficulty to proving existence of gamma

**References:**
- https://arxiv.org/pdf/1206.2092
- https://arxiv.org/pdf/2207.08433
- https://en.wikipedia.org/wiki/Connective_constant
- https://arxiv.org/pdf/1809.00760

Difficulty estimate: 7.5/10 (calibrated: Collatz ≈ 5.5, twin primes ≈ 5.0). It is believed open; do not assume a quick answer exists, and say so plainly if you cannot make progress. Never present a heuristic, numerical evidence, or a partial result as a solution.

## What counts as an answer
Either a proof of `OpenProblems.QEDE113.Claim` or a proof of `¬ OpenProblems.QEDE113.Claim` (a disproof), in Lean 4 + Mathlib, using the exact statement in `problems/QED-E113/Statement.lean`. Read its "Formalization notes" first. If that file still says `def Claim : Prop := sorry`, the problem must first be formalized (see CONTRIBUTING.md); a faithful formalization is itself a welcome contribution.

If you think the Lean statement does not match the informal problem (it is trivially true or false, or it says something else), report that in an issue instead of exploiting it: such solutions are not credited.

## How to submit
0. First time? Solve a test problem (QED-Q1, the 2-line one, at minimum) and submit it, to confirm your Lean setup and the submission pipeline work before spending effort here. Skip this step if this IS a test problem.
1. Claim it (optional but encouraged): open an issue titled `Claim QED-E113` at https://github.com/floration/qed/issues/new?template=claim.yml. Comment on it at least once a week or the claim lapses.
2. Add `solutions/QED-E113/<github-username>/Solution.lean`:
```lean
import Mathlib
-- do NOT redefine Claim: CI prepends problems/QED-E113/Statement.lean to your file
theorem solution : OpenProblems.QEDE113.Claim := by   -- or ¬ OpenProblems.QEDE113.Claim
  ...
```
   Large proofs may add more `.lean` files (subfolders allowed) next to Solution.lean; CI concatenates them in path order before Solution.lean. Don't import them.
3. Add `solutions/QED-E113/<github-username>/meta.json`: `{"model": "<AI model used, or none>", "kind": "proof" | "disproof"}`. Optionally a `README.md` explaining the idea.
4. Open a pull request. CI checks: it compiles, no `sorry`/`admit`/new `axiom`/`set_option` tricks, and `#print axioms solution` shows only `propext`, `Classical.choice`, `Quot.sound`.

## Scoring
Size = number of non-blank, non-comment lines of `Solution.lean` excluding `import` lines (helper lemmas count). First verified solution is credited permanently; any later, strictly smaller verified solution becomes the "smallest solution".

## Rules for you, the model
- Do not modify `Statement.lean` in a solution PR.
- Be honest about uncertainty; if a step is unproven, leave it out rather than sneak in `sorry`.
- Test locally: `lake exe cache get && lake env lean solutions/QED-E113/<user>/Solution.lean`.
