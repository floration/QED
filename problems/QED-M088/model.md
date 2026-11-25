# QED-M088 — Critical NLS blow-up threshold on the cube surface

You are an AI model helping someone attack this open problem. Read all of this before working.

## The problem
Main set · Grade B · QED Extension · PDE · formerly N-643

**Plain words:** In the plane, the focusing cubic Schrödinger equation needs at least the ground-state mass to blow up. On the surface of a cube, each corner is a cone with total angle 3π/2, which can hold a 'three-quarter' ground state. So the blow-up threshold should drop to three quarters of the planar one, and the claim is that it does exactly that.

**Math:** Let $S$ be the surface of the unit cube with its flat metric, and let $\Delta$ be the Friedrichs extension of the Laplace–Beltrami operator on $C_c^\infty(S\setminus\{\text{vertices}\})$. Let $Q$ be the ground state of $\Delta Q-Q+Q^3=0$ on $\mathbb R^2$, and put $m_*=\tfrac34\|Q\|_{L^2(\mathbb R^2)}^2$. For $iu_t+\Delta u+|u|^2u=0$ on $S$, prove: (i) every $u_0\in H^1(S)$ with $\|u_0\|_2^2<m_*$ gives a global $H^1$ solution; (ii) for every $\varepsilon>0$ there is $u_0\in H^1(S)$ with $m_*<\|u_0\|_2^2<m_*+\varepsilon$ whose solution blows up in finite time. (Stronger, optional: blow-up data exist for every mass $m>m_*$; also decide whether there is blow-up at mass exactly $m_*$.)

**Credit:** Extension of Weinstein (Comm. Math. Phys. 1983) mass-critical threshold; related Strichartz work on flat cones by Ford and by Blair-Ford-Marzuola.

**References:**
- https://arxiv.org/html/2503.15142v3

Difficulty estimate: 3.5/10 (calibrated: Collatz ≈ 5.5, twin primes ≈ 5.0). It is believed open; do not assume a quick answer exists, and say so plainly if you cannot make progress. Never present a heuristic, numerical evidence, or a partial result as a solution.

## What counts as an answer
Either a proof of `OpenProblems.QEDM088.Claim` or a proof of `¬ OpenProblems.QEDM088.Claim` (a disproof), in Lean 4 + Mathlib, using the exact statement in `problems/QED-M088/Statement.lean`. Read its "Formalization notes" first. If that file still says `def Claim : Prop := sorry`, the problem must first be formalized (see CONTRIBUTING.md); a faithful formalization is itself a welcome contribution. What is missing: Statement left as sorry by design. Literature check was not done by the original reviewer (search budget exhausted); worth a novelty search before publishing.

If you think the Lean statement does not match the informal problem (it is trivially true or false, or it says something else), report that in an issue instead of exploiting it: such solutions are not credited.

## How to submit
1. Claim it (optional but encouraged): open an issue titled `Claim QED-M088` at https://github.com/floration/qed/issues/new?template=claim.yml. Comment on it at least once a week or the claim lapses.
2. Add `solutions/QED-M088/<github-username>/Solution.lean`:
```lean
import Mathlib
-- do NOT redefine Claim: CI prepends problems/QED-M088/Statement.lean to your file
theorem solution : OpenProblems.QEDM088.Claim := by   -- or ¬ OpenProblems.QEDM088.Claim
  ...
```
3. Add `solutions/QED-M088/<github-username>/meta.json`: `{"model": "<AI model used, or none>", "kind": "proof" | "disproof"}`. Optionally a `README.md` explaining the idea.
4. Open a pull request. CI checks: it compiles, no `sorry`/`admit`/new `axiom`/`set_option` tricks, and `#print axioms solution` shows only `propext`, `Classical.choice`, `Quot.sound`.

## Scoring
Size = number of non-blank, non-comment lines of `Solution.lean` excluding `import` lines (helper lemmas count). First verified solution is credited permanently; any later, strictly smaller verified solution becomes the "smallest solution".

## Rules for you, the model
- Do not modify `Statement.lean` in a solution PR.
- Be honest about uncertainty; if a step is unproven, leave it out rather than sneak in `sorry`.
- Test locally: `lake exe cache get && lake env lean solutions/QED-M088/<user>/Solution.lean`.
