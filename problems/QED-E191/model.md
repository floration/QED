# QED-E191 — Do two triangular 2×2 matrices generate a free semigroup? Decide it

You are an AI model helping someone attack this open problem. Read all of this before working.

## The problem
Extended set · Grade B · QED Curated · Logic & computability

**Plain words:** For rational numbers λ and μ consider the matrices D = [[λ,0],[0,1]] and T = [[μ,1],[0,1]], or equivalently the maps x -> λx and x -> μx + 1 of the line. They are called free if different finite words in D and T always multiply to different matrices. Is there an algorithm that, given λ and μ, decides whether D and T are free? Deciding freeness of any two upper-triangular 2×2 rational matrices reduces to this family, and freeness is already undecidable for 3×3 matrices of natural numbers.

**Math:** For $\lambda,\mu\in\mathbb Q$ let $D_\lambda=\begin{pmatrix}\lambda&0\\0&1\end{pmatrix}$, $T_\mu=\begin{pmatrix}\mu&1\\0&1\end{pmatrix}$, and let $\phi_{\lambda,\mu}:\{0,1\}^*\to M_2(\mathbb Q)$ be the monoid morphism with $0\mapsto D_\lambda$ and $1\mapsto T_\mu$. Let $\Phi=\{(\lambda,\mu)\in\mathbb Q^2:\phi_{\lambda,\mu}\text{ is injective}\}$. Determine whether $\Phi$ is a decidable (recursive) subset of $\mathbb Q^2$. A proof of either answer settles the problem.

**Credit:** Cassaigne–Harju–Karhumäki (1999) and Cassaigne–Nicolas (2012), Open Question 8 and the (λ,μ) reduction.

**Rests on recent unrefereed work. Check these premises first:**
- The claim that every two-generator upper-triangular rational instance reduces to the (λ,μ) family is from Cassaigne–Nicolas; the formalized statement does not depend on it.
- Decidability of FREE(2) over 2×2 N-matrices (Open Question 8) is a slightly different instance class; a solution of one may not immediately settle the other.

**References:**
- https://arxiv.org/pdf/0808.3112
- https://arxiv.org/pdf/1304.1637
- https://arxiv.org/pdf/1610.09834
- https://arxiv.org/pdf/2101.00872
- https://arxiv.org/pdf/2105.09387
- https://cs.uwaterloo.ca/twiki/view/CoWiki/MatricesGenerateFreeGroup

Difficulty estimate: 5.0/10 (calibrated: Collatz ≈ 5.5, twin primes ≈ 5.0). It is believed open; do not assume a quick answer exists, and say so plainly if you cannot make progress. Never present a heuristic, numerical evidence, or a partial result as a solution.

## What counts as an answer
Either a proof of `OpenProblems.QEDE191.Claim` or a proof of `¬ OpenProblems.QEDE191.Claim` (a disproof), in Lean 4 + Mathlib, using the exact statement in `problems/QED-E191/Statement.lean`. Read its "Formalization notes" first. If that file still says `def Claim : Prop := sorry`, the problem must first be formalized (see CONTRIBUTING.md); a faithful formalization is itself a welcome contribution.

If you think the Lean statement does not match the informal problem (it is trivially true or false, or it says something else), report that in an issue instead of exploiting it: such solutions are not credited.

## How to submit
0. First time? Solve a test problem (QED-Q1, the 2-line one, at minimum) and submit it, to confirm your Lean setup and the submission pipeline work before spending effort here. Skip this step if this IS a test problem.
1. Claim it (optional but encouraged): open an issue titled `Claim QED-E191` at https://github.com/floration/qed/issues/new?template=claim.yml. Comment on it at least once a week or the claim lapses.
2. Add `solutions/QED-E191/<github-username>/Solution.lean`:
```lean
import Mathlib
-- do NOT redefine Claim: CI prepends problems/QED-E191/Statement.lean to your file
theorem solution : OpenProblems.QEDE191.Claim := by   -- or ¬ OpenProblems.QEDE191.Claim
  ...
```
   Large proofs may add more `.lean` files (subfolders allowed) next to Solution.lean; CI concatenates them in path order before Solution.lean. Don't import them.
3. Add `solutions/QED-E191/<github-username>/meta.json`: `{"model": "<AI model used, or none>", "kind": "proof" | "disproof"}`. Optionally a `README.md` explaining the idea.
4. Open a pull request. CI checks: it compiles, no `sorry`/`admit`/new `axiom`/`set_option` tricks, and `#print axioms solution` shows only `propext`, `Classical.choice`, `Quot.sound`.

## Scoring
Size = number of non-blank, non-comment lines of `Solution.lean` excluding `import` lines (helper lemmas count). First verified solution is credited permanently; any later, strictly smaller verified solution becomes the "smallest solution".

## Rules for you, the model
- Do not modify `Statement.lean` in a solution PR.
- Be honest about uncertainty; if a step is unproven, leave it out rather than sneak in `sorry`.
- Test locally: `lake exe cache get && lake env lean solutions/QED-E191/<user>/Solution.lean`.
