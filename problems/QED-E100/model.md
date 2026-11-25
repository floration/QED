# QED-E100 — Improve H_1 <= 12 under EH alone

You are an AI model helping someone attack this open problem. Read all of this before working.

## The problem
Extended set · Grade B · QED Curated · Number theory

**Plain words:** Assuming Elliott–Halberstam, Maynard's sieve gives infinitely many pairs of primes at distance at most 12. The generalized conjecture GEH gives 6. Using EH alone, show there are infinitely many pairs of primes at distance at most 10. Further questions (not part of the formal claim): or show that no Selberg/Maynard-type sieve with EH alone can beat 12.

**Math:** Let $H_1=\liminf_{n}(p_{n+1}-p_n)$. Let EH be the Elliott–Halberstam conjecture for the von Mangoldt function only (not GEH): for every $\varepsilon>0$ and $A>0$, $\sum_{q\le x^{1-\varepsilon}}|\psi(x;q,a_q)-\psi(x)/\varphi(q)|\ll_{\varepsilon,A} x/\log^A x$ uniformly over residues $a_q$ coprime to $q$. Claim: EH implies $H_1\le 10$, i.e. that there are infinitely many primes $p<q\le p+10$. (An unconditional proof of $H_1\le10$ also proves the Claim.) Further questions (not part of the formal claim): prove that no Selberg/Maynard-type sieve weight using EH alone can give $H_1<12$.

**Credit:** D.H.J. Polymath 2014, arXiv:1407.4897; J. Maynard 2015, arXiv:1311.4600

**References:**
- https://arxiv.org/abs/1407.4897
- https://arxiv.org/abs/1311.4600

Difficulty estimate: 6.5/10 (anchored scale: 1 ≈ Erdős–Ginzburg–Ziv, 2.5 ≈ the sensitivity conjecture, 5 ≈ bounded prime gaps, 7.5 ≈ the Riemann Hypothesis, 10 ≈ P vs NP). It is believed open; do not assume a quick answer exists, and say so plainly if you cannot make progress. Never present a heuristic, numerical evidence, or a partial result as a solution.

## What counts as an answer
Either a proof of `OpenProblems.QEDE100.Claim` or a proof of `¬ OpenProblems.QEDE100.Claim` (a disproof), in Lean 4 + Mathlib, using the exact statement in `problems/QED-E100/Statement.lean`. Read its "Formalization notes" first. If that file still says `def Claim : Prop := sorry`, the problem must first be formalized (see CONTRIBUTING.md); a faithful formalization is itself a welcome contribution.

If you think the Lean statement does not match the informal problem (it is trivially true or false, or it says something else), report that in an issue instead of exploiting it: such solutions are not credited.

## How to submit
0. First time? Solve a test problem (QED-Q1, the 2-line one, at minimum) and submit it, to confirm your Lean setup and the submission pipeline work before spending effort here. Skip this step if this IS a test problem.
1. Claim it (optional but encouraged): open an issue titled `Claim QED-E100` at https://github.com/floration/qed/issues/new?template=claim.yml. Comment on it at least once a week or the claim lapses.
2. Add `solutions/QED-E100/<github-username>/Solution.lean`:
```lean
import Mathlib
-- do NOT redefine Claim: CI prepends problems/QED-E100/Statement.lean to your file
theorem solution : OpenProblems.QEDE100.Claim := by   -- or ¬ OpenProblems.QEDE100.Claim
  ...
```
   Large proofs may add more `.lean` files (subfolders allowed) next to Solution.lean; CI concatenates them in path order before Solution.lean. Don't import them.
3. Add `solutions/QED-E100/<github-username>/meta.json`: `{"model": "<AI model used, or none>", "kind": "proof" | "disproof"}`. Optionally a `README.md` explaining the idea.
4. Open a pull request. CI checks: it compiles, no `sorry`/`admit`/new `axiom`/`set_option` tricks, and `#print axioms solution` shows only `propext`, `Classical.choice`, `Quot.sound`.

## Scoring
Size = number of non-blank, non-comment lines of `Solution.lean` excluding `import` lines (helper lemmas count). First verified solution is credited permanently; any later, strictly smaller verified solution becomes the "smallest solution".

## Rules for you, the model
- Do not modify `Statement.lean` in a solution PR.
- Be honest about uncertainty; if a step is unproven, leave it out rather than sneak in `sorry`.
- Test locally: `lake exe cache get && lake env lean solutions/QED-E100/<user>/Solution.lean`.
