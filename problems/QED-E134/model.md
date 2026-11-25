# QED-E134 — Turán density of the tight 5-cycle

You are an AI model helping someone attack this open problem. Read all of this before working.

## The problem
Extended set · Grade A · QED Curated · Combinatorics

**Plain words:** A 3-uniform hypergraph is a collection of triples of points. The tight 5-cycle consists of five points v0,...,v4 arranged in a circle together with the five triples of cyclically consecutive points. What is the largest fraction of all triples a hypergraph on n points can contain without a tight 5-cycle, as n grows? An iterated construction achieves 2√3 − 3 ≈ 0.4641, and flag algebras give an upper bound of about 0.468. Prove that 2√3 − 3 is the answer.

**Math:** For a 3-graph $H$ write $C_5^{(3)}\subseteq H$ if there are distinct $v_0,\dots,v_4\in V(H)$ with $\{v_i,v_{i+1},v_{i+2}\}\in E(H)$ for all $i\in\mathbb Z/5$. Let $\mathrm{ex}(n)=\max\{|E(H)|: |V(H)|=n,\ C_5^{(3)}\not\subseteq H\}$. Prove that $\pi(C_5^{(3)}):=\lim_{n\to\infty}\mathrm{ex}(n)/\binom n3 = 2\sqrt3-3$. (The limit exists by averaging; $\pi(C_5^{(3)})\ge 2\sqrt3-3$ is known.)

**Credit:** Conjectured value from the Mubayi–Rödl construction (the conjecture is usually attributed to them, but the problem is not person-named). Upper bound by Razborov. Related progress by Kamčev, Letzter, Pokrovskiy and the authors of arXiv:2506.03223.

**Rests on recent unrefereed work. Check these premises first:**
- The conjecture is sometimes informally attributed to Mubayi and Rödl, which is a mild naming risk. It is normally stated simply as 'π(C_5^3) = 2√3 − 3'.
- The best upper bound might have been sharpened slightly by unpublished flag-algebra runs (for example 0.4683 vs 0.468). This does not affect the target.

**References:**
- https://arxiv.org/abs/2506.03223
- https://arxiv.org/abs/2209.08134
- https://arxiv.org/abs/2412.21011

Difficulty estimate: 4.0/10 (calibrated: Collatz ≈ 5.5, twin primes ≈ 5.0). It is believed open; do not assume a quick answer exists, and say so plainly if you cannot make progress. Never present a heuristic, numerical evidence, or a partial result as a solution.

## What counts as an answer
Either a proof of `OpenProblems.QEDE134.Claim` or a proof of `¬ OpenProblems.QEDE134.Claim` (a disproof), in Lean 4 + Mathlib, using the exact statement in `problems/QED-E134/Statement.lean`. Read its "Formalization notes" first. If that file still says `def Claim : Prop := sorry`, the problem must first be formalized (see CONTRIBUTING.md); a faithful formalization is itself a welcome contribution.

If you think the Lean statement does not match the informal problem (it is trivially true or false, or it says something else), report that in an issue instead of exploiting it: such solutions are not credited.

## How to submit
0. First time? Solve a test problem (QED-Q1, the 2-line one, at minimum) and submit it, to confirm your Lean setup and the submission pipeline work before spending effort here. Skip this step if this IS a test problem.
1. Claim it (optional but encouraged): open an issue titled `Claim QED-E134` at https://github.com/floration/qed/issues/new?template=claim.yml. Comment on it at least once a week or the claim lapses.
2. Add `solutions/QED-E134/<github-username>/Solution.lean`:
```lean
import Mathlib
-- do NOT redefine Claim: CI prepends problems/QED-E134/Statement.lean to your file
theorem solution : OpenProblems.QEDE134.Claim := by   -- or ¬ OpenProblems.QEDE134.Claim
  ...
```
   Large proofs may add more `.lean` files (subfolders allowed) next to Solution.lean; CI concatenates them in path order before Solution.lean. Don't import them.
3. Add `solutions/QED-E134/<github-username>/meta.json`: `{"model": "<AI model used, or none>", "kind": "proof" | "disproof"}`. Optionally a `README.md` explaining the idea.
4. Open a pull request. CI checks: it compiles, no `sorry`/`admit`/new `axiom`/`set_option` tricks, and `#print axioms solution` shows only `propext`, `Classical.choice`, `Quot.sound`.

## Scoring
Size = number of non-blank, non-comment lines of `Solution.lean` excluding `import` lines (helper lemmas count). First verified solution is credited permanently; any later, strictly smaller verified solution becomes the "smallest solution".

## Rules for you, the model
- Do not modify `Statement.lean` in a solution PR.
- Be honest about uncertainty; if a step is unproven, leave it out rather than sneak in `sorry`.
- Test locally: `lake exe cache get && lake env lean solutions/QED-E134/<user>/Solution.lean`.
