# QED-E031 — An effective bound for the sum-free excess

You are an AI model helping someone attack this open problem. Read all of this before working.

## The problem
Extended set · Grade C · QED Extension · Combinatorics

**Plain words:** Every set of N nonzero integers contains a sum-free subset (no x+y=z inside it) of size a bit more than N/3; Bedert (2025) showed the excess grows at least like log log N. It is also known that you cannot always beat N/3 by more than o(N), but that proof gives no rate. Prove a quantitative version: some N-element sets have no sum-free subset larger than N/3 + N/(log N)^c.

**Math:** Let $S(N)=\min_{A\subset\mathbb Z\setminus\{0\},\,|A|=N}\max\{|B|:B\subseteq A\text{ sum-free}\}$. Known: $N/3+c\log\log N\le S(N)\le N/3+o(N)$, with the $o(N)$ ineffective. Prove that there is $c>0$ with $S(N)\le N/3+O\big(N/(\log N)^{c}\big)$. Any explicitly quantified $o(N)$ (e.g. $N/(\log\log N)^{c}$) would be partial progress.

**Reviewer note:** Known: Lower: Erdos (1965) $N/3$; Alon-Kleitman $(N+1)/3$; Bourgain $(N+2)/3$; Bedert, arXiv:2502.08624 (2025) $N/3+c\log\log N$. Upper: Eberhard-Green-Manners, Annals 180 (2014), arXiv:1301.4579: $N/3+o(N)$, ineffective.

**Credit:** Bedert (2025) remark; Eberhard-Green-Manners (2014).

**Rests on recent unrefereed work. Check these premises first:**
- EGM's argument might yield a very weak explicit rate on careful bookkeeping; the (log N)^{-c} target avoids this but may be much harder
- Truth could be N/3 + N^{1-c} or much smaller; no conjecture on the true rate

**References:**
- https://arxiv.org/abs/2502.08624
- https://arxiv.org/abs/1301.4579
- https://www.quantamagazine.org/graduate-student-solves-classic-problem-about-the-limits-of-addition-20250522/

Difficulty estimate: 5.0/10 (calibrated: Collatz ≈ 5.5, twin primes ≈ 5.0). It is believed open; do not assume a quick answer exists, and say so plainly if you cannot make progress. Never present a heuristic, numerical evidence, or a partial result as a solution.

## What counts as an answer
Either a proof of `OpenProblems.QEDE031.Claim` or a proof of `¬ OpenProblems.QEDE031.Claim` (a disproof), in Lean 4 + Mathlib, using the exact statement in `problems/QED-E031/Statement.lean`. Read its "Formalization notes" first. If that file still says `def Claim : Prop := sorry`, the problem must first be formalized (see CONTRIBUTING.md); a faithful formalization is itself a welcome contribution.

If you think the Lean statement does not match the informal problem (it is trivially true or false, or it says something else), report that in an issue instead of exploiting it: such solutions are not credited.

## How to submit
1. Claim it (optional but encouraged): open an issue titled `Claim QED-E031` at https://github.com/floration/qed/issues/new?template=claim.yml. Comment on it at least once a week or the claim lapses.
2. Add `solutions/QED-E031/<github-username>/Solution.lean`:
```lean
import Mathlib
-- do NOT redefine Claim: CI prepends problems/QED-E031/Statement.lean to your file
theorem solution : OpenProblems.QEDE031.Claim := by   -- or ¬ OpenProblems.QEDE031.Claim
  ...
```
   Large proofs may add more `.lean` files (subfolders allowed) next to Solution.lean; CI concatenates them in path order before Solution.lean. Don't import them.
3. Add `solutions/QED-E031/<github-username>/meta.json`: `{"model": "<AI model used, or none>", "kind": "proof" | "disproof"}`. Optionally a `README.md` explaining the idea.
4. Open a pull request. CI checks: it compiles, no `sorry`/`admit`/new `axiom`/`set_option` tricks, and `#print axioms solution` shows only `propext`, `Classical.choice`, `Quot.sound`.

## Scoring
Size = number of non-blank, non-comment lines of `Solution.lean` excluding `import` lines (helper lemmas count). First verified solution is credited permanently; any later, strictly smaller verified solution becomes the "smallest solution".

## Rules for you, the model
- Do not modify `Statement.lean` in a solution PR.
- Be honest about uncertainty; if a step is unproven, leave it out rather than sneak in `sorry`.
- Test locally: `lake exe cache get && lake env lean solutions/QED-E031/<user>/Solution.lean`.
