# QED-E044 — A macroscopic upper bound for tetrahedron packing

You are an AI model helping someone attack this open problem. Read all of this before working.

## The problem
Extended set · Grade B- · QED Curated · Geometry

**Plain words:** Regular tetrahedra cannot fill space, and the best packings found fill about 85.6% of it. Yet the best proved limit only says a packing fills at most 1 − 0.00000000000000000000000026 of space. Prove a macroscopic upper bound, for instance that no packing of congruent regular tetrahedra fills more than 99% of space.

**Math:** Let $\delta_T$ be the maximal packing density of congruent regular tetrahedra in $\mathbb R^3$. Known $0.856347\le\delta_T\le1-2.6\times10^{-25}$. Formal target: the macroscopic bound $\delta_T\le0.99$.

**Reviewer note:** Known: Lower $4000/4671$: Chen, Engel, Glotzer, DCG 43 (2010), arXiv:1001.0586 (dimer packings; cf. Kallus–Elser–Gravel, Torquato–Jiao). Upper $1-2.6\times10^{-25}$: Gravel, Elser, Kallus, 'Upper bound on the packing density of regular tetrahedra and octahedra', DCG 46 (2011), arXiv:1008.2830. SDP framework for congruent copies: Dostert, Guzmán, de Oliveira Filho, Vallentin, arXiv:1308.4893 (computed for pentagons, not tetrahedra). Translative case: arXiv:1208.0420.

**Credit:** Gravel–Elser–Kallus (2011); Chen–Engel–Glotzer (2010); Hilbert's 18th problem

**Rests on recent unrefereed work. Check these premises first:**
- the 0.99 benchmark is illustrative; the real question is any macroscopic bound
- an unpublished SDP computation for tetrahedra could exist

**References:**
- https://arxiv.org/abs/1008.2830
- https://arxiv.org/abs/1001.0586
- https://arxiv.org/abs/1308.4893
- https://en.wikipedia.org/wiki/Tetrahedron_packing

Difficulty estimate: 4.5/10 (calibrated: Collatz ≈ 5.5, twin primes ≈ 5.0). It is believed open; do not assume a quick answer exists, and say so plainly if you cannot make progress. Never present a heuristic, numerical evidence, or a partial result as a solution.

## What counts as an answer
Either a proof of `OpenProblems.QEDE044.Claim` or a proof of `¬ OpenProblems.QEDE044.Claim` (a disproof), in Lean 4 + Mathlib, using the exact statement in `problems/QED-E044/Statement.lean`. Read its "Formalization notes" first. If that file still says `def Claim : Prop := sorry`, the problem must first be formalized (see CONTRIBUTING.md); a faithful formalization is itself a welcome contribution.

If you think the Lean statement does not match the informal problem (it is trivially true or false, or it says something else), report that in an issue instead of exploiting it: such solutions are not credited.

## How to submit
1. Claim it (optional but encouraged): open an issue titled `Claim QED-E044` at https://github.com/floration/qed/issues/new?template=claim.yml. Comment on it at least once a week or the claim lapses.
2. Add `solutions/QED-E044/<github-username>/Solution.lean`:
```lean
import Mathlib
-- do NOT redefine Claim: CI prepends problems/QED-E044/Statement.lean to your file
theorem solution : OpenProblems.QEDE044.Claim := by   -- or ¬ OpenProblems.QEDE044.Claim
  ...
```
   Large proofs may add more `.lean` files (subfolders allowed) next to Solution.lean; CI concatenates them in path order before Solution.lean. Don't import them.
3. Add `solutions/QED-E044/<github-username>/meta.json`: `{"model": "<AI model used, or none>", "kind": "proof" | "disproof"}`. Optionally a `README.md` explaining the idea.
4. Open a pull request. CI checks: it compiles, no `sorry`/`admit`/new `axiom`/`set_option` tricks, and `#print axioms solution` shows only `propext`, `Classical.choice`, `Quot.sound`.

## Scoring
Size = number of non-blank, non-comment lines of `Solution.lean` excluding `import` lines (helper lemmas count). First verified solution is credited permanently; any later, strictly smaller verified solution becomes the "smallest solution".

## Rules for you, the model
- Do not modify `Statement.lean` in a solution PR.
- Be honest about uncertainty; if a step is unproven, leave it out rather than sneak in `sorry`.
- Test locally: `lake exe cache get && lake env lean solutions/QED-E044/<user>/Solution.lean`.
