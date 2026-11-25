# QED-E145 — No perfect single-error-correcting code over a 6-letter alphabet

You are an AI model helping someone attack this open problem. Read all of this before working.

## The problem
Extended set · Grade A · QED Curated · Algebra

**Plain words:** A code of words of length n over a 6-letter alphabet is 1-perfect if every possible word is either a codeword or differs from exactly one codeword in exactly one position. Over alphabets whose size is a prime power, such codes (Hamming codes) exist in infinitely many lengths. Over 6 letters none is known for n≥2. Counting arguments and Lloyd's theorem leave only lengths 7, 19, 43, 97, 115, 259, ..., and only 7 and 19 have been ruled out. Prove that none exists.

**Math:** Let $H(n,6)=\{0,\dots,5\}^n$ with the Hamming distance $d$. Prove that for no $n\ge2$ is there $C\subseteq H(n,6)$ such that every $x\in H(n,6)$ has exactly one $c\in C$ with $d(x,c)\le1$. (Necessary conditions: $1+5n=2^a3^b$ and, by Lloyd's theorem, $6\mid 1+5n$, so $n\in\{7,19,43,97,115,259,\dots\}$. The cases $n=7$ (Golomb\u2013Posner) and $n=19$ (Heden\u2013Roos) are excluded.)

**Credit:** Folklore conjecture on perfect codes over non-prime-power alphabets; Golomb–Posner, Heden–Roos, Heden's survey

**Rests on recent unrefereed work. Check these premises first:**
- Exact list of excluded lengths for q=6 not fully verified (some other paper might exclude 43); does not affect the general claim
- Heden–Roos 2011 citation details from secondary source

**References:**
- https://arxiv.org/abs/2403.10992
- https://arxiv.org/abs/2405.03347
- https://arxiv.org/abs/2607.27555
- https://arxiv.org/abs/2008.13260

Difficulty estimate: 6.5/10 (calibrated: Collatz ≈ 5.5, twin primes ≈ 5.0). It is believed open; do not assume a quick answer exists, and say so plainly if you cannot make progress. Never present a heuristic, numerical evidence, or a partial result as a solution.

## What counts as an answer
Either a proof of `OpenProblems.QEDE145.Claim` or a proof of `¬ OpenProblems.QEDE145.Claim` (a disproof), in Lean 4 + Mathlib, using the exact statement in `problems/QED-E145/Statement.lean`. Read its "Formalization notes" first. If that file still says `def Claim : Prop := sorry`, the problem must first be formalized (see CONTRIBUTING.md); a faithful formalization is itself a welcome contribution.

If you think the Lean statement does not match the informal problem (it is trivially true or false, or it says something else), report that in an issue instead of exploiting it: such solutions are not credited.

## How to submit
0. First time? Solve a test problem (QED-Q1, the 2-line one, at minimum) and submit it, to confirm your Lean setup and the submission pipeline work before spending effort here. Skip this step if this IS a test problem.
1. Claim it (optional but encouraged): open an issue titled `Claim QED-E145` at https://github.com/floration/qed/issues/new?template=claim.yml. Comment on it at least once a week or the claim lapses.
2. Add `solutions/QED-E145/<github-username>/Solution.lean`:
```lean
import Mathlib
-- do NOT redefine Claim: CI prepends problems/QED-E145/Statement.lean to your file
theorem solution : OpenProblems.QEDE145.Claim := by   -- or ¬ OpenProblems.QEDE145.Claim
  ...
```
   Large proofs may add more `.lean` files (subfolders allowed) next to Solution.lean; CI concatenates them in path order before Solution.lean. Don't import them.
3. Add `solutions/QED-E145/<github-username>/meta.json`: `{"model": "<AI model used, or none>", "kind": "proof" | "disproof"}`. Optionally a `README.md` explaining the idea.
4. Open a pull request. CI checks: it compiles, no `sorry`/`admit`/new `axiom`/`set_option` tricks, and `#print axioms solution` shows only `propext`, `Classical.choice`, `Quot.sound`.

## Scoring
Size = number of non-blank, non-comment lines of `Solution.lean` excluding `import` lines (helper lemmas count). First verified solution is credited permanently; any later, strictly smaller verified solution becomes the "smallest solution".

## Rules for you, the model
- Do not modify `Statement.lean` in a solution PR.
- Be honest about uncertainty; if a step is unproven, leave it out rather than sneak in `sorry`.
- Test locally: `lake exe cache get && lake env lean solutions/QED-E145/<user>/Solution.lean`.
