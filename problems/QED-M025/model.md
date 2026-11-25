# QED-M025 — Periodic optimal colourings of Cayley graphs of Z^2

You are an AI model helping someone attack this open problem. Read all of this before working.

## The problem
Main set · Grade A · QED Curated · Combinatorics

**Plain words:** Join two points of the integer grid when their difference lies in a fixed finite set D. If this graph can be properly coloured with k colours, can it always be coloured with k colours in a repeating, wallpaper-like pattern? On a line the answer is yes. For some infinite graphs built from trees it is no. The plane is the first open case, and a yes would also give an algorithm for the chromatic number.

**Math:** For finite symmetric $D\subset\mathbb Z^2\setminus\{0\}$ let $G_D=\mathrm{Cay}(\mathbb Z^2,D)$ with $\chi(G_D)=k<\infty$. Must $G_D$ have a proper $k$-colouring invariant under a finite-index subgroup of $\mathbb Z^2$? Equivalently, does the $k$-colouring subshift $X_{D,k}\subset\{1..k\}^{\mathbb Z^2}$ always contain a periodic point? (A yes makes $\{(D,k):\chi(G_D)\le k\}$ decidable via compactness plus enumeration of periodic colourings. A no gives the first weakly aperiodic colouring subshift on $\mathbb Z^2$.) Same question for $\mathbb Z^d$, $d\ge3$.

**Credit:** Posed for lattice Cayley graphs in 'The chromatic number of 4-dimensional lattices', arXiv:2407.03513 (2024); related: periodic colourings of quasi-transitive graphs, arXiv:2411.01951 (2024).

**QED results so far (reviewer-derived; check before relying on them):** No proof is claimed. The decidability corollary is correct: compactness (de Bruijn-Erdos) semi-decides chi>k, and enumerating periodic colourings (torus quotients) semi-decides chi<=k if the answer is yes. A Z^2 SFT with one period also has a fully periodic point, so 'periodic point' is unambiguous here.

**Rests on recent unrefereed work. Check these premises first:**
- arXiv:2607.26942 (2026 preprint) is in refs; the statement does not depend on it.

**References:**
- https://arxiv.org/pdf/2411.01951
- https://arxiv.org/pdf/2511.03028
- https://arxiv.org/pdf/2312.08911
- https://arxiv.org/abs/2411.01951
- https://arxiv.org/html/2407.03513v3
- https://arxiv.org/abs/2511.03028
- https://arxiv.org/pdf/2607.26942

Difficulty estimate: 5.0/10 (calibrated: Collatz ≈ 5.5, twin primes ≈ 5.0). It is believed open; do not assume a quick answer exists, and say so plainly if you cannot make progress. Never present a heuristic, numerical evidence, or a partial result as a solution.

## What counts as an answer
Either a proof of `OpenProblems.QEDM025.Claim` or a proof of `¬ OpenProblems.QEDM025.Claim` (a disproof), in Lean 4 + Mathlib, using the exact statement in `problems/QED-M025/Statement.lean`. Read its "Formalization notes" first. If that file still says `def Claim : Prop := sorry`, the problem must first be formalized (see CONTRIBUTING.md); a faithful formalization is itself a welcome contribution.

If you think the Lean statement does not match the informal problem (it is trivially true or false, or it says something else), report that in an issue instead of exploiting it: such solutions are not credited.

## How to submit
0. First time? Solve a test problem (QED-Q1, the 2-line one, at minimum) and submit it, to confirm your Lean setup and the submission pipeline work before spending effort here. Skip this step if this IS a test problem.
1. Claim it (optional but encouraged): open an issue titled `Claim QED-M025` at https://github.com/floration/qed/issues/new?template=claim.yml. Comment on it at least once a week or the claim lapses.
2. Add `solutions/QED-M025/<github-username>/Solution.lean`:
```lean
import Mathlib
-- do NOT redefine Claim: CI prepends problems/QED-M025/Statement.lean to your file
theorem solution : OpenProblems.QEDM025.Claim := by   -- or ¬ OpenProblems.QEDM025.Claim
  ...
```
   Large proofs may add more `.lean` files (subfolders allowed) next to Solution.lean; CI concatenates them in path order before Solution.lean. Don't import them.
3. Add `solutions/QED-M025/<github-username>/meta.json`: `{"model": "<AI model used, or none>", "kind": "proof" | "disproof"}`. Optionally a `README.md` explaining the idea.
4. Open a pull request. CI checks: it compiles, no `sorry`/`admit`/new `axiom`/`set_option` tricks, and `#print axioms solution` shows only `propext`, `Classical.choice`, `Quot.sound`.

## Scoring
Size = number of non-blank, non-comment lines of `Solution.lean` excluding `import` lines (helper lemmas count). First verified solution is credited permanently; any later, strictly smaller verified solution becomes the "smallest solution".

## Rules for you, the model
- Do not modify `Statement.lean` in a solution PR.
- Be honest about uncertainty; if a step is unproven, leave it out rather than sneak in `sorry`.
- Test locally: `lake exe cache get && lake env lean solutions/QED-M025/<user>/Solution.lean`.
