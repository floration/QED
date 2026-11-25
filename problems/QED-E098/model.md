# QED-E098 — Break the 5/8 barrier for primes with triply well-factorable weights

You are an AI model helping someone attack this open problem. Read all of this before working.

## The problem
Extended set · Grade A · QED Curated · Number theory

**Plain words:** The primes are known to be evenly spread over residue classes, on average over moduli up to x^{5/8}, if the average is weighted by triply well-factorable weights. Push the exponent past 5/8, or show the dispersion method cannot.

**Math:** Say (lambda_q)_{q<=Q} is triply well-factorable of level Q if for all Q1Q2Q3=Q there are 1-bounded alpha,beta,gamma supported on q_i<=Q_i with lambda=alpha*beta*gamma (Dirichlet convolution). Let theta* = sup of theta such that for all eps,A>0, fixed a!=0, and every such lambda of level Q=x^{theta-eps}: sum_{q<=Q,(q,a)=1} lambda_q(pi(x;q,a)-pi(x)/phi(q)) <<_{eps,A,a} x(log x)^{-A}. Known theta*>=5/8 (Pascadi). Prove theta*>5/8.

**Credit:** A. Pascadi, arXiv:2505.00653 (2025), Thm 1.3 and remarks on the 5/8 limit; J. D. Lichtman, arXiv:2309.08522 (2023); triply well-factorable weights from Maynard's equidistribution papers.

**Rests on recent unrefereed work. Check these premises first:**
- arXiv:2505.00653 (Pascadi, 2025 preprint, refereeing status unverified): the known baseline θ* ≥ 5/8 unconditionally and the exact definition of triply well-factorable weights (Def 1.1) are taken from it.
- arXiv:2602.20917 and arXiv:2608.13299 (2026 preprints): used only to check that no one has passed 5/8; the statement assumes nothing from them.

**References:**
- https://arxiv.org/abs/2505.00653
- https://arxiv.org/abs/2309.08522
- https://arxiv.org/abs/2404.04239
- arXiv:2505.00653
- arXiv:2309.08522
- arXiv:2404.04239
- arXiv:2602.20917
- arXiv:2608.13299

Difficulty estimate: 4.5/10 (calibrated: Collatz ≈ 5.5, twin primes ≈ 5.0). It is believed open; do not assume a quick answer exists, and say so plainly if you cannot make progress. Never present a heuristic, numerical evidence, or a partial result as a solution.

## What counts as an answer
Either a proof of `OpenProblems.QEDE098.Claim` or a proof of `¬ OpenProblems.QEDE098.Claim` (a disproof), in Lean 4 + Mathlib, using the exact statement in `problems/QED-E098/Statement.lean`. Read its "Formalization notes" first. If that file still says `def Claim : Prop := sorry`, the problem must first be formalized (see CONTRIBUTING.md); a faithful formalization is itself a welcome contribution.

If you think the Lean statement does not match the informal problem (it is trivially true or false, or it says something else), report that in an issue instead of exploiting it: such solutions are not credited.

## How to submit
0. First time? Solve a test problem (QED-Q1, the 2-line one, at minimum) and submit it, to confirm your Lean setup and the submission pipeline work before spending effort here. Skip this step if this IS a test problem.
1. Claim it (optional but encouraged): open an issue titled `Claim QED-E098` at https://github.com/floration/qed/issues/new?template=claim.yml. Comment on it at least once a week or the claim lapses.
2. Add `solutions/QED-E098/<github-username>/Solution.lean`:
```lean
import Mathlib
-- do NOT redefine Claim: CI prepends problems/QED-E098/Statement.lean to your file
theorem solution : OpenProblems.QEDE098.Claim := by   -- or ¬ OpenProblems.QEDE098.Claim
  ...
```
3. Add `solutions/QED-E098/<github-username>/meta.json`: `{"model": "<AI model used, or none>", "kind": "proof" | "disproof"}`. Optionally a `README.md` explaining the idea.
4. Open a pull request. CI checks: it compiles, no `sorry`/`admit`/new `axiom`/`set_option` tricks, and `#print axioms solution` shows only `propext`, `Classical.choice`, `Quot.sound`.

## Scoring
Size = number of non-blank, non-comment lines of `Solution.lean` excluding `import` lines (helper lemmas count). First verified solution is credited permanently; any later, strictly smaller verified solution becomes the "smallest solution".

## Rules for you, the model
- Do not modify `Statement.lean` in a solution PR.
- Be honest about uncertainty; if a step is unproven, leave it out rather than sneak in `sorry`.
- Test locally: `lake exe cache get && lake env lean solutions/QED-E098/<user>/Solution.lean`.
