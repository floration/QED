# QED-M127 — Are graphs with no K7 minor 7-colourable?

You are an AI model helping someone attack this open problem. Read all of this before working.

## The problem
Main set · Grade A · QED Curated · Graph theory

**Plain words:** A graph has a K7 minor if one can find 7 disjoint connected groups of vertices with an edge between every two groups. Graphs with no K7 minor are known to be colourable with 8 colours, and the t=7 case of Hadwiger's conjecture predicts that 6 suffice, but nobody can even show that 7 colours always suffice. Prove (or disprove) that every graph with no K7 minor can be properly coloured with 7 colours.

**Math:** Let $G$ be a finite simple graph with no $K_7$ minor, i.e. there are no pairwise disjoint nonempty sets $B_1,\dots,B_7\subseteq V(G)$ with each $G[B_i]$ connected and at least one edge between $B_i$ and $B_j$ for all $i\ne j$. Claim: $\chi(G)\le 7$. (Known: $\chi(G)\le 8$.)

**Credit:** Open question recorded in arXiv:2609.17760 and earlier (Albar-Gonçalves 2018); weaker unnamed sub-question of the t=7 case of Hadwiger's conjecture.

**Rests on recent unrefereed work. Check these premises first:**
- The '6-colourable' version is a named-conjecture case; the claim is deliberately the weaker 7-colour statement, which is unnamed
- Key 2026 source arXiv:2609.17760 is an unrefereed preprint (its statement of openness is corroborated by the refereed 8-colourability literature)
- Must make sure the OpenAI 'linear list colouring bound in terms of Hadwiger number' does not give a constant <= 7 for t=7 (its abstract-level claim is a linear bound, constant not small)

**References:**
- https://arxiv.org/abs/2208.07335
- https://arxiv.org/abs/2609.17760
- https://arxiv.org/abs/2507.03244
- https://arxiv.org/abs/1304.5468
- https://arxiv.org/abs/2610.17090

Difficulty estimate: 7.0/10 (anchored scale: 1 ≈ Erdős–Ginzburg–Ziv, 2.5 ≈ the sensitivity conjecture, 5 ≈ bounded prime gaps, 7.5 ≈ the Riemann Hypothesis, 10 ≈ P vs NP). It is believed open; do not assume a quick answer exists, and say so plainly if you cannot make progress. Never present a heuristic, numerical evidence, or a partial result as a solution.

## What counts as an answer
Either a proof of `OpenProblems.QEDM127.Claim` or a proof of `¬ OpenProblems.QEDM127.Claim` (a disproof), in Lean 4 + Mathlib, using the exact statement in `problems/QED-M127/Statement.lean`. Read its "Formalization notes" first. If that file still says `def Claim : Prop := sorry`, the problem must first be formalized (see CONTRIBUTING.md); a faithful formalization is itself a welcome contribution.

If you think the Lean statement does not match the informal problem (it is trivially true or false, or it says something else), report that in an issue instead of exploiting it: such solutions are not credited.

## How to submit
0. First time? Solve a test problem (QED-Q1, the 2-line one, at minimum) and submit it, to confirm your Lean setup and the submission pipeline work before spending effort here. Skip this step if this IS a test problem.
1. Claim it (optional but encouraged): open an issue titled `Claim QED-M127` at https://github.com/floration/qed/issues/new?template=claim.yml. Comment on it at least once a week or the claim lapses.
2. Add `solutions/QED-M127/<github-username>/Solution.lean`:
```lean
import Mathlib
-- do NOT redefine Claim: CI prepends problems/QED-M127/Statement.lean to your file
theorem solution : OpenProblems.QEDM127.Claim := by   -- or ¬ OpenProblems.QEDM127.Claim
  ...
```
   Large proofs may add more `.lean` files (subfolders allowed) next to Solution.lean; CI concatenates them in path order before Solution.lean. Don't import them.
3. Add `solutions/QED-M127/<github-username>/meta.json`: `{"model": "<AI model used, or none>", "kind": "proof" | "disproof"}`. Optionally a `README.md` explaining the idea.
4. Open a pull request. CI checks: it compiles, no `sorry`/`admit`/new `axiom`/`set_option` tricks, and `#print axioms solution` shows only `propext`, `Classical.choice`, `Quot.sound`.

## Scoring
Size = number of non-blank, non-comment lines of `Solution.lean` excluding `import` lines (helper lemmas count). First verified solution is credited permanently; any later, strictly smaller verified solution becomes the "smallest solution".

## Rules for you, the model
- Do not modify `Statement.lean` in a solution PR.
- Be honest about uncertainty; if a step is unproven, leave it out rather than sneak in `sorry`.
- Test locally: `lake exe cache get && lake env lean solutions/QED-M127/<user>/Solution.lean`.
