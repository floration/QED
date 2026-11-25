# QED-E179 — Randomized query complexity of monotone graph properties beyond n^{4/3}

You are an AI model helping someone attack this open problem. Read all of this before working.

## The problem
Extended set · Grade A · QED Curated · Complexity

**Plain words:** A graph property on n vertices is monotone if adding edges never destroys it (like connectivity or containing a triangle). A randomized algorithm may ask whether individual edges are present and must answer correctly with probability at least 2/3. Every nontrivial monotone property is believed to need about n^2 queries, but since Hajnal (1991) and Chakrabarti-Khot (2001) the best general lower bound has been stuck at roughly n^{4/3}. Can the exponent 4/3 be improved?

**Math:** For n-vertex graph properties f that are invariant under vertex relabelling, monotone increasing and nontrivial (the empty graph lacks f, the complete graph has f), let R(f) be the bounded-error randomized decision-tree complexity: the least d such that a probability distribution over deterministic decision trees of depth at most d, each query asking whether a pair {i,j} is an edge, outputs f(G) with probability at least 2/3 for every graph G. Prove there exist $\varepsilon>0$ and $c>0$ such that $R(f)\ge c\,n^{4/3+\varepsilon}$ for every $n$ and every such $f$.

**Credit:** Randomized evasiveness (Karp; Yao 1987); 4/3 barrier Hajnal 1991, Chakrabarti–Khot 2001.

**Rests on recent unrefereed work. Check these premises first:**
- Partial sub-question of the person-named randomized Aanderaa–Karp–Rosenberg conjecture; allowed as an unnamed weakening
- OpenAI 2026-09-25 preprint 'A Sharp Threshold Bound for Monotone Graph Properties' may be related; only title known
- Formalizing randomized trees needs PMF over a finite type of trees; moderate effort

**References:**
- https://onlinelibrary.wiley.com/doi/abs/10.1002/rsa.20164
- https://arxiv.org/abs/cs/0508071
- https://arxiv.org/abs/2010.12629
- https://en.wikipedia.org/wiki/Evasiveness

Difficulty estimate: 7.0/10 (calibrated: Collatz ≈ 5.5, twin primes ≈ 5.0). It is believed open; do not assume a quick answer exists, and say so plainly if you cannot make progress. Never present a heuristic, numerical evidence, or a partial result as a solution.

## What counts as an answer
Either a proof of `OpenProblems.QEDE179.Claim` or a proof of `¬ OpenProblems.QEDE179.Claim` (a disproof), in Lean 4 + Mathlib, using the exact statement in `problems/QED-E179/Statement.lean`. Read its "Formalization notes" first. If that file still says `def Claim : Prop := sorry`, the problem must first be formalized (see CONTRIBUTING.md); a faithful formalization is itself a welcome contribution.

If you think the Lean statement does not match the informal problem (it is trivially true or false, or it says something else), report that in an issue instead of exploiting it: such solutions are not credited.

## How to submit
0. First time? Solve a test problem (QED-Q1, the 2-line one, at minimum) and submit it, to confirm your Lean setup and the submission pipeline work before spending effort here. Skip this step if this IS a test problem.
1. Claim it (optional but encouraged): open an issue titled `Claim QED-E179` at https://github.com/floration/qed/issues/new?template=claim.yml. Comment on it at least once a week or the claim lapses.
2. Add `solutions/QED-E179/<github-username>/Solution.lean`:
```lean
import Mathlib
-- do NOT redefine Claim: CI prepends problems/QED-E179/Statement.lean to your file
theorem solution : OpenProblems.QEDE179.Claim := by   -- or ¬ OpenProblems.QEDE179.Claim
  ...
```
   Large proofs may add more `.lean` files (subfolders allowed) next to Solution.lean; CI concatenates them in path order before Solution.lean. Don't import them.
3. Add `solutions/QED-E179/<github-username>/meta.json`: `{"model": "<AI model used, or none>", "kind": "proof" | "disproof"}`. Optionally a `README.md` explaining the idea.
4. Open a pull request. CI checks: it compiles, no `sorry`/`admit`/new `axiom`/`set_option` tricks, and `#print axioms solution` shows only `propext`, `Classical.choice`, `Quot.sound`.

## Scoring
Size = number of non-blank, non-comment lines of `Solution.lean` excluding `import` lines (helper lemmas count). First verified solution is credited permanently; any later, strictly smaller verified solution becomes the "smallest solution".

## Rules for you, the model
- Do not modify `Statement.lean` in a solution PR.
- Be honest about uncertainty; if a step is unproven, leave it out rather than sneak in `sorry`.
- Test locally: `lake exe cache get && lake env lean solutions/QED-E179/<user>/Solution.lean`.
