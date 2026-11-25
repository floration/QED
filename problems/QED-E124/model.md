# QED-E124 — Separating words below the cube-root barrier

You are an AI model helping someone attack this open problem. Read all of this before working.

## The problem
Extended set · Grade B · QED Curated · Logic & computability

**Plain words:** Given two different binary words of the same length n, how small a deterministic finite automaton (DFA) is needed to accept one and reject the other? The best known upper bound is about n^{1/3} states and the best lower bound is only about log n. Prove that O(n^c) states always suffice for some exponent c < 1/3.

**Math:** For distinct $u,v\in\{0,1\}^n$ let $\mathrm{sep}(u,v)$ be the least number of states of a DFA over $\{0,1\}$ that accepts exactly one of $u,v$, and let $S(n)=\max\{\mathrm{sep}(u,v):u\ne v,\ |u|=|v|=n\}$. Prove that there exist $c<1/3$ and $C>0$ with $S(n)\le C\,n^{c}$ for all $n\ge2$. (Known: $\Omega(\log n)\le S(n)\le O(n^{1/3}\log^{7}n)$; the conjectured truth is $S(n)=O(\log n)$.)

**Credit:** Goralčík and Koubek (1986) posed the problem; Robson (1989); Chase (2021).

**Rests on recent unrefereed work. Check these premises first:**
- The withdrawn 2025 O(log^2 n) claim; confirm no revived version.
- The 2026 refinement (2609.08191) and 'Further remarks' (2608.30928) are unrefereed but do not affect the target.

**References:**
- https://arxiv.org/abs/2007.12097
- https://arxiv.org/pdf/2609.08191
- https://arxiv.org/pdf/2608.30928
- https://arxiv.org/pdf/2608.28385
- https://pdf.arxiv.org/abs/2503.23184
- https://arxiv.org/pdf/1103.4513

Difficulty estimate: 4.5/10 (calibrated: Collatz ≈ 5.5, twin primes ≈ 5.0). It is believed open; do not assume a quick answer exists, and say so plainly if you cannot make progress. Never present a heuristic, numerical evidence, or a partial result as a solution.

## What counts as an answer
Either a proof of `OpenProblems.QEDE124.Claim` or a proof of `¬ OpenProblems.QEDE124.Claim` (a disproof), in Lean 4 + Mathlib, using the exact statement in `problems/QED-E124/Statement.lean`. Read its "Formalization notes" first. If that file still says `def Claim : Prop := sorry`, the problem must first be formalized (see CONTRIBUTING.md); a faithful formalization is itself a welcome contribution.

If you think the Lean statement does not match the informal problem (it is trivially true or false, or it says something else), report that in an issue instead of exploiting it: such solutions are not credited.

## How to submit
0. First time? Solve a test problem (QED-Q1, the 2-line one, at minimum) and submit it, to confirm your Lean setup and the submission pipeline work before spending effort here. Skip this step if this IS a test problem.
1. Claim it (optional but encouraged): open an issue titled `Claim QED-E124` at https://github.com/floration/qed/issues/new?template=claim.yml. Comment on it at least once a week or the claim lapses.
2. Add `solutions/QED-E124/<github-username>/Solution.lean`:
```lean
import Mathlib
-- do NOT redefine Claim: CI prepends problems/QED-E124/Statement.lean to your file
theorem solution : OpenProblems.QEDE124.Claim := by   -- or ¬ OpenProblems.QEDE124.Claim
  ...
```
   Large proofs may add more `.lean` files (subfolders allowed) next to Solution.lean; CI concatenates them in path order before Solution.lean. Don't import them.
3. Add `solutions/QED-E124/<github-username>/meta.json`: `{"model": "<AI model used, or none>", "kind": "proof" | "disproof"}`. Optionally a `README.md` explaining the idea.
4. Open a pull request. CI checks: it compiles, no `sorry`/`admit`/new `axiom`/`set_option` tricks, and `#print axioms solution` shows only `propext`, `Classical.choice`, `Quot.sound`.

## Scoring
Size = number of non-blank, non-comment lines of `Solution.lean` excluding `import` lines (helper lemmas count). First verified solution is credited permanently; any later, strictly smaller verified solution becomes the "smallest solution".

## Rules for you, the model
- Do not modify `Statement.lean` in a solution PR.
- Be honest about uncertainty; if a step is unproven, leave it out rather than sneak in `sorry`.
- Test locally: `lake exe cache get && lake env lean solutions/QED-E124/<user>/Solution.lean`.
