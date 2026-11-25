# QED-M129 — Modular isomorphism problem for odd primes

You are an AI model helping someone attack this open problem. Read all of this before working.

## The problem
Main set · Grade A · QED Curated · Algebra

**Plain words:** For a finite p-group G, the group algebra F_p G remembers G only through linear combinations of its elements. Can two non-isomorphic p-groups have isomorphic group algebras over F_p? For p = 2 the answer is yes (groups of order 512, found in 2021). For every odd prime p the question is open: find such a pair, or prove the group algebra determines the group.

**Math:** Let $p$ be an odd prime. Decide whether there exist finite $p$-groups $G\not\cong H$ with $\mathbb F_pG\cong\mathbb F_pH$ as $\mathbb F_p$-algebras. Board claim (either direction accepted): exhibit such $p,G,H$, or prove that for every odd prime $p$ and all finite $p$-groups $G,H$, $\mathbb F_pG\cong\mathbb F_pH\Rightarrow G\cong H$.

**Credit:** Classical modular isomorphism problem; odd-p case posed in Margolis's survey (Jahresber. DMV 2022) after García-Lucas–Margolis–del Río

**Rests on recent unrefereed work. Check these premises first:**
- Named 'modular isomorphism problem' (not a person name) — fine
- Recent restrictive results are 2026 preprints (arXiv:2610.40868) — not needed for the statement

**References:**
- https://arxiv.org/abs/2202.11412
- https://arxiv.org/abs/2406.01810
- https://arxiv.org/pdf/2610.06909
- https://arxiv.org/pdf/2610.40868

Difficulty estimate: 6.5/10 (anchored scale: 1 ≈ Erdős–Ginzburg–Ziv, 2.5 ≈ the sensitivity conjecture, 5 ≈ bounded prime gaps, 7.5 ≈ the Riemann Hypothesis, 10 ≈ P vs NP). It is believed open; do not assume a quick answer exists, and say so plainly if you cannot make progress. Never present a heuristic, numerical evidence, or a partial result as a solution.

## What counts as an answer
Either a proof of `OpenProblems.QEDM129.Claim` or a proof of `¬ OpenProblems.QEDM129.Claim` (a disproof), in Lean 4 + Mathlib, using the exact statement in `problems/QED-M129/Statement.lean`. Read its "Formalization notes" first. If that file still says `def Claim : Prop := sorry`, the problem must first be formalized (see CONTRIBUTING.md); a faithful formalization is itself a welcome contribution.

If you think the Lean statement does not match the informal problem (it is trivially true or false, or it says something else), report that in an issue instead of exploiting it: such solutions are not credited.

## How to submit
0. First time? Solve a test problem (QED-Q1, the 2-line one, at minimum) and submit it, to confirm your Lean setup and the submission pipeline work before spending effort here. Skip this step if this IS a test problem.
1. Claim it (optional but encouraged): open an issue titled `Claim QED-M129` at https://github.com/floration/qed/issues/new?template=claim.yml. Comment on it at least once a week or the claim lapses.
2. Add `solutions/QED-M129/<github-username>/Solution.lean`:
```lean
import Mathlib
-- do NOT redefine Claim: CI prepends problems/QED-M129/Statement.lean to your file
theorem solution : OpenProblems.QEDM129.Claim := by   -- or ¬ OpenProblems.QEDM129.Claim
  ...
```
   Large proofs may add more `.lean` files (subfolders allowed) next to Solution.lean; CI concatenates them in path order before Solution.lean. Don't import them.
3. Add `solutions/QED-M129/<github-username>/meta.json`: `{"model": "<AI model used, or none>", "kind": "proof" | "disproof"}`. Optionally a `README.md` explaining the idea.
4. Open a pull request. CI checks: it compiles, no `sorry`/`admit`/new `axiom`/`set_option` tricks, and `#print axioms solution` shows only `propext`, `Classical.choice`, `Quot.sound`.

## Scoring
Size = number of non-blank, non-comment lines of `Solution.lean` excluding `import` lines (helper lemmas count). First verified solution is credited permanently; any later, strictly smaller verified solution becomes the "smallest solution".

## Rules for you, the model
- Do not modify `Statement.lean` in a solution PR.
- Be honest about uncertainty; if a step is unproven, leave it out rather than sneak in `sorry`.
- Test locally: `lake exe cache get && lake env lean solutions/QED-M129/<user>/Solution.lean`.
