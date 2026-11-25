# QED-E194 — Uniform spectral gap for the spin-2 Heisenberg antiferromagnetic ring

You are an AI model helping someone attack this open problem. Read all of this before working.

## The problem
Extended set · Grade A · QED Curated · Mathematical physics

**Plain words:** Put a quantum spin of size 2 at each site of a ring of L sites (L even) and couple neighbours by the antiferromagnetic Heisenberg interaction; the Hamiltonian is an explicit Hermitian matrix of size 5^L whose lowest eigenvalue is simple. Prove that the gap between the lowest and second-lowest eigenvalue stays above a fixed positive constant for all even L. The spin-1 case was proved in 2026 by a computer-assisted method; for spin 2 the predicted gap is only about 0.088 and the correlation length about 50 sites.

**Math:** Let $S^x,S^y,S^z$ be the spin-2 matrices on $\mathbb C^5$ and, for even $L\ge 4$, $H_L=\sum_{i\in\mathbb Z/L\mathbb Z}\vec S_i\cdot\vec S_{i+1}$ acting on $(\mathbb C^5)^{\otimes L}$, with eigenvalues (counted with multiplicity) $\lambda_1(L)\le\lambda_2(L)\le\cdots$. Prove that $\inf_{L\ \mathrm{even},\,L\ge4}\big(\lambda_2(L)-\lambda_1(L)\big)>0$.

**Credit:** Haldane (1983) prediction; S=2 case left open after the 2026 S=1 claims

**Rests on recent unrefereed work. Check these premises first:**
- Active area: the S=1 proof and its extensions are Sept-Nov 2026 preprints, and a certified S=2 result could appear soon. Not currently claimed by OpenAI or Anthropic.
- Special case of the person-named Haldane conjecture: allowed as an unnamed partial sub-question, but the scorer may see it as a famous problem in disguise.
- If solved by pure large computation plus the existing bootstrap, it may be judged low in new ideas.

**References:**
- https://arxiv.org/abs/2611.11049
- https://arxiv.org/abs/2611.07400
- https://arxiv.org/pdf/cond-mat/9903035
- https://arxiv.org/pdf/cond-mat/9501115
- https://arxiv.org/html/2407.17041v4
- https://www.emergentmind.com/open-problems/haldane-conjecture-integer-spin-heisenberg-chain-gap

Difficulty estimate: 5.0/10 (calibrated: Collatz ≈ 5.5, twin primes ≈ 5.0). It is believed open; do not assume a quick answer exists, and say so plainly if you cannot make progress. Never present a heuristic, numerical evidence, or a partial result as a solution.

## What counts as an answer
Either a proof of `OpenProblems.QEDE194.Claim` or a proof of `¬ OpenProblems.QEDE194.Claim` (a disproof), in Lean 4 + Mathlib, using the exact statement in `problems/QED-E194/Statement.lean`. Read its "Formalization notes" first. If that file still says `def Claim : Prop := sorry`, the problem must first be formalized (see CONTRIBUTING.md); a faithful formalization is itself a welcome contribution.

If you think the Lean statement does not match the informal problem (it is trivially true or false, or it says something else), report that in an issue instead of exploiting it: such solutions are not credited.

## How to submit
0. First time? Solve a test problem (QED-Q1, the 2-line one, at minimum) and submit it, to confirm your Lean setup and the submission pipeline work before spending effort here. Skip this step if this IS a test problem.
1. Claim it (optional but encouraged): open an issue titled `Claim QED-E194` at https://github.com/floration/qed/issues/new?template=claim.yml. Comment on it at least once a week or the claim lapses.
2. Add `solutions/QED-E194/<github-username>/Solution.lean`:
```lean
import Mathlib
-- do NOT redefine Claim: CI prepends problems/QED-E194/Statement.lean to your file
theorem solution : OpenProblems.QEDE194.Claim := by   -- or ¬ OpenProblems.QEDE194.Claim
  ...
```
   Large proofs may add more `.lean` files (subfolders allowed) next to Solution.lean; CI concatenates them in path order before Solution.lean. Don't import them.
3. Add `solutions/QED-E194/<github-username>/meta.json`: `{"model": "<AI model used, or none>", "kind": "proof" | "disproof"}`. Optionally a `README.md` explaining the idea.
4. Open a pull request. CI checks: it compiles, no `sorry`/`admit`/new `axiom`/`set_option` tricks, and `#print axioms solution` shows only `propext`, `Classical.choice`, `Quot.sound`.

## Scoring
Size = number of non-blank, non-comment lines of `Solution.lean` excluding `import` lines (helper lemmas count). First verified solution is credited permanently; any later, strictly smaller verified solution becomes the "smallest solution".

## Rules for you, the model
- Do not modify `Statement.lean` in a solution PR.
- Be honest about uncertainty; if a step is unproven, leave it out rather than sneak in `sorry`.
- Test locally: `lake exe cache get && lake env lean solutions/QED-E194/<user>/Solution.lean`.
