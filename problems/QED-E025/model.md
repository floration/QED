# QED-E025 — Turán density of K_4^- (the 2/7 conjecture)

You are an AI model helping someone attack this open problem. Read all of this before working.

## The problem
Extended set · Grade B- · QED Curated · Combinatorics

**Plain words:** Take a collection of triples from n points such that no 4 points carry 3 or more of their 4 triples. How large a fraction of all triples can you take? A recursive construction gets 2/7 and computer-aided proofs show you can't beat about 0.2868. Prove 2/7 is right, or beat it.

**Math:** Let $K_4^-$ be the $3$-graph on 4 vertices with 3 edges and $\pi(K_4^-)=\lim_n \mathrm{ex}(n,K_4^-)/\binom n3$. Known: $2/7\le \pi(K_4^-)\le 0.2868$. Prove $\pi(K_4^-)=2/7$ (Frankl-Furedi/Mubayi conjecture), or improve the upper bound.

**Reviewer note:** Known: Lower 2/7: Frankl-Furedi (1984) recursive construction. Upper: Baber-Talbot about 0.2871; Falgas-Ravry-Vaughan, 'Applications of the semi-definite method to the Turán density problem for 3-graphs', Combin. Probab. Comput. 22 (2013): about 0.2868. The density is stated as still unknown in Falgas-Ravry-Pikhurko-Vaughan-Volec, J. London Math. Soc. (2023). The codegree threshold of K_4^- is solved (arXiv:2112.09396).

**Credit:** Frankl-Furedi; Mubayi; Falgas-Ravry-Vaughan.

**Rests on recent unrefereed work. Check these premises first:**
- Fairly well-known conjecture
- Upper bound quoted to 4 decimals (0.28689 in Falgas-Ravry-Vaughan)

**References:**
- https://opikhurko.warwick.ac.uk/E/FalgasravryPikhurkoVaughanVolec23jlms.pdf
- https://arxiv.org/abs/1110.1623
- https://arxiv.org/abs/2112.09396

Difficulty estimate: 5.0/10 (calibrated: Collatz ≈ 5.5, twin primes ≈ 5.0). It is believed open; do not assume a quick answer exists, and say so plainly if you cannot make progress. Never present a heuristic, numerical evidence, or a partial result as a solution.

## What counts as an answer
Either a proof of `OpenProblems.QEDE025.Claim` or a proof of `¬ OpenProblems.QEDE025.Claim` (a disproof), in Lean 4 + Mathlib, using the exact statement in `problems/QED-E025/Statement.lean`. Read its "Formalization notes" first. If that file still says `def Claim : Prop := sorry`, the problem must first be formalized (see CONTRIBUTING.md); a faithful formalization is itself a welcome contribution.

If you think the Lean statement does not match the informal problem (it is trivially true or false, or it says something else), report that in an issue instead of exploiting it: such solutions are not credited.

## How to submit
1. Claim it (optional but encouraged): open an issue titled `Claim QED-E025` at https://github.com/floration/qed/issues/new?template=claim.yml. Comment on it at least once a week or the claim lapses.
2. Add `solutions/QED-E025/<github-username>/Solution.lean`:
```lean
import Mathlib
-- do NOT redefine Claim: CI prepends problems/QED-E025/Statement.lean to your file
theorem solution : OpenProblems.QEDE025.Claim := by   -- or ¬ OpenProblems.QEDE025.Claim
  ...
```
3. Add `solutions/QED-E025/<github-username>/meta.json`: `{"model": "<AI model used, or none>", "kind": "proof" | "disproof"}`. Optionally a `README.md` explaining the idea.
4. Open a pull request. CI checks: it compiles, no `sorry`/`admit`/new `axiom`/`set_option` tricks, and `#print axioms solution` shows only `propext`, `Classical.choice`, `Quot.sound`.

## Scoring
Size = number of non-blank, non-comment lines of `Solution.lean` excluding `import` lines (helper lemmas count). First verified solution is credited permanently; any later, strictly smaller verified solution becomes the "smallest solution".

## Rules for you, the model
- Do not modify `Statement.lean` in a solution PR.
- Be honest about uncertainty; if a step is unproven, leave it out rather than sneak in `sorry`.
- Test locally: `lake exe cache get && lake env lean solutions/QED-E025/<user>/Solution.lean`.
