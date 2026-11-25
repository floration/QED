# N-667 — Breaking the log k barrier for 3-petal sunflowers

You are an AI model helping someone attack this open problem. Read all of this before working.

## The problem
Grade A · QED Curated · Combinatorics

**Plain words:** Show every family of more than (o(log k))^k sets of size k (e.g. (log k)^{(1-c)k} or (log log k)^{O(k)}) contains a sunflower with 3 petals.

**Math:** Let f(k,3) be the least m such that every family of m distinct k-element sets contains a 3-petal sunflower. Known: f(k,3) <= (C log k)^k (ALWZ, Rao, Bell-Chueluecha-Warnke). Prove f(k,3) <= (eps(k) log k)^k for some eps(k)->0, e.g. f(k,3) <= (log k)^{(1-c)k} for a constant c>0.

**Credit:** Erdős-Rado 1960 (sunflower conjecture); log k barrier discussed in Alweiss-Lovett-Wu-Zhang, Annals 2021, and Rao, The story of sunflowers, JLMS 2026 (arXiv:2509.14790)

**References:**
- Alweiss, Lovett, Wu, Zhang, Improved bounds for the sunflower lemma, Annals of Math 2021
- The Story of Sunflowers (survey), arXiv:2509.14790
- Bell, Chueluecha, Warnke, Note on sunflowers, Discrete Math 2021
- Alweiss-Lovett-Wu-Zhang, Annals 2021
- Rao, The story of sunflowers, JLMS 2026 / arXiv:2509.14790
- Lovett, PCMI lecture notes: from sunflowers to thresholds
- arXiv:2606.02667

Difficulty estimate: 4.5/10 (calibrated: Collatz ≈ 5.5, twin primes ≈ 5.0). It is believed open; do not assume a quick answer exists, and say so plainly if you cannot make progress. Never present a heuristic, numerical evidence, or a partial result as a solution.

## What counts as an answer
Either a proof of `OpenProblems.N667.Claim` or a proof of `¬ OpenProblems.N667.Claim` (a disproof), in Lean 4 + Mathlib, using the exact statement in `problems/N-667/Statement.lean`. Read its "Formalization notes" first. If that file still says `def Claim : Prop := sorry`, the problem must first be formalized (see CONTRIBUTING.md); a faithful formalization is itself a welcome contribution.

If you think the Lean statement does not match the informal problem (it is trivially true or false, or it says something else), report that in an issue instead of exploiting it: such solutions are not credited.

## How to submit
1. Claim it (optional but encouraged): open an issue titled `Claim N-667` at https://github.com/floration/qed/issues/new?template=claim.yml. Comment on it at least once a week or the claim lapses.
2. Add `solutions/N-667/<github-username>/Solution.lean`:
```lean
import Mathlib
-- do NOT redefine Claim: CI prepends problems/N-667/Statement.lean to your file
theorem solution : OpenProblems.N667.Claim := by   -- or ¬ OpenProblems.N667.Claim
  ...
```
3. Add `solutions/N-667/<github-username>/meta.json`: `{"model": "<AI model used, or none>", "kind": "proof" | "disproof"}`. Optionally a `README.md` explaining the idea.
4. Open a pull request. CI checks: it compiles, no `sorry`/`admit`/new `axiom`/`set_option` tricks, and `#print axioms solution` shows only `propext`, `Classical.choice`, `Quot.sound`.

## Scoring
Size = number of non-blank, non-comment lines of `Solution.lean` excluding `import` lines (helper lemmas count). First verified solution is credited permanently; any later, strictly smaller verified solution becomes the "smallest solution".

## Rules for you, the model
- Do not modify `Statement.lean` in a solution PR.
- Be honest about uncertainty; if a step is unproven, leave it out rather than sneak in `sorry`.
- Test locally: `lake exe cache get && lake env lean solutions/N-667/<user>/Solution.lean`.
