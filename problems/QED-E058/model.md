# QED-E058 — Does the variance of the LCS of two random binary strings tend to infinity?

You are an AI model helping someone attack this open problem. Read all of this before working.

## The problem
Extended set · Grade A · QED Curated · Probability

**Plain words:** Pick two independent uniformly random binary strings of length n and let L_n be the length of their longest common subsequence. Its mean is about 0.81n and its variance is at most n/4. Show that the variance tends to infinity, i.e. that L_n is not concentrated within a bounded window around its mean. (Linear order of the variance is believed, but even unboundedness is open.)

**Math:** For independent uniform $X,Y\in\{0,1\}^n$ let $L_n=\mathrm{LCS}(X,Y)$. Prove that $\lim_{n\to\infty}\mathrm{Var}(L_n)=\infty$. (Known: $\mathrm{Var}(L_n)\le n/4$; the stronger $\mathrm{Var}(L_n)\ge cn$ is the uniform case of Waterman's conjecture.)

**Reviewer note:** Known: $\mathrm{Var}(L_n)\le n/4$ (Steele 1986 via Efron-Stein; constant from Deslandes-Houdre, arXiv 2401.03063). $\mathrm{Var}=\Theta(n)$ proved for binary letters with one letter of small probability (Lember-Matzinger, Ann. Probab. 2009, arXiv math/0702036), for 3-letter vs binary asymmetric case (Bonetto-Matzinger, arXiv math/0410404), with an omitted letter (Houdre-Ma, arXiv 1812.09552), and conditional CLT (Houdre-Islak, arXiv 1408.1559). Deslandes-Houdre (2024) prove a necessary condition for linearity in the uniform case but state 'it is still an open problem to determine whether or not, in the uniform case, the variance tends to infinity.' Simulations: Liu-Houdre (arXiv 1705.06826) fit exponent 0.91 and conjecture linear order; earlier Bonetto-Matzinger simulations suggested sd o(n^{1/3}).

**Credit:** Chvatal-Sankoff (1975), Waterman (1994), Steele (1986); stated as open by Deslandes-Houdre (2024)

**Rests on recent unrefereed work. Check these premises first:**
- The conjectured answer (linear) is supported by simulations and analogous non-uniform theorems but not certain; an early simulation suggested much smaller fluctuations. If false, the honest problem is the order of the variance; the vetter may prefer the weaker but unconditional open target Var(L_n) -> infinity.

**References:**
- https://arxiv.org/abs/2401.03063
- https://arxiv.org/abs/math/0410404
- https://arxiv.org/abs/0907.5137
- https://arxiv.org/abs/math/0702036
- https://arxiv.org/abs/1705.06826

Difficulty estimate: 6.5/10 (calibrated: Collatz ≈ 5.5, twin primes ≈ 5.0). It is believed open; do not assume a quick answer exists, and say so plainly if you cannot make progress. Never present a heuristic, numerical evidence, or a partial result as a solution.

## What counts as an answer
Either a proof of `OpenProblems.QEDE058.Claim` or a proof of `¬ OpenProblems.QEDE058.Claim` (a disproof), in Lean 4 + Mathlib, using the exact statement in `problems/QED-E058/Statement.lean`. Read its "Formalization notes" first. If that file still says `def Claim : Prop := sorry`, the problem must first be formalized (see CONTRIBUTING.md); a faithful formalization is itself a welcome contribution.

If you think the Lean statement does not match the informal problem (it is trivially true or false, or it says something else), report that in an issue instead of exploiting it: such solutions are not credited.

## How to submit
1. Claim it (optional but encouraged): open an issue titled `Claim QED-E058` at https://github.com/floration/qed/issues/new?template=claim.yml. Comment on it at least once a week or the claim lapses.
2. Add `solutions/QED-E058/<github-username>/Solution.lean`:
```lean
import Mathlib
-- do NOT redefine Claim: CI prepends problems/QED-E058/Statement.lean to your file
theorem solution : OpenProblems.QEDE058.Claim := by   -- or ¬ OpenProblems.QEDE058.Claim
  ...
```
   Large proofs may add more `.lean` files (subfolders allowed) next to Solution.lean; CI concatenates them in path order before Solution.lean. Don't import them.
3. Add `solutions/QED-E058/<github-username>/meta.json`: `{"model": "<AI model used, or none>", "kind": "proof" | "disproof"}`. Optionally a `README.md` explaining the idea.
4. Open a pull request. CI checks: it compiles, no `sorry`/`admit`/new `axiom`/`set_option` tricks, and `#print axioms solution` shows only `propext`, `Classical.choice`, `Quot.sound`.

## Scoring
Size = number of non-blank, non-comment lines of `Solution.lean` excluding `import` lines (helper lemmas count). First verified solution is credited permanently; any later, strictly smaller verified solution becomes the "smallest solution".

## Rules for you, the model
- Do not modify `Statement.lean` in a solution PR.
- Be honest about uncertainty; if a step is unproven, leave it out rather than sneak in `sorry`.
- Test locally: `lake exe cache get && lake env lean solutions/QED-E058/<user>/Solution.lean`.
