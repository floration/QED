# QED-E024 — Ramsey multiplicity constant of K_4

You are an AI model helping someone attack this open problem. Read all of this before working.

## The problem
Extended set · Grade B- · QED Curated · Combinatorics

**Plain words:** In any red/blue colouring of the edges of a huge complete graph, some fraction of all 4-vertex sets must be single-coloured (all 6 edges the same colour). The minimum possible fraction is known only to lie between about 0.0296 and 0.03015. Pin it down further, or find its exact value.

**Math:** Let $c_4=\lim_{n\to\infty}\min_{G,|V(G)|=n}\big(k_4(G)+k_4(\bar G)\big)/\binom n4$. Known: $0.0296<c_4\le U=4551721\cdot 2^{-24}\cdot 3^{-2}<0.030145$ (Parczyk–Pokutta–Spiegel–Szabó). Formal target: improve the upper bound strictly, i.e. prove $c_4<4551721\cdot 2^{-24}\cdot 3^{-2}$ (more generally improve either bound or determine $c_4$).

**Reviewer note:** Known: Upper: Thomason (1989) < 1/33; Parczyk-Pokutta-Spiegel-Szabo, arXiv:2206.04036, Found. Comput. Math. (2024): c_4 <= 4551721·2^{-24}·3^{-2} < 0.030145 (blow-ups of a 768-vertex Cayley graph). Lower: Niess (arXiv:1207.4714) 0.0287; Sperfeld; Grzesik-Lee-Lidicky-Volec: c_4 > 0.0296 (cited in PPSS). Erdos's conjecture c_4 = 1/32 was refuted by Thomason.

**Credit:** Erdos; Thomason; Parczyk-Pokutta-Spiegel-Szabo (2022/2024); Grzesik-Lee-Lidicky-Volec.

**Rests on recent unrefereed work. Check these premises first:**
- Asymptotic constant; Lean formalization would need the limit definition, and 'improve a bound' is not a yes/no claim

**References:**
- https://arxiv.org/abs/2206.04036v3
- https://link.springer.com/10.1007/s10208-024-09675-6
- https://arxiv.org/abs/1207.4714

Difficulty estimate: 4.0/10 (calibrated: Collatz ≈ 5.5, twin primes ≈ 5.0). It is believed open; do not assume a quick answer exists, and say so plainly if you cannot make progress. Never present a heuristic, numerical evidence, or a partial result as a solution.

## What counts as an answer
Either a proof of `OpenProblems.QEDE024.Claim` or a proof of `¬ OpenProblems.QEDE024.Claim` (a disproof), in Lean 4 + Mathlib, using the exact statement in `problems/QED-E024/Statement.lean`. Read its "Formalization notes" first. If that file still says `def Claim : Prop := sorry`, the problem must first be formalized (see CONTRIBUTING.md); a faithful formalization is itself a welcome contribution.

If you think the Lean statement does not match the informal problem (it is trivially true or false, or it says something else), report that in an issue instead of exploiting it: such solutions are not credited.

## How to submit
1. Claim it (optional but encouraged): open an issue titled `Claim QED-E024` at https://github.com/floration/qed/issues/new?template=claim.yml. Comment on it at least once a week or the claim lapses.
2. Add `solutions/QED-E024/<github-username>/Solution.lean`:
```lean
import Mathlib
-- do NOT redefine Claim: CI prepends problems/QED-E024/Statement.lean to your file
theorem solution : OpenProblems.QEDE024.Claim := by   -- or ¬ OpenProblems.QEDE024.Claim
  ...
```
3. Add `solutions/QED-E024/<github-username>/meta.json`: `{"model": "<AI model used, or none>", "kind": "proof" | "disproof"}`. Optionally a `README.md` explaining the idea.
4. Open a pull request. CI checks: it compiles, no `sorry`/`admit`/new `axiom`/`set_option` tricks, and `#print axioms solution` shows only `propext`, `Classical.choice`, `Quot.sound`.

## Scoring
Size = number of non-blank, non-comment lines of `Solution.lean` excluding `import` lines (helper lemmas count). First verified solution is credited permanently; any later, strictly smaller verified solution becomes the "smallest solution".

## Rules for you, the model
- Do not modify `Statement.lean` in a solution PR.
- Be honest about uncertainty; if a step is unproven, leave it out rather than sneak in `sorry`.
- Test locally: `lake exe cache get && lake env lean solutions/QED-E024/<user>/Solution.lean`.
