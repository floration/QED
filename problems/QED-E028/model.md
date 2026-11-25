# QED-E028 — Strong edge colouring with maximum degree 4: 20 or 21 colours?

You are an AI model helping someone attack this open problem. Read all of this before working.

## The problem
Extended set · Grade B- · QED Curated · Graph theory

**Plain words:** A strong edge colouring gives edges colours so that any two edges that touch, or are joined by a third edge, get different colours. Erdős and Nešetřil conjectured that graphs with maximum degree 4 need at most 20 colours; it is proved that 21 suffice. Close the one-colour gap.

**Math:** Prove that every graph $G$ with $\Delta(G)\le4$ has strong chromatic index $\chi'_s(G)\le20$ (Erdos-Nesetril bound $\tfrac54\Delta^2$), or find a graph with $\Delta\le4$ and $\chi'_s=21$.

**Reviewer note:** Known: chi'_s <= 22: Cranston (2006, arXiv:math/0601623). chi'_s <= 21: Huang-Santana-Yu, Electron. J. Combin. 25(3) (2018) P3.31 (arXiv:1806.07012). Lower bound 20 is attained by the blow-up of C_5 (each vertex replaced by 2 vertices). Related: packing edge-colouring results for Delta <= 4 (Involve 18(2), 2025) do not give 20. Delta=3 is settled (10; Andersen, Horak-He-Trotter).

**Credit:** Erdos-Nesetril conjecture; Cranston; Huang-Santana-Yu.

**Rests on recent unrefereed work. Check these premises first:**
- A 2026 improvement to 20 might exist that the searches missed

**References:**
- https://www.combinatorics.org/ojs/index.php/eljc/article/view/v25i3p31
- https://arxiv.org/abs/1806.07012
- https://arxiv.org/abs/math/0601623
- https://msp.org/involve/2025/18-2/p04.xhtml

Difficulty estimate: 4.0/10 (calibrated: Collatz ≈ 5.5, twin primes ≈ 5.0). It is believed open; do not assume a quick answer exists, and say so plainly if you cannot make progress. Never present a heuristic, numerical evidence, or a partial result as a solution.

## What counts as an answer
Either a proof of `OpenProblems.QEDE028.Claim` or a proof of `¬ OpenProblems.QEDE028.Claim` (a disproof), in Lean 4 + Mathlib, using the exact statement in `problems/QED-E028/Statement.lean`. Read its "Formalization notes" first. If that file still says `def Claim : Prop := sorry`, the problem must first be formalized (see CONTRIBUTING.md); a faithful formalization is itself a welcome contribution.

If you think the Lean statement does not match the informal problem (it is trivially true or false, or it says something else), report that in an issue instead of exploiting it: such solutions are not credited.

## How to submit
0. First time? Solve a test problem (QED-Q1, the 2-line one, at minimum) and submit it, to confirm your Lean setup and the submission pipeline work before spending effort here. Skip this step if this IS a test problem.
1. Claim it (optional but encouraged): open an issue titled `Claim QED-E028` at https://github.com/floration/qed/issues/new?template=claim.yml. Comment on it at least once a week or the claim lapses.
2. Add `solutions/QED-E028/<github-username>/Solution.lean`:
```lean
import Mathlib
-- do NOT redefine Claim: CI prepends problems/QED-E028/Statement.lean to your file
theorem solution : OpenProblems.QEDE028.Claim := by   -- or ¬ OpenProblems.QEDE028.Claim
  ...
```
3. Add `solutions/QED-E028/<github-username>/meta.json`: `{"model": "<AI model used, or none>", "kind": "proof" | "disproof"}`. Optionally a `README.md` explaining the idea.
4. Open a pull request. CI checks: it compiles, no `sorry`/`admit`/new `axiom`/`set_option` tricks, and `#print axioms solution` shows only `propext`, `Classical.choice`, `Quot.sound`.

## Scoring
Size = number of non-blank, non-comment lines of `Solution.lean` excluding `import` lines (helper lemmas count). First verified solution is credited permanently; any later, strictly smaller verified solution becomes the "smallest solution".

## Rules for you, the model
- Do not modify `Statement.lean` in a solution PR.
- Be honest about uncertainty; if a step is unproven, leave it out rather than sneak in `sorry`.
- Test locally: `lake exe cache get && lake env lean solutions/QED-E028/<user>/Solution.lean`.
