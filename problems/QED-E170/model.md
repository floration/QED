# QED-E170 — Are lower Bruhat intervals in S_n rank-unimodal?

You are an AI model helping someone attack this open problem. Read all of this before working.

## The problem
Extended set · Grade B · QED Curated · Combinatorics

**Plain words:** In the Bruhat order on permutations, u <= w roughly means that u can be obtained from w by undoing inversions. For a permutation w, count the permutations below it with exactly k inversions, for k = 0, 1, ..., inv(w). Does this sequence always rise and then fall? Bjorner and Ekedahl proved that the first half never decreases, but the full statement is open.

**Math:** For $w\in S_n$ let $f_k(w)=\#\{u\in S_n:\ u\le w\text{ in Bruhat order},\ \mathrm{inv}(u)=k\}$ for $0\le k\le\mathrm{inv}(w)$, where $u\le w$ iff $\#\{a\le i:u(a)\ge j\}\le\#\{a\le i:w(a)\ge j\}$ for all $i,j\in[n]$. Claim: for every $n$ and every $w\in S_n$ there is $m$ with $f_0(w)\le\dots\le f_m(w)\ge f_{m+1}(w)\ge\dots\ge f_{\mathrm{inv}(w)}(w)$.

**Credit:** Question raised by A. Björner (with T. Ekedahl, 'On the shape of Bruhat intervals', Ann. Math. 2009; SLC 61 talk)

**Rests on recent unrefereed work. Check these premises first:**
- A known type-A result (for example from Gaetz–Gao or later work) could already settle it; the last search was blocked by the search budget.
- The question in Björner's talk is posed for general crystallographic groups. Restricting to S_n is natural but narrower.
- Log-concavity was observed only for n ≤ 8; do not promote it to the claim.

**References:**
- https://www.mat.univie.ac.at/~slc/wpapers/s61vortrag/bjoerner.pdf
- https://arxiv.org/abs/2311.17980
- https://arxiv.org/abs/2501.03037
- https://arxiv.org/abs/2608.13836
- https://arxiv.org/abs/2003.06710

Difficulty estimate: 6.0/10 (anchored scale: 1 ≈ Erdős–Ginzburg–Ziv, 2.5 ≈ the sensitivity conjecture, 5 ≈ bounded prime gaps, 7.5 ≈ the Riemann Hypothesis, 10 ≈ P vs NP). It is believed open; do not assume a quick answer exists, and say so plainly if you cannot make progress. Never present a heuristic, numerical evidence, or a partial result as a solution.

## What counts as an answer
Either a proof of `OpenProblems.QEDE170.Claim` or a proof of `¬ OpenProblems.QEDE170.Claim` (a disproof), in Lean 4 + Mathlib, using the exact statement in `problems/QED-E170/Statement.lean`. Read its "Formalization notes" first. If that file still says `def Claim : Prop := sorry`, the problem must first be formalized (see CONTRIBUTING.md); a faithful formalization is itself a welcome contribution.

If you think the Lean statement does not match the informal problem (it is trivially true or false, or it says something else), report that in an issue instead of exploiting it: such solutions are not credited.

## How to submit
0. First time? Solve a test problem (QED-Q1, the 2-line one, at minimum) and submit it, to confirm your Lean setup and the submission pipeline work before spending effort here. Skip this step if this IS a test problem.
1. Claim it (optional but encouraged): open an issue titled `Claim QED-E170` at https://github.com/floration/qed/issues/new?template=claim.yml. Comment on it at least once a week or the claim lapses.
2. Add `solutions/QED-E170/<github-username>/Solution.lean`:
```lean
import Mathlib
-- do NOT redefine Claim: CI prepends problems/QED-E170/Statement.lean to your file
theorem solution : OpenProblems.QEDE170.Claim := by   -- or ¬ OpenProblems.QEDE170.Claim
  ...
```
   Large proofs may add more `.lean` files (subfolders allowed) next to Solution.lean; CI concatenates them in path order before Solution.lean. Don't import them.
3. Add `solutions/QED-E170/<github-username>/meta.json`: `{"model": "<AI model used, or none>", "kind": "proof" | "disproof"}`. Optionally a `README.md` explaining the idea.
4. Open a pull request. CI checks: it compiles, no `sorry`/`admit`/new `axiom`/`set_option` tricks, and `#print axioms solution` shows only `propext`, `Classical.choice`, `Quot.sound`.

## Scoring
Size = number of non-blank, non-comment lines of `Solution.lean` excluding `import` lines (helper lemmas count). First verified solution is credited permanently; any later, strictly smaller verified solution becomes the "smallest solution".

## Rules for you, the model
- Do not modify `Statement.lean` in a solution PR.
- Be honest about uncertainty; if a step is unproven, leave it out rather than sneak in `sorry`.
- Test locally: `lake exe cache get && lake env lean solutions/QED-E170/<user>/Solution.lean`.
