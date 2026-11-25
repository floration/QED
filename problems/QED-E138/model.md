# QED-E138 — Infinitely many non-Wieferich primes

You are an AI model helping someone attack this open problem. Read all of this before working.

## The problem
Extended set · Grade B · QED Curated · Number theory

**Plain words:** By Fermat's little theorem, every odd prime p divides 2^(p−1)−1. Usually p^2 does not; the only known exceptions are 1093 and 3511, and there are none other below 2^64. Yet nobody can prove that the usual case happens infinitely often: are there infinitely many primes p with p^2 not dividing 2^(p−1)−1?

**Math:** Prove that the set $\{p\text{ prime}: 2^{p-1}\not\equiv 1 \pmod{p^2}\}$ is infinite.

**Credit:** Folklore; Silverman (1988) conditional proof; Guy UPINT A3.

**Rests on recent unrefereed work. Check these premises first:**
- Very well-known; novelty modest
- Must not be confused with the (also open) question of infinitely many Wieferich primes

**References:**
- https://en.wikipedia.org/wiki/Wieferich_prime
- https://arxiv.org/abs/1610.00488
- https://arxiv.org/abs/2508.08472
- https://arxiv.org/abs/2310.06809

Difficulty estimate: 8.0/10 (anchored scale: 1 ≈ Erdős–Ginzburg–Ziv, 2.5 ≈ the sensitivity conjecture, 5 ≈ bounded prime gaps, 7.5 ≈ the Riemann Hypothesis, 10 ≈ P vs NP). It is believed open; do not assume a quick answer exists, and say so plainly if you cannot make progress. Never present a heuristic, numerical evidence, or a partial result as a solution.

## What counts as an answer
Either a proof of `OpenProblems.QEDE138.Claim` or a proof of `¬ OpenProblems.QEDE138.Claim` (a disproof), in Lean 4 + Mathlib, using the exact statement in `problems/QED-E138/Statement.lean`. Read its "Formalization notes" first. If that file still says `def Claim : Prop := sorry`, the problem must first be formalized (see CONTRIBUTING.md); a faithful formalization is itself a welcome contribution.

If you think the Lean statement does not match the informal problem (it is trivially true or false, or it says something else), report that in an issue instead of exploiting it: such solutions are not credited.

## How to submit
0. First time? Solve a test problem (QED-Q1, the 2-line one, at minimum) and submit it, to confirm your Lean setup and the submission pipeline work before spending effort here. Skip this step if this IS a test problem.
1. Claim it (optional but encouraged): open an issue titled `Claim QED-E138` at https://github.com/floration/qed/issues/new?template=claim.yml. Comment on it at least once a week or the claim lapses.
2. Add `solutions/QED-E138/<github-username>/Solution.lean`:
```lean
import Mathlib
-- do NOT redefine Claim: CI prepends problems/QED-E138/Statement.lean to your file
theorem solution : OpenProblems.QEDE138.Claim := by   -- or ¬ OpenProblems.QEDE138.Claim
  ...
```
   Large proofs may add more `.lean` files (subfolders allowed) next to Solution.lean; CI concatenates them in path order before Solution.lean. Don't import them.
3. Add `solutions/QED-E138/<github-username>/meta.json`: `{"model": "<AI model used, or none>", "kind": "proof" | "disproof"}`. Optionally a `README.md` explaining the idea.
4. Open a pull request. CI checks: it compiles, no `sorry`/`admit`/new `axiom`/`set_option` tricks, and `#print axioms solution` shows only `propext`, `Classical.choice`, `Quot.sound`.

## Scoring
Size = number of non-blank, non-comment lines of `Solution.lean` excluding `import` lines (helper lemmas count). First verified solution is credited permanently; any later, strictly smaller verified solution becomes the "smallest solution".

## Rules for you, the model
- Do not modify `Statement.lean` in a solution PR.
- Be honest about uncertainty; if a step is unproven, leave it out rather than sneak in `sorry`.
- Test locally: `lake exe cache get && lake env lean solutions/QED-E138/<user>/Solution.lean`.
