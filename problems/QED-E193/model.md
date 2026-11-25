# QED-E193 — Do hexagonal and cubic ice have the same residual entropy?

You are an AI model helping someone attack this open problem. Read all of this before working.

## The problem
Extended set · Grade A · QED Curated · Mathematical physics

**Plain words:** In ice, each oxygen sits at a vertex of a 4-regular crystal lattice and the hydrogens obey the ice rule: two bonds point in and two point out at every vertex. Counting such configurations is counting Eulerian orientations of the lattice. Hexagonal ice (Ih, the lonsdaleite net) and cubic ice (Ic, the diamond net) are two different stackings of the same puckered layers and look identical locally. Onsager proved that hexagonal ice has at least as many configurations per molecule as cubic ice. Are the two per-vertex growth constants exactly equal?

**Math:** Let $D$ be the diamond net and $H$ the lonsdaleite net (4-regular, period lattices $\Lambda_D,\Lambda_H\cong\mathbb Z^3$). For $m\ge1$ let $D_m=D/m\Lambda_D$ and $H_m=H/m\Lambda_H$ (finite 4-regular toroidal quotients, treated as multigraphs; parallel edges occur only for $m=1$). For a 4-regular multigraph $G$ let $\mathrm{EO}(G)$ be the number of orientations of $G$ with in-degree $2$ at every vertex. Prove or disprove: the limits $W_c=\lim_m|\mathrm{EO}(D_m)|^{1/|V(D_m)|}$ and $W_h=\lim_m|\mathrm{EO}(H_m)|^{1/|V(H_m)|}$ both exist and are equal. (Existence of both limits is standard, and $W_h\ge W_c$ by Onsager/Nagle, so the disproof direction amounts to $W_h>W_c$.)

**Credit:** Question going back to Onsager/Nagle (1960s); restated as open in arXiv:2404.13897, 2511.22477 and 2608.07613

**Rests on recent unrefereed work. Check these premises first:**
- The claimed direction (equality) could be false: a rigorous strict inequality W_h > W_c would refute the Claim and still resolve the question; the problem is posed as prove-or-disprove.
- Chen-Ran 2608.07613 (unrefereed, 2026) supplies only side bounds and is not needed for the premise. The premise W_h >= W_c rests on Onsager/Nagle 1966 plus the 2024 PRB.
- Defining the periodic lonsdaleite quotients in Lean needs care (two bilayers per period, consistent registry). The limit's independence of the torus shape is standard but must either be assumed in the statement or proved.

**References:**
- https://arxiv.org/abs/2511.22477
- https://arxiv.org/abs/2404.13897
- https://arxiv.org/pdf/math/9810155
- https://arxiv.org/pdf/2409.04989

Difficulty estimate: 5.5/10 (anchored scale: 1 ≈ Erdős–Ginzburg–Ziv, 2.5 ≈ the sensitivity conjecture, 5 ≈ bounded prime gaps, 7.5 ≈ the Riemann Hypothesis, 10 ≈ P vs NP). It is believed open; do not assume a quick answer exists, and say so plainly if you cannot make progress. Never present a heuristic, numerical evidence, or a partial result as a solution.

## What counts as an answer
Either a proof of `OpenProblems.QEDE193.Claim` or a proof of `¬ OpenProblems.QEDE193.Claim` (a disproof), in Lean 4 + Mathlib, using the exact statement in `problems/QED-E193/Statement.lean`. Read its "Formalization notes" first. If that file still says `def Claim : Prop := sorry`, the problem must first be formalized (see CONTRIBUTING.md); a faithful formalization is itself a welcome contribution.

If you think the Lean statement does not match the informal problem (it is trivially true or false, or it says something else), report that in an issue instead of exploiting it: such solutions are not credited.

## How to submit
0. First time? Solve a test problem (QED-Q1, the 2-line one, at minimum) and submit it, to confirm your Lean setup and the submission pipeline work before spending effort here. Skip this step if this IS a test problem.
1. Claim it (optional but encouraged): open an issue titled `Claim QED-E193` at https://github.com/floration/qed/issues/new?template=claim.yml. Comment on it at least once a week or the claim lapses.
2. Add `solutions/QED-E193/<github-username>/Solution.lean`:
```lean
import Mathlib
-- do NOT redefine Claim: CI prepends problems/QED-E193/Statement.lean to your file
theorem solution : OpenProblems.QEDE193.Claim := by   -- or ¬ OpenProblems.QEDE193.Claim
  ...
```
   Large proofs may add more `.lean` files (subfolders allowed) next to Solution.lean; CI concatenates them in path order before Solution.lean. Don't import them.
3. Add `solutions/QED-E193/<github-username>/meta.json`: `{"model": "<AI model used, or none>", "kind": "proof" | "disproof"}`. Optionally a `README.md` explaining the idea.
4. Open a pull request. CI checks: it compiles, no `sorry`/`admit`/new `axiom`/`set_option` tricks, and `#print axioms solution` shows only `propext`, `Classical.choice`, `Quot.sound`.

## Scoring
Size = number of non-blank, non-comment lines of `Solution.lean` excluding `import` lines (helper lemmas count). First verified solution is credited permanently; any later, strictly smaller verified solution becomes the "smallest solution".

## Rules for you, the model
- Do not modify `Statement.lean` in a solution PR.
- Be honest about uncertainty; if a step is unproven, leave it out rather than sneak in `sorry`.
- Test locally: `lake exe cache get && lake env lean solutions/QED-E193/<user>/Solution.lean`.
