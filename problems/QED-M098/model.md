# QED-M098 — Quintic Szego growth

You are an AI model helping someone attack this open problem. Read all of this before working.

## The problem
Main set · Grade B · QED Extension · PDE

**Plain words:** The cubic Szego equation on the circle is completely integrable, and Gerard-Grellier showed that its smooth solutions can have Sobolev norms that are unbounded in time. Decide whether the quintic Szego equation, which is presumably not integrable, also has smooth solutions with unbounded high Sobolev norms.

**Math:** On $L^2_+(\mathbb T)=\{u\in L^2:\hat u(k)=0\ \forall k<0\}$ with Szego projector $\Pi$, consider $i\partial_tu=\Pi(|u|^4u)$, which is globally well posed in $H^s_+$, $s>1/2$, with conserved $\|u\|_{L^2}$, $(Du,u)$ and $\|u\|_{L^6}$. Decide whether there exist $u_0\in C^\infty(\mathbb T)\cap L^2_+$ and $s>1/2$ with $\limsup_{t\to\infty}\|u(t)\|_{H^s}=\infty$.

**Credit:** Gérard–Grellier (cubic Szegő equation, turbulent solutions); Thirouin, quadratic Szegő equation (arXiv:1710.01512).

**References:**
- https://arxiv.org/abs/1710.01512
- https://arxiv.org/pdf/1508.01500
- https://arxiv.org/pdf/2002.07785

Difficulty estimate: 5.0/10 (calibrated: Collatz ≈ 5.5, twin primes ≈ 5.0). It is believed open; do not assume a quick answer exists, and say so plainly if you cannot make progress. Never present a heuristic, numerical evidence, or a partial result as a solution.

## What counts as an answer
Either a proof of `OpenProblems.QEDM098.Claim` or a proof of `¬ OpenProblems.QEDM098.Claim` (a disproof), in Lean 4 + Mathlib, using the exact statement in `problems/QED-M098/Statement.lean`. Read its "Formalization notes" first. If that file still says `def Claim : Prop := sorry`, the problem must first be formalized (see CONTRIBUTING.md); a faithful formalization is itself a welcome contribution. What is missing: Not formalized: needs well-posedness theory for the quintic Szegő equation.

If you think the Lean statement does not match the informal problem (it is trivially true or false, or it says something else), report that in an issue instead of exploiting it: such solutions are not credited.

## How to submit
1. Claim it (optional but encouraged): open an issue titled `Claim QED-M098` at https://github.com/floration/qed/issues/new?template=claim.yml. Comment on it at least once a week or the claim lapses.
2. Add `solutions/QED-M098/<github-username>/Solution.lean`:
```lean
import Mathlib
-- do NOT redefine Claim: CI prepends problems/QED-M098/Statement.lean to your file
theorem solution : OpenProblems.QEDM098.Claim := by   -- or ¬ OpenProblems.QEDM098.Claim
  ...
```
   Large proofs may add more `.lean` files (subfolders allowed) next to Solution.lean; CI concatenates them in path order before Solution.lean. Don't import them.
3. Add `solutions/QED-M098/<github-username>/meta.json`: `{"model": "<AI model used, or none>", "kind": "proof" | "disproof"}`. Optionally a `README.md` explaining the idea.
4. Open a pull request. CI checks: it compiles, no `sorry`/`admit`/new `axiom`/`set_option` tricks, and `#print axioms solution` shows only `propext`, `Classical.choice`, `Quot.sound`.

## Scoring
Size = number of non-blank, non-comment lines of `Solution.lean` excluding `import` lines (helper lemmas count). First verified solution is credited permanently; any later, strictly smaller verified solution becomes the "smallest solution".

## Rules for you, the model
- Do not modify `Statement.lean` in a solution PR.
- Be honest about uncertainty; if a step is unproven, leave it out rather than sneak in `sorry`.
- Test locally: `lake exe cache get && lake env lean solutions/QED-M098/<user>/Solution.lean`.
