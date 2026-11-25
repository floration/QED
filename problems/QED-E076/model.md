# QED-E076 — Blank jigsaw with few edge shapes

You are an AI model helping someone attack this open problem. Read all of this before working.

## The problem
Extended set · Grade B · QED Extension · Combinatorics

**Plain words:** A jigsaw with no picture can only be solved from the shapes of its pieces. Each internal edge is one of k shapes (a tab that fits only its own matching blank), and pieces may be turned. How small can k be if some n×n blank jigsaw still goes together in exactly one way? Counting shows k must be at least about √n, and random puzzles need about n.

**Math:** An $n\times n$ jigsaw with $k$ edge types is a map assigning to each internal edge of the $n\times n$ grid a type in $[k]$ and an orientation (which side carries the tab); border edges are flat. Its pieces are the $n^2$ unit squares, each regarded as a distinct physical object carrying its four (type, tab/blank) labels up to rotation. An assembly is a placement of all pieces bijectively on the cells, each rotated by a multiple of $90^\circ$, so that every internal edge joins a tab and a blank of the same type and all flat edges lie on the border. Let $k(n)$ be the least $k$ for which some $n\times n$ jigsaw with $k$ edge types has exactly one assembly up to the four rotations of the whole square. Determine the order of $k(n)$; in particular, is $k(n)=\Theta(\sqrt n)$?

**Credit:** Mossel & Ross (shotgun assembly); Bordenave, Feige, Mossel 2016, arXiv:1605.03086; Nenadov, Pfister, Steger 2017, arXiv:1701.04813

**References:**
- https://arxiv.org/pdf/1605.03086
- https://arxiv.org/abs/1605.03043
- https://arxiv.org/pdf/1701.04813
- https://arxiv.org/pdf/1707.04730

Difficulty estimate: 2.0/10 (calibrated: Collatz ≈ 5.5, twin primes ≈ 5.0). It is believed open; do not assume a quick answer exists, and say so plainly if you cannot make progress. Never present a heuristic, numerical evidence, or a partial result as a solution.

## What counts as an answer
Either a proof of `OpenProblems.QEDE076.Claim` or a proof of `¬ OpenProblems.QEDE076.Claim` (a disproof), in Lean 4 + Mathlib, using the exact statement in `problems/QED-E076/Statement.lean`. Read its "Formalization notes" first. If that file still says `def Claim : Prop := sorry`, the problem must first be formalized (see CONTRIBUTING.md); a faithful formalization is itself a welcome contribution.

If you think the Lean statement does not match the informal problem (it is trivially true or false, or it says something else), report that in an issue instead of exploiting it: such solutions are not credited.

## How to submit
0. First time? Solve a test problem (QED-Q1, the 2-line one, at minimum) and submit it, to confirm your Lean setup and the submission pipeline work before spending effort here. Skip this step if this IS a test problem.
1. Claim it (optional but encouraged): open an issue titled `Claim QED-E076` at https://github.com/floration/qed/issues/new?template=claim.yml. Comment on it at least once a week or the claim lapses.
2. Add `solutions/QED-E076/<github-username>/Solution.lean`:
```lean
import Mathlib
-- do NOT redefine Claim: CI prepends problems/QED-E076/Statement.lean to your file
theorem solution : OpenProblems.QEDE076.Claim := by   -- or ¬ OpenProblems.QEDE076.Claim
  ...
```
   Large proofs may add more `.lean` files (subfolders allowed) next to Solution.lean; CI concatenates them in path order before Solution.lean. Don't import them.
3. Add `solutions/QED-E076/<github-username>/meta.json`: `{"model": "<AI model used, or none>", "kind": "proof" | "disproof"}`. Optionally a `README.md` explaining the idea.
4. Open a pull request. CI checks: it compiles, no `sorry`/`admit`/new `axiom`/`set_option` tricks, and `#print axioms solution` shows only `propext`, `Classical.choice`, `Quot.sound`.

## Scoring
Size = number of non-blank, non-comment lines of `Solution.lean` excluding `import` lines (helper lemmas count). First verified solution is credited permanently; any later, strictly smaller verified solution becomes the "smallest solution".

## Rules for you, the model
- Do not modify `Statement.lean` in a solution PR.
- Be honest about uncertainty; if a step is unproven, leave it out rather than sneak in `sorry`.
- Test locally: `lake exe cache get && lake env lean solutions/QED-E076/<user>/Solution.lean`.
