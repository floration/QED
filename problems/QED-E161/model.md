# QED-E161 — Super-exponential anticoncentration of the random ±1 permanent at zero

You are an AI model helping someone attack this open problem. Read all of this before working.

## The problem
Extended set · Grade A · QED Curated · Probability

**Plain words:** Fill an n by n matrix with independent random signs +1/-1 and compute its permanent (the determinant without the minus signs). The chance that the determinant is 0 is about 2^(-n), mostly because two rows or columns can be equal or opposite. The permanent has no such structural reason to vanish, and in 2025 its chance of being 0 was shown to be exponentially small. Is it super-exponentially small, that is, smaller than e^(-Cn) for every fixed C once n is large?

**Math:** Let $p_n=2^{-n^2}\,\#\{M\in\{\pm1\}^{n\times n}:\operatorname{per}M=0\}$, where $\operatorname{per}M=\sum_{\pi\in S_n}\prod_{i=1}^n M_{i\pi(i)}$. Prove or disprove: for every $C>0$ there is $N$ such that $p_n\le e^{-Cn}$ for all $n\ge N$ (equivalently $\tfrac1n\log p_n\to-\infty$, with $\log 0=-\infty$). Known: $p_n\le e^{-cn}$ for some absolute $c>0$.

**Credit:** Conjecture 6.12 in V. Vu's survey (arXiv:2005.02797); current bound Hunter-Kwan-Sauermann (arXiv:2509.22577).

**Rests on recent unrefereed work. Check these premises first:**
- Attributed to Vu ('as conjectured by Vu'); appears unnamed as 'Conjecture 6.12 (Permanent)' but the owner may count it as person-attributed
- Hunter-Kwan-Sauermann is a 2025 arXiv preprint (refereeing status unknown); the claim does not depend on it beyond context

**References:**
- https://arxiv.org/abs/2509.22577
- https://arxiv.org/pdf/2005.02797v1
- https://arxiv.org/abs/0804.2362
- https://arxiv.org/pdf/2608.26707
- https://arxiv.org/html/2603.15856v1

Difficulty estimate: 3.5/10 (calibrated: Collatz ≈ 5.5, twin primes ≈ 5.0). It is believed open; do not assume a quick answer exists, and say so plainly if you cannot make progress. Never present a heuristic, numerical evidence, or a partial result as a solution.

## What counts as an answer
Either a proof of `OpenProblems.QEDE161.Claim` or a proof of `¬ OpenProblems.QEDE161.Claim` (a disproof), in Lean 4 + Mathlib, using the exact statement in `problems/QED-E161/Statement.lean`. Read its "Formalization notes" first. If that file still says `def Claim : Prop := sorry`, the problem must first be formalized (see CONTRIBUTING.md); a faithful formalization is itself a welcome contribution.

If you think the Lean statement does not match the informal problem (it is trivially true or false, or it says something else), report that in an issue instead of exploiting it: such solutions are not credited.

## How to submit
0. First time? Solve a test problem (QED-Q1, the 2-line one, at minimum) and submit it, to confirm your Lean setup and the submission pipeline work before spending effort here. Skip this step if this IS a test problem.
1. Claim it (optional but encouraged): open an issue titled `Claim QED-E161` at https://github.com/floration/qed/issues/new?template=claim.yml. Comment on it at least once a week or the claim lapses.
2. Add `solutions/QED-E161/<github-username>/Solution.lean`:
```lean
import Mathlib
-- do NOT redefine Claim: CI prepends problems/QED-E161/Statement.lean to your file
theorem solution : OpenProblems.QEDE161.Claim := by   -- or ¬ OpenProblems.QEDE161.Claim
  ...
```
   Large proofs may add more `.lean` files (subfolders allowed) next to Solution.lean; CI concatenates them in path order before Solution.lean. Don't import them.
3. Add `solutions/QED-E161/<github-username>/meta.json`: `{"model": "<AI model used, or none>", "kind": "proof" | "disproof"}`. Optionally a `README.md` explaining the idea.
4. Open a pull request. CI checks: it compiles, no `sorry`/`admit`/new `axiom`/`set_option` tricks, and `#print axioms solution` shows only `propext`, `Classical.choice`, `Quot.sound`.

## Scoring
Size = number of non-blank, non-comment lines of `Solution.lean` excluding `import` lines (helper lemmas count). First verified solution is credited permanently; any later, strictly smaller verified solution becomes the "smallest solution".

## Rules for you, the model
- Do not modify `Statement.lean` in a solution PR.
- Be honest about uncertainty; if a step is unproven, leave it out rather than sneak in `sorry`.
- Test locally: `lake exe cache get && lake env lean solutions/QED-E161/<user>/Solution.lean`.
