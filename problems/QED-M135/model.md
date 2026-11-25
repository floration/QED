# QED-M135 — Is the Shannon capacity of a graph computable?

You are an AI model helping someone attack this open problem. Read all of this before working.

## The problem
Main set · Grade A · QED Curated · Information theory

**Plain words:** The Shannon capacity Theta(G) of a finite graph is the limit of alpha(G^k)^{1/k}, where alpha is the independence number of the k-th strong power. Every alpha(G^k) is computable, so one can list ever better lower bounds, but no algorithm is known that produces upper bounds converging to Theta(G). Decide whether some algorithm, given G and a rational q, halts exactly when Theta(G) < q (equivalently, whether Theta is a computable function).

**Math:** Encode finite simple graphs and rationals as natural numbers and let $\Theta(G)=\sup_k\alpha(G^{\boxtimes k})^{1/k}$. Determine whether $U=\{(G,q):\Theta(G)<q\}$ is recursively enumerable. (Since $\{(G,q):\Theta(G)>q\}$ is r.e., $U$ is r.e. iff $G\mapsto\Theta(G)$ is a computable real-valued function.) A weaker open subquestion: is $\Theta(G)$ a computable real for every $G$ (e.g. $G=C_7$)?

**Credit:** Alon-Lubetzky (2006); Boche-Deppe (2020)

**Rests on recent unrefereed work. Check these premises first:**
- Phrasing as 'decide' - both answers would be major; scorer may see it as famous/very hard

**References:**
- https://arxiv.org/abs/2001.11442
- https://arxiv.org/abs/2010.06873
- https://arxiv.org/abs/1807.00169
- https://arxiv.org/abs/2509.24600
- https://arxiv.org/abs/2512.05357
- https://arxiv.org/abs/cs/0608021

Difficulty estimate: 9.0/10 (calibrated: Collatz ≈ 5.5, twin primes ≈ 5.0). It is believed open; do not assume a quick answer exists, and say so plainly if you cannot make progress. Never present a heuristic, numerical evidence, or a partial result as a solution.

## What counts as an answer
Either a proof of `OpenProblems.QEDM135.Claim` or a proof of `¬ OpenProblems.QEDM135.Claim` (a disproof), in Lean 4 + Mathlib, using the exact statement in `problems/QED-M135/Statement.lean`. Read its "Formalization notes" first. If that file still says `def Claim : Prop := sorry`, the problem must first be formalized (see CONTRIBUTING.md); a faithful formalization is itself a welcome contribution.

If you think the Lean statement does not match the informal problem (it is trivially true or false, or it says something else), report that in an issue instead of exploiting it: such solutions are not credited.

## How to submit
0. First time? Solve a test problem (QED-Q1, the 2-line one, at minimum) and submit it, to confirm your Lean setup and the submission pipeline work before spending effort here. Skip this step if this IS a test problem.
1. Claim it (optional but encouraged): open an issue titled `Claim QED-M135` at https://github.com/floration/qed/issues/new?template=claim.yml. Comment on it at least once a week or the claim lapses.
2. Add `solutions/QED-M135/<github-username>/Solution.lean`:
```lean
import Mathlib
-- do NOT redefine Claim: CI prepends problems/QED-M135/Statement.lean to your file
theorem solution : OpenProblems.QEDM135.Claim := by   -- or ¬ OpenProblems.QEDM135.Claim
  ...
```
   Large proofs may add more `.lean` files (subfolders allowed) next to Solution.lean; CI concatenates them in path order before Solution.lean. Don't import them.
3. Add `solutions/QED-M135/<github-username>/meta.json`: `{"model": "<AI model used, or none>", "kind": "proof" | "disproof"}`. Optionally a `README.md` explaining the idea.
4. Open a pull request. CI checks: it compiles, no `sorry`/`admit`/new `axiom`/`set_option` tricks, and `#print axioms solution` shows only `propext`, `Classical.choice`, `Quot.sound`.

## Scoring
Size = number of non-blank, non-comment lines of `Solution.lean` excluding `import` lines (helper lemmas count). First verified solution is credited permanently; any later, strictly smaller verified solution becomes the "smallest solution".

## Rules for you, the model
- Do not modify `Statement.lean` in a solution PR.
- Be honest about uncertainty; if a step is unproven, leave it out rather than sneak in `sorry`.
- Test locally: `lake exe cache get && lake env lean solutions/QED-M135/<user>/Solution.lean`.
