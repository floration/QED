# QED-E209 — Langton's ant builds a highway from every finite start

You are an AI model helping someone attack this open problem. Read all of this before working.

## The problem
Extended set · Grade B · QED Curated · Dynamics

**Plain words:** Langton's ant walks on the square grid of black and white cells. On a white cell it turns right, on a black cell it turns left, then it flips the colour of the cell it is on and steps forward. Starting from any configuration with finitely many black cells, simulations always end with the ant building a 'highway': after some time its motion repeats periodically while it drifts off in a fixed direction. Prove that this always happens.

**Math:** A state is $(S,p,d)$ with $S\subset\mathbb{Z}^2$ finite (the black cells), $p\in\mathbb{Z}^2$ and $d\in\{(1,0),(0,1),(-1,0),(0,-1)\}$. One step: if $p\notin S$, rotate $d$ by $-90^\circ$, otherwise by $+90^\circ$; then set $S\leftarrow S\,\triangle\,\{p\}$ and $p\leftarrow p+d$. Prove that for every initial state with $S_0$ finite there exist $T\ge0$, $P\ge1$ and $v\in\mathbb{Z}^2\setminus\{0\}$ such that $p_{t+P}=p_t+v$ and $d_{t+P}=d_t$ for all $t\ge T$.

**Credit:** C. Langton (1986, the ant); highway conjecture folklore, see Bunimovich-Troubetzkoy 1992 and Gajardo-Lutfalla-Rao 2024.

**Rests on recent unrefereed work. Check these premises first:**
- Well known (low novelty)
- If an alternative highway for the LR ant exists, the statement here still holds; only the stronger 'period-104' version could fail

**References:**
- https://www.arxiv.org/pdf/2409.10124
- https://arxiv.org/abs/2505.05426
- https://drops.dagstuhl.de/storage/00lipics/lipics-vol386-mfcs2026/LIPIcs.MFCS.2026.49/LIPIcs.MFCS.2026.49.pdf
- https://arxiv.org/pdf/nlin/0306022

Difficulty estimate: 6.5/10 (calibrated: Collatz ≈ 5.5, twin primes ≈ 5.0). It is believed open; do not assume a quick answer exists, and say so plainly if you cannot make progress. Never present a heuristic, numerical evidence, or a partial result as a solution.

## What counts as an answer
Either a proof of `OpenProblems.QEDE209.Claim` or a proof of `¬ OpenProblems.QEDE209.Claim` (a disproof), in Lean 4 + Mathlib, using the exact statement in `problems/QED-E209/Statement.lean`. Read its "Formalization notes" first. If that file still says `def Claim : Prop := sorry`, the problem must first be formalized (see CONTRIBUTING.md); a faithful formalization is itself a welcome contribution.

If you think the Lean statement does not match the informal problem (it is trivially true or false, or it says something else), report that in an issue instead of exploiting it: such solutions are not credited.

## How to submit
0. First time? Solve a test problem (QED-Q1, the 2-line one, at minimum) and submit it, to confirm your Lean setup and the submission pipeline work before spending effort here. Skip this step if this IS a test problem.
1. Claim it (optional but encouraged): open an issue titled `Claim QED-E209` at https://github.com/floration/qed/issues/new?template=claim.yml. Comment on it at least once a week or the claim lapses.
2. Add `solutions/QED-E209/<github-username>/Solution.lean`:
```lean
import Mathlib
-- do NOT redefine Claim: CI prepends problems/QED-E209/Statement.lean to your file
theorem solution : OpenProblems.QEDE209.Claim := by   -- or ¬ OpenProblems.QEDE209.Claim
  ...
```
   Large proofs may add more `.lean` files (subfolders allowed) next to Solution.lean; CI concatenates them in path order before Solution.lean. Don't import them.
3. Add `solutions/QED-E209/<github-username>/meta.json`: `{"model": "<AI model used, or none>", "kind": "proof" | "disproof"}`. Optionally a `README.md` explaining the idea.
4. Open a pull request. CI checks: it compiles, no `sorry`/`admit`/new `axiom`/`set_option` tricks, and `#print axioms solution` shows only `propext`, `Classical.choice`, `Quot.sound`.

## Scoring
Size = number of non-blank, non-comment lines of `Solution.lean` excluding `import` lines (helper lemmas count). First verified solution is credited permanently; any later, strictly smaller verified solution becomes the "smallest solution".

## Rules for you, the model
- Do not modify `Statement.lean` in a solution PR.
- Be honest about uncertainty; if a step is unproven, leave it out rather than sneak in `sorry`.
- Test locally: `lake exe cache get && lake env lean solutions/QED-E209/<user>/Solution.lean`.
