# QED-E127 — Two colours, sums of at most two: does every solution compute the halting problem?

You are an AI model helping someone attack this open problem. Read all of this before working.

## The problem
Extended set · Grade B · QED Curated · Logic & computability

**Plain words:** Hindman's theorem says that for any finite colouring of the positive integers there is an infinite set H all of whose finite sums have one colour. Restrict this to sums of one or two distinct elements. A computable 4-colouring is known to force every such H to compute the halting problem, but with only 2 colours (and no extra 'apartness' condition) nobody knows. Decide whether some computable 2-colouring forces every solution to compute the halting problem.

**Math:** For $H\subseteq\mathbb N_{>0}$ let $FS^{\le2}(H)=H\cup\{x+y:x,y\in H,\ x\ne y\}$. Decide whether there exists a computable $c:\mathbb N_{>0}\to\{0,1\}$ such that every infinite $H\subseteq\mathbb N_{>0}$ on which $FS^{\le2}(H)$ is $c$-monochromatic satisfies $\emptyset'\le_T H$. Either answer is a solution. (A relativizable positive answer gives $\mathsf{RCA}_0\vdash\mathsf{HT}^{\le2}_2\to\mathsf{ACA}_0$.)

**Credit:** Hindman–Leader–Strauss (2003) question; Dzhafarov, Jockusch, Solomon, Westrick; Carlucci, Kołodziejczyk, Lepore, Zdanowski.

**Rests on recent unrefereed work. Check these premises first:**
- The computable formulation is slightly different from the RCA0 implication; a positive answer that relativizes gives HT^{<=2}_2 -> ACA0, a negative answer alone does not separate them.
- Check Bompard–Liu–Patey and any 2025-2026 work for an unpublicized resolution.

**References:**
- https://arxiv.org/abs/1603.08249
- https://arxiv.org/abs/1701.06095
- https://arxiv.org/abs/2207.08554
- https://link.springer.com/article/10.1007/s00153-023-00901-6
- https://arxiv.org/abs/2607.17666
- https://arxiv.org/abs/1804.09809

Difficulty estimate: 4.0/10 (calibrated: Collatz ≈ 5.5, twin primes ≈ 5.0). It is believed open; do not assume a quick answer exists, and say so plainly if you cannot make progress. Never present a heuristic, numerical evidence, or a partial result as a solution.

## What counts as an answer
Either a proof of `OpenProblems.QEDE127.Claim` or a proof of `¬ OpenProblems.QEDE127.Claim` (a disproof), in Lean 4 + Mathlib, using the exact statement in `problems/QED-E127/Statement.lean`. Read its "Formalization notes" first. If that file still says `def Claim : Prop := sorry`, the problem must first be formalized (see CONTRIBUTING.md); a faithful formalization is itself a welcome contribution.

If you think the Lean statement does not match the informal problem (it is trivially true or false, or it says something else), report that in an issue instead of exploiting it: such solutions are not credited.

## How to submit
0. First time? Solve a test problem (QED-Q1, the 2-line one, at minimum) and submit it, to confirm your Lean setup and the submission pipeline work before spending effort here. Skip this step if this IS a test problem.
1. Claim it (optional but encouraged): open an issue titled `Claim QED-E127` at https://github.com/floration/qed/issues/new?template=claim.yml. Comment on it at least once a week or the claim lapses.
2. Add `solutions/QED-E127/<github-username>/Solution.lean`:
```lean
import Mathlib
-- do NOT redefine Claim: CI prepends problems/QED-E127/Statement.lean to your file
theorem solution : OpenProblems.QEDE127.Claim := by   -- or ¬ OpenProblems.QEDE127.Claim
  ...
```
   Large proofs may add more `.lean` files (subfolders allowed) next to Solution.lean; CI concatenates them in path order before Solution.lean. Don't import them.
3. Add `solutions/QED-E127/<github-username>/meta.json`: `{"model": "<AI model used, or none>", "kind": "proof" | "disproof"}`. Optionally a `README.md` explaining the idea.
4. Open a pull request. CI checks: it compiles, no `sorry`/`admit`/new `axiom`/`set_option` tricks, and `#print axioms solution` shows only `propext`, `Classical.choice`, `Quot.sound`.

## Scoring
Size = number of non-blank, non-comment lines of `Solution.lean` excluding `import` lines (helper lemmas count). First verified solution is credited permanently; any later, strictly smaller verified solution becomes the "smallest solution".

## Rules for you, the model
- Do not modify `Statement.lean` in a solution PR.
- Be honest about uncertainty; if a step is unproven, leave it out rather than sneak in `sorry`.
- Test locally: `lake exe cache get && lake env lean solutions/QED-E127/<user>/Solution.lean`.
