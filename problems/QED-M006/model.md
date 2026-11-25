# QED-M006 — Which monodromy groups do Jacobian counterexamples have?

You are an AI model helping someone attack this open problem. Read all of this before working.

## The problem
Main set · Grade B · QED Original · Algebra

**Plain words:** A Keller map (polynomial map with constant nonzero Jacobian) that is not invertible covers a generic point d times, and following the d preimages around loops gives a permutation group, its monodromy. Campbell's 1973 theorem says that if this group is regular (the Galois case), the map is invertible. The 2026 counterexamples realize full symmetric groups and some imprimitive groups. Is Campbell's theorem the only obstruction?

**Math:** For a Keller map $F:\mathbb C^n\to\mathbb C^n$ ($\det JF\in\mathbb C^\times$) of geometric degree $d\ge2$, let $\mathrm{Mon}(F)\le S_d$ be the geometric monodromy group (Galois group of the Galois closure of $\mathbb C(x)/\mathbb C(F)$ acting on the $d$ embeddings). It is transitive, and by Campbell's theorem it is regular only if $d=1$. Let $\mathcal M$ be the set of transitive groups (up to permutation isomorphism) arising as $\mathrm{Mon}(F)$ for non-invertible Keller maps in some dimension; $\mathcal M$ contains $S_d$, $A_d$ (e.g. $d=6,12$ and the families of Kistner-Shaska 2608.02863) and imprimitive wreath-type groups (Fonollosa 2609.33491), and is closed under direct products in product action ($F\times G$). Is $\mathcal M$ exactly the set of non-regular transitive groups? Test case: does some primitive group not containing $A_d$ (e.g. $\mathrm{AGL}(1,p)$ for a prime $p\ge5$, or $\mathrm{PSL}(2,7)$ on 7 points) lie in $\mathcal M$? (A negative answer to the test case means every primitive member of $\mathcal M$ is alternating or symmetric, which would refute the first question.)

**Rests on recent unrefereed work. Check these premises first:**
- The premise that the Jacobian conjecture was refuted in 2026 rests on 2026 preprints (arXiv:2607.20210, 2607.21572, 2608.00222); if those counterexamples fail, the set M is empty and the question changes completely.
- arXiv:2608.02863 (Kistner-Shaska, 2026 preprint): source of S_d, A_d (d = 6, 12, families) as realized monodromy groups.
- arXiv:2609.33491 (Fonollosa, 2026 preprint): source of imprimitive wreath-type monodromy groups.

**References:**
- https://arxiv.org/pdf/2608.00222
- https://arxiv.org/pdf/2607.21572
- https://arxiv.org/pdf/2608.02863
- https://arxiv.org/pdf/2609.33491
- https://arxiv.org/pdf/2607.20210
- https://www.ams.org/bull/1982-07-02/S0273-0979-1982-15032-7/
- https://arxiv.org/abs/2608.02863
- https://arxiv.org/abs/2609.33491
- https://arxiv.org/abs/2608.00222
- https://arxiv.org/abs/2607.20210

Difficulty estimate: 5.0/10 (anchored scale: 1 ≈ Erdős–Ginzburg–Ziv, 2.5 ≈ the sensitivity conjecture, 5 ≈ bounded prime gaps, 7.5 ≈ the Riemann Hypothesis, 10 ≈ P vs NP). It is believed open; do not assume a quick answer exists, and say so plainly if you cannot make progress. Never present a heuristic, numerical evidence, or a partial result as a solution.

## What counts as an answer
Either a proof of `OpenProblems.QEDM006.Claim` or a proof of `¬ OpenProblems.QEDM006.Claim` (a disproof), in Lean 4 + Mathlib, using the exact statement in `problems/QED-M006/Statement.lean`. Read its "Formalization notes" first. If that file still says `def Claim : Prop := sorry`, the problem must first be formalized (see CONTRIBUTING.md); a faithful formalization is itself a welcome contribution.

If you think the Lean statement does not match the informal problem (it is trivially true or false, or it says something else), report that in an issue instead of exploiting it: such solutions are not credited.

## How to submit
0. First time? Solve a test problem (QED-Q1, the 2-line one, at minimum) and submit it, to confirm your Lean setup and the submission pipeline work before spending effort here. Skip this step if this IS a test problem.
1. Claim it (optional but encouraged): open an issue titled `Claim QED-M006` at https://github.com/floration/qed/issues/new?template=claim.yml. Comment on it at least once a week or the claim lapses.
2. Add `solutions/QED-M006/<github-username>/Solution.lean`:
```lean
import Mathlib
-- do NOT redefine Claim: CI prepends problems/QED-M006/Statement.lean to your file
theorem solution : OpenProblems.QEDM006.Claim := by   -- or ¬ OpenProblems.QEDM006.Claim
  ...
```
   Large proofs may add more `.lean` files (subfolders allowed) next to Solution.lean; CI concatenates them in path order before Solution.lean. Don't import them.
3. Add `solutions/QED-M006/<github-username>/meta.json`: `{"model": "<AI model used, or none>", "kind": "proof" | "disproof"}`. Optionally a `README.md` explaining the idea.
4. Open a pull request. CI checks: it compiles, no `sorry`/`admit`/new `axiom`/`set_option` tricks, and `#print axioms solution` shows only `propext`, `Classical.choice`, `Quot.sound`.

## Scoring
Size = number of non-blank, non-comment lines of `Solution.lean` excluding `import` lines (helper lemmas count). First verified solution is credited permanently; any later, strictly smaller verified solution becomes the "smallest solution".

## Rules for you, the model
- Do not modify `Statement.lean` in a solution PR.
- Be honest about uncertainty; if a step is unproven, leave it out rather than sneak in `sorry`.
- Test locally: `lake exe cache get && lake env lean solutions/QED-M006/<user>/Solution.lean`.
