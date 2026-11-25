# QED-M148 — Critical Ising interfaces on the hat tiling converge to SLE(3)

You are an AI model helping someone attack this open problem. Read all of this before working.

## The problem
Main set · Grade B · QED Original · Physics

**Plain words:** Put an Ising spin on every tile of a hat tiling, with neighbouring tiles (sharing an edge segment) interacting, at the critical temperature. Take a large simply connected region with plus spins forced on one boundary arc and minus spins on the other. Show that, as the tiles shrink, the interface between the plus and minus clusters converges to the random curve SLE(3), just as on the square lattice, although the hat graph is neither periodic nor isoradial.

**Math:** Let $G_T$ be the tile-adjacency graph of a hat tiling $T$ (Smith–Myers–Kaplan–Goodman-Strauss hat, reflections allowed; tiles adjacent iff they share a boundary segment of positive length), with the ferromagnetic nearest-neighbour Ising model, $J\equiv1$. Prove: (i) there is $\beta_c\in(0,\infty)$, independent of $T$, such that the plus-state magnetisation of every tile vanishes for $0<\beta\le\beta_c$ and is positive for $\beta>\beta_c$; (ii) for every hat tiling $T$, every Jordan domain $\Omega$ with distinct boundary points $a,b$, and all discretisations $(\Omega_\delta,a_\delta,b_\delta)$ by simply connected unions of tiles of $\delta T$ whose boundary curves converge to $\partial\Omega$ uniformly up to reparametrisation, with $a_\delta\to a$, $b_\delta\to b$: with Dobrushin boundary conditions ($+$ on the boundary arc from $a_\delta$ to $b_\delta$, $-$ on the other) at $\beta=\beta_c$, the interface from $a_\delta$ to $b_\delta$ (any interface path, whatever choice is made at vertices where several interface edges meet) converges in law, in the topology of curves up to reparametrisation, to chordal $\mathrm{SLE}_3$ in $(\Omega,a,b)$.

**Credit:** QED original (archived Nov 2026, restored after re-review).

**References:**
- https://arxiv.org/abs/2402.11331
- https://arxiv.org/abs/2006.14559
- https://arxiv.org/abs/1712.04192
- https://arxiv.org/abs/2309.08470
- https://arxiv.org/abs/2604.21165

Difficulty estimate: 7.3/10 (calibrated: Collatz ≈ 5.5, twin primes ≈ 5.0). It is believed open; do not assume a quick answer exists, and say so plainly if you cannot make progress. Never present a heuristic, numerical evidence, or a partial result as a solution.

## What counts as an answer
Either a proof of `OpenProblems.QEDM148.Claim` or a proof of `¬ OpenProblems.QEDM148.Claim` (a disproof), in Lean 4 + Mathlib, using the exact statement in `problems/QED-M148/Statement.lean`. Read its "Formalization notes" first. If that file still says `def Claim : Prop := sorry`, the problem must first be formalized (see CONTRIBUTING.md); a faithful formalization is itself a welcome contribution.

If you think the Lean statement does not match the informal problem (it is trivially true or false, or it says something else), report that in an issue instead of exploiting it: such solutions are not credited.

## How to submit
0. First time? Solve a test problem (QED-Q1, the 2-line one, at minimum) and submit it, to confirm your Lean setup and the submission pipeline work before spending effort here. Skip this step if this IS a test problem.
1. Claim it (optional but encouraged): open an issue titled `Claim QED-M148` at https://github.com/floration/qed/issues/new?template=claim.yml. Comment on it at least once a week or the claim lapses.
2. Add `solutions/QED-M148/<github-username>/Solution.lean`:
```lean
import Mathlib
-- do NOT redefine Claim: CI prepends problems/QED-M148/Statement.lean to your file
theorem solution : OpenProblems.QEDM148.Claim := by   -- or ¬ OpenProblems.QEDM148.Claim
  ...
```
   Large proofs may add more `.lean` files (subfolders allowed) next to Solution.lean; CI concatenates them in path order before Solution.lean. Don't import them.
3. Add `solutions/QED-M148/<github-username>/meta.json`: `{"model": "<AI model used, or none>", "kind": "proof" | "disproof"}`. Optionally a `README.md` explaining the idea.
4. Open a pull request. CI checks: it compiles, no `sorry`/`admit`/new `axiom`/`set_option` tricks, and `#print axioms solution` shows only `propext`, `Classical.choice`, `Quot.sound`.

## Scoring
Size = number of non-blank, non-comment lines of `Solution.lean` excluding `import` lines (helper lemmas count). First verified solution is credited permanently; any later, strictly smaller verified solution becomes the "smallest solution".

## Rules for you, the model
- Do not modify `Statement.lean` in a solution PR.
- Be honest about uncertainty; if a step is unproven, leave it out rather than sneak in `sorry`.
- Test locally: `lake exe cache get && lake env lean solutions/QED-M148/<user>/Solution.lean`.
