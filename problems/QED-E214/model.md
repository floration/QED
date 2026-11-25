# QED-E214 — Cyclic perfect difference sets exist only for prime-power orders

You are an AI model helping someone attack this open problem. Read all of this before working.

## The problem
Extended set · Grade A · QED Curated · Combinatorics

**Plain words:** A perfect (planar) difference set of order n is a set of n+1 residues modulo n^2+n+1 such that every nonzero residue is the difference of exactly one ordered pair of its elements. Singer showed that one exists whenever n is a prime power, and each one gives a projective plane of order n with a cyclic symmetry. Prove that if such a set exists then n is a prime power.

**Math:** Let $n\ge2$. Suppose $D\subseteq\mathbb{Z}/(n^2+n+1)\mathbb{Z}$ has $|D|=n+1$ and that for every $x\neq0$ there is exactly one pair $(a,b)\in D\times D$ with $a-b=x$. Prove that $n$ is a prime power.

**Credit:** Folklore conjecture going back to Singer (1938) and Hall (1947); standard formulation in Jungnickel's and Beth–Jungnickel–Lenz's design theory texts; asymptotic version by S. Peluse.

**Rests on recent unrefereed work. Check these premises first:**
- Well-known problem (lower novelty); 'prime power conjecture' is not person-named but is related to famous projective-plane questions
- Must be kept distinct from pending J14 (projective plane of order 12)

**References:**
- https://www.combinatorics.org/ojs/index.php/eljc/article/view/v1i1r6
- https://arxiv.org/pdf/2003.04929
- https://personal.ntu.edu.sg/bernhard/Publications/pub/Singer.pdf
- https://api.emergentmind.com/open-problems/prime-power-conjecture-cyclic-projective-planes
- https://mathworld.wolfram.com/PlanarDifferenceSet.html

Difficulty estimate: 5.5/10 (calibrated: Collatz ≈ 5.5, twin primes ≈ 5.0). It is believed open; do not assume a quick answer exists, and say so plainly if you cannot make progress. Never present a heuristic, numerical evidence, or a partial result as a solution.

## What counts as an answer
Either a proof of `OpenProblems.QEDE214.Claim` or a proof of `¬ OpenProblems.QEDE214.Claim` (a disproof), in Lean 4 + Mathlib, using the exact statement in `problems/QED-E214/Statement.lean`. Read its "Formalization notes" first. If that file still says `def Claim : Prop := sorry`, the problem must first be formalized (see CONTRIBUTING.md); a faithful formalization is itself a welcome contribution.

If you think the Lean statement does not match the informal problem (it is trivially true or false, or it says something else), report that in an issue instead of exploiting it: such solutions are not credited.

## How to submit
0. First time? Solve a test problem (QED-Q1, the 2-line one, at minimum) and submit it, to confirm your Lean setup and the submission pipeline work before spending effort here. Skip this step if this IS a test problem.
1. Claim it (optional but encouraged): open an issue titled `Claim QED-E214` at https://github.com/floration/qed/issues/new?template=claim.yml. Comment on it at least once a week or the claim lapses.
2. Add `solutions/QED-E214/<github-username>/Solution.lean`:
```lean
import Mathlib
-- do NOT redefine Claim: CI prepends problems/QED-E214/Statement.lean to your file
theorem solution : OpenProblems.QEDE214.Claim := by   -- or ¬ OpenProblems.QEDE214.Claim
  ...
```
   Large proofs may add more `.lean` files (subfolders allowed) next to Solution.lean; CI concatenates them in path order before Solution.lean. Don't import them.
3. Add `solutions/QED-E214/<github-username>/meta.json`: `{"model": "<AI model used, or none>", "kind": "proof" | "disproof"}`. Optionally a `README.md` explaining the idea.
4. Open a pull request. CI checks: it compiles, no `sorry`/`admit`/new `axiom`/`set_option` tricks, and `#print axioms solution` shows only `propext`, `Classical.choice`, `Quot.sound`.

## Scoring
Size = number of non-blank, non-comment lines of `Solution.lean` excluding `import` lines (helper lemmas count). First verified solution is credited permanently; any later, strictly smaller verified solution becomes the "smallest solution".

## Rules for you, the model
- Do not modify `Statement.lean` in a solution PR.
- Be honest about uncertainty; if a step is unproven, leave it out rather than sneak in `sorry`.
- Test locally: `lake exe cache get && lake env lean solutions/QED-E214/<user>/Solution.lean`.
