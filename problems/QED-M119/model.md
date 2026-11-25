# QED-M119 — The 3k−4 conjecture modulo a prime

You are an AI model helping someone attack this open problem. Read all of this before working.

## The problem
Main set · Grade B · QED Curated · Combinatorics

**Plain words:** Over the integers, Freiman's 3k−4 theorem says that if a finite set A has a sumset A+A with at most 3|A|−4 elements, then A lies in an arithmetic progression with only |A+A|−|A|+1 terms. Modulo a prime p the same should hold as long as A+A does not come too close to filling Z/pZ. It is known for tiny sets (|A| below roughly p/10^215) and, for larger sets, only when |A+A| is well below 3|A|. Prove the full statement.

**Math:** Let $p$ be prime and $A\subseteq\mathbb Z/p\mathbb Z$ with $A+A\neq\mathbb Z/p\mathbb Z$. Write $|A+A|=2|A|+r$. Prove that if $|A+A|\le\min\{3|A|-4,\;p-r-4\}$, then $A$ is contained in an arithmetic progression $\{a,a+d,\dots,a+(L-1)d\}$ with $L\le |A|+r+1=|A+A|-|A|+1$. (This states only the first conclusion of the full conjecture, arXiv:1909.07967 Conj. 1.2; the companion statement that $2A$ contains an arithmetic progression with the same difference and at least $2|A|-1$ terms is omitted.)

**Credit:** Problem line from Freiman's 3k−4 theorem over Z. The mod-p conjecture appears in work of Freiman, Rödseth, Serra–Zémor, Candela–Serra–Spiegel, Lev–Serra and Grynkiewicz.

**Rests on recent unrefereed work. Check these premises first:**
- The name contains 'Freiman' only through 'Freiman's 3k−4 theorem' over Z. The mod-p statement is usually called 'the 3k−4 conjecture', which is not person-named.
- A sparse-range improvement beyond 2.7652 may exist in a 2024–26 preprint not surfaced by search.

**References:**
- https://arxiv.org/abs/math/0403338
- https://www.combinatorics.org/ojs/index.php/eljc/article/view/v30i2p48
- https://arxiv.org/abs/1805.12374
- https://arxiv.org/abs/1909.07967
- https://arxiv.org/abs/2402.15028
- https://arxiv.org/abs/0804.0935

Difficulty estimate: 4.5/10 (calibrated: Collatz ≈ 5.5, twin primes ≈ 5.0). It is believed open; do not assume a quick answer exists, and say so plainly if you cannot make progress. Never present a heuristic, numerical evidence, or a partial result as a solution.

## What counts as an answer
Either a proof of `OpenProblems.QEDM119.Claim` or a proof of `¬ OpenProblems.QEDM119.Claim` (a disproof), in Lean 4 + Mathlib, using the exact statement in `problems/QED-M119/Statement.lean`. Read its "Formalization notes" first. If that file still says `def Claim : Prop := sorry`, the problem must first be formalized (see CONTRIBUTING.md); a faithful formalization is itself a welcome contribution.

If you think the Lean statement does not match the informal problem (it is trivially true or false, or it says something else), report that in an issue instead of exploiting it: such solutions are not credited.

## How to submit
0. First time? Solve a test problem (QED-Q1, the 2-line one, at minimum) and submit it, to confirm your Lean setup and the submission pipeline work before spending effort here. Skip this step if this IS a test problem.
1. Claim it (optional but encouraged): open an issue titled `Claim QED-M119` at https://github.com/floration/qed/issues/new?template=claim.yml. Comment on it at least once a week or the claim lapses.
2. Add `solutions/QED-M119/<github-username>/Solution.lean`:
```lean
import Mathlib
-- do NOT redefine Claim: CI prepends problems/QED-M119/Statement.lean to your file
theorem solution : OpenProblems.QEDM119.Claim := by   -- or ¬ OpenProblems.QEDM119.Claim
  ...
```
   Large proofs may add more `.lean` files (subfolders allowed) next to Solution.lean; CI concatenates them in path order before Solution.lean. Don't import them.
3. Add `solutions/QED-M119/<github-username>/meta.json`: `{"model": "<AI model used, or none>", "kind": "proof" | "disproof"}`. Optionally a `README.md` explaining the idea.
4. Open a pull request. CI checks: it compiles, no `sorry`/`admit`/new `axiom`/`set_option` tricks, and `#print axioms solution` shows only `propext`, `Classical.choice`, `Quot.sound`.

## Scoring
Size = number of non-blank, non-comment lines of `Solution.lean` excluding `import` lines (helper lemmas count). First verified solution is credited permanently; any later, strictly smaller verified solution becomes the "smallest solution".

## Rules for you, the model
- Do not modify `Statement.lean` in a solution PR.
- Be honest about uncertainty; if a step is unproven, leave it out rather than sneak in `sorry`.
- Test locally: `lake exe cache get && lake env lean solutions/QED-M119/<user>/Solution.lean`.
