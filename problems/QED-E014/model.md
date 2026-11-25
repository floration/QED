# QED-E014 — Minimal-mass blow-up with reflection

You are an AI model helping someone attack this open problem. Read all of this before working.

## The problem
Extended set · Grade C · PDE

**Plain words:** Consider the 2D Schrödinger equation in which the self-interaction at each point uses the density at the mirror point -x. Below the ground-state mass, solutions exist forever. Show that the only solutions that blow up with exactly the ground-state mass are the explicit pseudo-conformal ground-state solutions centred at the origin.

**Math:** Let $Q>0$ be the radial solution of $\Delta Q-Q+Q^3=0$ on $\mathbb R^2$. Consider $iu_t+\Delta u+|u(-x,t)|^2u=0$ with $u_0\in H^1(\mathbb R^2)$ and $\|u_0\|_{L^2}=\|Q\|_{L^2}$. Prove that if $u$ blows up at a finite time $T$, then there are $\theta\in\mathbb R$ and $\lambda>0$ with $u(t,x)=e^{i\theta}\frac{\lambda}{T-t}\,Q\!\Big(\frac{\lambda x}{T-t}\Big)\exp\!\Big(i\frac{\lambda^2}{T-t}-i\frac{|x|^2}{4(T-t)}\Big)$.

**Reviewer note:** T

**References:**
- https://arxiv.org/abs/0804.1124
- https://arxiv.org/abs/2311.04443
- https://arxiv.org/abs/2201.04500

Difficulty estimate: 2.5/10 (calibrated: Collatz ≈ 5.5, twin primes ≈ 5.0). It is believed open; do not assume a quick answer exists, and say so plainly if you cannot make progress. Never present a heuristic, numerical evidence, or a partial result as a solution.

## What counts as an answer
Either a proof of `OpenProblems.QEDE014.Claim` or a proof of `¬ OpenProblems.QEDE014.Claim` (a disproof), in Lean 4 + Mathlib, using the exact statement in `problems/QED-E014/Statement.lean`. Read its "Formalization notes" first. If that file still says `def Claim : Prop := sorry`, the problem must first be formalized (see CONTRIBUTING.md); a faithful formalization is itself a welcome contribution.

If you think the Lean statement does not match the informal problem (it is trivially true or false, or it says something else), report that in an issue instead of exploiting it: such solutions are not credited.

## How to submit
0. First time? Solve a test problem (QED-Q1, the 2-line one, at minimum) and submit it, to confirm your Lean setup and the submission pipeline work before spending effort here. Skip this step if this IS a test problem.
1. Claim it (optional but encouraged): open an issue titled `Claim QED-E014` at https://github.com/floration/qed/issues/new?template=claim.yml. Comment on it at least once a week or the claim lapses.
2. Add `solutions/QED-E014/<github-username>/Solution.lean`:
```lean
import Mathlib
-- do NOT redefine Claim: CI prepends problems/QED-E014/Statement.lean to your file
theorem solution : OpenProblems.QEDE014.Claim := by   -- or ¬ OpenProblems.QEDE014.Claim
  ...
```
   Large proofs may add more `.lean` files (subfolders allowed) next to Solution.lean; CI concatenates them in path order before Solution.lean. Don't import them.
3. Add `solutions/QED-E014/<github-username>/meta.json`: `{"model": "<AI model used, or none>", "kind": "proof" | "disproof"}`. Optionally a `README.md` explaining the idea.
4. Open a pull request. CI checks: it compiles, no `sorry`/`admit`/new `axiom`/`set_option` tricks, and `#print axioms solution` shows only `propext`, `Classical.choice`, `Quot.sound`.

## Scoring
Size = number of non-blank, non-comment lines of `Solution.lean` excluding `import` lines (helper lemmas count). First verified solution is credited permanently; any later, strictly smaller verified solution becomes the "smallest solution".

## Rules for you, the model
- Do not modify `Statement.lean` in a solution PR.
- Be honest about uncertainty; if a step is unproven, leave it out rather than sneak in `sorry`.
- Test locally: `lake exe cache get && lake env lean solutions/QED-E014/<user>/Solution.lean`.
