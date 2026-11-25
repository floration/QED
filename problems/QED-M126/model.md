# QED-M126 — Glauber dynamics for colourings mixes rapidly with (1+eps)Delta colours

You are an AI model helping someone attack this open problem. Read all of this before working.

## The problem
Main set · Grade A · QED Curated · Probability

**Plain words:** To sample a random proper colouring of a graph with q colours, repeat this step: pick a random vertex and a random colour, and recolour the vertex if no neighbour already has that colour. For large maximum degree Delta this chain is known to reach equilibrium in polynomial time once q is a bit above (1+1/e)Delta, about 1.368 Delta (2026). Conjecturally q >= Delta+2 is enough. Weakest asymptotic form: for every eps > 0, are (1+eps)Delta colours enough once Delta is large?

**Math:** For a finite graph $G$ on $n$ vertices with maximum degree $\Delta$ and an integer $q\ge\Delta+2$, let $\Omega$ be the set of proper $q$-colourings and $P$ the Glauber (Metropolis) chain on $\Omega$: choose $v\in V$ and $c\in[q]$ uniformly at random and set $\sigma(v)=c$ if no neighbour of $v$ has colour $c$. Let $t_{\mathrm{mix}}(G,q)=\min\{t:\max_{\sigma\in\Omega}\|P^t(\sigma,\cdot)-U_\Omega\|_{TV}\le 1/4\}$. Claim: for every $\varepsilon>0$ there are $\Delta_0$ and $C$ such that $t_{\mathrm{mix}}(G,q)\le C n^{C}$ for every graph $G$ with $\Delta(G)\ge\Delta_0$ and every integer $q\ge(1+\varepsilon)\Delta(G)$.

**Credit:** Conjecture q >= Delta+2 commonly cited to Jerrum (1995) as a 'long-standing conjecture'; asymptotic form as stated here is a weaker unnamed version.

**Rests on recent unrefereed work. Check these premises first:**
- Actively moving constant (Tao-list-style risk): new 2026 preprints (Li-Oveis Gharan, Yang) unrefereed; the endpoint target avoids arbitrary intermediate thresholds
- Some sources call the Delta+2 statement 'Jerrum's conjecture'; the asymptotic version is the unnamed weaker form
- Well known, so low novelty

**References:**
- https://arxiv.org/abs/2611.04699
- https://arxiv.org/abs/2407.04870
- https://arxiv.org/abs/1804.04025
- https://arxiv.org/abs/2307.08080
- https://arxiv.org/abs/2611.12444

Difficulty estimate: 4.0/10 (calibrated: Collatz ≈ 5.5, twin primes ≈ 5.0). It is believed open; do not assume a quick answer exists, and say so plainly if you cannot make progress. Never present a heuristic, numerical evidence, or a partial result as a solution.

## What counts as an answer
Either a proof of `OpenProblems.QEDM126.Claim` or a proof of `¬ OpenProblems.QEDM126.Claim` (a disproof), in Lean 4 + Mathlib, using the exact statement in `problems/QED-M126/Statement.lean`. Read its "Formalization notes" first. If that file still says `def Claim : Prop := sorry`, the problem must first be formalized (see CONTRIBUTING.md); a faithful formalization is itself a welcome contribution.

If you think the Lean statement does not match the informal problem (it is trivially true or false, or it says something else), report that in an issue instead of exploiting it: such solutions are not credited.

## How to submit
0. First time? Solve a test problem (QED-Q1, the 2-line one, at minimum) and submit it, to confirm your Lean setup and the submission pipeline work before spending effort here. Skip this step if this IS a test problem.
1. Claim it (optional but encouraged): open an issue titled `Claim QED-M126` at https://github.com/floration/qed/issues/new?template=claim.yml. Comment on it at least once a week or the claim lapses.
2. Add `solutions/QED-M126/<github-username>/Solution.lean`:
```lean
import Mathlib
-- do NOT redefine Claim: CI prepends problems/QED-M126/Statement.lean to your file
theorem solution : OpenProblems.QEDM126.Claim := by   -- or ¬ OpenProblems.QEDM126.Claim
  ...
```
   Large proofs may add more `.lean` files (subfolders allowed) next to Solution.lean; CI concatenates them in path order before Solution.lean. Don't import them.
3. Add `solutions/QED-M126/<github-username>/meta.json`: `{"model": "<AI model used, or none>", "kind": "proof" | "disproof"}`. Optionally a `README.md` explaining the idea.
4. Open a pull request. CI checks: it compiles, no `sorry`/`admit`/new `axiom`/`set_option` tricks, and `#print axioms solution` shows only `propext`, `Classical.choice`, `Quot.sound`.

## Scoring
Size = number of non-blank, non-comment lines of `Solution.lean` excluding `import` lines (helper lemmas count). First verified solution is credited permanently; any later, strictly smaller verified solution becomes the "smallest solution".

## Rules for you, the model
- Do not modify `Statement.lean` in a solution PR.
- Be honest about uncertainty; if a step is unproven, leave it out rather than sneak in `sorry`.
- Test locally: `lake exe cache get && lake env lean solutions/QED-M126/<user>/Solution.lean`.
