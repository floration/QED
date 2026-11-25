# QED-E195 — Is the Held–Karp integrality ratio for asymmetric TSP equal to 2?

You are an AI model helping someone attack this open problem. Read all of this before working.

## The problem
Extended set · Grade A · QED Curated · Combinatorics

**Plain words:** In the asymmetric traveling salesman problem the distance from a to b may differ from b to a, but the triangle inequality holds. The Held–Karp linear program assigns fractional weights to directed arcs so that every city has in-weight and out-weight 1 and every proper set of cities has out-weight at least 1. Is the cheapest directed tour always at most twice the LP value? A factor 2 is known to be necessary; the best proven factor is 22 in refereed work and about 14.8 in a 2026 preprint.

**Math:** Let $n\ge2$ and $c:[n]\times[n]\to\mathbb R_{\ge0}$ with $c(u,w)\le c(u,v)+c(v,w)$ for all $u,v,w$ (not necessarily symmetric). Let $x\ge0$ be defined on arcs $(u,v)$, $u\ne v$, with $x(\delta^+(v))=x(\delta^-(v))=1$ for all $v$ and $x(\delta^+(S))\ge1$ for all $\emptyset\ne S\subsetneq[n]$. Prove or disprove: there is a cyclic ordering $v_1,\dots,v_n$ of $[n]$ with $\sum_{i=1}^n c(v_i,v_{i+1})\le 2\sum_{(u,v)}c(u,v)x_{uv}$ (indices mod $n$). Since the integrality ratio is known to be $\ge2$ (Charikar–Goemans–Karloff), a proof shows it equals $2$.

**Credit:** Open question posed in Charikar–Goemans–Karloff (2006) and repeated in Svensson–Tarnawski–Végh and Traub–Vygen.

**Rests on recent unrefereed work. Check these premises first:**
- Upper bound ~14.83 rests on a 2026 preprint (refereed bound is 22)
- Exact value 2 is a natural target but not universally conjectured; some experts only expect a small constant

**References:**
- https://arxiv.org/html/2603.14334v1
- https://math.mit.edu/~goemans/PAPERS/CharikarGoemansKarloff-2006-ATSP.pdf
- https://arxiv.org/pdf/1708.04215

Difficulty estimate: 4.0/10 (calibrated: Collatz ≈ 5.5, twin primes ≈ 5.0). It is believed open; do not assume a quick answer exists, and say so plainly if you cannot make progress. Never present a heuristic, numerical evidence, or a partial result as a solution.

## What counts as an answer
Either a proof of `OpenProblems.QEDE195.Claim` or a proof of `¬ OpenProblems.QEDE195.Claim` (a disproof), in Lean 4 + Mathlib, using the exact statement in `problems/QED-E195/Statement.lean`. Read its "Formalization notes" first. If that file still says `def Claim : Prop := sorry`, the problem must first be formalized (see CONTRIBUTING.md); a faithful formalization is itself a welcome contribution.

If you think the Lean statement does not match the informal problem (it is trivially true or false, or it says something else), report that in an issue instead of exploiting it: such solutions are not credited.

## How to submit
0. First time? Solve a test problem (QED-Q1, the 2-line one, at minimum) and submit it, to confirm your Lean setup and the submission pipeline work before spending effort here. Skip this step if this IS a test problem.
1. Claim it (optional but encouraged): open an issue titled `Claim QED-E195` at https://github.com/floration/qed/issues/new?template=claim.yml. Comment on it at least once a week or the claim lapses.
2. Add `solutions/QED-E195/<github-username>/Solution.lean`:
```lean
import Mathlib
-- do NOT redefine Claim: CI prepends problems/QED-E195/Statement.lean to your file
theorem solution : OpenProblems.QEDE195.Claim := by   -- or ¬ OpenProblems.QEDE195.Claim
  ...
```
   Large proofs may add more `.lean` files (subfolders allowed) next to Solution.lean; CI concatenates them in path order before Solution.lean. Don't import them.
3. Add `solutions/QED-E195/<github-username>/meta.json`: `{"model": "<AI model used, or none>", "kind": "proof" | "disproof"}`. Optionally a `README.md` explaining the idea.
4. Open a pull request. CI checks: it compiles, no `sorry`/`admit`/new `axiom`/`set_option` tricks, and `#print axioms solution` shows only `propext`, `Classical.choice`, `Quot.sound`.

## Scoring
Size = number of non-blank, non-comment lines of `Solution.lean` excluding `import` lines (helper lemmas count). First verified solution is credited permanently; any later, strictly smaller verified solution becomes the "smallest solution".

## Rules for you, the model
- Do not modify `Statement.lean` in a solution PR.
- Be honest about uncertainty; if a step is unproven, leave it out rather than sneak in `sorry`.
- Test locally: `lake exe cache get && lake env lean solutions/QED-E195/<user>/Solution.lean`.
