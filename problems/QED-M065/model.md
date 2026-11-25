# QED-M065 — An explicit, checkable counterexample to Hadwiger's conjecture

You are an AI model helping someone attack this open problem. Read all of this before working.

## The problem
Main set · Grade B · QED Original · Graph theory

**Plain words:** Hadwiger's conjecture says a graph that needs t colours contains the complete graph K_t as a minor. A disproof claimed in October 2026 (not yet peer reviewed) is non-constructive: it uses graphs with no three pairwise non-adjacent vertices, on roughly 2^(10^12) vertices or more, and never names a graph. Find one concrete graph on fewer than a million vertices for which the conjecture fails, with a proof that can be checked.

**Math:** For a finite graph $G$ let $h(G)=\max\{t: K_t\preceq G\}$ be its Hadwiger number and $\chi(G)$ its chromatic number. Exhibit an explicit graph $G$ with $|V(G)|<10^6$ and $h(G)<\chi(G)$, with a complete proof of both bounds that can be checked (by hand or by a computer computation of feasible size). Sufficient route (Cambie): an explicit $G$ with $\alpha(G)\le2$, $|V(G)|=4t-1$ and no connected matching of size $t$ (a matching whose edges are pairwise joined by an edge of $G$) violates Hadwiger's conjecture.

**Rests on recent unrefereed work. Check these premises first:**
- OpenAI October 2026 release (Family 157), surveyed in arXiv:2610.17090 (unrefereed): the claim that Hadwiger's conjecture is false at all. If that disproof is wrong, the problem asks for something that may not exist, and its whole motivation collapses.
- arXiv:2609.35361 and arXiv:2606.01586 (2026 preprints): background on the α ≤ 2 / connected-matching route and the size of known counterexamples.

**References:**
- https://arxiv.org/pdf/2610.17090
- https://en.wikipedia.org/wiki/Hadwiger_conjecture_(graph_theory)
- https://arxiv.org/abs/2512.20392v1
- https://arxiv.org/pdf/2609.35361
- https://arxiv.org/abs/2606.01586
- https://arxiv.org/pdf/2305.05868
- https://arxiv.org/pdf/2108.10303
- https://arxiv.org/abs/2409.05920

Difficulty estimate: 5.0/10 (calibrated: Collatz ≈ 5.5, twin primes ≈ 5.0). It is believed open; do not assume a quick answer exists, and say so plainly if you cannot make progress. Never present a heuristic, numerical evidence, or a partial result as a solution.

## What counts as an answer
Either a proof of `OpenProblems.QEDM065.Claim` or a proof of `¬ OpenProblems.QEDM065.Claim` (a disproof), in Lean 4 + Mathlib, using the exact statement in `problems/QED-M065/Statement.lean`. Read its "Formalization notes" first. If that file still says `def Claim : Prop := sorry`, the problem must first be formalized (see CONTRIBUTING.md); a faithful formalization is itself a welcome contribution.

If you think the Lean statement does not match the informal problem (it is trivially true or false, or it says something else), report that in an issue instead of exploiting it: such solutions are not credited.

## How to submit
0. First time? Solve a test problem (QED-Q1, the 2-line one, at minimum) and submit it, to confirm your Lean setup and the submission pipeline work before spending effort here. Skip this step if this IS a test problem.
1. Claim it (optional but encouraged): open an issue titled `Claim QED-M065` at https://github.com/floration/qed/issues/new?template=claim.yml. Comment on it at least once a week or the claim lapses.
2. Add `solutions/QED-M065/<github-username>/Solution.lean`:
```lean
import Mathlib
-- do NOT redefine Claim: CI prepends problems/QED-M065/Statement.lean to your file
theorem solution : OpenProblems.QEDM065.Claim := by   -- or ¬ OpenProblems.QEDM065.Claim
  ...
```
3. Add `solutions/QED-M065/<github-username>/meta.json`: `{"model": "<AI model used, or none>", "kind": "proof" | "disproof"}`. Optionally a `README.md` explaining the idea.
4. Open a pull request. CI checks: it compiles, no `sorry`/`admit`/new `axiom`/`set_option` tricks, and `#print axioms solution` shows only `propext`, `Classical.choice`, `Quot.sound`.

## Scoring
Size = number of non-blank, non-comment lines of `Solution.lean` excluding `import` lines (helper lemmas count). First verified solution is credited permanently; any later, strictly smaller verified solution becomes the "smallest solution".

## Rules for you, the model
- Do not modify `Statement.lean` in a solution PR.
- Be honest about uncertainty; if a step is unproven, leave it out rather than sneak in `sorry`.
- Test locally: `lake exe cache get && lake env lean solutions/QED-M065/<user>/Solution.lean`.
