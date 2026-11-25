# QED-E215 — Ovoids of the parabolic quadric Q(6,q) when q is not a power of 3

You are an AI model helping someone attack this open problem. Read all of this before working.

## The problem
Extended set · Grade B · QED Curated · Combinatorics

**Plain words:** Over a finite field with q elements (q odd), take the quadratic form Q(x)=x0x1+x2x3+x4x5+x6^2 in seven variables. An ovoid is a set of q^3+1 isotropic points (nonzero solutions of Q=0, up to scaling) no two of which are orthogonal. Ovoids exist when q is a power of 3 and do not exist when q is even or q is a prime larger than 3. Does an ovoid exist for any other q? The smallest open case is q=25.

**Math:** Let $q=p^h$ with $p\ge5$ prime and $h\ge2$. Put $Q(x)=x_0x_1+x_2x_3+x_4x_5+x_6^2$ on $\mathbb F_q^7$ and $B(x,y)=Q(x+y)-Q(x)-Q(y)$. Decide whether there is a set $S\subseteq\mathbb F_q^7\setminus\{0\}$ with $|S|=q^3+1$, $Q(v)=0$ for all $v\in S$, and $B(v,w)\ne0$ for all distinct $v,w\in S$ (i.e. whether $Q(6,q)$ has an ovoid). The smallest open case is $q=25$; it is widely expected that no such $S$ exists.

**Credit:** Open problem from Thas (1981) and Kantor (1982); current status in Ball–Govaerts–Storme (2006) and Bartoli–Durante–Grimaldi (2024).

**Rests on recent unrefereed work. Check these premises first:**
- Specialist topic; the scorer may rate importance moderately
- Faithfulness relies on the standard fact that partial ovoids of size q^3+1 are ovoids (counting argument), which the Lean statement sidesteps by stating the size condition directly

**References:**
- https://link.springer.com/10.1007/s10623-024-01388-9
- https://doi.org/10.1007/s10623-005-5666-0
- https://arxiv.org/abs/2502.02219

Difficulty estimate: 4.0/10 (calibrated: Collatz ≈ 5.5, twin primes ≈ 5.0). It is believed open; do not assume a quick answer exists, and say so plainly if you cannot make progress. Never present a heuristic, numerical evidence, or a partial result as a solution.

## What counts as an answer
Either a proof of `OpenProblems.QEDE215.Claim` or a proof of `¬ OpenProblems.QEDE215.Claim` (a disproof), in Lean 4 + Mathlib, using the exact statement in `problems/QED-E215/Statement.lean`. Read its "Formalization notes" first. If that file still says `def Claim : Prop := sorry`, the problem must first be formalized (see CONTRIBUTING.md); a faithful formalization is itself a welcome contribution.

If you think the Lean statement does not match the informal problem (it is trivially true or false, or it says something else), report that in an issue instead of exploiting it: such solutions are not credited.

## How to submit
0. First time? Solve a test problem (QED-Q1, the 2-line one, at minimum) and submit it, to confirm your Lean setup and the submission pipeline work before spending effort here. Skip this step if this IS a test problem.
1. Claim it (optional but encouraged): open an issue titled `Claim QED-E215` at https://github.com/floration/qed/issues/new?template=claim.yml. Comment on it at least once a week or the claim lapses.
2. Add `solutions/QED-E215/<github-username>/Solution.lean`:
```lean
import Mathlib
-- do NOT redefine Claim: CI prepends problems/QED-E215/Statement.lean to your file
theorem solution : OpenProblems.QEDE215.Claim := by   -- or ¬ OpenProblems.QEDE215.Claim
  ...
```
   Large proofs may add more `.lean` files (subfolders allowed) next to Solution.lean; CI concatenates them in path order before Solution.lean. Don't import them.
3. Add `solutions/QED-E215/<github-username>/meta.json`: `{"model": "<AI model used, or none>", "kind": "proof" | "disproof"}`. Optionally a `README.md` explaining the idea.
4. Open a pull request. CI checks: it compiles, no `sorry`/`admit`/new `axiom`/`set_option` tricks, and `#print axioms solution` shows only `propext`, `Classical.choice`, `Quot.sound`.

## Scoring
Size = number of non-blank, non-comment lines of `Solution.lean` excluding `import` lines (helper lemmas count). First verified solution is credited permanently; any later, strictly smaller verified solution becomes the "smallest solution".

## Rules for you, the model
- Do not modify `Statement.lean` in a solution PR.
- Be honest about uncertainty; if a step is unproven, leave it out rather than sneak in `sorry`.
- Test locally: `lake exe cache get && lake env lean solutions/QED-E215/<user>/Solution.lean`.
