# QED-E166 — Does the cubic-residue graph on 127 vertices force a monochromatic triangle?

You are an AI model helping someone attack this open problem. Read all of this before working.

## The problem
Extended set · Grade B · QED Curated · Graph theory

**Plain words:** Folkman showed that there are graphs with no 4 mutually adjacent vertices in which every red/blue colouring of the edges creates a single-coloured triangle. The fewest vertices such a graph can have, F_e(3,3;4), is only known to lie between 21 and 786. A natural candidate is the graph on the integers mod 127 that joins x and y when x - y is a nonzero cube mod 127; it has no 4 mutually adjacent vertices. Decide whether every red/blue colouring of its edges has a single-coloured triangle. A yes would show F_e(3,3;4) <= 127.

**Math:** Let $G_{127}$ be the Cayley graph on $\mathbb Z_{127}$ with connection set $C=\{x^3: x\in\mathbb Z_{127}^{*}\}$ (a subgroup of order $42$ containing $-1$, so $G_{127}$ is a $42$-regular simple graph; it is $K_4$-free). Decide whether $G_{127}\to(3,3)^e$, i.e. whether every map $c:E(G_{127})\to\{0,1\}$ admits a triangle of $G_{127}$ whose three edges have the same colour. (Known: $21\le F_e(3,3;4)\le 786$; a positive answer gives $F_e(3,3;4)\le 127$.)

**Credit:** Folkman (1970) existence; problem of bounding F_e(3,3;4): Erdős, Graham prize; G127 candidate suggested by G. Exoo; bounds by Radziszowski-Xu, Lange-Radziszowski-Xu, Bikov-Nenov.

**Rests on recent unrefereed work. Check these premises first:**
- Identification of G127 (Hill-Irwing graph) with the cubic-residue Cayley graph on Z_127 should be double-checked against Radziszowski-Xu 2007 (the K4-freeness and 42-regularity checks are consistent with it)
- Largely a computational decision problem on one fixed graph; accepted because it is a recognised open problem in refereed literature
- A negative answer (a good colouring) settles G127 but says little about F_e(3,3;4) itself

**References:**
- https://arxiv.org/pdf/1904.01937
- https://www.cs.rit.edu/~spr/COURSES/CCOMP/tc25.pdf
- https://arxiv.org/pdf/2605.16542
- https://arxiv.org/pdf/1207.3750
- https://arxiv.org/pdf/1609.03468

Difficulty estimate: 5.0/10 (calibrated: Collatz ≈ 5.5, twin primes ≈ 5.0). It is believed open; do not assume a quick answer exists, and say so plainly if you cannot make progress. Never present a heuristic, numerical evidence, or a partial result as a solution.

## What counts as an answer
Either a proof of `OpenProblems.QEDE166.Claim` or a proof of `¬ OpenProblems.QEDE166.Claim` (a disproof), in Lean 4 + Mathlib, using the exact statement in `problems/QED-E166/Statement.lean`. Read its "Formalization notes" first. If that file still says `def Claim : Prop := sorry`, the problem must first be formalized (see CONTRIBUTING.md); a faithful formalization is itself a welcome contribution.

If you think the Lean statement does not match the informal problem (it is trivially true or false, or it says something else), report that in an issue instead of exploiting it: such solutions are not credited.

## How to submit
0. First time? Solve a test problem (QED-Q1, the 2-line one, at minimum) and submit it, to confirm your Lean setup and the submission pipeline work before spending effort here. Skip this step if this IS a test problem.
1. Claim it (optional but encouraged): open an issue titled `Claim QED-E166` at https://github.com/floration/qed/issues/new?template=claim.yml. Comment on it at least once a week or the claim lapses.
2. Add `solutions/QED-E166/<github-username>/Solution.lean`:
```lean
import Mathlib
-- do NOT redefine Claim: CI prepends problems/QED-E166/Statement.lean to your file
theorem solution : OpenProblems.QEDE166.Claim := by   -- or ¬ OpenProblems.QEDE166.Claim
  ...
```
   Large proofs may add more `.lean` files (subfolders allowed) next to Solution.lean; CI concatenates them in path order before Solution.lean. Don't import them.
3. Add `solutions/QED-E166/<github-username>/meta.json`: `{"model": "<AI model used, or none>", "kind": "proof" | "disproof"}`. Optionally a `README.md` explaining the idea.
4. Open a pull request. CI checks: it compiles, no `sorry`/`admit`/new `axiom`/`set_option` tricks, and `#print axioms solution` shows only `propext`, `Classical.choice`, `Quot.sound`.

## Scoring
Size = number of non-blank, non-comment lines of `Solution.lean` excluding `import` lines (helper lemmas count). First verified solution is credited permanently; any later, strictly smaller verified solution becomes the "smallest solution".

## Rules for you, the model
- Do not modify `Statement.lean` in a solution PR.
- Be honest about uncertainty; if a step is unproven, leave it out rather than sneak in `sorry`.
- Test locally: `lake exe cache get && lake env lean solutions/QED-E166/<user>/Solution.lean`.
