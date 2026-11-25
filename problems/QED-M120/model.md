# QED-M120 — Superlinear exponent for K_t-intersecting graph families

You are an AI model helping someone attack this open problem. Read all of this before working.

## The problem
Main set · Grade B · QED Extension · Combinatorics

**Plain words:** Consider a family of graphs on the same n labelled vertices such that any two graphs in the family share a complete subgraph K_t among their common edges. Taking all graphs that contain one fixed K_t gives a fraction 2^{-t(t-1)/2} of all graphs, and this is believed to be optimal. An easy entropy argument shows the best possible fraction is at most about 2^{-2t}, so the exponent is at least linear in t. Prove that the exponent grows faster than linearly: the largest fraction is at most 2^{-f(t)} with f(t)/t tending to infinity.

**Math:** Call $\mathcal F\subseteq 2^{E(K_n)}$ $K_t$-intersecting if for all $G,H\in\mathcal F$ the graph $G\cap H$ contains a copy of $K_t$. Let $\alpha_t=\sup_n\max\{|\mathcal F|\,2^{-\binom n2}:\mathcal F\text{ is }K_t\text{-intersecting on }[n]\}$ and $f(t)=\log_2(1/\alpha_t)$. Prove $f(t)/t\to\infty$. (Known: $f(t)\le\binom t2$; $f(3)=3,f(4)=6,f(5)=10$; Shearer's lemma over a uniformly random partition of $[n]$ into $m$ parts gives $f(t)\ge m\,f(\lceil t/m\rceil)$, hence $f(t)\ge 10\lfloor t/5\rfloor$ and $\lim f(t)/t=\sup_s f(s)/s$. So the claim is equivalent to: for every $C$ there is $s$ with $\alpha_s\le 2^{-Cs}$. Conjectured: $f(t)=\binom t2$.)

**Credit:** Full conjecture by Ellis, Filmus, Friedgut (generalising the Simonovits–Sós triangle question). Superlinear-exponent formulation by the proposer. Bounds by Berger–Zhao, Mani–Zhang, Sason.

**Rests on recent unrefereed work. Check these premises first:**
- The full statement is often called the 'Ellis–Filmus–Friedgut conjecture'. This candidate is an unnamed weaker sub-question, which the naming rule allows.
- The t=5 result is a 2025 PRIMES report, possibly unrefereed. It is used only for context.
- A cleverer entropy or recursive-trace argument might give a superlinear exponent fairly easily. I could not find one, but this is a difficulty risk.

**References:**
- https://arxiv.org/abs/2103.12671
- https://arxiv.org/abs/2501.02894
- https://math.mit.edu/research/highschool/primes/materials/2024/Mani-Zhang.pdf
- https://arxiv.org/pdf/2510.18064

Difficulty estimate: 3.5/10 (calibrated: Collatz ≈ 5.5, twin primes ≈ 5.0). It is believed open; do not assume a quick answer exists, and say so plainly if you cannot make progress. Never present a heuristic, numerical evidence, or a partial result as a solution.

## What counts as an answer
Either a proof of `OpenProblems.QEDM120.Claim` or a proof of `¬ OpenProblems.QEDM120.Claim` (a disproof), in Lean 4 + Mathlib, using the exact statement in `problems/QED-M120/Statement.lean`. Read its "Formalization notes" first. If that file still says `def Claim : Prop := sorry`, the problem must first be formalized (see CONTRIBUTING.md); a faithful formalization is itself a welcome contribution.

If you think the Lean statement does not match the informal problem (it is trivially true or false, or it says something else), report that in an issue instead of exploiting it: such solutions are not credited.

## How to submit
0. First time? Solve a test problem (QED-Q1, the 2-line one, at minimum) and submit it, to confirm your Lean setup and the submission pipeline work before spending effort here. Skip this step if this IS a test problem.
1. Claim it (optional but encouraged): open an issue titled `Claim QED-M120` at https://github.com/floration/qed/issues/new?template=claim.yml. Comment on it at least once a week or the claim lapses.
2. Add `solutions/QED-M120/<github-username>/Solution.lean`:
```lean
import Mathlib
-- do NOT redefine Claim: CI prepends problems/QED-M120/Statement.lean to your file
theorem solution : OpenProblems.QEDM120.Claim := by   -- or ¬ OpenProblems.QEDM120.Claim
  ...
```
   Large proofs may add more `.lean` files (subfolders allowed) next to Solution.lean; CI concatenates them in path order before Solution.lean. Don't import them.
3. Add `solutions/QED-M120/<github-username>/meta.json`: `{"model": "<AI model used, or none>", "kind": "proof" | "disproof"}`. Optionally a `README.md` explaining the idea.
4. Open a pull request. CI checks: it compiles, no `sorry`/`admit`/new `axiom`/`set_option` tricks, and `#print axioms solution` shows only `propext`, `Classical.choice`, `Quot.sound`.

## Scoring
Size = number of non-blank, non-comment lines of `Solution.lean` excluding `import` lines (helper lemmas count). First verified solution is credited permanently; any later, strictly smaller verified solution becomes the "smallest solution".

## Rules for you, the model
- Do not modify `Statement.lean` in a solution PR.
- Be honest about uncertainty; if a step is unproven, leave it out rather than sneak in `sorry`.
- Test locally: `lake exe cache get && lake env lean solutions/QED-M120/<user>/Solution.lean`.
