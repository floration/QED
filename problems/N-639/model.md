# N-639 — KdV with a cosine coefficient

You are an AI model helping someone attack this open problem. Read all of this before working.

## The problem
Grade B · QED Original · PDE

**Plain words:** Put a cos x in front of the cubic term of the modified KdV equation on the circle. The energy and the mean are still conserved, but the L² norm is not, and the energy no longer has a definite sign. Can smooth solutions blow up in finite time?

**Math:** Consider $u_t+u_{xxx}+(\cos(x)\,u^3)_x=0$ on $\mathbb T=\mathbb R/2\pi\mathbb Z$ with real $u_0\in C^\infty(\mathbb T)$. It is Hamiltonian, $u_t=\partial_x\frac{\delta H}{\delta u}$ with $H=\int(\tfrac12u_x^2-\tfrac14\cos(x)u^4)$, and conserves $\int u$ and $H$. However, $\frac{d}{dt}\int u^2=\frac12\int\sin(x)u^4$. Decide whether every such $u_0$ yields a global smooth solution, or whether $\|u(t)\|_{H^1}\to\infty$ in finite time for some $u_0$.

**References:**
- https://arxiv.org/pdf/2108.11104
- https://arxiv.org/pdf/1308.4835

Difficulty estimate: 4.0/10 (calibrated: Collatz ≈ 5.5, twin primes ≈ 5.0). It is believed open; do not assume a quick answer exists, and say so plainly if you cannot make progress. Never present a heuristic, numerical evidence, or a partial result as a solution.

## What counts as an answer
Either a proof of `OpenProblems.N639.Claim` or a proof of `¬ OpenProblems.N639.Claim` (a disproof), in Lean 4 + Mathlib, using the exact statement in `problems/N-639/Statement.lean`. Read its "Formalization notes" first. If that file still says `def Claim : Prop := sorry`, the problem must first be formalized (see CONTRIBUTING.md); a faithful formalization is itself a welcome contribution.

If you think the Lean statement does not match the informal problem (it is trivially true or false, or it says something else), report that in an issue instead of exploiting it: such solutions are not credited.

## How to submit
1. Claim it (optional but encouraged): open an issue titled `Claim N-639` at https://github.com/floration/qed/issues/new?template=claim.yml. Comment on it at least once a week or the claim lapses.
2. Add `solutions/N-639/<github-username>/Solution.lean`:
```lean
import Mathlib
-- do NOT redefine Claim: CI prepends problems/N-639/Statement.lean to your file
theorem solution : OpenProblems.N639.Claim := by   -- or ¬ OpenProblems.N639.Claim
  ...
```
3. Add `solutions/N-639/<github-username>/meta.json`: `{"model": "<AI model used, or none>", "kind": "proof" | "disproof"}`. Optionally a `README.md` explaining the idea.
4. Open a pull request. CI checks: it compiles, no `sorry`/`admit`/new `axiom`/`set_option` tricks, and `#print axioms solution` shows only `propext`, `Classical.choice`, `Quot.sound`.

## Scoring
Size = number of non-blank, non-comment lines of `Solution.lean` excluding `import` lines (helper lemmas count). First verified solution is credited permanently; any later, strictly smaller verified solution becomes the "smallest solution".

## Rules for you, the model
- Do not modify `Statement.lean` in a solution PR.
- Be honest about uncertainty; if a step is unproven, leave it out rather than sneak in `sorry`.
- Test locally: `lake exe cache get && lake env lean solutions/N-639/<user>/Solution.lean`.
