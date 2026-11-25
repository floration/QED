# QED-E008 — Two vortices on a cube

You are an AI model helping someone attack this open problem. Read all of this before working.

## The problem
Extended set · Grade C · Dynamics

**Plain words:** Two identical point vortices moving on the surface of a cube form a two-degree-of-freedom Hamiltonian system with no continuous symmetry, so there is no second conserved quantity to make it integrable. Prove their motion is genuinely chaotic.

**Math:** Let $S$ be the boundary of the unit cube with its flat cone metric (eight cone points $v_i$ of angle $3\pi/2$), area $A=6$. Let $G$ solve $-\Delta_zG(z,w)=\delta_w-1/A$ with $\int_SG(\cdot,w)\,dA=0$, and let $R(z)=\lim_{w\to z}\big[G(z,w)+\tfrac1{2\pi}\log d(z,w)\big]$ for $z\notin\{v_i\}$. On $M=\{(z_1,z_2):z_1\ne z_2,\ z_j\notin\{v_i\}\}$ with $\omega=dA(z_1)+dA(z_2)$, let $H=G(z_1,z_2)+\tfrac12(R(z_1)+R(z_2))$. Prove that the Hamiltonian flow has a compact invariant set, inside one energy level, on which its topological entropy is positive.

**Reviewer note:** T

**References:**
- https://arxiv.org/abs/2201.00528
- https://digitalcommons.njit.edu/fac_pubs/12905
- https://arxiv.org/abs/2003.00716
- https://arxiv.org/abs/2512.05574

Difficulty estimate: 4.0/10 (calibrated: Collatz ≈ 5.5, twin primes ≈ 5.0). It is believed open; do not assume a quick answer exists, and say so plainly if you cannot make progress. Never present a heuristic, numerical evidence, or a partial result as a solution.

## What counts as an answer
Either a proof of `OpenProblems.QEDE008.Claim` or a proof of `¬ OpenProblems.QEDE008.Claim` (a disproof), in Lean 4 + Mathlib, using the exact statement in `problems/QED-E008/Statement.lean`. Read its "Formalization notes" first. If that file still says `def Claim : Prop := sorry`, the problem must first be formalized (see CONTRIBUTING.md); a faithful formalization is itself a welcome contribution.

If you think the Lean statement does not match the informal problem (it is trivially true or false, or it says something else), report that in an issue instead of exploiting it: such solutions are not credited.

## How to submit
1. Claim it (optional but encouraged): open an issue titled `Claim QED-E008` at https://github.com/floration/qed/issues/new?template=claim.yml. Comment on it at least once a week or the claim lapses.
2. Add `solutions/QED-E008/<github-username>/Solution.lean`:
```lean
import Mathlib
-- do NOT redefine Claim: CI prepends problems/QED-E008/Statement.lean to your file
theorem solution : OpenProblems.QEDE008.Claim := by   -- or ¬ OpenProblems.QEDE008.Claim
  ...
```
   Large proofs may add more `.lean` files (subfolders allowed) next to Solution.lean; CI concatenates them in path order before Solution.lean. Don't import them.
3. Add `solutions/QED-E008/<github-username>/meta.json`: `{"model": "<AI model used, or none>", "kind": "proof" | "disproof"}`. Optionally a `README.md` explaining the idea.
4. Open a pull request. CI checks: it compiles, no `sorry`/`admit`/new `axiom`/`set_option` tricks, and `#print axioms solution` shows only `propext`, `Classical.choice`, `Quot.sound`.

## Scoring
Size = number of non-blank, non-comment lines of `Solution.lean` excluding `import` lines (helper lemmas count). First verified solution is credited permanently; any later, strictly smaller verified solution becomes the "smallest solution".

## Rules for you, the model
- Do not modify `Statement.lean` in a solution PR.
- Be honest about uncertainty; if a step is unproven, leave it out rather than sneak in `sorry`.
- Test locally: `lake exe cache get && lake env lean solutions/QED-E008/<user>/Solution.lean`.
