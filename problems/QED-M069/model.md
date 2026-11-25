# QED-M069 — Deciding limit cycles

You are an AI model helping someone attack this open problem. Read all of this before working.

## The problem
Main set · Grade A · QED Extension · Logic & computability

**Plain words:** Given a polynomial vector field in the plane with rational coefficients, is there an algorithm that decides whether it has a limit cycle, that is, an isolated closed orbit? Hilbert's 16th problem asks how many limit cycles there can be. This asks only whether their existence is algorithmically decidable. The same question can be asked for closed orbits of any kind, including those in period annuli around centres.

**Math:** Let $\mathcal L=\{(P,Q)\in\mathbb Q[x,y]^2:\ \dot x=P,\dot y=Q$ has a limit cycle, i.e. a non-constant periodic orbit that has a neighbourhood containing no other periodic orbit$\}$ and $\mathcal P=\{(P,Q):$ the system has a non-constant periodic orbit in $\mathbb R^2\}$, with inputs given by their rational coefficient lists (degree unbounded). (a) Is $\mathcal L$ decidable? (b) Is $\mathcal P$ decidable? (c) Are $\mathcal L,\mathcal P$ or their complements recursively enumerable? (d) Same questions restricted to degree 2.

**Reviewer note:** Context (Nov 2026): OpenAI claims uniform bounds for Hilbert's 16th problem; that does not decide existence of limit cycles, which this problem asks.

**Credit:** Extension of Graca-Zhong (arXiv:2101.07701) noncomputability of planar periodic orbits; related: Hilbert's 16th problem, Il'yashenko on algebraic unsolvability of the center-focus problem.

**QED results so far (reviewer-derived; check before relying on them):** The claim that hyperbolic limit cycles are r.e. via interval certification is correct. The remark that fixed-degree versions 'can become trivially decidable' is wrong. Each fixed-degree set is still infinite. Bautin's finite generation only gives non-uniform decidability of the local center condition, not of whether cycles exist.

**Rests on recent unrefereed work. Check these premises first:**
- arXiv:2609.22058 (2026 preprint): cited only for the claim that the planar (N=2) case is open and that Lyapunov stability is undecidable in dimension 5; the statement does not depend on it.

**References:**
- https://arxiv.org/abs/2101.07701
- https://core.ac.uk/download/61500783.pdf
- https://encyclopediaofmath.org/wiki/Algebraic_decidability_of_local_classification_problems
- https://arxiv.org/abs/1602.00113
- https://arxiv.org/abs/2101.07701
- https://arxiv.org/pdf/2609.22058
- https://core.ac.uk/download/61500783.pdf

Difficulty estimate: 6.0/10 (calibrated: Collatz ≈ 5.5, twin primes ≈ 5.0). It is believed open; do not assume a quick answer exists, and say so plainly if you cannot make progress. Never present a heuristic, numerical evidence, or a partial result as a solution.

## What counts as an answer
Either a proof of `OpenProblems.QEDM069.Claim` or a proof of `¬ OpenProblems.QEDM069.Claim` (a disproof), in Lean 4 + Mathlib, using the exact statement in `problems/QED-M069/Statement.lean`. Read its "Formalization notes" first. If that file still says `def Claim : Prop := sorry`, the problem must first be formalized (see CONTRIBUTING.md); a faithful formalization is itself a welcome contribution.

If you think the Lean statement does not match the informal problem (it is trivially true or false, or it says something else), report that in an issue instead of exploiting it: such solutions are not credited.

## How to submit
0. First time? Solve a test problem (QED-Q1, the 2-line one, at minimum) and submit it, to confirm your Lean setup and the submission pipeline work before spending effort here. Skip this step if this IS a test problem.
1. Claim it (optional but encouraged): open an issue titled `Claim QED-M069` at https://github.com/floration/qed/issues/new?template=claim.yml. Comment on it at least once a week or the claim lapses.
2. Add `solutions/QED-M069/<github-username>/Solution.lean`:
```lean
import Mathlib
-- do NOT redefine Claim: CI prepends problems/QED-M069/Statement.lean to your file
theorem solution : OpenProblems.QEDM069.Claim := by   -- or ¬ OpenProblems.QEDM069.Claim
  ...
```
   Large proofs may add more `.lean` files (subfolders allowed) next to Solution.lean; CI concatenates them in path order before Solution.lean. Don't import them.
3. Add `solutions/QED-M069/<github-username>/meta.json`: `{"model": "<AI model used, or none>", "kind": "proof" | "disproof"}`. Optionally a `README.md` explaining the idea.
4. Open a pull request. CI checks: it compiles, no `sorry`/`admit`/new `axiom`/`set_option` tricks, and `#print axioms solution` shows only `propext`, `Classical.choice`, `Quot.sound`.

## Scoring
Size = number of non-blank, non-comment lines of `Solution.lean` excluding `import` lines (helper lemmas count). First verified solution is credited permanently; any later, strictly smaller verified solution becomes the "smallest solution".

## Rules for you, the model
- Do not modify `Statement.lean` in a solution PR.
- Be honest about uncertainty; if a step is unproven, leave it out rather than sneak in `sorry`.
- Test locally: `lake exe cache get && lake env lean solutions/QED-M069/<user>/Solution.lean`.
