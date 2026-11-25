# QED-E158 — Once-reinforced random walk on Z^2: recurrent for some reinforcement?

You are an AI model helping someone attack this open problem. Read all of this before working.

## The problem
Extended set · Grade A · QED Curated · Probability

**Plain words:** A walker on the square grid prefers edges it has already crossed: a used edge has weight beta, an unused edge weight 1. With beta = 1 this is simple random walk, which returns to its start infinitely often. Is there any beta > 1 for which the reinforced walk is still recurrent (returns to the origin infinitely often with probability 1)? In dimensions 2 to 5, no beta > 1 is known to give either recurrence or transience.

**Math:** Fix $\beta>1$. ORRW$(\beta)$ on $\mathbb Z^2$: $X_0=0$; let $E_t$ be the set of undirected nearest-neighbour edges traversed by $X$ up to time $t$, $w_t(e)=\beta$ if $e\in E_t$ and $w_t(e)=1$ otherwise, and $\Pr(X_{t+1}=y\mid X_0,\dots,X_t)=w_t(\{X_t,y\})/\sum_{z\sim X_t}w_t(\{X_t,z\})$ for $y\sim X_t$. Claim: there exists $\beta>1$ such that $\Pr(X_t=0\text{ for infinitely many }t)=1$.

**Credit:** Davis (model); conjecture forms due to Sidoravicius (all beta, d=2) and Beffara (large reinforcement); stated as open in Bou-Rabee-Peres arXiv:2610.00090 Problem 3 and Kious-Schapira-Tarres arXiv:1807.07167.

**Rests on recent unrefereed work. Check these premises first:**
- Key status statements come from 2026 preprints (Bou-Rabee-Peres, Elboim-Kozma), not yet refereed
- Naming: the full 'every beta' and 'large beta' versions are attributed to Sidoravicius/Beffara; the 'some beta>1' claim is an unnamed weaker sub-question
- Collevecchio-Tarres mention advanced work in progress on Z^2 shape theorem failure (not a recurrence result)

**References:**
- https://arxiv.org/abs/2610.00090
- https://arxiv.org/abs/1807.07167
- https://arxiv.org/abs/2601.17972
- https://arxiv.org/abs/2509.04318
- https://arxiv.org/abs/2602.10721

Difficulty estimate: 3.5/10 (calibrated: Collatz ≈ 5.5, twin primes ≈ 5.0). It is believed open; do not assume a quick answer exists, and say so plainly if you cannot make progress. Never present a heuristic, numerical evidence, or a partial result as a solution.

## What counts as an answer
Either a proof of `OpenProblems.QEDE158.Claim` or a proof of `¬ OpenProblems.QEDE158.Claim` (a disproof), in Lean 4 + Mathlib, using the exact statement in `problems/QED-E158/Statement.lean`. Read its "Formalization notes" first. If that file still says `def Claim : Prop := sorry`, the problem must first be formalized (see CONTRIBUTING.md); a faithful formalization is itself a welcome contribution.

If you think the Lean statement does not match the informal problem (it is trivially true or false, or it says something else), report that in an issue instead of exploiting it: such solutions are not credited.

## How to submit
0. First time? Solve a test problem (QED-Q1, the 2-line one, at minimum) and submit it, to confirm your Lean setup and the submission pipeline work before spending effort here. Skip this step if this IS a test problem.
1. Claim it (optional but encouraged): open an issue titled `Claim QED-E158` at https://github.com/floration/qed/issues/new?template=claim.yml. Comment on it at least once a week or the claim lapses.
2. Add `solutions/QED-E158/<github-username>/Solution.lean`:
```lean
import Mathlib
-- do NOT redefine Claim: CI prepends problems/QED-E158/Statement.lean to your file
theorem solution : OpenProblems.QEDE158.Claim := by   -- or ¬ OpenProblems.QEDE158.Claim
  ...
```
   Large proofs may add more `.lean` files (subfolders allowed) next to Solution.lean; CI concatenates them in path order before Solution.lean. Don't import them.
3. Add `solutions/QED-E158/<github-username>/meta.json`: `{"model": "<AI model used, or none>", "kind": "proof" | "disproof"}`. Optionally a `README.md` explaining the idea.
4. Open a pull request. CI checks: it compiles, no `sorry`/`admit`/new `axiom`/`set_option` tricks, and `#print axioms solution` shows only `propext`, `Classical.choice`, `Quot.sound`.

## Scoring
Size = number of non-blank, non-comment lines of `Solution.lean` excluding `import` lines (helper lemmas count). First verified solution is credited permanently; any later, strictly smaller verified solution becomes the "smallest solution".

## Rules for you, the model
- Do not modify `Statement.lean` in a solution PR.
- Be honest about uncertainty; if a step is unproven, leave it out rather than sneak in `sorry`.
- Test locally: `lake exe cache get && lake env lean solutions/QED-E158/<user>/Solution.lean`.
