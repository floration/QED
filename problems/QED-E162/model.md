# QED-E162 — Is the Ramsey number R(5,5) equal to 43?

You are an AI model helping someone attack this open problem. Read all of this before working.

## The problem
Extended set · Grade A · QED Curated · Graph theory

**Plain words:** R(5,5) is the least n such that every graph on n vertices contains either 5 mutually adjacent vertices or 5 mutually non-adjacent vertices. Exoo's 1989 graph on 42 vertices has neither, so R(5,5) >= 43; computer-assisted work of Angeltveit and McKay (2024) gives R(5,5) <= 46. Determine R(5,5); the expected answer is 43, i.e. every graph on 43 vertices has a clique or an independent set of size 5.

**Math:** Determine $R(5,5)$, where $R(5,5)=\min\{n:\ \forall G \text{ on } n \text{ vertices},\ \omega(G)\ge5 \text{ or } \alpha(G)\ge5\}$. Known: $43\le R(5,5)\le 46$. Board claim: $R(5,5)=43$, i.e. every simple graph $G$ on $43$ vertices has $\omega(G)\ge5$ or $\alpha(G)\ge5$. (Determining the value exactly, whichever of 43--46 it is, also resolves the problem; an upper bound $\le 45$ is partial progress.)

**Credit:** Conjecture R(5,5)=43: B. McKay and S. Radziszowski (1997); bounds: Exoo (1989), Angeltveit-McKay (2018, 2024).

**Rests on recent unrefereed work. Check these premises first:**
- Board already has R(3,10) and R(3,3,3,3); owner may consider a third exact Ramsey value too similar in style, though R(5,5) is the canonical diagonal case
- Primarily computational; a proof would likely be computer-assisted and hard to formalise as a Lean proof (statement itself is trivial to formalise)

**References:**
- https://arxiv.org/abs/2409.15709
- https://arxiv.org/abs/1703.08768
- https://www.cs.rit.edu/~spr/COURSES/CCOMP/boca25b.pdf
- https://arxiv.org/pdf/2508.16699

Difficulty estimate: 6.5/10 (calibrated: Collatz ≈ 5.5, twin primes ≈ 5.0). It is believed open; do not assume a quick answer exists, and say so plainly if you cannot make progress. Never present a heuristic, numerical evidence, or a partial result as a solution.

## What counts as an answer
Either a proof of `OpenProblems.QEDE162.Claim` or a proof of `¬ OpenProblems.QEDE162.Claim` (a disproof), in Lean 4 + Mathlib, using the exact statement in `problems/QED-E162/Statement.lean`. Read its "Formalization notes" first. If that file still says `def Claim : Prop := sorry`, the problem must first be formalized (see CONTRIBUTING.md); a faithful formalization is itself a welcome contribution.

If you think the Lean statement does not match the informal problem (it is trivially true or false, or it says something else), report that in an issue instead of exploiting it: such solutions are not credited.

## How to submit
0. First time? Solve a test problem (QED-Q1, the 2-line one, at minimum) and submit it, to confirm your Lean setup and the submission pipeline work before spending effort here. Skip this step if this IS a test problem.
1. Claim it (optional but encouraged): open an issue titled `Claim QED-E162` at https://github.com/floration/qed/issues/new?template=claim.yml. Comment on it at least once a week or the claim lapses.
2. Add `solutions/QED-E162/<github-username>/Solution.lean`:
```lean
import Mathlib
-- do NOT redefine Claim: CI prepends problems/QED-E162/Statement.lean to your file
theorem solution : OpenProblems.QEDE162.Claim := by   -- or ¬ OpenProblems.QEDE162.Claim
  ...
```
   Large proofs may add more `.lean` files (subfolders allowed) next to Solution.lean; CI concatenates them in path order before Solution.lean. Don't import them.
3. Add `solutions/QED-E162/<github-username>/meta.json`: `{"model": "<AI model used, or none>", "kind": "proof" | "disproof"}`. Optionally a `README.md` explaining the idea.
4. Open a pull request. CI checks: it compiles, no `sorry`/`admit`/new `axiom`/`set_option` tricks, and `#print axioms solution` shows only `propext`, `Classical.choice`, `Quot.sound`.

## Scoring
Size = number of non-blank, non-comment lines of `Solution.lean` excluding `import` lines (helper lemmas count). First verified solution is credited permanently; any later, strictly smaller verified solution becomes the "smallest solution".

## Rules for you, the model
- Do not modify `Statement.lean` in a solution PR.
- Be honest about uncertainty; if a step is unproven, leave it out rather than sneak in `sorry`.
- Test locally: `lake exe cache get && lake env lean solutions/QED-E162/<user>/Solution.lean`.
