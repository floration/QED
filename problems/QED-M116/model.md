# QED-M116 — Spectral gap of the spin-2 valence-bond-solid (AKLT) model on the square lattice

You are an AI model helping someone attack this open problem. Read all of this before working.

## The problem
Main set · Grade A · QED Curated · Mathematical physics

**Plain words:** Put a quantum spin 2 (a 5-dimensional space) at every site of an L x L periodic square grid. For each edge, add the energy of projecting the two neighbouring spins onto their joint spin-4 state. The resulting Hamiltonian has ground energy 0, attained by the AKLT valence-bond state. Show that the first excited level stays a fixed distance above 0 however large L is. This gap was proved for the hexagonal lattice in 2020 and for many decorated square lattices, but not for the plain square lattice.

**Math:** Let $\mathcal H_L=\bigotimes_{x\in(\mathbb Z/L\mathbb Z)^2}\mathbb C^5$, let $\mathbf S_x$ be the spin-2 operators at $x$, and for a nearest-neighbour edge $xy$ of the torus let $P^{(4)}_{xy}$ be the orthogonal projection onto the eigenspace $\{(\mathbf S_x+\mathbf S_y)^2=20\}$ (total spin 4). Let $H_L=\sum_{xy}P^{(4)}_{xy}$, so $H_L\ge0$ and $\ker H_L\neq\{0\}$. Prove there is $\gamma>0$ with $\mathrm{spec}(H_L)\subset\{0\}\cup[\gamma,\infty)$ for all $L\ge3$.

**Credit:** Conjectured by Affleck, Kennedy, Lieb, Tasaki (1988); status per Pomata-Wei (2020) and Jackson-Nachtergaele-Young (2026).

**Rests on recent unrefereed work. Check these premises first:**
- Model named after people (AKLT), but the question is the spectral-gap property, not a named conjecture
- Partly approachable by a large certified finite-size computation; could fall to a computer-assisted proof
- Board already has AKLT on the hat (N-457) - related theme

**References:**
- https://arxiv.org/pdf/2010.03137
- https://arxiv.org/pdf/1905.01275
- https://arxiv.org/pdf/1901.09297
- https://pdf.arxiv.org/pdf/2212.11872
- https://arxiv.org/pdf/2605.12184
- https://ar5iv.labs.arxiv.org/html/1308.3631

Difficulty estimate: 6.5/10 (calibrated: Collatz ≈ 5.5, twin primes ≈ 5.0). It is believed open; do not assume a quick answer exists, and say so plainly if you cannot make progress. Never present a heuristic, numerical evidence, or a partial result as a solution.

## What counts as an answer
Either a proof of `OpenProblems.QEDM116.Claim` or a proof of `¬ OpenProblems.QEDM116.Claim` (a disproof), in Lean 4 + Mathlib, using the exact statement in `problems/QED-M116/Statement.lean`. Read its "Formalization notes" first. If that file still says `def Claim : Prop := sorry`, the problem must first be formalized (see CONTRIBUTING.md); a faithful formalization is itself a welcome contribution.

If you think the Lean statement does not match the informal problem (it is trivially true or false, or it says something else), report that in an issue instead of exploiting it: such solutions are not credited.

## How to submit
0. First time? Solve a test problem (QED-Q1, the 2-line one, at minimum) and submit it, to confirm your Lean setup and the submission pipeline work before spending effort here. Skip this step if this IS a test problem.
1. Claim it (optional but encouraged): open an issue titled `Claim QED-M116` at https://github.com/floration/qed/issues/new?template=claim.yml. Comment on it at least once a week or the claim lapses.
2. Add `solutions/QED-M116/<github-username>/Solution.lean`:
```lean
import Mathlib
-- do NOT redefine Claim: CI prepends problems/QED-M116/Statement.lean to your file
theorem solution : OpenProblems.QEDM116.Claim := by   -- or ¬ OpenProblems.QEDM116.Claim
  ...
```
   Large proofs may add more `.lean` files (subfolders allowed) next to Solution.lean; CI concatenates them in path order before Solution.lean. Don't import them.
3. Add `solutions/QED-M116/<github-username>/meta.json`: `{"model": "<AI model used, or none>", "kind": "proof" | "disproof"}`. Optionally a `README.md` explaining the idea.
4. Open a pull request. CI checks: it compiles, no `sorry`/`admit`/new `axiom`/`set_option` tricks, and `#print axioms solution` shows only `propext`, `Classical.choice`, `Quot.sound`.

## Scoring
Size = number of non-blank, non-comment lines of `Solution.lean` excluding `import` lines (helper lemmas count). First verified solution is credited permanently; any later, strictly smaller verified solution becomes the "smallest solution".

## Rules for you, the model
- Do not modify `Statement.lean` in a solution PR.
- Be honest about uncertainty; if a step is unproven, leave it out rather than sneak in `sorry`.
- Test locally: `lake exe cache get && lake env lean solutions/QED-M116/<user>/Solution.lean`.
