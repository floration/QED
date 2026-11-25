# QED-E190 — Conjugacy problem for one-relator groups

You are an AI model helping someone attack this open problem. Read all of this before working.

## The problem
Extended set · Grade A · QED Curated · Logic & computability

**Plain words:** A one-relator group is obtained from a free group on finitely many letters by imposing a single relation r = 1. Magnus showed in 1932 that one can always decide whether two words are equal in such a group. Can one also always decide whether two words are conjugate, i.e. whether u = g v g^{-1} for some g? Many classes are done, including (by a 2026 claim) all one-relator groups without Baumslag-Solitar subgroups, which are hyperbolic; what remains are one-relator groups that contain a Baumslag-Solitar subgroup.

**Math:** For $n\ge1$ and $r\in F_n$ (free group on $x_1,\dots,x_n$) let $G_r=F_n/\langle\!\langle r\rangle\!\rangle$ and $\pi:F_n\to G_r$. Decide whether, for every $n$ and every $r\in F_n$, the set $\mathrm{Conj}_r=\{(u,v)\in F_n^2:\exists g\in G_r,\ \pi(u)=g\,\pi(v)\,g^{-1}\}$ is decidable. A solution is either a proof that it is (an algorithm uniform in $(n,r,u,v)$ is a stronger positive answer), or an explicit pair $(n,r)$ for which $\mathrm{Conj}_r$ is undecidable. (Since Baumslag-Solitar-free one-relator groups are hyperbolic, the problem concerns only $r$ for which $G_r$ contains some $BS(p,q)$.)

**Credit:** Classical problem in combinatorial group theory (Magnus era); current statement as in Linton et al. arXiv:2501.18306.

**Rests on recent unrefereed work. Check these premises first:**
- Status of BS-free one-relator groups depends on unrefereed 2026 claims (OpenAI preprint on hyperbolicity; conditional results in arXiv:2610.25305). These affect only the description of partial progress, not openness.
- Attribution details for some subclass results (pinched cases) should be double-checked against the Linton survey before posting.

**References:**
- https://arxiv.org/abs/2501.18306
- https://arxiv.org/abs/2610.25305
- https://arxiv.org/abs/2209.04357
- https://www.emergentmind.com/open-problems/conjugacy-problem-one-relator-groups
- https://en.wikipedia.org/wiki/One-relator_group

Difficulty estimate: 6.0/10 (calibrated: Collatz ≈ 5.5, twin primes ≈ 5.0). It is believed open; do not assume a quick answer exists, and say so plainly if you cannot make progress. Never present a heuristic, numerical evidence, or a partial result as a solution.

## What counts as an answer
Either a proof of `OpenProblems.QEDE190.Claim` or a proof of `¬ OpenProblems.QEDE190.Claim` (a disproof), in Lean 4 + Mathlib, using the exact statement in `problems/QED-E190/Statement.lean`. Read its "Formalization notes" first. If that file still says `def Claim : Prop := sorry`, the problem must first be formalized (see CONTRIBUTING.md); a faithful formalization is itself a welcome contribution.

If you think the Lean statement does not match the informal problem (it is trivially true or false, or it says something else), report that in an issue instead of exploiting it: such solutions are not credited.

## How to submit
0. First time? Solve a test problem (QED-Q1, the 2-line one, at minimum) and submit it, to confirm your Lean setup and the submission pipeline work before spending effort here. Skip this step if this IS a test problem.
1. Claim it (optional but encouraged): open an issue titled `Claim QED-E190` at https://github.com/floration/qed/issues/new?template=claim.yml. Comment on it at least once a week or the claim lapses.
2. Add `solutions/QED-E190/<github-username>/Solution.lean`:
```lean
import Mathlib
-- do NOT redefine Claim: CI prepends problems/QED-E190/Statement.lean to your file
theorem solution : OpenProblems.QEDE190.Claim := by   -- or ¬ OpenProblems.QEDE190.Claim
  ...
```
   Large proofs may add more `.lean` files (subfolders allowed) next to Solution.lean; CI concatenates them in path order before Solution.lean. Don't import them.
3. Add `solutions/QED-E190/<github-username>/meta.json`: `{"model": "<AI model used, or none>", "kind": "proof" | "disproof"}`. Optionally a `README.md` explaining the idea.
4. Open a pull request. CI checks: it compiles, no `sorry`/`admit`/new `axiom`/`set_option` tricks, and `#print axioms solution` shows only `propext`, `Classical.choice`, `Quot.sound`.

## Scoring
Size = number of non-blank, non-comment lines of `Solution.lean` excluding `import` lines (helper lemmas count). First verified solution is credited permanently; any later, strictly smaller verified solution becomes the "smallest solution".

## Rules for you, the model
- Do not modify `Statement.lean` in a solution PR.
- Be honest about uncertainty; if a step is unproven, leave it out rather than sneak in `sorry`.
- Test locally: `lake exe cache get && lake env lean solutions/QED-E190/<user>/Solution.lean`.
