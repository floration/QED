# QED-E184 — A flat cyclotomic polynomial with five odd prime factors

You are an AI model helping someone attack this open problem. Read all of this before working.

## The problem
Extended set · Grade B · QED Curated · Algebra

**Plain words:** Call the cyclotomic polynomial Phi_n flat if every coefficient is -1, 0 or 1. Flat examples are known when n has up to four distinct odd prime factors (for example Phi_{3*5*31*929}). Is there a flat Phi_n where n has five distinct odd prime factors? None has ever been found, and no reason is known why they cannot exist.

**Math:** Let $\omega_{\mathrm{odd}}(n)$ be the number of distinct odd primes dividing $n$. Does there exist $n$ with $\omega_{\mathrm{odd}}(n)=5$ such that every coefficient of $\Phi_n(x)\in\mathbb Z[x]$ lies in $\{-1,0,1\}$? (Since $\Phi_{2m}(x)=\pm\Phi_m(-x)$ for odd $m>1$ and $\Phi_{n}(x)=\Phi_{\mathrm{rad}(n)}(x^{n/\mathrm{rad}(n)})$, one may assume $n=p_1p_2p_3p_4p_5$ with distinct odd primes.)

**Credit:** Question stated by N. Kaplan (Integers 2010); computations by Arnold–Monagan

**Rests on recent unrefereed work. Check these premises first:**
- Search bound 6.26·10^8 is from 2010; later unpublished searches may extend it but no example has been reported (Bachman 2026)
- Could be resolved by a lucky search, but candidate n are enormous (order-4 flat examples already ~4·10^5 with degree ~2·10^5), so a construction needs theory

**References:**
- https://emis.univie.ac.at/journals/INTEGERS/papers/k30/k30.pdf
- https://arxiv.org/abs/1207.5811
- https://arxiv.org/abs/2602.07727
- https://arxiv.org/abs/2111.04034

Difficulty estimate: 6.0/10 (anchored scale: 1 ≈ Erdős–Ginzburg–Ziv, 2.5 ≈ the sensitivity conjecture, 5 ≈ bounded prime gaps, 7.5 ≈ the Riemann Hypothesis, 10 ≈ P vs NP). It is believed open; do not assume a quick answer exists, and say so plainly if you cannot make progress. Never present a heuristic, numerical evidence, or a partial result as a solution.

## What counts as an answer
Either a proof of `OpenProblems.QEDE184.Claim` or a proof of `¬ OpenProblems.QEDE184.Claim` (a disproof), in Lean 4 + Mathlib, using the exact statement in `problems/QED-E184/Statement.lean`. Read its "Formalization notes" first. If that file still says `def Claim : Prop := sorry`, the problem must first be formalized (see CONTRIBUTING.md); a faithful formalization is itself a welcome contribution.

If you think the Lean statement does not match the informal problem (it is trivially true or false, or it says something else), report that in an issue instead of exploiting it: such solutions are not credited.

## How to submit
0. First time? Solve a test problem (QED-Q1, the 2-line one, at minimum) and submit it, to confirm your Lean setup and the submission pipeline work before spending effort here. Skip this step if this IS a test problem.
1. Claim it (optional but encouraged): open an issue titled `Claim QED-E184` at https://github.com/floration/qed/issues/new?template=claim.yml. Comment on it at least once a week or the claim lapses.
2. Add `solutions/QED-E184/<github-username>/Solution.lean`:
```lean
import Mathlib
-- do NOT redefine Claim: CI prepends problems/QED-E184/Statement.lean to your file
theorem solution : OpenProblems.QEDE184.Claim := by   -- or ¬ OpenProblems.QEDE184.Claim
  ...
```
   Large proofs may add more `.lean` files (subfolders allowed) next to Solution.lean; CI concatenates them in path order before Solution.lean. Don't import them.
3. Add `solutions/QED-E184/<github-username>/meta.json`: `{"model": "<AI model used, or none>", "kind": "proof" | "disproof"}`. Optionally a `README.md` explaining the idea.
4. Open a pull request. CI checks: it compiles, no `sorry`/`admit`/new `axiom`/`set_option` tricks, and `#print axioms solution` shows only `propext`, `Classical.choice`, `Quot.sound`.

## Scoring
Size = number of non-blank, non-comment lines of `Solution.lean` excluding `import` lines (helper lemmas count). First verified solution is credited permanently; any later, strictly smaller verified solution becomes the "smallest solution".

## Rules for you, the model
- Do not modify `Statement.lean` in a solution PR.
- Be honest about uncertainty; if a step is unproven, leave it out rather than sneak in `sorry`.
- Test locally: `lake exe cache get && lake env lean solutions/QED-E184/<user>/Solution.lean`.
