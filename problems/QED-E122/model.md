# QED-E122 — The domination game 3/5 bound for all isolate-free graphs

You are an AI model helping someone attack this open problem. Read all of this before working.

## The problem
Extended set · Grade B · QED Curated · Games

**Plain words:** In the domination game on a graph, Dominator and Staller take turns choosing vertices. Each chosen vertex must dominate (be, or be adjacent to) at least one vertex not yet dominated, and the game ends when every vertex is dominated. Dominator wants the game to be short and Staller wants it long. With Dominator moving first and optimal play, does the game always end within 3n/5 moves on an n-vertex graph with no isolated vertices?

**Math:** For a finite graph $G$ on $n$ vertices with no isolated vertex, let $\gamma_g(G)$ be the number of moves under optimal play: players alternately choose a vertex $v$ with $N[v]\not\subseteq N[S]$, where $S$ is the set of vertices chosen so far; Dominator moves first and minimizes the length, Staller maximizes it, and the game ends when $N[S]=V(G)$. Prove or disprove $\gamma_g(G)\le 3n/5$. Best known: $\gamma_g(G)\le 5n/8$.

**Credit:** Kinnersley, West and Zamani (2013); Brešar, Klavžar and Rall (domination game)

**Rests on recent unrefereed work. Check these premises first:**
- Is the full '3/5-conjecture' (named by a fraction, not a person)
- Forest case rests partly on an unrefereed long preprint; irrelevant to the general claim

**References:**
- https://arxiv.org/abs/2002.00105
- https://www.math.uri.edu/~billk/pubs/gamedom_mindeg2.pdf
- https://arxiv.org/abs/1603.01181
- https://arxiv.org/abs/1406.7372

Difficulty estimate: 5.5/10 (anchored scale: 1 ≈ Erdős–Ginzburg–Ziv, 2.5 ≈ the sensitivity conjecture, 5 ≈ bounded prime gaps, 7.5 ≈ the Riemann Hypothesis, 10 ≈ P vs NP). It is believed open; do not assume a quick answer exists, and say so plainly if you cannot make progress. Never present a heuristic, numerical evidence, or a partial result as a solution.

## What counts as an answer
Either a proof of `OpenProblems.QEDE122.Claim` or a proof of `¬ OpenProblems.QEDE122.Claim` (a disproof), in Lean 4 + Mathlib, using the exact statement in `problems/QED-E122/Statement.lean`. Read its "Formalization notes" first. If that file still says `def Claim : Prop := sorry`, the problem must first be formalized (see CONTRIBUTING.md); a faithful formalization is itself a welcome contribution.

If you think the Lean statement does not match the informal problem (it is trivially true or false, or it says something else), report that in an issue instead of exploiting it: such solutions are not credited.

## How to submit
0. First time? Solve a test problem (QED-Q1, the 2-line one, at minimum) and submit it, to confirm your Lean setup and the submission pipeline work before spending effort here. Skip this step if this IS a test problem.
1. Claim it (optional but encouraged): open an issue titled `Claim QED-E122` at https://github.com/floration/qed/issues/new?template=claim.yml. Comment on it at least once a week or the claim lapses.
2. Add `solutions/QED-E122/<github-username>/Solution.lean`:
```lean
import Mathlib
-- do NOT redefine Claim: CI prepends problems/QED-E122/Statement.lean to your file
theorem solution : OpenProblems.QEDE122.Claim := by   -- or ¬ OpenProblems.QEDE122.Claim
  ...
```
   Large proofs may add more `.lean` files (subfolders allowed) next to Solution.lean; CI concatenates them in path order before Solution.lean. Don't import them.
3. Add `solutions/QED-E122/<github-username>/meta.json`: `{"model": "<AI model used, or none>", "kind": "proof" | "disproof"}`. Optionally a `README.md` explaining the idea.
4. Open a pull request. CI checks: it compiles, no `sorry`/`admit`/new `axiom`/`set_option` tricks, and `#print axioms solution` shows only `propext`, `Classical.choice`, `Quot.sound`.

## Scoring
Size = number of non-blank, non-comment lines of `Solution.lean` excluding `import` lines (helper lemmas count). First verified solution is credited permanently; any later, strictly smaller verified solution becomes the "smallest solution".

## Rules for you, the model
- Do not modify `Statement.lean` in a solution PR.
- Be honest about uncertainty; if a step is unproven, leave it out rather than sneak in `sorry`.
- Test locally: `lake exe cache get && lake env lean solutions/QED-E122/<user>/Solution.lean`.
