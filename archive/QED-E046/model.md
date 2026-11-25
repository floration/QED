# QED-E046 — Rigorously refute Palásti's parking conjecture in the plane

You are an AI model helping someone attack this open problem. Read all of this before working.

## The problem
Extended set · Grade B- · QED Curated · Probability

**Plain words:** Drop unit squares (all axis-parallel) one at a time at uniformly random positions in a huge box, keeping each one only if it does not overlap those already placed, until no more fit. In one dimension the covered fraction tends to Rényi's constant, about 0.7476. Palásti guessed the planar answer is Rényi's constant squared, about 0.5589. Simulations give about 0.5620, so the guess seems wrong, but nobody has proved it. Prove that the planar jamming density is not Rényi's constant squared.

**Math:** Let $\rho_2$ be the jamming limit of random sequential adsorption of aligned unit squares in $[0,L]^2$ as $L\to\infty$; it exists, with $L^1$ and a.s. convergence, by Penrose (2001). Let $c_R=\int_0^\infty\exp\!\left(-2\int_0^t\frac{1-e^{-u}}{u}\,du\right)dt\approx0.747598$ be Rényi's constant. Prove $\rho_2\ne c_R^2$, for instance by proving a rigorous lower bound $\rho_2>c_R^2\approx0.55890$. More generally, give any rigorous non-trivial two-sided bound on $\rho_2$.

**Reviewer note:** Known: Rényi (1958): $\rho_1=c_R$. Palásti (1960) conjectured $\rho_d=c_R^d$. Weiner, J. Appl. Prob. (1978), claimed a proof for a planar sequential packing model; it was disputed in J. Appl. Prob. by Hori (1979, 'On Weiner's proof of the Palásti conjecture') and in 'Has the Palásti conjecture been proved? A criticism of a paper by H. J. Weiner', and Weiner replied (1980). The modern literature treats the conjecture as numerically false. Existence of $\rho_d$: Penrose, CMP 218 (2001). CLT: Penrose–Yukich, AAP 12 (2002). Simulations: $\rho_2\approx0.562009(4)$ (Brosilow–Ziff–Vigil 1991 and others; Wikipedia RSA table). Low-density availability series: arXiv:2607.05634 (2026), which gives no jamming bound.

**Credit:** Palásti (1960); Rényi (1958); Penrose (2001)

**Rests on recent unrefereed work. Check these premises first:**
- Weiner (1978) claimed a proof of a Palásti conjecture; the exchange in J. Appl. Prob. indicates it is flawed or about a different model, but I did not read the papers in full
- Variants use lattice squares or random sizes; the continuum aligned unit-square version is intended

**References:**
- https://en.wikipedia.org/wiki/Random_sequential_adsorption
- https://link.springer.com/article/10.1007/s002200100387
- https://www.cambridge.org/core/journals/journal-of-applied-probability/article/on-weiners-proof-of-the-palasti-conjecture/BDF40496AA96FDDA7DC4730E1D07B972
- https://www.cambridge.org/core/services/aop-cambridge-core/content/view/02466E85D27B52C8AE6B435A7EA86D4E/S0021900200107880a.pdf/has-the-palasti-conjecture-been-proved-a-criticism-of-a-paper-with-h-j-weiner.pdf
- https://arxiv.org/pdf/cond-mat/9903139
- https://arxiv.org/pdf/2607.05634

Difficulty estimate: 4.0/10 (calibrated: Collatz ≈ 5.5, twin primes ≈ 5.0). It is believed open; do not assume a quick answer exists, and say so plainly if you cannot make progress. Never present a heuristic, numerical evidence, or a partial result as a solution.

## What counts as an answer
Either a proof of `OpenProblems.QEDE046.Claim` or a proof of `¬ OpenProblems.QEDE046.Claim` (a disproof), in Lean 4 + Mathlib, using the exact statement in `problems/QED-E046/Statement.lean`. Read its "Formalization notes" first. If that file still says `def Claim : Prop := sorry`, the problem must first be formalized (see CONTRIBUTING.md); a faithful formalization is itself a welcome contribution.

If you think the Lean statement does not match the informal problem (it is trivially true or false, or it says something else), report that in an issue instead of exploiting it: such solutions are not credited.

## How to submit
1. Claim it (optional but encouraged): open an issue titled `Claim QED-E046` at https://github.com/floration/qed/issues/new?template=claim.yml. Comment on it at least once a week or the claim lapses.
2. Add `solutions/QED-E046/<github-username>/Solution.lean`:
```lean
import Mathlib
-- do NOT redefine Claim: CI prepends problems/QED-E046/Statement.lean to your file
theorem solution : OpenProblems.QEDE046.Claim := by   -- or ¬ OpenProblems.QEDE046.Claim
  ...
```
3. Add `solutions/QED-E046/<github-username>/meta.json`: `{"model": "<AI model used, or none>", "kind": "proof" | "disproof"}`. Optionally a `README.md` explaining the idea.
4. Open a pull request. CI checks: it compiles, no `sorry`/`admit`/new `axiom`/`set_option` tricks, and `#print axioms solution` shows only `propext`, `Classical.choice`, `Quot.sound`.

## Scoring
Size = number of non-blank, non-comment lines of `Solution.lean` excluding `import` lines (helper lemmas count). First verified solution is credited permanently; any later, strictly smaller verified solution becomes the "smallest solution".

## Rules for you, the model
- Do not modify `Statement.lean` in a solution PR.
- Be honest about uncertainty; if a step is unproven, leave it out rather than sneak in `sorry`.
- Test locally: `lake exe cache get && lake env lean solutions/QED-E046/<user>/Solution.lean`.
