# QED-E199 — Are VT codes optimal single-deletion-correcting codes for every length?

You are an AI model helping someone attack this open problem. Read all of this before working.

## The problem
Extended set · Grade A · QED Curated · Coding & information theory

**Plain words:** A set of binary strings of length n corrects one deletion if no two of its strings can become the same string when each loses one symbol. The Varshamov-Tenengolts code VT_0(n), the strings whose position-weighted sum of 1s is divisible by n+1, is such a code, with about 2^n/(n+1) words. Is VT_0(n) a largest single-deletion-correcting code for every length n?

**Math:** Let $D(n)=\max\{|C|: C\subseteq\{0,1\}^n,\ \mathcal D_1(x)\cap\mathcal D_1(y)=\emptyset\ \forall x\ne y\in C\}$, where $\mathcal D_1(x)$ is the set of length-$(n-1)$ subsequences of $x$. Let $VT_0(n)=\{x\in\{0,1\}^n:\sum_{i=1}^n i x_i\equiv0\pmod{n+1}\}$, so $|VT_0(n)|=\frac{1}{2(n+1)}\sum_{d\mid n+1,\ d\text{ odd}}\varphi(d)\,2^{(n+1)/d}$. Decide whether $D(n)=|VT_0(n)|$ for all $n\ge1$.

**Credit:** Varshamov-Tenengolts (1965), Levenshtein; optimality question recorded by Sloane (2002)

**Rests on recent unrefereed work. Check these premises first:**
- Could be false for some larger n (only n<=11 verified); posed as prove-or-disprove
- Object named after people (VT codes) but the question is not a person-named conjecture
- n=11 verification (arXiv:2309.14736) may be unrefereed

**References:**
- https://arxiv.org/abs/2309.14736
- https://www.mdpi.com/1099-4300/21/12/1202
- https://arxiv.org/abs/2504.00613
- https://arxiv.org/abs/math/0207197
- https://arxiv.org/pdf/2602.08952

Difficulty estimate: 6.5/10 (anchored scale: 1 ≈ Erdős–Ginzburg–Ziv, 2.5 ≈ the sensitivity conjecture, 5 ≈ bounded prime gaps, 7.5 ≈ the Riemann Hypothesis, 10 ≈ P vs NP). It is believed open; do not assume a quick answer exists, and say so plainly if you cannot make progress. Never present a heuristic, numerical evidence, or a partial result as a solution.

## What counts as an answer
Either a proof of `OpenProblems.QEDE199.Claim` or a proof of `¬ OpenProblems.QEDE199.Claim` (a disproof), in Lean 4 + Mathlib, using the exact statement in `problems/QED-E199/Statement.lean`. Read its "Formalization notes" first. If that file still says `def Claim : Prop := sorry`, the problem must first be formalized (see CONTRIBUTING.md); a faithful formalization is itself a welcome contribution.

If you think the Lean statement does not match the informal problem (it is trivially true or false, or it says something else), report that in an issue instead of exploiting it: such solutions are not credited.

## How to submit
0. First time? Solve a test problem (QED-Q1, the 2-line one, at minimum) and submit it, to confirm your Lean setup and the submission pipeline work before spending effort here. Skip this step if this IS a test problem.
1. Claim it (optional but encouraged): open an issue titled `Claim QED-E199` at https://github.com/floration/qed/issues/new?template=claim.yml. Comment on it at least once a week or the claim lapses.
2. Add `solutions/QED-E199/<github-username>/Solution.lean`:
```lean
import Mathlib
-- do NOT redefine Claim: CI prepends problems/QED-E199/Statement.lean to your file
theorem solution : OpenProblems.QEDE199.Claim := by   -- or ¬ OpenProblems.QEDE199.Claim
  ...
```
   Large proofs may add more `.lean` files (subfolders allowed) next to Solution.lean; CI concatenates them in path order before Solution.lean. Don't import them.
3. Add `solutions/QED-E199/<github-username>/meta.json`: `{"model": "<AI model used, or none>", "kind": "proof" | "disproof"}`. Optionally a `README.md` explaining the idea.
4. Open a pull request. CI checks: it compiles, no `sorry`/`admit`/new `axiom`/`set_option` tricks, and `#print axioms solution` shows only `propext`, `Classical.choice`, `Quot.sound`.

## Scoring
Size = number of non-blank, non-comment lines of `Solution.lean` excluding `import` lines (helper lemmas count). First verified solution is credited permanently; any later, strictly smaller verified solution becomes the "smallest solution".

## Rules for you, the model
- Do not modify `Statement.lean` in a solution PR.
- Be honest about uncertainty; if a step is unproven, leave it out rather than sneak in `sorry`.
- Test locally: `lake exe cache get && lake env lean solutions/QED-E199/<user>/Solution.lean`.
