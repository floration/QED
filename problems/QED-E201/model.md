# QED-E201 — 3-query locally decodable codes: beat the cubic lower bound

You are an AI model helping someone attack this open problem. Read all of this before working.

## The problem
Extended set · Grade A · QED Curated · Coding theory

**Plain words:** A 3-query locally decodable code encodes k bits into n bits so that any single message bit can be recovered with probability 1/2+eps by reading just 3 randomly chosen positions, even after a delta fraction of the codeword has been corrupted. The shortest known such codes have length exp(exp(O(sqrt(log k loglog k)))), while the best lower bound (2023) is n >= k^3/polylog(k). Prove n >= k^{3+c} for some fixed c>0.

**Math:** A map $E:\{0,1\}^k\to\{0,1\}^n$ is a $(3,\delta,\varepsilon)$-LDC if for each $i\in[k]$ there is a probability distribution $\mu_i$ on pairs $(S,f)$ with $S\in[n]^3$ and $f:\{0,1\}^3\to\{0,1\}$ such that for all $x\in\{0,1\}^k$ and all $y\in\{0,1\}^n$ with $d_H(y,E(x))\le\delta n$: $\Pr_{(S,f)\sim\mu_i}[f(y_S)=x_i]\ge\tfrac12+\varepsilon$. Prove: for all fixed $\delta,\varepsilon\in(0,1/2)$ there exist $c=c(\delta,\varepsilon)>0$ and $K$ such that every $(3,\delta,\varepsilon)$-LDC with $k\ge K$ has $n\ge k^{3+c}$. (Strengthening: $c$ independent of $\delta,\varepsilon$.)

**Credit:** Katz-Trevisan (2000); barrier per Alrabiah-Guruswami-Kothari-Manohar (2023)

**Rests on recent unrefereed work. Check these premises first:**
- Lean statement needs care with the order of quantifiers (c absolute, K depending on delta, eps)

**References:**
- https://arxiv.org/abs/2308.15403
- https://eccc.weizmann.ac.il/report/2022/101
- https://eccc.weizmann.ac.il/report/2026/156/download
- https://drops.dagstuhl.de/entities/document/10.4230/LIPIcs.ITCS.2025.2

Difficulty estimate: 7.0/10 (anchored scale: 1 ≈ Erdős–Ginzburg–Ziv, 2.5 ≈ the sensitivity conjecture, 5 ≈ bounded prime gaps, 7.5 ≈ the Riemann Hypothesis, 10 ≈ P vs NP). It is believed open; do not assume a quick answer exists, and say so plainly if you cannot make progress. Never present a heuristic, numerical evidence, or a partial result as a solution.

## What counts as an answer
Either a proof of `OpenProblems.QEDE201.Claim` or a proof of `¬ OpenProblems.QEDE201.Claim` (a disproof), in Lean 4 + Mathlib, using the exact statement in `problems/QED-E201/Statement.lean`. Read its "Formalization notes" first. If that file still says `def Claim : Prop := sorry`, the problem must first be formalized (see CONTRIBUTING.md); a faithful formalization is itself a welcome contribution.

If you think the Lean statement does not match the informal problem (it is trivially true or false, or it says something else), report that in an issue instead of exploiting it: such solutions are not credited.

## How to submit
0. First time? Solve a test problem (QED-Q1, the 2-line one, at minimum) and submit it, to confirm your Lean setup and the submission pipeline work before spending effort here. Skip this step if this IS a test problem.
1. Claim it (optional but encouraged): open an issue titled `Claim QED-E201` at https://github.com/floration/qed/issues/new?template=claim.yml. Comment on it at least once a week or the claim lapses.
2. Add `solutions/QED-E201/<github-username>/Solution.lean`:
```lean
import Mathlib
-- do NOT redefine Claim: CI prepends problems/QED-E201/Statement.lean to your file
theorem solution : OpenProblems.QEDE201.Claim := by   -- or ¬ OpenProblems.QEDE201.Claim
  ...
```
   Large proofs may add more `.lean` files (subfolders allowed) next to Solution.lean; CI concatenates them in path order before Solution.lean. Don't import them.
3. Add `solutions/QED-E201/<github-username>/meta.json`: `{"model": "<AI model used, or none>", "kind": "proof" | "disproof"}`. Optionally a `README.md` explaining the idea.
4. Open a pull request. CI checks: it compiles, no `sorry`/`admit`/new `axiom`/`set_option` tricks, and `#print axioms solution` shows only `propext`, `Classical.choice`, `Quot.sound`.

## Scoring
Size = number of non-blank, non-comment lines of `Solution.lean` excluding `import` lines (helper lemmas count). First verified solution is credited permanently; any later, strictly smaller verified solution becomes the "smallest solution".

## Rules for you, the model
- Do not modify `Statement.lean` in a solution PR.
- Be honest about uncertainty; if a step is unproven, leave it out rather than sneak in `sorry`.
- Test locally: `lake exe cache get && lake env lean solutions/QED-E201/<user>/Solution.lean`.
