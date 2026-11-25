# QED-M139 — Three consecutive integers with large prime factors

You are an AI model helping someone attack this open problem. Read all of this before working.

## The problem
Main set · Grade B · QED Curated · Number theory

**Plain words:** Show that for every exponent θ below 1 there are infinitely many n such that n, n+1 and n+2 each have a prime factor larger than n^θ (for instance θ = 0.9). The two-term analogue (n and n+1) is settled: OpenAI's 2026 joint Dickman law for consecutive integers (Erdős–Pomerance conjecture) shows that log P(n)/log n and log P(n+1)/log n are asymptotically independent, so that set has density (log(1/θ))^2 for 1/2 ≤ θ < 1. Three consecutive integers are not covered.

**Math:** Let $P(m)$ be the largest prime factor of $m$. Prove that for every $\theta<1$ there are infinitely many $n$ with $\min\{P(n),P(n+1),P(n+2)\}>n^{\theta}$. (Benchmark case: $\theta=0.9$. Stronger target: for $1/2\le\theta<1$ the set has lower density $\ge c(\theta)>0$, conjecturally equal to $(\log(1/\theta))^3$.)

**Credit:** QED original (archived Nov 2026, restored after re-review).

**References:**
- https://arxiv.org/abs/1904.05096
- https://arxiv.org/abs/2607.16032
- https://arxiv.org/abs/2610.23280
- https://users.renyi.hu/~p_erdos/1978-29.pdf
- https://arxiv.org/html/2512.01739v1

Difficulty estimate: 5.5/10 (anchored scale: 1 ≈ Erdős–Ginzburg–Ziv, 2.5 ≈ the sensitivity conjecture, 5 ≈ bounded prime gaps, 7.5 ≈ the Riemann Hypothesis, 10 ≈ P vs NP). It is believed open; do not assume a quick answer exists, and say so plainly if you cannot make progress. Never present a heuristic, numerical evidence, or a partial result as a solution.

## What counts as an answer
Either a proof of `OpenProblems.QEDM139.Claim` or a proof of `¬ OpenProblems.QEDM139.Claim` (a disproof), in Lean 4 + Mathlib, using the exact statement in `problems/QED-M139/Statement.lean`. Read its "Formalization notes" first. If that file still says `def Claim : Prop := sorry`, the problem must first be formalized (see CONTRIBUTING.md); a faithful formalization is itself a welcome contribution.

If you think the Lean statement does not match the informal problem (it is trivially true or false, or it says something else), report that in an issue instead of exploiting it: such solutions are not credited.

## How to submit
0. First time? Solve a test problem (QED-Q1, the 2-line one, at minimum) and submit it, to confirm your Lean setup and the submission pipeline work before spending effort here. Skip this step if this IS a test problem.
1. Claim it (optional but encouraged): open an issue titled `Claim QED-M139` at https://github.com/floration/qed/issues/new?template=claim.yml. Comment on it at least once a week or the claim lapses.
2. Add `solutions/QED-M139/<github-username>/Solution.lean`:
```lean
import Mathlib
-- do NOT redefine Claim: CI prepends problems/QED-M139/Statement.lean to your file
theorem solution : OpenProblems.QEDM139.Claim := by   -- or ¬ OpenProblems.QEDM139.Claim
  ...
```
   Large proofs may add more `.lean` files (subfolders allowed) next to Solution.lean; CI concatenates them in path order before Solution.lean. Don't import them.
3. Add `solutions/QED-M139/<github-username>/meta.json`: `{"model": "<AI model used, or none>", "kind": "proof" | "disproof"}`. Optionally a `README.md` explaining the idea.
4. Open a pull request. CI checks: it compiles, no `sorry`/`admit`/new `axiom`/`set_option` tricks, and `#print axioms solution` shows only `propext`, `Classical.choice`, `Quot.sound`.

## Scoring
Size = number of non-blank, non-comment lines of `Solution.lean` excluding `import` lines (helper lemmas count). First verified solution is credited permanently; any later, strictly smaller verified solution becomes the "smallest solution".

## Rules for you, the model
- Do not modify `Statement.lean` in a solution PR.
- Be honest about uncertainty; if a step is unproven, leave it out rather than sneak in `sorry`.
- Test locally: `lake exe cache get && lake env lean solutions/QED-M139/<user>/Solution.lean`.
