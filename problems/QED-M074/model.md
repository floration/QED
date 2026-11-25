# QED-M074 — Ten Martini for every periodic planar lattice

You are an AI model helping someone attack this open problem. Read all of this before working.

## The problem
Main set · Grade A · QED Extension · Mathematical physics

**Plain words:** A tight-binding electron on any doubly periodic planar network in a uniform magnetic field: is the energy spectrum always a Cantor set when the flux per cell is irrational? This is known for the square lattice (Ten Martini), the honeycomb lattice and the Lieb lattice, each by a reduction to a one-dimensional operator. Flat-band eigenvalues that persist in any field can sit isolated, so they must be set aside. The question is whether what remains is always a Cantor set, or at least never contains an interval.

**Math:** Let $G\subset\mathbb R^2$ be a connected planar graph with straight edges that is invariant under a lattice $L\cong\mathbb Z^2$ and has finitely many $L$-orbits of vertices. For a constant field $B$ with vector potential $A$, set $(H_B\psi)(x)=\sum_{y\sim x}e^{i\int_{[x,y]}A}\psi(y)$ on $\ell^2(V(G))$, and let $2\pi\alpha=B\cdot\mathrm{covol}(L)$. Let $\Sigma'$ be the derived set of $\sigma(H_B)$, i.e. $\sigma(H_B)$ minus its isolated points (eigenvalues of infinite multiplicity, i.e. flat bands). Prove or disprove: for every such $G$ and every irrational $\alpha$, $\Sigma'$ is a nonempty Cantor set. At minimum, decide whether $\sigma(H_B)$ is always nowhere dense. The first open instance is the kagome lattice in a uniform field. (The pure line-graph flux pattern, with no flux through the triangles, reduces to the honeycomb case.)

**Credit:** Extends Avila–Jitomirskaya (Ten Martini, Annals 2009) and Becker–Han–Jitomirskaya–Zworski (honeycomb, arXiv:1803.00988).

**QED results so far (reviewer-derived; check before relying on them):** The pendant-twin counterexample is correct. Attach two pendant vertices x,x' to each vertex of Z^2. Then delta_x - (phase) delta_x' is an eigenvector with eigenvalue 0 for every B. For E nonzero, E is in sigma iff E-2/E is in sigma(H_sq), which lies in [-4,4]. So a punctured neighbourhood of 0 is a gap, 0 is isolated, and the naive statement fails.

**Rests on recent unrefereed work. Check these premises first:**
- arXiv:2609.15812 (2026 preprint): 1D Robust Ten Martini; cited as a possible tool only, M does not depend on it.
- arXiv:2611.10767 (2026 preprint): cited; M does not depend on it.

**References:**
- https://arxiv.org/abs/1408.2814
- https://arxiv.org/pdf/1404.0642
- https://arxiv.org/pdf/1803.00988
- https://www.imo.universite-paris-saclay.fr/~bernard.helffer/helfferharpercambridge2015.pdf
- https://arxiv.org/abs/2401.11405
- https://arxiv.org/abs/math-ph/0511057
- https://arxiv.org/abs/2609.15812
- https://arxiv.org/html/1803.00988
- https://arxiv.org/abs/2401.11405
- https://arxiv.org/abs/1408.2814
- https://www.imo.universite-paris-saclay.fr/~bernard.helffer/helfferharperbucarest.pdf
- https://arxiv.org/abs/2609.15812

Difficulty estimate: 3.5/10 (calibrated: Collatz ≈ 5.5, twin primes ≈ 5.0). It is believed open; do not assume a quick answer exists, and say so plainly if you cannot make progress. Never present a heuristic, numerical evidence, or a partial result as a solution.

## What counts as an answer
Either a proof of `OpenProblems.QEDM074.Claim` or a proof of `¬ OpenProblems.QEDM074.Claim` (a disproof), in Lean 4 + Mathlib, using the exact statement in `problems/QED-M074/Statement.lean`. Read its "Formalization notes" first. If that file still says `def Claim : Prop := sorry`, the problem must first be formalized (see CONTRIBUTING.md); a faithful formalization is itself a welcome contribution.

If you think the Lean statement does not match the informal problem (it is trivially true or false, or it says something else), report that in an issue instead of exploiting it: such solutions are not credited.

## How to submit
1. Claim it (optional but encouraged): open an issue titled `Claim QED-M074` at https://github.com/floration/qed/issues/new?template=claim.yml. Comment on it at least once a week or the claim lapses.
2. Add `solutions/QED-M074/<github-username>/Solution.lean`:
```lean
import Mathlib
-- do NOT redefine Claim: CI prepends problems/QED-M074/Statement.lean to your file
theorem solution : OpenProblems.QEDM074.Claim := by   -- or ¬ OpenProblems.QEDM074.Claim
  ...
```
3. Add `solutions/QED-M074/<github-username>/meta.json`: `{"model": "<AI model used, or none>", "kind": "proof" | "disproof"}`. Optionally a `README.md` explaining the idea.
4. Open a pull request. CI checks: it compiles, no `sorry`/`admit`/new `axiom`/`set_option` tricks, and `#print axioms solution` shows only `propext`, `Classical.choice`, `Quot.sound`.

## Scoring
Size = number of non-blank, non-comment lines of `Solution.lean` excluding `import` lines (helper lemmas count). First verified solution is credited permanently; any later, strictly smaller verified solution becomes the "smallest solution".

## Rules for you, the model
- Do not modify `Statement.lean` in a solution PR.
- Be honest about uncertainty; if a step is unproven, leave it out rather than sneak in `sorry`.
- Test locally: `lake exe cache get && lake env lean solutions/QED-M074/<user>/Solution.lean`.
