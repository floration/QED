# QED-E167 — Hamilton decompositions of 6-regular abelian Cayley graphs of even order

You are an AI model helping someone attack this open problem. Read all of this before working.

## The problem
Extended set · Grade B · QED Curated · Graph theory

**Plain words:** Take a finite abelian group of even order and a set S of 6 nonzero elements, closed under negation, that generates the group; join x to x+s for each s in S. The resulting connected 6-regular Cayley graph is predicted to split into 3 edge-disjoint Hamilton cycles. This is proved for all 4-regular such graphs and for 6-regular ones on groups of odd order, but only special even-order cases are known. Prove it for every abelian group of even order.

**Math:** Let $A$ be a finite abelian group with $|A|$ even, and $S\subseteq A\setminus\{0\}$ with $S=-S$, $|S|=6$, $\langle S\rangle=A$. Let $\Gamma=\mathrm{Cay}(A,S)$ be the simple graph with edges $\{x,x+s\}$, $s\in S$ (an involution $s\in S$ gives one edge at each vertex, so $\Gamma$ is $6$-regular). Prove that $E(\Gamma)$ can be partitioned into three Hamilton cycles.

**Credit:** Unnamed open case of B. Alspach's 1984 problem on Hamilton-decomposing Cayley graphs of abelian groups; status per Westlund-Liu-Kreher (2009) and the Kreher-Westlund HDCGAG project.

**Rests on recent unrefereed work. Check these premises first:**
- Is a sub-case of a person-named conjecture (Alspach's conjecture), allowed as an unnamed partial sub-question
- Partial even-order results rest partly on a Westlund preprint whose refereed status I did not confirm
- Could be seen as a 'next valency' parameter choice, though 6 is the first open valency

**References:**
- https://digitalcommons.mtu.edu/michigantech-p/6284
- https://digitalcommons.kennesaw.edu/facpubs/2825
- https://portal.mardi4nfdi.de/wiki/Publication:855297
- https://pages.mtu.edu/~kreher/ResearchWebsites/HDCGAG/HDCGAG.html
- https://arxiv.org/abs/1408.5211

Difficulty estimate: 5.5/10 (anchored scale: 1 ≈ Erdős–Ginzburg–Ziv, 2.5 ≈ the sensitivity conjecture, 5 ≈ bounded prime gaps, 7.5 ≈ the Riemann Hypothesis, 10 ≈ P vs NP). It is believed open; do not assume a quick answer exists, and say so plainly if you cannot make progress. Never present a heuristic, numerical evidence, or a partial result as a solution.

## What counts as an answer
Either a proof of `OpenProblems.QEDE167.Claim` or a proof of `¬ OpenProblems.QEDE167.Claim` (a disproof), in Lean 4 + Mathlib, using the exact statement in `problems/QED-E167/Statement.lean`. Read its "Formalization notes" first. If that file still says `def Claim : Prop := sorry`, the problem must first be formalized (see CONTRIBUTING.md); a faithful formalization is itself a welcome contribution.

If you think the Lean statement does not match the informal problem (it is trivially true or false, or it says something else), report that in an issue instead of exploiting it: such solutions are not credited.

## How to submit
0. First time? Solve a test problem (QED-Q1, the 2-line one, at minimum) and submit it, to confirm your Lean setup and the submission pipeline work before spending effort here. Skip this step if this IS a test problem.
1. Claim it (optional but encouraged): open an issue titled `Claim QED-E167` at https://github.com/floration/qed/issues/new?template=claim.yml. Comment on it at least once a week or the claim lapses.
2. Add `solutions/QED-E167/<github-username>/Solution.lean`:
```lean
import Mathlib
-- do NOT redefine Claim: CI prepends problems/QED-E167/Statement.lean to your file
theorem solution : OpenProblems.QEDE167.Claim := by   -- or ¬ OpenProblems.QEDE167.Claim
  ...
```
   Large proofs may add more `.lean` files (subfolders allowed) next to Solution.lean; CI concatenates them in path order before Solution.lean. Don't import them.
3. Add `solutions/QED-E167/<github-username>/meta.json`: `{"model": "<AI model used, or none>", "kind": "proof" | "disproof"}`. Optionally a `README.md` explaining the idea.
4. Open a pull request. CI checks: it compiles, no `sorry`/`admit`/new `axiom`/`set_option` tricks, and `#print axioms solution` shows only `propext`, `Classical.choice`, `Quot.sound`.

## Scoring
Size = number of non-blank, non-comment lines of `Solution.lean` excluding `import` lines (helper lemmas count). First verified solution is credited permanently; any later, strictly smaller verified solution becomes the "smallest solution".

## Rules for you, the model
- Do not modify `Statement.lean` in a solution PR.
- Be honest about uncertainty; if a step is unproven, leave it out rather than sneak in `sorry`.
- Test locally: `lake exe cache get && lake env lean solutions/QED-E167/<user>/Solution.lean`.
