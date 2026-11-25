# QED-E210 — Thue-Morse along fourth powers

You are an AI model helping someone attack this open problem. Read all of this before working.

## The problem
Extended set · Grade B · QED Extension · Number theory

**Plain words:** Let s(m) be the number of 1s in the binary expansion of m. It is known that s(n), s(n^2) and (since 2023) s(n^3) are even for asymptotically half of all n. Prove the same for fourth powers: s(n^4) is even for asymptotically half of all n.

**Math:** Let $s_2(m)$ be the binary digit sum. Prove $\lim_{N\to\infty}\frac1N\#\{0\le n<N:\ s_2(n^4)\equiv0\pmod 2\}=\tfrac12$, equivalently $\sum_{n<N}(-1)^{s_2(n^4)}=o(N)$. (Natural strengthening: the same for $n^k$ for every $k\ge4$.)

**Credit:** A. O. Gelfond (1968) posed the general polynomial problem; degree 2 Mauduit-Rivat, degree 3 Spiegelhofer.

**Rests on recent unrefereed work. Check these premises first:**
- Cube case (arXiv:2308.09498) is a preprint as of my check; acceptance status unverified
- Scorer may regard degree 4 as a parameter choice; it is the first open monomial case, and the general k>=4 version is given as strengthening

**References:**
- https://arxiv.org/abs/2308.09498
- https://www.unileoben.ac.at/fileadmin/shares/mathstat/personal/spiegelhofer/files/slides/2024_02_29_Spiegelhofer.pdf
- https://arxiv.org/abs/1110.4830

Difficulty estimate: 5.5/10 (anchored scale: 1 ≈ Erdős–Ginzburg–Ziv, 2.5 ≈ the sensitivity conjecture, 5 ≈ bounded prime gaps, 7.5 ≈ the Riemann Hypothesis, 10 ≈ P vs NP). It is believed open; do not assume a quick answer exists, and say so plainly if you cannot make progress. Never present a heuristic, numerical evidence, or a partial result as a solution.

## What counts as an answer
Either a proof of `OpenProblems.QEDE210.Claim` or a proof of `¬ OpenProblems.QEDE210.Claim` (a disproof), in Lean 4 + Mathlib, using the exact statement in `problems/QED-E210/Statement.lean`. Read its "Formalization notes" first. If that file still says `def Claim : Prop := sorry`, the problem must first be formalized (see CONTRIBUTING.md); a faithful formalization is itself a welcome contribution.

If you think the Lean statement does not match the informal problem (it is trivially true or false, or it says something else), report that in an issue instead of exploiting it: such solutions are not credited.

## How to submit
0. First time? Solve a test problem (QED-Q1, the 2-line one, at minimum) and submit it, to confirm your Lean setup and the submission pipeline work before spending effort here. Skip this step if this IS a test problem.
1. Claim it (optional but encouraged): open an issue titled `Claim QED-E210` at https://github.com/floration/qed/issues/new?template=claim.yml. Comment on it at least once a week or the claim lapses.
2. Add `solutions/QED-E210/<github-username>/Solution.lean`:
```lean
import Mathlib
-- do NOT redefine Claim: CI prepends problems/QED-E210/Statement.lean to your file
theorem solution : OpenProblems.QEDE210.Claim := by   -- or ¬ OpenProblems.QEDE210.Claim
  ...
```
   Large proofs may add more `.lean` files (subfolders allowed) next to Solution.lean; CI concatenates them in path order before Solution.lean. Don't import them.
3. Add `solutions/QED-E210/<github-username>/meta.json`: `{"model": "<AI model used, or none>", "kind": "proof" | "disproof"}`. Optionally a `README.md` explaining the idea.
4. Open a pull request. CI checks: it compiles, no `sorry`/`admit`/new `axiom`/`set_option` tricks, and `#print axioms solution` shows only `propext`, `Classical.choice`, `Quot.sound`.

## Scoring
Size = number of non-blank, non-comment lines of `Solution.lean` excluding `import` lines (helper lemmas count). First verified solution is credited permanently; any later, strictly smaller verified solution becomes the "smallest solution".

## Rules for you, the model
- Do not modify `Statement.lean` in a solution PR.
- Be honest about uncertainty; if a step is unproven, leave it out rather than sneak in `sorry`.
- Test locally: `lake exe cache get && lake env lean solutions/QED-E210/<user>/Solution.lean`.
