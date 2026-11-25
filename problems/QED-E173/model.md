# QED-E173 — The Mertens function is unbounded on the square-root scale

You are an AI model helping someone attack this open problem. Read all of this before working.

## The problem
Extended set · Grade A · QED Curated · Number theory

**Plain words:** The Mertens function M(x) adds up the Möbius function μ(n) for n ≤ x. Mertens guessed |M(x)| < √x, which was disproved in 1985 without an explicit counterexample, and we now know M(x)/√x exceeds about 1.83 in absolute value infinitely often. Prove that M(x)/√x is unbounded. Now that RH is proved (Alpöge 2026), the easy route via a zero off the critical line is closed: unboundedness would follow from a multiple zero of ζ, or from Ingham's linear independence of the zero ordinates, and neither is known.

**Math:** Let $M(x)=\sum_{n\le x}\mu(n)$. Prove $\limsup_{x\to\infty}|M(x)|/\sqrt{x}=+\infty$; i.e. for every $C>0$ there is $x$ with $|M(x)|>C\sqrt x$.

**Credit:** Classical (Ingham 1942; Odlyzko–te Riele 1985); see Hurst 2018 for status.

**Rests on recent unrefereed work. Check these premises first:**
- Low novelty: well-known open problem
- RH is now a theorem (Alpöge, Nov 2026, Lean-certified), so the problem lives in the RH setting: boundedness of M(x)/√x would force all zeros to be simple and contradict linear independence of the ordinates (Ingham 1942), but proving unboundedness seems to need linear-independence-type information or a multiple zero; difficulty is high.

**References:**
- https://arxiv.org/pdf/1610.08551
- https://arxiv.org/pdf/2604.23517
- https://arxiv.org/abs/2511.14736
- https://arxiv.org/abs/2208.06141

Difficulty estimate: 8.0/10 (anchored scale: 1 ≈ Erdős–Ginzburg–Ziv, 2.5 ≈ the sensitivity conjecture, 5 ≈ bounded prime gaps, 7.5 ≈ the Riemann Hypothesis, 10 ≈ P vs NP). It is believed open; do not assume a quick answer exists, and say so plainly if you cannot make progress. Never present a heuristic, numerical evidence, or a partial result as a solution.

## What counts as an answer
Either a proof of `OpenProblems.QEDE173.Claim` or a proof of `¬ OpenProblems.QEDE173.Claim` (a disproof), in Lean 4 + Mathlib, using the exact statement in `problems/QED-E173/Statement.lean`. Read its "Formalization notes" first. If that file still says `def Claim : Prop := sorry`, the problem must first be formalized (see CONTRIBUTING.md); a faithful formalization is itself a welcome contribution.

If you think the Lean statement does not match the informal problem (it is trivially true or false, or it says something else), report that in an issue instead of exploiting it: such solutions are not credited.

## How to submit
0. First time? Solve a test problem (QED-Q1, the 2-line one, at minimum) and submit it, to confirm your Lean setup and the submission pipeline work before spending effort here. Skip this step if this IS a test problem.
1. Claim it (optional but encouraged): open an issue titled `Claim QED-E173` at https://github.com/floration/qed/issues/new?template=claim.yml. Comment on it at least once a week or the claim lapses.
2. Add `solutions/QED-E173/<github-username>/Solution.lean`:
```lean
import Mathlib
-- do NOT redefine Claim: CI prepends problems/QED-E173/Statement.lean to your file
theorem solution : OpenProblems.QEDE173.Claim := by   -- or ¬ OpenProblems.QEDE173.Claim
  ...
```
   Large proofs may add more `.lean` files (subfolders allowed) next to Solution.lean; CI concatenates them in path order before Solution.lean. Don't import them.
3. Add `solutions/QED-E173/<github-username>/meta.json`: `{"model": "<AI model used, or none>", "kind": "proof" | "disproof"}`. Optionally a `README.md` explaining the idea.
4. Open a pull request. CI checks: it compiles, no `sorry`/`admit`/new `axiom`/`set_option` tricks, and `#print axioms solution` shows only `propext`, `Classical.choice`, `Quot.sound`.

## Scoring
Size = number of non-blank, non-comment lines of `Solution.lean` excluding `import` lines (helper lemmas count). First verified solution is credited permanently; any later, strictly smaller verified solution becomes the "smallest solution".

## Rules for you, the model
- Do not modify `Statement.lean` in a solution PR.
- Be honest about uncertainty; if a step is unproven, leave it out rather than sneak in `sorry`.
- Test locally: `lake exe cache get && lake env lean solutions/QED-E173/<user>/Solution.lean`.
