# QED-M105 — Does the trefoil have a symbiont?

You are an AI model helping someone attack this open problem. Read all of this before working.

## The problem
Main set · Grade B · QED Extension · Topology

**Plain words:** The unknotting number of a knot is the fewest crossing changes needed to turn it into an unknotted loop. In 2025 it was shown that tying two knots together end to end can need fewer changes than the two knots need separately, and in 2026 that every torus knot except possibly the trefoil has a partner like this. Does the trefoil, the simplest knot, also have such a partner? The most likely candidate is the 10-crossing knot 10_6, whose own unknotting number is still unknown (it is 2 or 3).

**Math:** Write $u(K)$ for the unknotting number and $\#$ for connected sum. Knots $K,K'$ are symbionts if $u(K\#K')<u(K)+u(K')$. Is there a knot $K$, with some choice of mirror image, such that $u(3_1\#K)<1+u(K)$? By Scharlemann's theorem any such $K$ has $u(K)\ge2$. Concrete subquestion: is $u(10_6)=3$? Brittenham–Hermiller prove $u(3_1\#10_6)\le3$ for the mirror choice with $|\sigma(3_1\#10_6)|=2$, so $u(10_6)=3$ would give a positive answer.

**Reviewer note:** Known: Additivity fails: $u(7_1\#\overline{7_1})\le5$ (Brittenham–Hermiller, arXiv:2506.24088, 2025). Every non-trivial torus knot except possibly $T(2,3)$ has a symbiont (Cor. 4.2), and $u(3_1\#10_6)\le3$ with $u(10_6)\in\{2,3\}$ (Thm 1.3); the paper calls deciding $u(10_6)$ an interesting open problem (Brittenham–Hermiller, arXiv:2601.18757, 2026). Scharlemann: $u(K\#K')\ge2$ for non-trivial $K,K'$. arXiv:2608.25256 (2026) obtains 194 new unknotting numbers of alternating knots with d-invariants and Owens' theorem; it began as an attempt to prove $u(10_6)=3$ and says $u(10_6)$ is still unknown. Lee (arXiv:2609.09861, 2026) also lists $10_6$ as unresolved in $[2,3]$.

**Credit:** Brittenham & Hermiller, arXiv 2601.18757 (2026), Cor. 4.2 and Sec. 3/5

**Rests on recent unrefereed work. Check these premises first:**
- Fast-moving area: a late-2026 preprint could settle u(10_6)
- Mirror conventions: the bound u(3_1#10_6) ≤ 3 is for a specific mirror pairing
- u(10_6)=2 would not settle the trefoil question, since another partner could exist

**References:**
- https://arxiv.org/abs/2506.24088
- https://arxiv.org/abs/2601.18757
- https://arxiv.org/abs/2608.25256
- https://arxiv.org/abs/2609.09861

Difficulty estimate: 6.0/10 (anchored scale: 1 ≈ Erdős–Ginzburg–Ziv, 2.5 ≈ the sensitivity conjecture, 5 ≈ bounded prime gaps, 7.5 ≈ the Riemann Hypothesis, 10 ≈ P vs NP). It is believed open; do not assume a quick answer exists, and say so plainly if you cannot make progress. Never present a heuristic, numerical evidence, or a partial result as a solution.

## What counts as an answer
Either a proof of `OpenProblems.QEDM105.Claim` or a proof of `¬ OpenProblems.QEDM105.Claim` (a disproof), in Lean 4 + Mathlib, using the exact statement in `problems/QED-M105/Statement.lean`. Read its "Formalization notes" first. If that file still says `def Claim : Prop := sorry`, the problem must first be formalized (see CONTRIBUTING.md); a faithful formalization is itself a welcome contribution.

If you think the Lean statement does not match the informal problem (it is trivially true or false, or it says something else), report that in an issue instead of exploiting it: such solutions are not credited.

## How to submit
0. First time? Solve a test problem (QED-Q1, the 2-line one, at minimum) and submit it, to confirm your Lean setup and the submission pipeline work before spending effort here. Skip this step if this IS a test problem.
1. Claim it (optional but encouraged): open an issue titled `Claim QED-M105` at https://github.com/floration/qed/issues/new?template=claim.yml. Comment on it at least once a week or the claim lapses.
2. Add `solutions/QED-M105/<github-username>/Solution.lean`:
```lean
import Mathlib
-- do NOT redefine Claim: CI prepends problems/QED-M105/Statement.lean to your file
theorem solution : OpenProblems.QEDM105.Claim := by   -- or ¬ OpenProblems.QEDM105.Claim
  ...
```
   Large proofs may add more `.lean` files (subfolders allowed) next to Solution.lean; CI concatenates them in path order before Solution.lean. Don't import them.
3. Add `solutions/QED-M105/<github-username>/meta.json`: `{"model": "<AI model used, or none>", "kind": "proof" | "disproof"}`. Optionally a `README.md` explaining the idea.
4. Open a pull request. CI checks: it compiles, no `sorry`/`admit`/new `axiom`/`set_option` tricks, and `#print axioms solution` shows only `propext`, `Classical.choice`, `Quot.sound`.

## Scoring
Size = number of non-blank, non-comment lines of `Solution.lean` excluding `import` lines (helper lemmas count). First verified solution is credited permanently; any later, strictly smaller verified solution becomes the "smallest solution".

## Rules for you, the model
- Do not modify `Statement.lean` in a solution PR.
- Be honest about uncertainty; if a step is unproven, leave it out rather than sneak in `sorry`.
- Test locally: `lake exe cache get && lake env lean solutions/QED-M105/<user>/Solution.lean`.
